-- =====================================================================
--  VILAS MOTOR - Sistema de gestión de mantenimiento de flota
--  Base de datos MySQL 8 (utf8mb4)
--
--  Basada en el schema.sql del proyecto del equipo (docs/diagramas/
--  bitacoras_UML/db/schema.sql). Se mantienen todas sus tablas y se
--  agrega lo que pide la maqueta:
--    * Código, nombre e ID de telemetría automáticos por equipo
--    * ID correlativo de cada máquina (id_equipo)
--    * Geolocalización GPS (posición actual + historial)
--    * Arriendos con número correlativo (ARR-0001) y faenas
--    * Verificación en dos pasos al iniciar sesión
--    * Vistas para el dashboard: cada número sale de la misma consulta
--      que la lista a la que lleva, así siempre coinciden.
--
--  Orden de ejecución: 01_esquema.sql -> 02_datos.sql -> 03_consultas.sql
-- =====================================================================

DROP DATABASE IF EXISTS vilas_motor;
CREATE DATABASE vilas_motor CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE vilas_motor;

-- ---------------------------------------------------------------------
-- Usuarios, roles y clientes
-- ---------------------------------------------------------------------
CREATE TABLE rol (
    id_rol          TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(30)  NOT NULL UNIQUE,
    descripcion     VARCHAR(120)
);

