-- =====================================================================
--  VILAS MOTOR - Datos iniciales
--  Lo marcado "planilla" viene de PLANILLA DE V168.xlsx y
--  PAUTA INSUMOS GENERADOR G45QX.xlsx. El resto es de ejemplo y
--  coincide con la maqueta (vilas-motor-flota.html).
-- =====================================================================
USE vilas_motor;

-- ---------------------------------------------------------------------
-- Roles y usuario de la demo
--   email: planificador@vilasmotor.cl   clave: VilasMotor2026
--   (hash en formato Django pbkdf2_sha256; la clave nunca se guarda en texto)
-- ---------------------------------------------------------------------
INSERT INTO rol (nombre, descripcion) VALUES
  ('PLANIFICADOR', 'Gestiona flota, mantenciones, arriendos y órdenes de trabajo'),
  ('TECNICO',      'Ejecuta órdenes de trabajo y registra insumos'),
  ('CLIENTE',      'Reporta horómetros de los equipos arrendados');

INSERT INTO usuario (id_rol, nombre, email, password_hash, dos_pasos_activo) VALUES
  ((SELECT id_rol FROM rol WHERE nombre = 'PLANIFICADOR'), 'Planificador Vilas Motor', 'planificador@vilasmotor.cl',
   'pbkdf2_sha256$1000000$gHYvi_fmyFIuI7D77iOB5w$sJzkxgOhHyHKjYvdXfvAC4+vdVPGDFnp3cC6vOPSm80=', 1);

-- ---------------------------------------------------------------------
-- Clientes
-- ---------------------------------------------------------------------
INSERT INTO cliente (rut, razon_social, email_contacto, telefono) VALUES
  ('76.543.210-K', 'Minera Cerro Dragón SpA',          'contacto@cerrodragon.cl', '+56 57 234 1100'),
  ('77.111.222-3', 'Constructora Altiplano Ltda',      'obras@altiplano.cl',      '+56 57 241 8820'),
  ('78.222.333-4', 'Servicios Portuarios Iquique SpA', 'admin@spi.cl',            '+56 57 251 3340'),
  ('79.333.444-5', 'Áridos del Norte Ltda',            'ventas@aridosnorte.cl',   '+56 57 262 7710'),
  ('80.444.555-6', 'Logística Tarapacá SpA',           'flota@logtarapaca.cl',    '+56 57 271 0099');

-- ---------------------------------------------------------------------
-- Faenas (coordenadas de ejemplo en la Región de Tarapacá)
-- ---------------------------------------------------------------------
INSERT INTO faena (nombre, latitud, longitud) VALUES
  ('Taller Vilas Motor',          -20.244800, -70.139300),
  ('Puerto de Iquique',           -20.205200, -70.150800),
  ('Zofri, Iquique',              -20.219500, -70.137000),
  ('Alto Hospicio',               -20.269000, -70.098600),
  ('Faena Pozo Almonte',          -20.256900, -69.785900),
  ('Faena minera Cerro Colorado', -20.045000, -69.262000);

-- ---------------------------------------------------------------------
-- Tipos de equipo: el prefijo se genera solo (GH, GE, EX, RE, CA)
-- ---------------------------------------------------------------------
INSERT INTO tipo_equipo (nombre, unidad_medida) VALUES
  ('Grúa horquilla',  'HORAS'),
  ('Generador',       'HORAS'),
  ('Excavadora',      'HORAS'),
  ('Retroexcavadora', 'HORAS'),
  ('Camión',          'KM');

-- ---------------------------------------------------------------------
-- Insumos
-- ---------------------------------------------------------------------
INSERT INTO insumo (codigo, nombre, unidad_medida) VALUES
  ('INS-001', 'ACEITE MOTOR 15W40 (Total Rubia Tir 7400)', 'LTS'),   -- planilla
  ('INS-002', 'FILTRO ACEITE DE MOTOR 02/971635',          'UN'),    -- planilla
  ('INS-003', 'FILTRO COMBUSTIBLE 02/971620',              'UN'),    -- planilla
  ('INS-004', 'FILTRO DE AIRE EXTERIOR 02/971664',         'UN'),    -- planilla
  ('INS-005', 'FILTRO DE AIRE INTERIOR',                   'UN'),    -- planilla
  ('INS-006', 'LOGO ADHESIVO MANTENCION',                  'UN'),    -- planilla
  ('INS-007', 'CORREA VENTILADOR JCB G45QX',               'UN'),    -- planilla
  ('INS-008', 'REFRIGERANTE',                              'LTS');   -- planilla

