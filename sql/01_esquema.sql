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
--    * Roles (administrador, planificador, técnico) y auditoría automática
--    * Vistas para el dashboard: cada número sale de la misma consulta
--      que la lista a la que lleva, así siempre coinciden.
--
--  Reglas de negocio alineadas con el MVP del equipo (kbdd23/vilas_motorMVP_E2):
--    * Próximo servicio: por cada servicio del plan, intervalo - (horómetro
--      actual - horómetro de cierre de su última OT cerrada); manda el que
--      está más cerca de vencer. Por vencer: dentro de 100 h (o 1.000 km).
--    * Una lectura de horómetro no puede ser negativa ni menor a la actual.
--    * Iniciar una OT manda el equipo a EN_MANTENIMIENTO (solo si estaba
--      DISPONIBLE o INTERNO); cerrarla mueve el horómetro y lo devuelve a
--      su estado previo. Una OT cerrada no se modifica.
--    * Un arriendo se termina en dos pasos: cerrar el contrato y marcar el
--      regreso del equipo (CALL sp_marcar_regreso). Un equipo no puede
--      tener dos arriendos vigentes.
--
--  Orden de ejecución: 01_esquema.sql -> 02_datos.sql -> (04_datos_simulados.sql)
--                      -> 03_consultas.sql
--  Las cargas masivas usan SET @carga_datos = 1 para saltarse las
--  validaciones de negocio (los datos históricos ya vienen consistentes).
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
    fuente          ENUM('CLIENTE','TECNICO','PLANIFICACION','TELEMETRIA','INTERNO') NOT NULL,
    validada        TINYINT(1) NOT NULL DEFAULT 0,
    observacion     VARCHAR(255),
    CONSTRAINT fk_lectura_equipo  FOREIGN KEY (id_equipo)  REFERENCES equipo(id_equipo),
    CONSTRAINT fk_lectura_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT ck_lectura_valor   CHECK (valor >= 0),
    INDEX ix_lectura_equipo_fecha (id_equipo, fecha_hora)
);  -- Historial de horas reales reportadas (reemplaza la columna "Horómetro" del Excel)