CREATE TABLE cliente (
    id_cliente      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    rut             VARCHAR(12)  NOT NULL UNIQUE,
    razon_social    VARCHAR(120) NOT NULL,
    email_contacto  VARCHAR(120),
    telefono        VARCHAR(20),
    activo          TINYINT(1)   NOT NULL DEFAULT 1,
    creado_en       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE usuario (
    id_usuario       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_rol           TINYINT UNSIGNED NOT NULL,
    id_cliente       INT UNSIGNED,
    nombre           VARCHAR(100) NOT NULL,
    email            VARCHAR(120) NOT NULL UNIQUE,
    password_hash    VARCHAR(255) NOT NULL,          -- formato Django: pbkdf2_sha256$iteraciones$sal$hash
    dos_pasos_activo TINYINT(1)   NOT NULL DEFAULT 1, -- NUEVO: exige código de verificación al entrar
    activo           TINYINT(1)   NOT NULL DEFAULT 1,
    ultimo_acceso    DATETIME,
    creado_en        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_usuario_rol     FOREIGN KEY (id_rol)     REFERENCES rol(id_rol),
    CONSTRAINT fk_usuario_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- NUEVO: verificación en dos pasos. Se guarda el hash del código (nunca el código).
CREATE TABLE codigo_verificacion (
    id_codigo       BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario      INT UNSIGNED NOT NULL,
    codigo_hash     CHAR(64)     NOT NULL,           -- SHA-256 del código de 6 dígitos
    canal           ENUM('EMAIL','SMS') NOT NULL DEFAULT 'EMAIL',
    creado_en       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    vence_en        DATETIME     NOT NULL,           -- creado_en + 5 minutos
    intentos        TINYINT UNSIGNED NOT NULL DEFAULT 0,  -- se bloquea al llegar a 3
    usado_en        DATETIME,
    ip              VARCHAR(45),
    CONSTRAINT fk_codigo_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT ck_codigo_intentos CHECK (intentos <= 3),
    INDEX ix_codigo_usuario (id_usuario, creado_en)
);

-- NUEVO: "confiar en este dispositivo por 30 días"
CREATE TABLE dispositivo_confiable (
    id_dispositivo  BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario      INT UNSIGNED NOT NULL,
    token_hash      CHAR(64)     NOT NULL UNIQUE,
    descripcion     VARCHAR(120),                    -- ej: "Chrome en Windows"
    creado_en       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    vence_en        DATETIME     NOT NULL,
    CONSTRAINT fk_dispositivo_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- ---------------------------------------------------------------------
-- Flota
-- ---------------------------------------------------------------------
CREATE TABLE tipo_equipo (
    id_tipo_equipo  SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(60)  NOT NULL UNIQUE,
    prefijo         VARCHAR(5)   NOT NULL UNIQUE,    -- NUEVO: arma el código de sus equipos (GH, GE...). Se genera solo.
    unidad_medida   ENUM('HORAS','KM') NOT NULL,
    creado_en       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
);  -- Categorías de equipos (ej. Grúa horquilla, Generador)

-- NUEVO: lugares donde se dejan los equipos arrendados
CREATE TABLE faena (
    id_faena        SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(80)  NOT NULL UNIQUE,
    latitud         DECIMAL(9,6) NOT NULL,
    longitud        DECIMAL(9,6) NOT NULL
);

CREATE TABLE equipo (
    id_equipo        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,   -- ID correlativo de cada máquina: 1, 2, 3...
    id_tipo_equipo   SMALLINT UNSIGNED NOT NULL,
    codigo           VARCHAR(30)  NOT NULL UNIQUE,  -- se genera solo: prefijo del tipo + correlativo (GH-001)
    codigo_anterior  VARCHAR(30)  UNIQUE,           -- NUEVO: código que usaba la empresa (V168, VG10...)
    nombre           VARCHAR(160) NOT NULL,         -- NUEVO: se genera solo: tipo + marca + modelo + detalle
    patente          VARCHAR(10)  UNIQUE,
    marca            VARCHAR(50),
    modelo           VARCHAR(50),
    detalle          VARCHAR(50),                   -- NUEVO: ej. "3.5 ton"
    numero_serie     VARCHAR(50)  UNIQUE,
    estado           ENUM('DISPONIBLE','EN_FAENA','EN_MANTENIMIENTO','INTERNO') NOT NULL DEFAULT 'DISPONIBLE',
    estado_previo    ENUM('DISPONIBLE','EN_FAENA','EN_MANTENIMIENTO','INTERNO'),  -- a dónde vuelve al cerrar la OT
    horometro_actual DECIMAL(10,1) NOT NULL DEFAULT 0.0,   -- horas o km según el tipo
    ultimo_servicio  DECIMAL(10,1) NOT NULL DEFAULT 0.0,   -- NUEVO: horómetro de la última mantención
    telemetria_id    VARCHAR(40)  UNIQUE,           -- se completa solo como TLM-0001 (ver vista v_equipo)
    -- NUEVO: última posición reportada por el GPS
    latitud          DECIMAL(9,6),
    longitud         DECIMAL(9,6),
    ubicacion        VARCHAR(120) NOT NULL DEFAULT 'Taller',
    velocidad_kmh    SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    ultima_senal     DATETIME,                      -- NULL o muy antigua = sin señal
    creado_en        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_equipo_tipo FOREIGN KEY (id_tipo_equipo) REFERENCES tipo_equipo(id_tipo_equipo),
    CONSTRAINT ck_equipo_lat CHECK (latitud  IS NULL OR latitud  BETWEEN -90  AND 90),
    CONSTRAINT ck_equipo_lng CHECK (longitud IS NULL OR longitud BETWEEN -180 AND 180),
    INDEX ix_equipo_estado (estado)
);  -- La información de cada equipo: el inventario

-- ---------------------------------------------------------------------
-- Planes de mantención e insumos
-- ---------------------------------------------------------------------
CREATE TABLE plan_mantencion (
    id_plan         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_tipo_equipo  SMALLINT UNSIGNED NOT NULL,
    nombre          VARCHAR(80)  NOT NULL,
    CONSTRAINT fk_plan_tipo_equipo FOREIGN KEY (id_tipo_equipo) REFERENCES tipo_equipo(id_tipo_equipo)
);  -- Un plan pertenece a un tipo de equipo; un tipo puede tener varios planes

CREATE TABLE servicio_plan (
    id_servicio_plan INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_plan          INT UNSIGNED NOT NULL,
    nombre           VARCHAR(60)  NOT NULL,
    intervalo_horas  INT UNSIGNED NOT NULL,   -- intervalo en la unidad del tipo (horas o km)
    descripcion      TEXT,
    CONSTRAINT fk_servicio_plan FOREIGN KEY (id_plan) REFERENCES plan_mantencion(id_plan),
    CONSTRAINT uq_servicio_intervalo UNIQUE (id_plan, intervalo_horas)
);  -- Distingue una mantención de 250 h de una de 1000 h

CREATE TABLE insumo (
    id_insumo       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo          VARCHAR(30)  NOT NULL UNIQUE,
    nombre          VARCHAR(100) NOT NULL,
    unidad_medida   VARCHAR(20)
);  -- Catálogo de insumos (sin stock: los requerimientos no lo piden)

CREATE TABLE servicio_plan_insumo (
    id_servicio_plan INT UNSIGNED NOT NULL,
    id_insumo        INT UNSIGNED NOT NULL,
    cantidad         DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_servicio_plan, id_insumo),
    CONSTRAINT fk_spi_servicio FOREIGN KEY (id_servicio_plan) REFERENCES servicio_plan(id_servicio_plan),
    CONSTRAINT fk_spi_insumo   FOREIGN KEY (id_insumo)        REFERENCES insumo(id_insumo)
);  -- Reemplaza la "PAUTA INSUMOS": la receta de cada servicio

-- ---------------------------------------------------------------------
-- Arriendos
-- ---------------------------------------------------------------------
CREATE TABLE arriendo (
    id_arriendo     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero          VARCHAR(12)  NOT NULL UNIQUE,   -- NUEVO: ARR-0001, se genera solo
    id_equipo       INT UNSIGNED NOT NULL,
    id_cliente      INT UNSIGNED NOT NULL,
    id_faena        SMALLINT UNSIGNED,              -- NUEVO: dónde queda la máquina
    fecha_inicio    DATE NOT NULL,
    fecha_termino   DATE,
    estado          ENUM('VIGENTE','TERMINADO') NOT NULL DEFAULT 'VIGENTE',  -- NUEVO
    creado_en       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_arriendo_equipo  FOREIGN KEY (id_equipo)  REFERENCES equipo(id_equipo),
    CONSTRAINT fk_arriendo_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_arriendo_faena   FOREIGN KEY (id_faena)   REFERENCES faena(id_faena),
    CONSTRAINT ck_arriendo_fechas  CHECK (fecha_termino IS NULL OR fecha_termino >= fecha_inicio),
    INDEX ix_arriendo_estado (estado)
);  -- Contrato de arriendo de un equipo a un cliente

-- ---------------------------------------------------------------------
-- Horómetros y telemetría GPS
-- ---------------------------------------------------------------------
CREATE TABLE lectura_horometro (
    id_lectura      BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_equipo       INT UNSIGNED NOT NULL,
    id_usuario      INT UNSIGNED NOT NULL,
    valor           DECIMAL(10,1) NOT NULL,
    fecha_hora      DATETIME NOT NULL,
    fuente          ENUM('CLIENTE','TECNICO','PLANIFICACION','TELEMETRIA') NOT NULL,
    validada        TINYINT(1) NOT NULL DEFAULT 0,
    observacion     VARCHAR(255),
    CONSTRAINT fk_lectura_equipo  FOREIGN KEY (id_equipo)  REFERENCES equipo(id_equipo),
    CONSTRAINT fk_lectura_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);  -- Historial de horas reales reportadas (reemplaza la columna "Horómetro" del Excel)

CREATE TABLE solicitud_horometro (
    id_solicitud        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_equipo           INT UNSIGNED NOT NULL,
    id_cliente          INT UNSIGNED NOT NULL,
    id_usuario_solicita INT UNSIGNED NOT NULL,
    fecha_solicitud     DATETIME NOT NULL,
    estado              ENUM('PENDIENTE','CUMPLIDA','VENCIDA') NOT NULL DEFAULT 'PENDIENTE',
    id_lectura          BIGINT UNSIGNED UNIQUE,
    CONSTRAINT fk_solicitud_equipo  FOREIGN KEY (id_equipo)           REFERENCES equipo(id_equipo),
    CONSTRAINT fk_solicitud_cliente FOREIGN KEY (id_cliente)          REFERENCES cliente(id_cliente),
    CONSTRAINT fk_solicitud_usuario FOREIGN KEY (id_usuario_solicita) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_solicitud_lectura FOREIGN KEY (id_lectura)          REFERENCES lectura_horometro(id_lectura)
);  -- Se usa con equipos sin señal GPS (reemplaza los correos/WhatsApp pidiendo la hora)

CREATE TABLE telemetria_equipo (
    id_telemetria   BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_equipo       INT UNSIGNED NOT NULL,
    ts              DATETIME NOT NULL,
    horometro       DECIMAL(10,1),
    latitud         DECIMAL(9,6),                   -- NUEVO: posición GPS
    longitud        DECIMAL(9,6),                   -- NUEVO
    velocidad_kmh   SMALLINT UNSIGNED,              -- NUEVO
    payload         JSON,                           -- dato crudo del dispositivo
    CONSTRAINT fk_telemetria_equipo FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo),
    INDEX ix_telemetria_equipo_ts (id_equipo, ts)
);  -- Historial de señales GPS. Cada señal nueva actualiza la posición del equipo (trigger)

-- ---------------------------------------------------------------------
-- Órdenes de trabajo
-- ---------------------------------------------------------------------
CREATE TABLE orden_trabajo (
    id_ot            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_equipo        INT UNSIGNED NOT NULL,
    id_servicio_plan INT UNSIGNED,
    tipo             ENUM('PREVENTIVA','CORRECTIVA') NOT NULL,
    estado           ENUM('PROGRAMADA','EN_CURSO','CERRADA') NOT NULL DEFAULT 'PROGRAMADA',
    numero_ot        VARCHAR(20) NOT NULL UNIQUE,   -- correlativo; guarda los números de la planilla (89867...)
    fecha_programada DATE,
    fecha_ejecucion  DATE,
    horometro_cierre DECIMAL(10,1),
    observaciones    TEXT,
    creado_en        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_ot_equipo   FOREIGN KEY (id_equipo)        REFERENCES equipo(id_equipo),
    CONSTRAINT fk_ot_servicio FOREIGN KEY (id_servicio_plan) REFERENCES servicio_plan(id_servicio_plan),
    INDEX ix_ot_estado (estado)
);  -- Reemplaza la "PLANILLA DE V168": todas las OT de una máquina

CREATE TABLE orden_trabajo_insumo (
    id_ot           INT UNSIGNED NOT NULL,
    id_insumo       INT UNSIGNED NOT NULL,
    cantidad_usada  DECIMAL(10,2) NOT NULL,
    notas           VARCHAR(255),   -- imprevistos en terreno ("cambiar correas según condición")
    PRIMARY KEY (id_ot, id_insumo),
    CONSTRAINT fk_oti_ot     FOREIGN KEY (id_ot)     REFERENCES orden_trabajo(id_ot),
    CONSTRAINT fk_oti_insumo FOREIGN KEY (id_insumo) REFERENCES insumo(id_insumo)
);  -- Insumos reales usados en una OT

-- ---------------------------------------------------------------------
-- Soporte (sin cambios respecto al esquema original)
-- ---------------------------------------------------------------------
CREATE TABLE auditoria (
    id_auditoria    BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario      INT UNSIGNED NOT NULL,
    fecha_hora      DATETIME(3) NOT NULL,
    entidad         VARCHAR(40) NOT NULL,
    id_registro     BIGINT UNSIGNED NOT NULL,
    operacion       ENUM('INSERT','UPDATE','DELETE') NOT NULL,
    valor_anterior  JSON,
    valor_nuevo     JSON,
    ip              VARCHAR(45),
    CONSTRAINT fk_auditoria_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE archivo_adjunto (
    id_archivo       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario_subio INT UNSIGNED NOT NULL,
    entidad          VARCHAR(40)  NOT NULL,
    id_registro      BIGINT UNSIGNED NOT NULL,
    nombre_original  VARCHAR(255) NOT NULL,
    ruta             VARCHAR(500) NOT NULL,
    mime             VARCHAR(100),
    subido_en        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_archivo_usuario FOREIGN KEY (id_usuario_subio) REFERENCES usuario(id_usuario)
);

CREATE TABLE notificacion (
    id_notificacion    BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario_destino INT UNSIGNED NOT NULL,
    id_equipo          INT UNSIGNED,
    tipo               VARCHAR(30) NOT NULL,
    contenido          JSON,
    estado             ENUM('PENDIENTE','ENVIADA','ERROR'),
    enviada_en         DATETIME,
    CONSTRAINT fk_notificacion_usuario FOREIGN KEY (id_usuario_destino) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_notificacion_equipo  FOREIGN KEY (id_equipo)          REFERENCES equipo(id_equipo)
);  -- Fuera del MVP; sirve para avisos multicanal (ej. enviar el código de 2 pasos)

-- =====================================================================
-- TRIGGERS: códigos y nombres automáticos
-- =====================================================================
DELIMITER $$

-- Tipo: si no se indica prefijo, se arma con las iniciales de las dos
-- primeras palabras ("Grúa horquilla" -> GH) o las dos primeras letras
-- ("Generador" -> GE). La app puede mandar uno propio si este choca.
CREATE TRIGGER trg_tipo_equipo_prefijo
BEFORE INSERT ON tipo_equipo
FOR EACH ROW
BEGIN
    DECLARE limpio VARCHAR(60);
    IF NEW.prefijo IS NULL OR NEW.prefijo = '' THEN
        SET limpio = UPPER(TRIM(REPLACE(REPLACE(REPLACE(NEW.nombre, ' de ', ' '), ' del ', ' '), ' la ', ' ')));
        IF LOCATE(' ', limpio) > 0 THEN
            SET NEW.prefijo = CONCAT(LEFT(limpio, 1), LEFT(TRIM(SUBSTRING(limpio, LOCATE(' ', limpio) + 1)), 1));
        ELSE
            SET NEW.prefijo = LEFT(limpio, 2);
        END IF;
        -- quitar tildes de la primera letra (Ó -> O, Á -> A...)
        SET NEW.prefijo = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(NEW.prefijo, 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U');
    END IF;
END$$

-- Equipo: código = prefijo del tipo + correlativo de 3 dígitos (GH-001, GH-002...)
--         nombre = tipo + marca + modelo + detalle
CREATE TRIGGER trg_equipo_autocompletar
BEFORE INSERT ON equipo
FOR EACH ROW
BEGIN
    DECLARE v_prefijo VARCHAR(5);
    DECLARE v_tipo    VARCHAR(60);
    DECLARE v_ultimo  INT UNSIGNED;

    SELECT prefijo, nombre INTO v_prefijo, v_tipo
    FROM tipo_equipo WHERE id_tipo_equipo = NEW.id_tipo_equipo;

    IF NEW.codigo IS NULL OR NEW.codigo = '' THEN
        SELECT COALESCE(MAX(CAST(SUBSTRING(codigo, LENGTH(v_prefijo) + 2) AS UNSIGNED)), 0)
          INTO v_ultimo
          FROM equipo
         WHERE codigo LIKE CONCAT(v_prefijo, '-%');
        SET NEW.codigo = CONCAT(v_prefijo, '-', LPAD(v_ultimo + 1, 3, '0'));
    END IF;

    IF NEW.nombre IS NULL OR NEW.nombre = '' THEN
        SET NEW.nombre = CONCAT_WS(' ', v_tipo, NULLIF(NEW.marca, ''), NULLIF(NEW.modelo, ''), NULLIF(NEW.detalle, ''));
    END IF;

    IF NEW.patente IS NOT NULL THEN
        SET NEW.patente = UPPER(REPLACE(REPLACE(NEW.patente, '-', ''), ' ', ''));
        IF NEW.patente = '' THEN SET NEW.patente = NULL; END IF;
    END IF;
END$$

-- Arriendo: número correlativo ARR-0001; el equipo pasa a EN_FAENA y toma la ubicación de la faena
CREATE TRIGGER trg_arriendo_numero
BEFORE INSERT ON arriendo
FOR EACH ROW
BEGIN
    DECLARE v_ultimo INT UNSIGNED;
    IF NEW.numero IS NULL OR NEW.numero = '' THEN
        SELECT COALESCE(MAX(CAST(SUBSTRING(numero, 5) AS UNSIGNED)), 0) INTO v_ultimo FROM arriendo;
        SET NEW.numero = CONCAT('ARR-', LPAD(v_ultimo + 1, 4, '0'));
    END IF;
END$$

CREATE TRIGGER trg_arriendo_equipo
AFTER INSERT ON arriendo
FOR EACH ROW
BEGIN
    IF NEW.estado = 'VIGENTE' THEN
        UPDATE equipo e
          LEFT JOIN faena f ON f.id_faena = NEW.id_faena
           SET e.estado    = 'EN_FAENA',
               e.ubicacion = COALESCE(f.nombre, e.ubicacion),
               e.latitud   = COALESCE(f.latitud, e.latitud),
               e.longitud  = COALESCE(f.longitud, e.longitud)
         WHERE e.id_equipo = NEW.id_equipo;
    END IF;
END$$

-- Al terminar un arriendo el equipo vuelve al taller como DISPONIBLE
CREATE TRIGGER trg_arriendo_termino
AFTER UPDATE ON arriendo
FOR EACH ROW
BEGIN
    IF OLD.estado = 'VIGENTE' AND NEW.estado = 'TERMINADO' THEN
        UPDATE equipo SET estado = 'DISPONIBLE', ubicacion = 'Taller', velocidad_kmh = 0
         WHERE id_equipo = NEW.id_equipo AND estado = 'EN_FAENA';
    END IF;
END$$

-- Cada señal GPS actualiza la posición, el horómetro y la hora de la última señal del equipo
CREATE TRIGGER trg_telemetria_posicion
AFTER INSERT ON telemetria_equipo
FOR EACH ROW
BEGIN
    UPDATE equipo
       SET latitud          = COALESCE(NEW.latitud, latitud),
           longitud         = COALESCE(NEW.longitud, longitud),
           velocidad_kmh    = COALESCE(NEW.velocidad_kmh, velocidad_kmh),
           horometro_actual = GREATEST(horometro_actual, COALESCE(NEW.horometro, horometro_actual)),
           ultima_senal     = GREATEST(COALESCE(ultima_senal, NEW.ts), NEW.ts)
     WHERE id_equipo = NEW.id_equipo;
END$$

-- Al cerrar una OT se registra el horómetro como último servicio y el equipo vuelve a su estado previo
CREATE TRIGGER trg_ot_cierre
AFTER UPDATE ON orden_trabajo
FOR EACH ROW
BEGIN
    IF OLD.estado <> 'CERRADA' AND NEW.estado = 'CERRADA' THEN
        UPDATE equipo
           SET ultimo_servicio = COALESCE(NEW.horometro_cierre, horometro_actual),
               estado          = IF(estado = 'EN_MANTENIMIENTO', COALESCE(estado_previo, 'DISPONIBLE'), estado),
               estado_previo   = NULL
         WHERE id_equipo = NEW.id_equipo;
    END IF;
END$$

DELIMITER ;

-- =====================================================================
-- VISTAS: el dashboard y las listas leen de las mismas vistas
-- =====================================================================

-- Parámetros del aviso "por vencer"
CREATE OR REPLACE VIEW v_parametros AS
SELECT 100  AS umbral_horas,
       1000 AS umbral_km,
       10   AS minutos_sin_senal;   -- sin señal si no reporta hace más de 10 min

-- Ficha completa de cada equipo (ID formateado, telemetría, cliente y arriendo vigente)
CREATE OR REPLACE VIEW v_equipo AS
SELECT e.id_equipo,
       CONCAT('#', LPAD(e.id_equipo, 4, '0'))                        AS id_txt,
       e.codigo, e.codigo_anterior, e.nombre,
       t.id_tipo_equipo, t.nombre AS tipo, t.prefijo, t.unidad_medida,
       e.marca, e.modelo, e.detalle, e.patente, e.numero_serie,
       e.estado, e.horometro_actual, e.ultimo_servicio,
       COALESCE(e.telemetria_id, CONCAT('TLM-', LPAD(e.id_equipo, 4, '0'))) AS telemetria_id,
       e.latitud, e.longitud, e.ubicacion, e.velocidad_kmh, e.ultima_senal,
       (e.ultima_senal IS NOT NULL
        AND e.ultima_senal >= NOW() - INTERVAL p.minutos_sin_senal MINUTE) AS con_senal,
       a.id_arriendo, a.numero AS arriendo, c.id_cliente, c.razon_social AS cliente,
       e.creado_en
FROM equipo e
JOIN tipo_equipo t ON t.id_tipo_equipo = e.id_tipo_equipo
LEFT JOIN arriendo a ON a.id_equipo = e.id_equipo AND a.estado = 'VIGENTE'
LEFT JOIN cliente  c ON c.id_cliente = a.id_cliente
CROSS JOIN v_parametros p;

-- Próximo mantenimiento de cada equipo
--   base     = intervalo más corto de su pauta (ej. 250 h)
--   vence en = último servicio + base
--   servicio = el intervalo más grande que "cae" en ese múltiplo (250, 500, 1000 o 2000)
CREATE OR REPLACE VIEW v_proximo_mantenimiento AS
SELECT x.*,
       (SELECT MAX(sp.intervalo_horas)
          FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan
         WHERE pm.id_tipo_equipo = x.id_tipo_equipo
           AND MOD(x.nominal, sp.intervalo_horas) = 0)                AS proximo_servicio,
       CASE
         WHEN x.base IS NULL THEN 'SIN_PLAN'
         WHEN x.restante < 0 THEN 'VENCIDO'
         WHEN x.restante <= IF(x.unidad_medida = 'KM', p.umbral_km, p.umbral_horas) THEN 'POR_VENCER'
         ELSE 'AL_DIA'
       END                                                            AS estado_mantencion
FROM (
    SELECT v.*,
           b.base,
           v.ultimo_servicio + b.base                                 AS vence_en,
           (FLOOR(v.ultimo_servicio / b.base) + 1) * b.base           AS nominal,
           (v.ultimo_servicio + b.base) - v.horometro_actual          AS restante
    FROM v_equipo v
    LEFT JOIN (SELECT pm.id_tipo_equipo, MIN(sp.intervalo_horas) AS base
                 FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan
                GROUP BY pm.id_tipo_equipo) b ON b.id_tipo_equipo = v.id_tipo_equipo
) x
CROSS JOIN v_parametros p;

-- Los números del dashboard. Cada columna cuenta exactamente las filas de
-- v_proximo_mantenimiento / orden_trabajo que muestra la lista correspondiente.
CREATE OR REPLACE VIEW v_dashboard AS
SELECT
    (SELECT COUNT(*) FROM v_proximo_mantenimiento)                                         AS equipos,
    (SELECT COUNT(*) FROM v_proximo_mantenimiento WHERE estado = 'DISPONIBLE')             AS disponibles,
    (SELECT COUNT(*) FROM v_proximo_mantenimiento WHERE estado = 'EN_FAENA')               AS en_faena,
    (SELECT COUNT(DISTINCT id_cliente) FROM v_proximo_mantenimiento WHERE estado = 'EN_FAENA') AS clientes_en_faena,
    (SELECT COUNT(*) FROM v_proximo_mantenimiento WHERE con_senal = 1)                     AS con_senal,
    (SELECT COUNT(*) FROM v_proximo_mantenimiento WHERE con_senal = 0)                     AS sin_senal,
    (SELECT COUNT(*) FROM v_proximo_mantenimiento WHERE estado_mantencion = 'VENCIDO')     AS mantencion_vencida,
    (SELECT COUNT(*) FROM v_proximo_mantenimiento WHERE estado_mantencion = 'POR_VENCER')  AS mantencion_por_vencer,
    (SELECT COUNT(*) FROM orden_trabajo WHERE estado <> 'CERRADA')                         AS ot_abiertas,
    (SELECT COUNT(*) FROM orden_trabajo)                                                   AS ot_historial;

-- Equipos disponibles para arrendar (la barra de Arriendos), el más nuevo primero
CREATE OR REPLACE VIEW v_disponibles_arriendo AS
SELECT id_equipo, id_txt, codigo, nombre, tipo, ubicacion
FROM v_equipo WHERE estado = 'DISPONIBLE'
ORDER BY id_equipo DESC;