-- ---------------------------------------------------------------------
-- Planes de mantención y sus servicios
-- ---------------------------------------------------------------------
INSERT INTO plan_mantencion (id_tipo_equipo, nombre)
SELECT id_tipo_equipo, CONCAT('Plan ', nombre) FROM tipo_equipo;

INSERT INTO servicio_plan (id_plan, nombre, intervalo_horas)
SELECT pm.id_plan, CONCAT(s.intervalo, IF(t.unidad_medida = 'KM', ' KM', ' HORAS')), s.intervalo
FROM plan_mantencion pm
JOIN tipo_equipo t ON t.id_tipo_equipo = pm.id_tipo_equipo
JOIN (
          SELECT 'Grúa horquilla' AS tipo, 250 AS intervalo UNION ALL SELECT 'Grúa horquilla', 500
UNION ALL SELECT 'Grúa horquilla', 1000 UNION ALL SELECT 'Grúa horquilla', 2000          -- planilla V168
UNION ALL SELECT 'Generador', 250   UNION ALL SELECT 'Generador', 500
UNION ALL SELECT 'Generador', 1000  UNION ALL SELECT 'Generador', 2000                   -- planilla G45QX
UNION ALL SELECT 'Excavadora', 500  UNION ALL SELECT 'Excavadora', 1000
UNION ALL SELECT 'Retroexcavadora', 500 UNION ALL SELECT 'Retroexcavadora', 1000
UNION ALL SELECT 'Camión', 10000    UNION ALL SELECT 'Camión', 20000
) s ON s.tipo = t.nombre;