CREATE TABLE solicitud_horometro (
    id_solicitud        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_equipo           INT UNSIGNED NOT NULL,
    id_cliente          INT UNSIGNED,                    -- NULL si se le pide al técnico o a uso interno
    id_usuario_solicita INT UNSIGNED NOT NULL,
    fuente              ENUM('CLIENTE','TECNICO','PLANIFICACION','TELEMETRIA','INTERNO') NOT NULL DEFAULT 'CLIENTE',
    fecha_solicitud     DATETIME NOT NULL,
    estado              ENUM('PENDIENTE','CUMPLIDA') NOT NULL DEFAULT 'PENDIENTE',
    fecha_resolucion    DATETIME,                        -- cuándo dejó de estar pendiente
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
-- Historial de auditoría. Las tablas principales se registran solas con
-- triggers (ver más abajo); los accesos (login/logout) los registra la app.
-- La app indica quién hace el cambio con:  SET @app_usuario = <id_usuario>;
CREATE TABLE auditoria (
    id_auditoria    BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario      INT UNSIGNED,                    -- NULL = acción del sistema (carga de datos, telemetría)
    fecha_hora      DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    entidad         VARCHAR(40) NOT NULL,            -- equipo, arriendo, orden_trabajo, usuario, sesion
    id_registro     BIGINT UNSIGNED NOT NULL,
    operacion       ENUM('INSERT','UPDATE','DELETE','LOGIN','LOGOUT','LOGIN_FALLIDO') NOT NULL,
    detalle         VARCHAR(255),                    -- NUEVO: texto legible ("Estado: Disponible → En faena")
    valor_anterior  JSON,
    valor_nuevo     JSON,
    ip              VARCHAR(45),
    CONSTRAINT fk_auditoria_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    INDEX ix_auditoria_fecha (fecha_hora),
    INDEX ix_auditoria_entidad (entidad, id_registro)
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
    DECLARE v_estado VARCHAR(20);
    IF COALESCE(@carga_datos, 0) = 0 AND NEW.estado = 'VIGENTE' THEN
        SELECT estado INTO v_estado FROM equipo WHERE id_equipo = NEW.id_equipo;
        IF v_estado <> 'DISPONIBLE' THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Solo se puede arrendar un equipo DISPONIBLE.';
        END IF;
        IF EXISTS (SELECT 1 FROM arriendo WHERE id_equipo = NEW.id_equipo AND estado = 'VIGENTE') THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El equipo ya tiene un arriendo vigente.';
        END IF;
    END IF;
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
    INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle, valor_nuevo)
    VALUES (@app_usuario, 'arriendo', NEW.id_arriendo, 'INSERT',
            CONCAT('Nuevo arriendo ', NEW.numero, ' · ', (SELECT codigo FROM equipo WHERE id_equipo = NEW.id_equipo),
                   ' a ', (SELECT razon_social FROM cliente WHERE id_cliente = NEW.id_cliente)),
            JSON_OBJECT('numero', NEW.numero, 'id_equipo', NEW.id_equipo, 'id_cliente', NEW.id_cliente, 'fecha_inicio', NEW.fecha_inicio));
END$$

-- Cerrar el contrato fija su fecha de término (hoy, si no se indica).
-- El equipo sigue EN_FAENA hasta que se marque su regreso (sp_marcar_regreso),
-- igual que en el MVP: cerrar el contrato y recibir la máquina son dos pasos.
CREATE TRIGGER trg_arriendo_cierre
BEFORE UPDATE ON arriendo
FOR EACH ROW
BEGIN
    IF OLD.estado = 'TERMINADO' AND NEW.estado = 'VIGENTE' AND COALESCE(@carga_datos, 0) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un arriendo terminado no se reabre: cree uno nuevo.';
    END IF;
    IF OLD.estado = 'VIGENTE' AND NEW.estado = 'TERMINADO'
       AND (NEW.fecha_termino IS NULL OR NEW.fecha_termino > CURDATE()) THEN
        SET NEW.fecha_termino = CURDATE();
    END IF;
END$$

CREATE TRIGGER trg_arriendo_termino
AFTER UPDATE ON arriendo
FOR EACH ROW
BEGIN
    IF OLD.estado <> NEW.estado OR NOT (OLD.fecha_termino <=> NEW.fecha_termino) THEN
        INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle, valor_anterior, valor_nuevo)
        VALUES (@app_usuario, 'arriendo', NEW.id_arriendo, 'UPDATE',
                CONCAT('Arriendo ', NEW.numero, ': ', OLD.estado, ' → ', NEW.estado),
                JSON_OBJECT('estado', OLD.estado, 'fecha_termino', OLD.fecha_termino),
                JSON_OBJECT('estado', NEW.estado, 'fecha_termino', NEW.fecha_termino));
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

-- Reglas de la OT (igual que el MVP):
--   PROGRAMADA -> EN_CURSO: solo si el equipo está DISPONIBLE o INTERNO
--   EN_CURSO   -> CERRADA : con horómetro de cierre >= horómetro actual
--   Una OT CERRADA no vuelve atrás.
CREATE TRIGGER trg_ot_validar
BEFORE UPDATE ON orden_trabajo
FOR EACH ROW
BEGIN
    DECLARE v_estado VARCHAR(20);
    DECLARE v_horometro DECIMAL(10,1);
    IF COALESCE(@carga_datos, 0) = 0 AND OLD.estado <> NEW.estado THEN
        SELECT estado, horometro_actual INTO v_estado, v_horometro FROM equipo WHERE id_equipo = NEW.id_equipo;
        IF OLD.estado = 'CERRADA' THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Una OT cerrada no se modifica: es el historial del equipo.';
        END IF;
        IF NEW.estado = 'EN_CURSO' AND v_estado NOT IN ('DISPONIBLE', 'INTERNO') THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Solo se inicia una OT si el equipo está DISPONIBLE o INTERNO.';
        END IF;
        IF NEW.estado = 'CERRADA' THEN
            IF OLD.estado <> 'EN_CURSO' THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Primero se inicia la OT (EN_CURSO) y luego se cierra.';
            END IF;
            IF NEW.horometro_cierre IS NULL OR NEW.horometro_cierre < v_horometro THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El horómetro de cierre no puede ser menor al horómetro actual del equipo.';
            END IF;
        END IF;
    END IF;
    IF NEW.estado = 'CERRADA' AND OLD.estado <> 'CERRADA' AND NEW.fecha_ejecucion IS NULL THEN
        SET NEW.fecha_ejecucion = CURDATE();
    END IF;
END$$