-- Receta de insumos por servicio (tipo, intervalo, insumo, cantidad)
INSERT INTO servicio_plan_insumo (id_servicio_plan, id_insumo, cantidad)
SELECT sp.id_servicio_plan, i.id_insumo, r.cantidad
FROM (
          SELECT 'Generador' AS tipo, 250 AS intervalo, 'INS-001' AS insumo, 11 AS cantidad   -- planilla G45QX
UNION ALL SELECT 'Generador', 250,  'INS-002', 1  UNION ALL SELECT 'Generador', 250,  'INS-003', 1
UNION ALL SELECT 'Generador', 250,  'INS-004', 1  UNION ALL SELECT 'Generador', 250,  'INS-006', 1
UNION ALL SELECT 'Generador', 250,  'INS-008', 10
UNION ALL SELECT 'Generador', 500,  'INS-001', 11 UNION ALL SELECT 'Generador', 500,  'INS-002', 1
UNION ALL SELECT 'Generador', 500,  'INS-003', 1  UNION ALL SELECT 'Generador', 500,  'INS-004', 1
UNION ALL SELECT 'Generador', 500,  'INS-006', 1  UNION ALL SELECT 'Generador', 500,  'INS-007', 1
UNION ALL SELECT 'Generador', 1000, 'INS-001', 11 UNION ALL SELECT 'Generador', 1000, 'INS-002', 1
UNION ALL SELECT 'Generador', 1000, 'INS-003', 1  UNION ALL SELECT 'Generador', 1000, 'INS-004', 1
UNION ALL SELECT 'Generador', 1000, 'INS-005', 1  UNION ALL SELECT 'Generador', 1000, 'INS-006', 1
UNION ALL SELECT 'Generador', 2000, 'INS-001', 11 UNION ALL SELECT 'Generador', 2000, 'INS-002', 1
UNION ALL SELECT 'Generador', 2000, 'INS-003', 1  UNION ALL SELECT 'Generador', 2000, 'INS-004', 1
UNION ALL SELECT 'Generador', 2000, 'INS-005', 1  UNION ALL SELECT 'Generador', 2000, 'INS-006', 1
UNION ALL SELECT 'Grúa horquilla', 250,  'INS-001', 8 UNION ALL SELECT 'Grúa horquilla', 250,  'INS-002', 1
UNION ALL SELECT 'Grúa horquilla', 250,  'INS-003', 1 UNION ALL SELECT 'Grúa horquilla', 250,  'INS-004', 1
UNION ALL SELECT 'Grúa horquilla', 250,  'INS-006', 1
UNION ALL SELECT 'Grúa horquilla', 500,  'INS-001', 8 UNION ALL SELECT 'Grúa horquilla', 500,  'INS-002', 1
UNION ALL SELECT 'Grúa horquilla', 500,  'INS-003', 1 UNION ALL SELECT 'Grúa horquilla', 500,  'INS-004', 1
UNION ALL SELECT 'Grúa horquilla', 500,  'INS-006', 1
UNION ALL SELECT 'Grúa horquilla', 1000, 'INS-001', 8 UNION ALL SELECT 'Grúa horquilla', 1000, 'INS-002', 1
UNION ALL SELECT 'Grúa horquilla', 1000, 'INS-003', 1 UNION ALL SELECT 'Grúa horquilla', 1000, 'INS-004', 1
UNION ALL SELECT 'Grúa horquilla', 1000, 'INS-005', 1 UNION ALL SELECT 'Grúa horquilla', 1000, 'INS-006', 1
UNION ALL SELECT 'Grúa horquilla', 2000, 'INS-001', 8 UNION ALL SELECT 'Grúa horquilla', 2000, 'INS-002', 1
UNION ALL SELECT 'Grúa horquilla', 2000, 'INS-003', 1 UNION ALL SELECT 'Grúa horquilla', 2000, 'INS-004', 1
UNION ALL SELECT 'Grúa horquilla', 2000, 'INS-005', 1 UNION ALL SELECT 'Grúa horquilla', 2000, 'INS-006', 1
UNION ALL SELECT 'Excavadora', 500,  'INS-001', 16 UNION ALL SELECT 'Excavadora', 500,  'INS-002', 1
UNION ALL SELECT 'Excavadora', 500,  'INS-003', 2  UNION ALL SELECT 'Excavadora', 500,  'INS-004', 1
UNION ALL SELECT 'Excavadora', 1000, 'INS-001', 16 UNION ALL SELECT 'Excavadora', 1000, 'INS-002', 1
UNION ALL SELECT 'Excavadora', 1000, 'INS-003', 2  UNION ALL SELECT 'Excavadora', 1000, 'INS-004', 1
UNION ALL SELECT 'Excavadora', 1000, 'INS-005', 1
UNION ALL SELECT 'Retroexcavadora', 500,  'INS-001', 8 UNION ALL SELECT 'Retroexcavadora', 500,  'INS-002', 1
UNION ALL SELECT 'Retroexcavadora', 500,  'INS-003', 1 UNION ALL SELECT 'Retroexcavadora', 500,  'INS-004', 1
UNION ALL SELECT 'Retroexcavadora', 1000, 'INS-001', 8 UNION ALL SELECT 'Retroexcavadora', 1000, 'INS-002', 1
UNION ALL SELECT 'Retroexcavadora', 1000, 'INS-003', 1 UNION ALL SELECT 'Retroexcavadora', 1000, 'INS-004', 1
UNION ALL SELECT 'Retroexcavadora', 1000, 'INS-005', 1
UNION ALL SELECT 'Camión', 10000, 'INS-001', 24 UNION ALL SELECT 'Camión', 10000, 'INS-002', 1
UNION ALL SELECT 'Camión', 10000, 'INS-003', 2  UNION ALL SELECT 'Camión', 10000, 'INS-004', 1
UNION ALL SELECT 'Camión', 20000, 'INS-001', 24 UNION ALL SELECT 'Camión', 20000, 'INS-002', 1
UNION ALL SELECT 'Camión', 20000, 'INS-003', 2  UNION ALL SELECT 'Camión', 20000, 'INS-004', 1
UNION ALL SELECT 'Camión', 20000, 'INS-005', 1
) r
JOIN tipo_equipo t      ON t.nombre = r.tipo
JOIN plan_mantencion pm ON pm.id_tipo_equipo = t.id_tipo_equipo
JOIN servicio_plan sp   ON sp.id_plan = pm.id_plan AND sp.intervalo_horas = r.intervalo
JOIN insumo i           ON i.codigo = r.insumo;