-- Iniciar una OT manda el equipo a mantenimiento recordando de dónde venía;
-- cerrarla deja la lectura del técnico, mueve el horómetro y lo devuelve a ese estado.
CREATE TRIGGER trg_ot_cierre
AFTER UPDATE ON orden_trabajo
FOR EACH ROW
BEGIN
    IF OLD.estado = 'PROGRAMADA' AND NEW.estado = 'EN_CURSO' THEN
        UPDATE equipo
           SET estado_previo = IF(estado = 'EN_MANTENIMIENTO', estado_previo, estado),
               estado        = 'EN_MANTENIMIENTO',
               ubicacion     = 'Taller'
         WHERE id_equipo = NEW.id_equipo;
    END IF;
    IF OLD.estado <> 'CERRADA' AND NEW.estado = 'CERRADA' THEN
        IF @app_usuario IS NOT NULL AND NEW.horometro_cierre IS NOT NULL THEN
            INSERT INTO lectura_horometro (id_equipo, id_usuario, valor, fecha_hora, fuente, validada, observacion)
            VALUES (NEW.id_equipo, @app_usuario, NEW.horometro_cierre, NOW(), 'TECNICO', 1,
                    CONCAT('Cierre de la OT ', NEW.numero_ot));
        END IF;
        UPDATE equipo
           SET horometro_actual = GREATEST(horometro_actual, COALESCE(NEW.horometro_cierre, horometro_actual)),
               ultimo_servicio  = COALESCE(NEW.horometro_cierre, horometro_actual),
               estado           = IF(estado = 'EN_MANTENIMIENTO', COALESCE(estado_previo, 'DISPONIBLE'), estado),
               estado_previo    = NULL
         WHERE id_equipo = NEW.id_equipo;
    END IF;
    IF OLD.estado <> NEW.estado THEN
        INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle, valor_anterior, valor_nuevo)
        VALUES (@app_usuario, 'orden_trabajo', NEW.id_ot, 'UPDATE',
                CONCAT('OT ', NEW.numero_ot, ': ', OLD.estado, ' → ', NEW.estado,
                       IF(NEW.estado = 'CERRADA', CONCAT(' a las ', COALESCE(NEW.horometro_cierre, '?')), '')),
                JSON_OBJECT('estado', OLD.estado), JSON_OBJECT('estado', NEW.estado, 'horometro_cierre', NEW.horometro_cierre));
    END IF;
END$$

-- Lecturas de horómetro: no negativas ni menores a la actual (una igual es válida).
-- Una lectura válida actualiza el horómetro del equipo.
CREATE TRIGGER trg_lectura_validar
BEFORE INSERT ON lectura_horometro
FOR EACH ROW
BEGIN
    DECLARE v_actual DECIMAL(10,1);
    IF COALESCE(@carga_datos, 0) = 0 THEN
        SELECT horometro_actual INTO v_actual FROM equipo WHERE id_equipo = NEW.id_equipo;
        IF NEW.valor < 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La lectura del horómetro no puede ser negativa.';
        END IF;
        IF NEW.valor < v_actual THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La lectura no puede ser menor al horómetro actual del equipo.';
        END IF;
        SET NEW.validada = 1;
    END IF;
END$$

CREATE TRIGGER trg_lectura_actualiza_equipo
AFTER INSERT ON lectura_horometro
FOR EACH ROW
BEGIN
    IF NEW.validada = 1 THEN
        UPDATE equipo SET horometro_actual = GREATEST(horometro_actual, NEW.valor)
         WHERE id_equipo = NEW.id_equipo;
    END IF;
END$$

-- Paso 2 del término de un arriendo: el equipo vuelve al taller como DISPONIBLE.
-- Solo si ya no tiene un contrato vigente (primero se cierra el contrato).
CREATE PROCEDURE sp_marcar_regreso(IN p_id_equipo INT UNSIGNED)
BEGIN
    IF EXISTS (SELECT 1 FROM arriendo WHERE id_equipo = p_id_equipo AND estado = 'VIGENTE') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Primero se cierra el contrato de arriendo.';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM equipo WHERE id_equipo = p_id_equipo AND estado = 'EN_FAENA') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El equipo no está en faena.';
    END IF;
    UPDATE equipo
       SET estado = 'DISPONIBLE', ubicacion = 'Taller', velocidad_kmh = 0
     WHERE id_equipo = p_id_equipo;
END$$

-- ---------------------------------------------------------------------
-- Auditoría automática de equipos, órdenes y usuarios
-- ---------------------------------------------------------------------
CREATE TRIGGER trg_auditoria_equipo_alta
AFTER INSERT ON equipo
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle, valor_nuevo)
    VALUES (@app_usuario, 'equipo', NEW.id_equipo, 'INSERT',
            CONCAT('Nuevo equipo #', LPAD(NEW.id_equipo, 4, '0'), ' ', NEW.codigo, ' · ', NEW.nombre),
            JSON_OBJECT('codigo', NEW.codigo, 'nombre', NEW.nombre, 'estado', NEW.estado, 'codigo_anterior', NEW.codigo_anterior));
END$$

-- Solo se registran cambios de estado (la posición GPS cambia cada pocos segundos y va en telemetria_equipo)
CREATE TRIGGER trg_auditoria_equipo_estado
AFTER UPDATE ON equipo
FOR EACH ROW
BEGIN
    IF OLD.estado <> NEW.estado THEN
        INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle, valor_anterior, valor_nuevo)
        VALUES (@app_usuario, 'equipo', NEW.id_equipo, 'UPDATE',
                CONCAT(NEW.codigo, ' · estado: ', OLD.estado, ' → ', NEW.estado),
                JSON_OBJECT('estado', OLD.estado), JSON_OBJECT('estado', NEW.estado));
    END IF;
END$$

CREATE TRIGGER trg_auditoria_ot_alta
AFTER INSERT ON orden_trabajo
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle, valor_nuevo)
    VALUES (@app_usuario, 'orden_trabajo', NEW.id_ot, 'INSERT',
            CONCAT('OT ', NEW.numero_ot, ' · ', (SELECT codigo FROM equipo WHERE id_equipo = NEW.id_equipo), ' · ', NEW.estado),
            JSON_OBJECT('numero_ot', NEW.numero_ot, 'id_equipo', NEW.id_equipo, 'estado', NEW.estado));
END$$

CREATE TRIGGER trg_auditoria_usuario_alta
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle, valor_nuevo)
    VALUES (@app_usuario, 'usuario', NEW.id_usuario, 'INSERT',
            CONCAT('Nuevo usuario ', NEW.nombre, ' (', NEW.email, ') con rol ', (SELECT nombre FROM rol WHERE id_rol = NEW.id_rol)),
            JSON_OBJECT('email', NEW.email, 'id_rol', NEW.id_rol, 'activo', NEW.activo));
END$$

-- Cambios de rol, activación, verificación en dos pasos y contraseña (sin guardar el hash)
CREATE TRIGGER trg_auditoria_usuario_cambio
AFTER UPDATE ON usuario
FOR EACH ROW
BEGIN
    IF OLD.id_rol <> NEW.id_rol THEN
        INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle, valor_anterior, valor_nuevo)
        VALUES (@app_usuario, 'usuario', NEW.id_usuario, 'UPDATE',
                CONCAT(NEW.email, ' · rol: ', (SELECT nombre FROM rol WHERE id_rol = OLD.id_rol), ' → ', (SELECT nombre FROM rol WHERE id_rol = NEW.id_rol)),
                JSON_OBJECT('id_rol', OLD.id_rol), JSON_OBJECT('id_rol', NEW.id_rol));
    END IF;
    IF OLD.activo <> NEW.activo THEN
        INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle, valor_anterior, valor_nuevo)
        VALUES (@app_usuario, 'usuario', NEW.id_usuario, 'UPDATE',
                CONCAT(NEW.email, IF(NEW.activo = 1, ' · cuenta reactivada', ' · cuenta desactivada')),
                JSON_OBJECT('activo', OLD.activo), JSON_OBJECT('activo', NEW.activo));
    END IF;
    IF OLD.dos_pasos_activo <> NEW.dos_pasos_activo THEN
        INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle, valor_anterior, valor_nuevo)
        VALUES (@app_usuario, 'usuario', NEW.id_usuario, 'UPDATE',
                CONCAT(NEW.email, IF(NEW.dos_pasos_activo = 1, ' · verificación en dos pasos activada', ' · verificación en dos pasos desactivada')),
                JSON_OBJECT('dos_pasos_activo', OLD.dos_pasos_activo), JSON_OBJECT('dos_pasos_activo', NEW.dos_pasos_activo));
    END IF;
    IF OLD.password_hash <> NEW.password_hash THEN
        INSERT INTO auditoria (id_usuario, entidad, id_registro, operacion, detalle)
        VALUES (@app_usuario, 'usuario', NEW.id_usuario, 'UPDATE', CONCAT(NEW.email, ' · contraseña cambiada'));
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