-- ---------------------------------------------------------------------
-- Equipos: se insertan SIN código ni nombre; el trigger los genera.
-- El orden de inserción da el ID correlativo (#0001, #0002...).
-- ---------------------------------------------------------------------
INSERT INTO equipo (id_tipo_equipo, codigo, codigo_anterior, nombre, marca, modelo, detalle, patente, numero_serie,
                    estado, horometro_actual, ultimo_servicio, ubicacion, latitud, longitud)
VALUES
  ((SELECT id_tipo_equipo FROM tipo_equipo WHERE nombre = 'Grúa horquilla'),  '', 'V168',    '', 'Toyota',        '8FGU25',      '3.5 ton', 'SVTJ39', '8FGU25-V168',
   'EN_FAENA',          3620.0,   3157.0, 'Puerto de Iquique',      -20.205200, -70.150800),   -- planilla: grúa 3.5 ton PPU SVTJ39, último servicio 1000 h a las 3157 h
  ((SELECT id_tipo_equipo FROM tipo_equipo WHERE nombre = 'Generador'),       '', 'VG10',    '', 'JCB',           'G45QX',       NULL,      NULL,     'JCBG45QX-2023-018',
   'EN_FAENA',           480.0,    250.0, 'Faena Pozo Almonte',     -20.256900, -69.785900),   -- planilla: generadores VG10 - VG11
  ((SELECT id_tipo_equipo FROM tipo_equipo WHERE nombre = 'Generador'),       '', 'VG11',    '', 'JCB',           'G45QX',       NULL,      NULL,     'JCBG45QX-2023-019',
   'DISPONIBLE',        1105.0,   1000.0, 'Taller',                 -20.245200, -70.138900),
  ((SELECT id_tipo_equipo FROM tipo_equipo WHERE nombre = 'Excavadora'),      '', 'EX-204',  '', 'Caterpillar',   '320',         NULL,      NULL,     'CAT0320-EX204',
   'EN_MANTENIMIENTO',  3120.0,   2500.0, 'Taller',                 -20.244400, -70.139800),
  ((SELECT id_tipo_equipo FROM tipo_equipo WHERE nombre = 'Retroexcavadora'), '', 'RET-118', '', 'JCB',           '3CX',         NULL,      NULL,     'JCB3CX-RET118',
   'DISPONIBLE',        1450.5,   1000.0, 'Taller',                 -20.245500, -70.140100),
  ((SELECT id_tipo_equipo FROM tipo_equipo WHERE nombre = 'Camión'),          '', 'CAM-301', '', 'Mercedes-Benz', 'Actros 2645', NULL,      'BJKT-45','WDB9640-CAM301',
   'EN_FAENA',        128400.0, 120000.0, 'Ruta 16, Alto Hospicio', -20.269000, -70.098600);

UPDATE equipo SET estado_previo = 'DISPONIBLE' WHERE codigo_anterior = 'EX-204';

-- ---------------------------------------------------------------------
-- Arriendos vigentes (el número ARR-0001... lo genera el trigger)
-- ---------------------------------------------------------------------
INSERT INTO arriendo (numero, id_equipo, id_cliente, id_faena, fecha_inicio, fecha_termino)
SELECT '', e.id_equipo, c.id_cliente, f.id_faena, a.desde, a.hasta
FROM (
          SELECT 1 AS orden, 'V168' AS equipo, 'Servicios Portuarios Iquique SpA' AS cliente, 'Puerto de Iquique' AS faena, DATE('2026-09-01') AS desde, DATE('2026-12-31') AS hasta
UNION ALL SELECT 2, 'VG10',    'Minera Cerro Dragón SpA', 'Faena Pozo Almonte', DATE('2026-10-05'), DATE('2026-11-30')
UNION ALL SELECT 3, 'CAM-301', 'Logística Tarapacá SpA',  'Alto Hospicio',      DATE('2026-10-20'), NULL
) a
JOIN equipo  e ON e.codigo_anterior = a.equipo
JOIN cliente c ON c.razon_social    = a.cliente
JOIN faena   f ON f.nombre          = a.faena
ORDER BY a.orden;

-- ---------------------------------------------------------------------
-- Señales GPS (telemetría). Cada fila actualiza la posición del equipo.
-- La excavadora EX-204 quedó sin señal hace 31 horas.
-- ---------------------------------------------------------------------
INSERT INTO telemetria_equipo (id_equipo, ts, horometro, latitud, longitud, velocidad_kmh, payload)
SELECT e.id_equipo, s.ts, s.horometro, s.lat, s.lng, s.vel, JSON_OBJECT('fuente', 'GPS', 'bateria', s.bat)
FROM (
          SELECT 'V168' AS equipo, NOW() - INTERVAL 1 MINUTE AS ts, 3620.0 AS horometro, -20.205200 AS lat, -70.150800 AS lng, 4 AS vel, 96 AS bat
UNION ALL SELECT 'VG10',    NOW() - INTERVAL 1 MINUTE,     480.0, -20.256900, -69.785900,  0, 88
UNION ALL SELECT 'VG11',    NOW() - INTERVAL 2 MINUTE,    1105.0, -20.245200, -70.138900,  0, 100
UNION ALL SELECT 'EX-204',  NOW() - INTERVAL 31 HOUR,     3120.0, -20.244400, -70.139800,  0, 12
UNION ALL SELECT 'RET-118', NOW() - INTERVAL 2 MINUTE,    1450.5, -20.245500, -70.140100,  0, 97
UNION ALL SELECT 'CAM-301', NOW() - INTERVAL 1 MINUTE,  128400.0, -20.269000, -70.098600, 68, 91
) s
JOIN equipo e ON e.codigo_anterior = s.equipo;

-- ---------------------------------------------------------------------
-- Órdenes de trabajo: historial real de la V168 (planilla) + una OT en curso
-- ---------------------------------------------------------------------
INSERT INTO orden_trabajo (id_equipo, id_servicio_plan, tipo, estado, numero_ot, fecha_programada, fecha_ejecucion, horometro_cierre)
SELECT e.id_equipo, sp.id_servicio_plan, 'PREVENTIVA', o.estado, o.numero, o.fecha, IF(o.estado = 'CERRADA', o.fecha, NULL), IF(o.estado = 'CERRADA', o.horometro, NULL)
FROM (
          SELECT 'V168' AS equipo, '89867' AS numero, DATE('2023-10-16') AS fecha, 250 AS servicio, 828.0 AS horometro, 'CERRADA' AS estado
UNION ALL SELECT 'V168', '90717',  DATE('2023-11-29'), 1000, 1083.0, 'CERRADA'
UNION ALL SELECT 'V168', '91902',  DATE('2024-02-05'),  250, 1325.0, 'CERRADA'
UNION ALL SELECT 'V168', '92935',  DATE('2024-04-04'),  500, 1575.0, 'CERRADA'
UNION ALL SELECT 'V168', '94281',  DATE('2024-07-05'),  250, 1803.0, 'CERRADA'
UNION ALL SELECT 'V168', '98470',  DATE('2025-02-26'), 2000, 2080.0, 'CERRADA'
UNION ALL SELECT 'V168', '100666', DATE('2025-06-26'),  250, 2363.0, 'CERRADA'
UNION ALL SELECT 'V168', '102477', DATE('2025-10-01'),  500, 2601.0, 'CERRADA'
UNION ALL SELECT 'V168', '105418', DATE('2026-03-13'),  500, 2896.0, 'CERRADA'
UNION ALL SELECT 'V168', '106948', DATE('2026-05-29'), 1000, 3157.0, 'CERRADA'
UNION ALL SELECT 'EX-204', '107012', DATE('2026-10-24'), 500, 3120.0, 'EN_CURSO'
) o
JOIN equipo e           ON e.codigo_anterior = o.equipo
JOIN plan_mantencion pm ON pm.id_tipo_equipo = e.id_tipo_equipo
JOIN servicio_plan sp   ON sp.id_plan = pm.id_plan AND sp.intervalo_horas = o.servicio
ORDER BY CAST(o.numero AS UNSIGNED);