-- Estado de cada servicio del plan para cada equipo (regla del MVP):
--   último cierre = horómetro de cierre de la última OT CERRADA de ese servicio
--                   (si el equipo nunca lo ha hecho: su último servicio registrado,
--                    que en el MVP es 0; aquí permite cargar flota sin historial)
--   restante      = intervalo - (horómetro actual - último cierre)   (negativo = vencido)
CREATE OR REPLACE VIEW v_mantencion_servicio AS
SELECT e.id_equipo, sp.id_servicio_plan, sp.nombre AS servicio, sp.intervalo_horas,
       COALESCE((SELECT MAX(ot.horometro_cierre)
                   FROM orden_trabajo ot
                  WHERE ot.id_equipo = e.id_equipo
                    AND ot.id_servicio_plan = sp.id_servicio_plan
                    AND ot.estado = 'CERRADA'
                    AND ot.horometro_cierre IS NOT NULL), e.ultimo_servicio)          AS ultimo_cierre,
       sp.intervalo_horas - (e.horometro_actual -
       COALESCE((SELECT MAX(ot.horometro_cierre)
                   FROM orden_trabajo ot
                  WHERE ot.id_equipo = e.id_equipo
                    AND ot.id_servicio_plan = sp.id_servicio_plan
                    AND ot.estado = 'CERRADA'
                    AND ot.horometro_cierre IS NOT NULL), e.ultimo_servicio))         AS restante
FROM equipo e
JOIN plan_mantencion pm ON pm.id_tipo_equipo = e.id_tipo_equipo
JOIN servicio_plan sp   ON sp.id_plan = pm.id_plan;

-- Próximo mantenimiento de cada equipo: el servicio más cerca de vencer
CREATE OR REPLACE VIEW v_proximo_mantenimiento AS
SELECT v.*,
       s.id_servicio_plan,
       s.servicio,
       s.intervalo_horas                                              AS proximo_servicio,
       s.ultimo_cierre,
       s.ultimo_cierre + s.intervalo_horas                            AS vence_en,
       s.restante,
       CASE
         WHEN s.id_servicio_plan IS NULL THEN 'SIN_PLAN'
         WHEN s.restante < 0 THEN 'VENCIDO'
         WHEN s.restante <= IF(v.unidad_medida = 'KM', p.umbral_km, p.umbral_horas) THEN 'POR_VENCER'
         ELSE 'AL_DIA'
       END                                                            AS estado_mantencion
FROM v_equipo v
LEFT JOIN (
    SELECT ms.*, ROW_NUMBER() OVER (PARTITION BY ms.id_equipo ORDER BY ms.restante, ms.intervalo_horas) AS n
    FROM v_mantencion_servicio ms
) s ON s.id_equipo = v.id_equipo AND s.n = 1
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

-- Historial de auditoría legible, lo más reciente primero
CREATE OR REPLACE VIEW v_auditoria AS
SELECT a.id_auditoria, a.fecha_hora,
       COALESCE(u.nombre, 'Sistema') AS usuario, u.email,
       CASE a.operacion
         WHEN 'INSERT' THEN 'Crear' WHEN 'UPDATE' THEN 'Actualizar' WHEN 'DELETE' THEN 'Eliminar'
         WHEN 'LOGIN' THEN 'Acceso' WHEN 'LOGOUT' THEN 'Acceso' ELSE 'Alerta' END AS accion,
       a.entidad AS modulo, a.id_registro, a.detalle, a.valor_anterior, a.valor_nuevo, a.ip
FROM auditoria a
LEFT JOIN usuario u ON u.id_usuario = a.id_usuario
ORDER BY a.id_auditoria DESC;

-- Usuarios con su rol, para la pantalla de Administración (el más nuevo primero)
CREATE OR REPLACE VIEW v_usuarios AS
SELECT u.id_usuario, CONCAT('U-', LPAD(u.id_usuario, 4, '0')) AS id_txt, u.nombre, u.email,
       r.nombre AS rol, u.activo, u.dos_pasos_activo, u.ultimo_acceso, u.creado_en
FROM usuario u JOIN rol r ON r.id_rol = u.id_rol
ORDER BY u.id_usuario DESC;

-- Equipos disponibles para arrendar (la barra de Arriendos), el más nuevo primero
CREATE OR REPLACE VIEW v_disponibles_arriendo AS
SELECT id_equipo, id_txt, codigo, nombre, tipo, ubicacion
FROM v_equipo WHERE estado = 'DISPONIBLE'
ORDER BY id_equipo DESC;
