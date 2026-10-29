-- =====================================================================
--  VILAS MOTOR - Datos iniciales
--  Inventario: Equipos.xlsx (394 equipos enviados por el profesor,
--  normalizados; ver datos/equipos_normalizados.csv) + la V168.
--  Lo marcado "planilla" viene de PLANILLA DE V168.xlsx y
--  PAUTA INSUMOS GENERADOR G45QX.xlsx.
--  Usuarios, clientes y faenas son de ejemplo. Los estados, horómetros,
--  arriendos y señales GPS de demostración están en 04_datos_simulados.sql.
-- =====================================================================
USE vilas_motor;

-- ---------------------------------------------------------------------
-- Roles y usuarios de la demo
--   planificador@vilasmotor.cl  VilasMotor2026   Administrador
--   tecnico@vilasmotor.cl       TecnicoVM2026    Técnico
--   crojas@vilasmotor.cl        PlanificaVM2026  Planificador (desactivada)
--   (hash en formato Django pbkdf2_sha256; la clave nunca se guarda en texto)
-- ---------------------------------------------------------------------
SET @app_usuario = NULL;   -- la carga inicial queda registrada como "Sistema"

INSERT INTO rol (nombre, descripcion) VALUES
  ('ADMINISTRADOR', 'Todo el sistema, más crear usuarios y ver el historial de auditoría'),
  ('PLANIFICADOR',  'Gestiona flota, mantenciones, arriendos y órdenes de trabajo'),
  ('TECNICO',       'Ve la flota y ejecuta órdenes de trabajo'),
  ('CLIENTE',       'Reporta horómetros de los equipos arrendados');

INSERT INTO usuario (id_rol, nombre, email, password_hash, dos_pasos_activo, activo) VALUES
  ((SELECT id_rol FROM rol WHERE nombre = 'ADMINISTRADOR'), 'Planificador Vilas Motor', 'planificador@vilasmotor.cl',
   'pbkdf2_sha256$1000000$gHYvi_fmyFIuI7D77iOB5w$sJzkxgOhHyHKjYvdXfvAC4+vdVPGDFnp3cC6vOPSm80=', 1, 1),
  ((SELECT id_rol FROM rol WHERE nombre = 'TECNICO'), 'Juan Pérez', 'tecnico@vilasmotor.cl',
   'pbkdf2_sha256$1000000$Wxl_-VWUH9sp-9BYtR9OJQ$J6ApJIkSH9Vm8yVetNvInOXSobktTAikSsvnJ8/Y/IY=', 1, 1),
  ((SELECT id_rol FROM rol WHERE nombre = 'PLANIFICADOR'), 'Camila Rojas', 'crojas@vilasmotor.cl',
   'pbkdf2_sha256$1000000$BKbyx78MpoXupFhojIZT6Q$8eJhaGVaftSrqHt3A5aL7wc8TLQ+TLm3ea9MtKjsX6A=', 1, 0);

-- Desde aquí, los cambios quedan a nombre del administrador
SET @app_usuario = (SELECT id_usuario FROM usuario WHERE email = 'planificador@vilasmotor.cl');

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
-- Tipos de equipo, planes de mantención e inventario (generado desde Equipos.xlsx)
-- ---------------------------------------------------------------------
-- Tipos de equipo (prefijo explícito para que los códigos sean legibles)
INSERT INTO tipo_equipo (nombre, prefijo, unidad_medida) VALUES
  ('Grúa horquilla', 'GH', 'HORAS'),
  ('Generador', 'GE', 'HORAS'),
  ('Luminaria', 'LU', 'HORAS'),
  ('Luminaria solar', 'LS', 'HORAS'),
  ('Camioneta', 'CT', 'KM'),
  ('Retroexcavadora', 'RE', 'HORAS'),
  ('Compresor', 'CO', 'HORAS'),
  ('Camión pluma', 'CP', 'KM'),
  ('Pluma', 'PL', 'HORAS'),
  ('Camión', 'CA', 'KM'),
  ('Cama baja', 'CB', 'KM'),
  ('Tracto camión', 'TC', 'KM'),
  ('Manipulador', 'MA', 'HORAS'),
  ('Minicargador', 'MC', 'HORAS'),
  ('Soldadora', 'SO', 'HORAS'),
  ('Camión tolva', 'TV', 'KM'),
  ('Excavadora', 'EX', 'HORAS'),
  ('Cargador frontal', 'CF', 'HORAS'),
  ('Alza hombre', 'AH', 'HORAS'),
  ('Plataforma tijera', 'PT', 'HORAS'),
  ('Camión aljibe', 'AL', 'KM'),
  ('Furgón', 'FU', 'KM'),
  ('Rodillo compactador', 'RC', 'HORAS'),
  ('Minibús', 'MB', 'KM'),
  ('Camión lubricador', 'LB', 'KM'),
  ('Camión combustible', 'CC', 'KM'),
  ('Camión plataforma', 'PF', 'KM'),
  ('Camión plano', 'PN', 'KM'),
  ('Motoniveladora', 'MN', 'HORAS'),
  ('Camión rescate', 'RS', 'KM'),
  ('Camión pantalla', 'PA', 'KM'),
  ('Semirremolque', 'SR', 'KM'),
  ('Rampla', 'RA', 'KM');

-- Un plan de mantención por tipo, con sus servicios
INSERT INTO plan_mantencion (id_tipo_equipo, nombre)
SELECT id_tipo_equipo, CONCAT('Plan ', nombre) FROM tipo_equipo;

INSERT INTO servicio_plan (id_plan, nombre, intervalo_horas)
SELECT pm.id_plan, CONCAT(s.intervalo, IF(t.unidad_medida = 'KM', ' KM', ' HORAS')), s.intervalo
FROM plan_mantencion pm
JOIN tipo_equipo t ON t.id_tipo_equipo = pm.id_tipo_equipo
JOIN (
          SELECT 'Grúa horquilla' AS tipo, 250 AS intervalo
UNION ALL SELECT 'Grúa horquilla', 500
UNION ALL SELECT 'Grúa horquilla', 1000
UNION ALL SELECT 'Grúa horquilla', 2000
UNION ALL SELECT 'Generador', 250
UNION ALL SELECT 'Generador', 500
UNION ALL SELECT 'Generador', 1000
UNION ALL SELECT 'Generador', 2000
UNION ALL SELECT 'Luminaria', 250
UNION ALL SELECT 'Luminaria', 500
UNION ALL SELECT 'Luminaria', 1000
UNION ALL SELECT 'Luminaria solar', 1000
UNION ALL SELECT 'Luminaria solar', 2000
UNION ALL SELECT 'Camioneta', 10000
UNION ALL SELECT 'Camioneta', 20000
UNION ALL SELECT 'Retroexcavadora', 500
UNION ALL SELECT 'Retroexcavadora', 1000
UNION ALL SELECT 'Compresor', 500
UNION ALL SELECT 'Compresor', 1000
UNION ALL SELECT 'Camión pluma', 10000
UNION ALL SELECT 'Camión pluma', 20000
UNION ALL SELECT 'Pluma', 500
UNION ALL SELECT 'Pluma', 1000
UNION ALL SELECT 'Camión', 10000
UNION ALL SELECT 'Camión', 20000
UNION ALL SELECT 'Cama baja', 20000
UNION ALL SELECT 'Cama baja', 40000
UNION ALL SELECT 'Tracto camión', 10000
UNION ALL SELECT 'Tracto camión', 20000
UNION ALL SELECT 'Manipulador', 500
UNION ALL SELECT 'Manipulador', 1000
UNION ALL SELECT 'Minicargador', 250
UNION ALL SELECT 'Minicargador', 500
UNION ALL SELECT 'Minicargador', 1000
UNION ALL SELECT 'Soldadora', 250
UNION ALL SELECT 'Soldadora', 500
UNION ALL SELECT 'Camión tolva', 10000
UNION ALL SELECT 'Camión tolva', 20000
UNION ALL SELECT 'Excavadora', 500
UNION ALL SELECT 'Excavadora', 1000
UNION ALL SELECT 'Cargador frontal', 500
UNION ALL SELECT 'Cargador frontal', 1000
UNION ALL SELECT 'Alza hombre', 250
UNION ALL SELECT 'Alza hombre', 500
UNION ALL SELECT 'Alza hombre', 1000
UNION ALL SELECT 'Plataforma tijera', 250
UNION ALL SELECT 'Plataforma tijera', 500
UNION ALL SELECT 'Camión aljibe', 10000
UNION ALL SELECT 'Camión aljibe', 20000
UNION ALL SELECT 'Furgón', 10000
UNION ALL SELECT 'Furgón', 20000
UNION ALL SELECT 'Rodillo compactador', 250
UNION ALL SELECT 'Rodillo compactador', 500
UNION ALL SELECT 'Rodillo compactador', 1000
UNION ALL SELECT 'Minibús', 10000
UNION ALL SELECT 'Minibús', 20000
UNION ALL SELECT 'Camión lubricador', 10000
UNION ALL SELECT 'Camión lubricador', 20000
UNION ALL SELECT 'Camión combustible', 10000
UNION ALL SELECT 'Camión combustible', 20000
UNION ALL SELECT 'Camión plataforma', 10000
UNION ALL SELECT 'Camión plataforma', 20000
UNION ALL SELECT 'Camión plano', 10000
UNION ALL SELECT 'Camión plano', 20000
UNION ALL SELECT 'Motoniveladora', 500
UNION ALL SELECT 'Motoniveladora', 1000
UNION ALL SELECT 'Camión rescate', 10000
UNION ALL SELECT 'Camión rescate', 20000
UNION ALL SELECT 'Camión pantalla', 10000
UNION ALL SELECT 'Camión pantalla', 20000
UNION ALL SELECT 'Semirremolque', 20000
UNION ALL SELECT 'Semirremolque', 40000
UNION ALL SELECT 'Rampla', 20000
UNION ALL SELECT 'Rampla', 40000
) s ON s.tipo = t.nombre;

-- Inventario: 394 equipos de Equipos.xlsx (lista del profesor) + la V168 de la planilla de mantenciones.
-- ID y código van explícitos: #0001 es la V168 y desde #0002 el ID coincide con la fila del Excel. Estado inicial: DISPONIBLE en el taller.
INSERT INTO equipo (id_equipo, id_tipo_equipo, codigo, codigo_anterior, nombre, marca, modelo, detalle, patente, numero_serie, latitud, longitud) VALUES
  (1, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-001', 'V168', 'Grúa horquilla 3.5 ton', NULL, NULL, '3.5 ton', 'SVTJ39', NULL, -20.244800, -70.139300),   -- planilla V168
  (2, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-002', NULL, 'Grúa horquilla Komatsu FG20T-16 2 ton', 'Komatsu', 'FG20T-16', '2 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 2
  (3, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-003', NULL, 'Grúa horquilla Komatsu FD70-10 7 ton', 'Komatsu', 'FD70-10', '7 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 3
  (4, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-004', NULL, 'Grúa horquilla Komatsu FD70-10 7 ton', 'Komatsu', 'FD70-10', '7 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 4
  (5, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-005', NULL, 'Grúa horquilla Komatsu FD50AT-7 5 ton', 'Komatsu', 'FD50AT-7', '5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 5
  (6, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-006', NULL, 'Grúa horquilla Hangcha CPCD-35 3.5 ton', 'Hangcha', 'CPCD-35', '3.5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 6
  (7, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-007', NULL, 'Grúa horquilla Komatsu FG20T-16 2 ton', 'Komatsu', 'FG20T-16', '2 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 7
  (8, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RC'), 'RC-001', NULL, 'Rodillo compactador Hamm 3412', 'Hamm', '3412', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 8
  (9, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-008', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 9
  (10, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-009', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 10
  (11, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-010', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 11
  (12, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CF'), 'CF-001', NULL, 'Cargador frontal JCB 456ZX', 'JCB', '456ZX', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 12
  (13, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-011', NULL, 'Grúa horquilla Komatsu FD100-8 10 ton', 'Komatsu', 'FD100-8', '10 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 13
  (14, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-012', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 14
  (15, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-013', NULL, 'Grúa horquilla Komatsu FD50AT-10 5 ton', 'Komatsu', 'FD50AT-10', '5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 15
  (16, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-014', NULL, 'Grúa horquilla Komatsu FD50AT-10 5 ton', 'Komatsu', 'FD50AT-10', '5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 16
  (17, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-015', NULL, 'Grúa horquilla Komatsu FD50AT-10 5 ton', 'Komatsu', 'FD50AT-10', '5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 17
  (18, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'EX'), 'EX-001', NULL, 'Excavadora JCB JS220LC', 'JCB', 'JS220LC', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 18
  (19, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MA'), 'MA-001', NULL, 'Manipulador JCB 533-105 T', 'JCB', '533-105 T', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 19
  (20, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MA'), 'MA-002', NULL, 'Manipulador JCB 531 70 T', 'JCB', '531 70 T', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 20
  (21, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-016', NULL, 'Grúa horquilla Komatsu FD100-8 10 ton', 'Komatsu', 'FD100-8', '10 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 21
  (22, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-017', NULL, 'Grúa horquilla Komatsu FD70-10 7 ton', 'Komatsu', 'FD70-10', '7 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 22
  (23, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-018', NULL, 'Grúa horquilla Komatsu LRTL85 16 ton', 'Komatsu', 'LRTL85', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 23
  (24, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-001', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 24
  (25, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-002', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 25
  (26, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-019', NULL, 'Grúa horquilla Komatsu FD250-7 25 ton', 'Komatsu', 'FD250-7', '25 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 26
  (27, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-020', NULL, 'Grúa horquilla Komatsu FD70-10 7 ton', 'Komatsu', 'FD70-10', '7 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 27
  (28, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-021', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 28
  (29, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-022', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 29
  (30, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-023', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 30
  (31, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-024', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 31
  (32, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-025', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 32
  (33, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-003', NULL, 'Retroexcavadora JCB 3CX', 'JCB', '3CX', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 33
  (34, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-004', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 34
  (35, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-005', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 35
  (36, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-006', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, 'RCSZ64', NULL, -20.244800, -70.139300),   -- fila 36
  (37, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-026', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 37
  (38, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-027', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 38
  (39, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-028', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 39
  (40, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-029', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 40
  (41, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-030', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 41
  (42, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MA'), 'MA-003', NULL, 'Manipulador JCB 533-105 T', 'JCB', '533-105 T', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 42
  (43, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MA'), 'MA-004', NULL, 'Manipulador JCB 533-105 T', 'JCB', '533-105 T', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 43
  (44, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-031', NULL, 'Grúa horquilla Komatsu FD100-8 10 ton', 'Komatsu', 'FD100-8', '10 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 44
  (45, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-032', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 45
  (46, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-033', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 46
  (47, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-034', NULL, 'Grúa horquilla Hangcha CPCD-35 3.5 ton', 'Hangcha', 'CPCD-35', '3.5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 47
  (48, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-007', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, 'LPHL61', NULL, -20.244800, -70.139300),   -- fila 48
  (49, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-035', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 49
  (50, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-008', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 50
  (51, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-009', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 51
  (52, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-010', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 52
  (53, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-036', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 53
  (54, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-037', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 54
  (55, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-038', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 55
  (56, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-039', NULL, 'Grúa horquilla Komatsu FD70-10 7 ton', 'Komatsu', 'FD70-10', '7 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 56
  (57, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-040', NULL, 'Grúa horquilla Komatsu 3 ton', 'Komatsu', NULL, '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 57
  (58, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'EX'), 'EX-002', NULL, 'Excavadora JCB JS220LC', 'JCB', 'JS220LC', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 58
  (59, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'EX'), 'EX-003', NULL, 'Excavadora JCB JS220LC', 'JCB', 'JS220LC', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 59
  (60, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-041', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 60
  (61, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MC'), 'MC-001', NULL, 'Minicargador JCB 205 CAB AC', 'JCB', '205 CAB AC', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 61
  (62, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CF'), 'CF-002', NULL, 'Cargador frontal Sany SYL956H5', 'Sany', 'SYL956H5', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 62
  (63, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'EX'), 'EX-004', NULL, 'Excavadora JCB JS220LC', 'JCB', 'JS220LC', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 63
  (64, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-042', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 64
  (65, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-043', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 65
  (66, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-011', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 66
  (67, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-044', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 67
  (68, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-045', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 68
  (69, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-046', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 69
  (70, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-047', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 70
  (71, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-048', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 71
  (72, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-049', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 72
  (73, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-050', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 73
  (74, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-051', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 74
  (75, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-052', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 75
  (76, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-053', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 76
  (77, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-054', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 77
  (78, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-055', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 78
  (79, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-056', NULL, 'Grúa horquilla Komatsu FD30T-17 3 ton', 'Komatsu', 'FD30T-17', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 79
  (80, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'EX'), 'EX-005', NULL, 'Excavadora JCB JS220LC', 'JCB', 'JS220LC', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 80
  (81, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-057', NULL, 'Grúa horquilla Hangcha CPCD35 XW33CRT4 3.5 ton', 'Hangcha', 'CPCD35 XW33CRT4', '3.5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 81
  (82, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-058', NULL, 'Grúa horquilla Komatsu FD250-7 25 ton', 'Komatsu', 'FD250-7', '25 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 82
  (83, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-012', NULL, 'Retroexcavadora JCB 3CX', 'JCB', '3CX', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 83
  (84, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-013', NULL, 'Retroexcavadora JCB 3CX', 'JCB', '3CX', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 84
  (85, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-059', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 85
  (86, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-060', NULL, 'Grúa horquilla Komatsu FD160E-8 16 ton', 'Komatsu', 'FD160E-8', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 86
  (87, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-061', NULL, 'Grúa horquilla Hangcha CPCD50-RT4 4X4 3,6 AUT 5 ton', 'Hangcha', 'CPCD50-RT4 4X4 3,6 AUT', '5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 87
  (88, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-062', NULL, 'Grúa horquilla Hangcha CPCD35 4X4 3,3AUT 3.5 ton', 'Hangcha', 'CPCD35 4X4 3,3AUT', '3.5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 88
  (89, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-063', NULL, 'Grúa horquilla Hangcha CPCD35 4X4 3,3AUT 3.5 ton', 'Hangcha', 'CPCD35 4X4 3,3AUT', '3.5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 89
  (90, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MC'), 'MC-002', NULL, 'Minicargador JCB 270 CAB AC', 'JCB', '270 CAB AC', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 90
  (91, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CF'), 'CF-003', NULL, 'Cargador frontal JCB 455ZX', 'JCB', '455ZX', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 91
  (92, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CF'), 'CF-004', NULL, 'Cargador frontal JCB 455ZX', 'JCB', '455ZX', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 92
  (93, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MA'), 'MA-005', NULL, 'Manipulador JCB 533', 'JCB', '533', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 93
  (94, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MC'), 'MC-003', NULL, 'Minicargador JCB 270 T3', 'JCB', '270 T3', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 94
  (95, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-064', NULL, 'Grúa horquilla Bobcat D1605-7 16 ton', 'Bobcat', 'D1605-7', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 95
  (96, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-065', NULL, 'Grúa horquilla Bobcat D70S-9 7 ton', 'Bobcat', 'D70S-9', '7 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 96
  (97, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-014', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, NULL, 'JCB3CX4TER3325888', -20.244800, -70.139300),   -- fila 97
  (98, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RE'), 'RE-015', NULL, 'Retroexcavadora JCB 3CX 4X4', 'JCB', '3CX 4X4', NULL, NULL, 'JCB3CX4TPR3324034', -20.244800, -70.139300),   -- fila 98
  (99, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MA'), 'MA-006', NULL, 'Manipulador JCB 540-170', 'JCB', '540-170', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 99
  (100, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-066', NULL, 'Grúa horquilla Konecranes SMV25-1200C 25 ton', 'Konecranes', 'SMV25-1200C', '25 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 100
  (101, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-067', NULL, 'Grúa horquilla Konecranes SMV25-1200C 25 ton', 'Konecranes', 'SMV25-1200C', '25 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 101
  (102, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MC'), 'MC-004', NULL, 'Minicargador JCB JCB270CAB_AC_CL', 'JCB', 'JCB270CAB_AC_CL', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 102
  (103, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MC'), 'MC-005', NULL, 'Minicargador JCB JCB270CAB_AC_CL', 'JCB', 'JCB270CAB_AC_CL', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 103
  (104, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-068', NULL, 'Grúa horquilla Hangcha CPCD30-X2W97B1 4X2 3 ton', 'Hangcha', 'CPCD30-X2W97B1 4X2', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 104
  (105, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-069', NULL, 'Grúa horquilla Hangcha CPCD30-X2W97B1 4X2 3 ton', 'Hangcha', 'CPCD30-X2W97B1 4X2', '3 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 105
  (106, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-070', NULL, 'Grúa horquilla Hangcha CPCD35-QQ98CRT4 4X4 3.5 ton', 'Hangcha', 'CPCD35-QQ98CRT4 4X4', '3.5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 106
  (107, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-071', NULL, 'Grúa horquilla Hangcha CPCD50-RT4_CL 5 ton', 'Hangcha', 'CPCD50-RT4_CL', '5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 107
  (108, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-072', NULL, 'Grúa horquilla Hangcha CPCD50-RT4_CL 5 ton', 'Hangcha', 'CPCD50-RT4_CL', '5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 108
  (109, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MC'), 'MC-006', NULL, 'Minicargador JCB JCB270CAB_AC_CL', 'JCB', 'JCB270CAB_AC_CL', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 109
  (110, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-073', NULL, 'Grúa horquilla Komatsu FH50-2 5 ton', 'Komatsu', 'FH50-2', '5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 110
  (111, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-074', NULL, 'Grúa horquilla Hangcha CPCD100-XH16B 10 ton', 'Hangcha', 'CPCD100-XH16B', '10 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 111
  (112, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-075', NULL, 'Grúa horquilla Hangcha CPD25-XEY2HA-SI_CL 2.5 ton eléctrica', 'Hangcha', 'CPD25-XEY2HA-SI_CL', '2.5 ton eléctrica', NULL, NULL, -20.244800, -70.139300),   -- fila 112
  (113, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-076', NULL, 'Grúa horquilla Hangcha CPQYD30-XRW22 3 ton a gas', 'Hangcha', 'CPQYD30-XRW22', '3 ton a gas', NULL, NULL, -20.244800, -70.139300),   -- fila 113
  (114, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-077', NULL, 'Grúa horquilla Hangcha CPQYD30-XRW22 3 ton a gas', 'Hangcha', 'CPQYD30-XRW22', '3 ton a gas', NULL, NULL, -20.244800, -70.139300),   -- fila 114
  (115, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-078', NULL, 'Grúa horquilla Komatsu FH100-1 10 ton', 'Komatsu', 'FH100-1', '10 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 115
  (116, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-079', NULL, 'Grúa horquilla Komatsu FH100-1 10 ton', 'Komatsu', 'FH100-1', '10 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 116
  (117, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GH'), 'GH-080', NULL, 'Grúa horquilla Komatsu FH160-1 16 ton', 'Komatsu', 'FH160-1', '16 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 117
  (118, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-001', NULL, 'Camioneta Mazda NEW BT 50 DCAB SDX 4X4', 'Mazda', 'NEW BT 50 DCAB SDX 4X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 118
  (119, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-002', NULL, 'Camioneta Maxus C35 C PLANA 2.0', 'Maxus', 'C35 C PLANA 2.0', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 119
  (120, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-003', NULL, 'Camioneta Dodge RAM VAN 700 CITY', 'Dodge', 'RAM VAN 700 CITY', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 120
  (121, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-004', NULL, 'Camioneta Dodge RAM VAN 700 CITY', 'Dodge', 'RAM VAN 700 CITY', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 121
  (122, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MB'), 'MB-001', NULL, 'Minibús Hyundai COUNTY', 'Hyundai', 'COUNTY', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 122
  (123, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-005', NULL, 'Camioneta Mitsubishi L200 KATANA CRT 4X4 2.4', 'Mitsubishi', 'L200 KATANA CRT 4X4 2.4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 123
  (124, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-006', NULL, 'Camioneta Mitsubishi L200 KATANA CRT 4X4 2.4', 'Mitsubishi', 'L200 KATANA CRT 4X4 2.4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 124
  (125, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-007', NULL, 'Camioneta Dodge RAM VAN 700 CITY', 'Dodge', 'RAM VAN 700 CITY', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 125
  (126, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-008', NULL, 'Camioneta Dodge RAM VAN 700 CITY', 'Dodge', 'RAM VAN 700 CITY', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 126
  (127, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-009', NULL, 'Camioneta Dodge RAM VAN 700 CITY', 'Dodge', 'RAM VAN 700 CITY', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 127
  (128, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-010', NULL, 'Camioneta Dodge RAM VAN 700 CITY', 'Dodge', 'RAM VAN 700 CITY', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 128
  (129, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-011', NULL, 'Camioneta Mitsubishi L200 KATANA CRT 4X4 2.4', 'Mitsubishi', 'L200 KATANA CRT 4X4 2.4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 129
  (130, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-012', NULL, 'Camioneta Mitsubishi L200 KATANA CRT 4X4 2.4', 'Mitsubishi', 'L200 KATANA CRT 4X4 2.4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 130
  (131, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-013', NULL, 'Camioneta Maxus T90 4x4 AT', 'Maxus', 'T90 4x4 AT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 131
  (132, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-014', NULL, 'Camioneta Renault DOKKER III', 'Renault', 'DOKKER III', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 132
  (133, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-015', NULL, 'Camioneta Renault DOKKER III', 'Renault', 'DOKKER III', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 133
  (134, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-016', NULL, 'Camioneta Renault DOKKER III', 'Renault', 'DOKKER III', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 134
  (135, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-017', NULL, 'Camioneta Renault DOKKER III', 'Renault', 'DOKKER III', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 135
  (136, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-018', NULL, 'Camioneta Toyota HILUX D CAB 4X4 3.0', 'Toyota', 'HILUX D CAB 4X4 3.0', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 136
  (137, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-019', NULL, 'Camioneta Toyota HILUX D CAB 4X4 3.0', 'Toyota', 'HILUX D CAB 4X4 3.0', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 137
  (138, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-020', NULL, 'Camioneta Toyota HILUX', 'Toyota', 'HILUX', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 138
  (139, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-021', NULL, 'Camioneta Toyota HILUX D CAB 4X4 3.0', 'Toyota', 'HILUX D CAB 4X4 3.0', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 139
  (140, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-022', NULL, 'Camioneta Toyota HILUX', 'Toyota', 'HILUX', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 140
  (141, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LB'), 'LB-001', NULL, 'Camión lubricador Hino XZU 6.5DC', 'Hino', 'XZU 6.5DC', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 141
  (142, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-023', NULL, 'Camioneta Toyota HILUX', 'Toyota', 'HILUX', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 142
  (143, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-024', NULL, 'Camioneta Toyota HILUX', 'Toyota', 'HILUX', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 143
  (144, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-025', NULL, 'Camioneta Renault DOKKER III', 'Renault', 'DOKKER III', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 144
  (145, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-026', NULL, 'Camioneta Dodge RAM TRUCK 2500 6.7L CUMMINS', 'Dodge', 'RAM TRUCK 2500 6.7L CUMMINS', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 145
  (146, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-027', NULL, 'Camioneta Dodge RAM TRUCK 2500 6.7L CUMMINS', 'Dodge', 'RAM TRUCK 2500 6.7L CUMMINS', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 146
  (147, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-028', NULL, 'Camioneta Great Wall WINGLE2,4 T/M 4X2', 'Great Wall', 'WINGLE2,4 T/M 4X2', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 147
  (148, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-029', NULL, 'Camioneta Great Wall POER PLUS AT 2,0', 'Great Wall', 'POER PLUS AT 2,0', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 148
  (149, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-030', NULL, 'Camioneta Great Wall WINGLE2,4 T/M 4X2', 'Great Wall', 'WINGLE2,4 T/M 4X2', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 149
  (150, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-031', NULL, 'Camioneta Great Wall WINGLE2,4 T/M 4X2', 'Great Wall', 'WINGLE2,4 T/M 4X2', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 150
  (151, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-032', NULL, 'Camioneta RAM 700 BIGHORN DC 1,3 CVT', 'RAM', '700 BIGHORN DC 1,3 CVT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 151
  (152, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-033', NULL, 'Camioneta RAM 700 BIGHORN DC 1,3 CVT', 'RAM', '700 BIGHORN DC 1,3 CVT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 152
  (153, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-034', NULL, 'Camioneta RAM 700 BIGHORN DC 1,3 CVT', 'RAM', '700 BIGHORN DC 1,3 CVT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 153
  (154, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-035', NULL, 'Camioneta RAM 700 BIGHORN DC 1,3 CVT', 'RAM', '700 BIGHORN DC 1,3 CVT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 154
  (155, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-036', NULL, 'Camioneta RAM 700 BIGHORN DC 1,3 CVT', 'RAM', '700 BIGHORN DC 1,3 CVT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 155
  (156, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-037', NULL, 'Camioneta RAM 700 BIGHORN 1,3 AUT', 'RAM', '700 BIGHORN 1,3 AUT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 156
  (157, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-038', NULL, 'Camioneta RAM 700 BIGHORN 1,3 AUT', 'RAM', '700 BIGHORN 1,3 AUT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 157
  (158, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-039', NULL, 'Camioneta RAM 700 BIGHORN 1,3 AUT', 'RAM', '700 BIGHORN 1,3 AUT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 158
  (159, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-040', NULL, 'Camioneta RAM 700 BIGHORN 1,3 AUT', 'RAM', '700 BIGHORN 1,3 AUT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 159
  (160, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CT'), 'CT-041', NULL, 'Camioneta RAM 700 BIGHORN 1,3 AUT', 'RAM', '700 BIGHORN 1,3 AUT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 160
  (161, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'FU'), 'FU-001', NULL, 'Furgón', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 161
  (162, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'FU'), 'FU-002', NULL, 'Furgón Maxus E DELIVER 3 AUT', 'Maxus', 'E DELIVER 3 AUT', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 162
  (163, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'AH'), 'AH-001', NULL, 'Alza hombre Genie Z62/40', 'Genie', 'Z62/40', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 163
  (164, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'AH'), 'AH-002', NULL, 'Alza hombre Genie Z - 45/25J RT 4X4 articulado 16 m', 'Genie', 'Z - 45/25J RT 4X4', 'articulado 16 m', NULL, NULL, -20.244800, -70.139300),   -- fila 164
  (165, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'AH'), 'AH-003', NULL, 'Alza hombre Genie Z - 45/25J RT 4X4 articulado 16 m', 'Genie', 'Z - 45/25J RT 4X4', 'articulado 16 m', NULL, NULL, -20.244800, -70.139300),   -- fila 165
  (166, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'AH'), 'AH-004', NULL, 'Alza hombre Genie Z - 45/25J RT 4X4 articulado 16 m', 'Genie', 'Z - 45/25J RT 4X4', 'articulado 16 m', NULL, NULL, -20.244800, -70.139300),   -- fila 166
  (167, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'AH'), 'AH-005', NULL, 'Alza hombre Genie Z - 45/25J RT 4X4 articulado 16,5 m', 'Genie', 'Z - 45/25J RT 4X4', 'articulado 16,5 m', NULL, NULL, -20.244800, -70.139300),   -- fila 167
  (168, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'AH'), 'AH-006', NULL, 'Alza hombre Genie Z80/60 articulado 25,77 m', 'Genie', 'Z80/60', 'articulado 25,77 m', NULL, NULL, -20.244800, -70.139300),   -- fila 168
  (169, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-001', NULL, 'Luminaria Pramac T.LED 1700K', 'Pramac', 'T.LED 1700K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 169
  (170, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-002', NULL, 'Luminaria Pramac T.LED 1700K', 'Pramac', 'T.LED 1700K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 170
  (171, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-003', NULL, 'Luminaria Pramac T.LED 1700K', 'Pramac', 'T.LED 1700K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 171
  (172, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-004', NULL, 'Luminaria Pramac T.LED 1700K', 'Pramac', 'T.LED 1700K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 172
  (173, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-005', NULL, 'Luminaria Pramac T.LED 1700K', 'Pramac', 'T.LED 1700K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 173
  (174, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-001', NULL, 'Generador JCB G220QX 220 kVA', 'JCB', 'G220QX', '220 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 174
  (175, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-002', NULL, 'Generador JCB G330QX 330 kVA', 'JCB', 'G330QX', '330 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 175
  (176, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-003', NULL, 'Generador JCB G90QX 90 kVA', 'JCB', 'G90QX', '90 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 176
  (177, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-004', NULL, 'Generador JCB G45QX 45 kVA', 'JCB', 'G45QX', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 177
  (178, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-005', NULL, 'Generador JCB G90QX 90 kVA', 'JCB', 'G90QX', '90 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 178
  (179, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-006', NULL, 'Generador JCB G20QS 20 kVA', 'JCB', 'G20QS', '20 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 179
  (180, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-007', NULL, 'Generador JCB G45QS 45 kVA', 'JCB', 'G45QS', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 180
  (181, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-008', NULL, 'Generador JCB G440QX 440 kVA', 'JCB', 'G440QX', '440 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 181
  (182, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-009', NULL, 'Generador JCB G440QX 440 kVA', 'JCB', 'G440QX', '440 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 182
  (183, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-010', NULL, 'Generador JCB G440QX 440 kVA', 'JCB', 'G440QX', '440 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 183
  (184, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-011', NULL, 'Generador JCB G45QS 45 kVA', 'JCB', 'G45QS', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 184
  (185, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-012', NULL, 'Generador JCB G45QS 45 kVA', 'JCB', 'G45QS', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 185
  (186, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-013', NULL, 'Generador JCB G440QX 440 kVA', 'JCB', 'G440QX', '440 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 186
  (187, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-014', NULL, 'Generador JCB G20QS 20 kVA', 'JCB', 'G20QS', '20 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 187
  (188, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-015', NULL, 'Generador JCB G90QS 90 kVA', 'JCB', 'G90QS', '90 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 188
  (189, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-016', NULL, 'Generador JCB G115QS 115 kVA', 'JCB', 'G115QS', '115 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 189
  (190, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-017', NULL, 'Generador JCB G220QS 220 kVA', 'JCB', 'G220QS', '220 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 190
  (191, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-018', NULL, 'Generador JCB G115QS 115 kVA', 'JCB', 'G115QS', '115 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 191
  (192, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-019', NULL, 'Generador JCB G45QS 45 kVA', 'JCB', 'G45QS', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 192
  (193, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-020', NULL, 'Generador JCB G90QS 90 kVA', 'JCB', 'G90QS', '90 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 193
  (194, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-021', NULL, 'Generador JCB G45QS 45 kVA', 'JCB', 'G45QS', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 194
  (195, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-022', NULL, 'Generador JCB G115QS 115 kVA', 'JCB', 'G115QS', '115 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 195
  (196, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-023', NULL, 'Generador JCB G45QX 45 kVA', 'JCB', 'G45QX', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 196
  (197, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-024', NULL, 'Generador JCB G220QS 220 kVA', 'JCB', 'G220QS', '220 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 197
  (198, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-025', NULL, 'Generador JCB G165QS 165 kVA', 'JCB', 'G165QS', '165 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 198
  (199, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-026', NULL, 'Generador JCB G165QS 165 kVA', 'JCB', 'G165QS', '165 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 199
  (200, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-027', NULL, 'Generador JCB G45QS 45 kVA', 'JCB', 'G45QS', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 200
  (201, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-028', NULL, 'Generador JCB G45QS 45 kVA', 'JCB', 'G45QS', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 201
  (202, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-029', NULL, 'Generador JCB G33QS 33 kVA', 'JCB', 'G33QS', '33 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 202
  (203, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-030', NULL, 'Generador JCB G33QS 33 kVA', 'JCB', 'G33QS', '33 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 203
  (204, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-031', NULL, 'Generador JCB G33QS 33 kVA', 'JCB', 'G33QS', '33 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 204
  (205, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-032', NULL, 'Generador JCB G33QS 33 kVA', 'JCB', 'G33QS', '33 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 205
  (206, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-033', NULL, 'Generador JCB G45QS 45 kVA', 'JCB', 'G45QS', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 206
  (207, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-034', NULL, 'Generador JCB G221QS 221 kVA', 'JCB', 'G221QS', '221 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 207
  (208, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-035', NULL, 'Generador JCB G221QS 221 kVA', 'JCB', 'G221QS', '221 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 208
  (209, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-036', NULL, 'Generador JCB G165QS 165 kVA', 'JCB', 'G165QS', '165 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 209
  (210, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-037', NULL, 'Generador JCB G141QS 141 kVA', 'JCB', 'G141QS', '141 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 210
  (211, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-038', NULL, 'Generador JCB G166QS 166 kVA', 'JCB', 'G166QS', '166 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 211
  (212, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-039', NULL, 'Generador JCB G166QS 166 kVA', 'JCB', 'G166QS', '166 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 212
  (213, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-040', NULL, 'Generador JCB G66QS 66 kVA', 'JCB', 'G66QS', '66 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 213
  (214, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-041', NULL, 'Generador JCB G66QS 66 kVA', 'JCB', 'G66QS', '66 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 214
  (215, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-042', NULL, 'Generador JCB G141QS 141 kVA', 'JCB', 'G141QS', '141 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 215
  (216, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-043', NULL, 'Generador JCB G91QS 91 kVA', 'JCB', 'G91QS', '91 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 216
  (217, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-044', NULL, 'Generador JCB G91QS 91 kVA', 'JCB', 'G91QS', '91 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 217
  (218, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-045', NULL, 'Generador JCB G41QS 41 kVA', 'JCB', 'G41QS', '41 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 218
  (219, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-046', NULL, 'Generador JCB G41QS 41 kVA', 'JCB', 'G41QS', '41 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 219
  (220, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-047', NULL, 'Generador JCB G41QS 41 kVA', 'JCB', 'G41QS', '41 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 220
  (221, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-048', NULL, 'Generador Vielco VIELCO TRIF GS11YLD 11 kVA', 'Vielco', 'VIELCO TRIF GS11YLD', '11 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 221
  (222, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-049', NULL, 'Generador Vielco VIELCO TRIF GS11YLD 11 kVA', 'Vielco', 'VIELCO TRIF GS11YLD', '11 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 222
  (223, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-050', NULL, 'Generador Vielco VIELCO FAW TRIF GS22FLD 22 kVA', 'Vielco', 'VIELCO FAW TRIF GS22FLD', '22 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 223
  (224, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-051', NULL, 'Generador Vielco VIELCO FAW TRIF GS22FLD 22 kVA', 'Vielco', 'VIELCO FAW TRIF GS22FLD', '22 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 224
  (225, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-052', NULL, 'Generador Vielco VIELCO FAW TRIF GS22FLD 22 kVA', 'Vielco', 'VIELCO FAW TRIF GS22FLD', '22 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 225
  (226, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-053', NULL, 'Generador JCB G41QS 41 kVA', 'JCB', 'G41QS', '41 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 226
  (227, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-054', NULL, 'Generador JCB G41QS 41 kVA', 'JCB', 'G41QS', '41 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 227
  (228, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-055', NULL, 'Generador JCB G20QS 20 kVA', 'JCB', 'G20QS', '20 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 228
  (229, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-056', NULL, 'Generador JCB G141QS 137 kVA', 'JCB', 'G141QS', '137 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 229
  (230, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-057', NULL, 'Generador JCB G20QS 20 kVA', 'JCB', 'G20QS', '20 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 231
  (231, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-001', NULL, 'Compresor Sullair', 'Sullair', NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 232
  (232, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'SO'), 'SO-001', NULL, 'Soldadora Lincoln VANTAGE 500', 'Lincoln', 'VANTAGE 500', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 233
  (233, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'SO'), 'SO-002', NULL, 'Soldadora Lincoln VANTAGE 500', 'Lincoln', 'VANTAGE 500', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 234
  (234, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'SO'), 'SO-003', NULL, 'Soldadora Lincoln VANTAGE 500', 'Lincoln', 'VANTAGE 500', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 235
  (235, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'SO'), 'SO-004', NULL, 'Soldadora Lincoln VANTAGE 500', 'Lincoln', 'VANTAGE 500', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 236
  (236, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'SO'), 'SO-005', NULL, 'Soldadora Lincoln VANTAGE 500', 'Lincoln', 'VANTAGE 500', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 237
  (237, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'SO'), 'SO-006', NULL, 'Soldadora Lincoln VANTAGE 500', 'Lincoln', 'VANTAGE 500', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 238
  (238, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-006', NULL, 'Luminaria Wacker Neuson LTV 6K', 'Wacker Neuson', 'LTV 6K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 239
  (239, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-007', NULL, 'Luminaria Wacker Neuson LTV 6K', 'Wacker Neuson', 'LTV 6K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 240
  (240, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-008', NULL, 'Luminaria Allmand NIGHT LITE PRO 212', 'Allmand', 'NIGHT LITE PRO 212', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 241
  (241, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-009', NULL, 'Luminaria Wacker Neuson LTV 6K', 'Wacker Neuson', 'LTV 6K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 242
  (242, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-001', NULL, 'Camión pluma Freightliner M2 106', 'Freightliner', 'M2 106', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 243
  (243, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PL'), 'PL-001', NULL, 'Pluma', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 244
  (244, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CC'), 'CC-001', NULL, 'Camión combustible Mitsubishi CANTER', 'Mitsubishi', 'CANTER', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 245
  (245, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'AL'), 'AL-001', NULL, 'Camión aljibe Mercedes-Benz ACTROS 3336', 'Mercedes-Benz', 'ACTROS 3336', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 246
  (246, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TV'), 'TV-001', NULL, 'Camión tolva Freightliner M2 112 6X4', 'Freightliner', 'M2 112 6X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 247
  (247, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TV'), 'TV-002', NULL, 'Camión tolva Freightliner M2 112 6X4', 'Freightliner', 'M2 112 6X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 248
  (248, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-002', NULL, 'Camión pluma Mercedes-Benz ACTROS 4144K 8X4', 'Mercedes-Benz', 'ACTROS 4144K 8X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 249
  (249, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PL'), 'PL-002', NULL, 'Pluma', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 250
  (250, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PT'), 'PT-001', NULL, 'Plataforma tijera Haulotte', 'Haulotte', NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 251
  (251, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-010', NULL, 'Luminaria Wacker Neuson LTV 6K', 'Wacker Neuson', 'LTV 6K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 252
  (252, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-003', NULL, 'Camión pluma Freightliner GWLW60', 'Freightliner', 'GWLW60', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 253
  (253, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-004', NULL, 'Camión pluma Freightliner M2 106 (CUMMINS)', 'Freightliner', 'M2 106 (CUMMINS)', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 254
  (254, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PL'), 'PL-003', NULL, 'Pluma', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 255
  (255, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-005', NULL, 'Camión pluma Mercedes-Benz ACTROS 4144K 8X4', 'Mercedes-Benz', 'ACTROS 4144K 8X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 256
  (256, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PL'), 'PL-004', NULL, 'Pluma Palfinger PK48002-EH', 'Palfinger', 'PK48002-EH', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 257
  (257, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-006', NULL, 'Camión pluma Freightliner M2 112 DD13 EPA10', 'Freightliner', 'M2 112 DD13 EPA10', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 258
  (258, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PL'), 'PL-005', NULL, 'Pluma', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 259
  (259, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-007', NULL, 'Camión pluma Freightliner M2 112 DD13', 'Freightliner', 'M2 112 DD13', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 260
  (260, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PL'), 'PL-006', NULL, 'Pluma', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 261
  (261, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-002', NULL, 'Compresor Kaeser M50 CL', 'Kaeser', 'M50 CL', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 262
  (262, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-003', NULL, 'Compresor Kaeser', 'Kaeser', NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 263
  (263, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-004', NULL, 'Compresor Kaeser', 'Kaeser', NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 264
  (264, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-008', NULL, 'Camión pluma Freightliner M2 106 CUMMINS', 'Freightliner', 'M2 106 CUMMINS', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 265
  (265, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PL'), 'PL-007', NULL, 'Pluma', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 266
  (266, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'AL'), 'AL-002', NULL, 'Camión aljibe Mercedes-Benz ACTROS 3336', 'Mercedes-Benz', 'ACTROS 3336', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 267
  (267, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PF'), 'PF-001', NULL, 'Camión plataforma Mercedes-Benz ATEGO 1726/54 EURO V', 'Mercedes-Benz', 'ATEGO 1726/54 EURO V', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 268
  (268, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-009', NULL, 'Camión pluma Freightliner M2 112 DD13 EPA', 'Freightliner', 'M2 112 DD13 EPA', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 269
  (269, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PL'), 'PL-008', NULL, 'Pluma', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 270
  (270, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-010', NULL, 'Camión pluma Freightliner SD 114', 'Freightliner', 'SD 114', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 271
  (271, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PL'), 'PL-009', NULL, 'Pluma', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 272
  (272, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TV'), 'TV-003', NULL, 'Camión tolva Mercedes-Benz AROCS 4848', 'Mercedes-Benz', 'AROCS 4848', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 273
  (273, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TV'), 'TV-004', NULL, 'Camión tolva Mercedes-Benz AROCS 4848', 'Mercedes-Benz', 'AROCS 4848', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 274
  (274, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'AL'), 'AL-003', NULL, 'Camión aljibe Mercedes-Benz AROCS 3342 K 3600 RET', 'Mercedes-Benz', 'AROCS 3342 K 3600 RET', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 275
  (275, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TV'), 'TV-005', NULL, 'Camión tolva Mercedes-Benz AROCS 4848', 'Mercedes-Benz', 'AROCS 4848', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 276
  (276, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TV'), 'TV-006', NULL, 'Camión tolva Mercedes-Benz AROCS 4848', 'Mercedes-Benz', 'AROCS 4848', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 277
  (277, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CA'), 'CA-001', NULL, 'Camión Hino FD1121', 'Hino', 'FD1121', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 278
  (278, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-005', NULL, 'Compresor Kaeser M100', 'Kaeser', 'M100', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 279
  (279, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-006', NULL, 'Compresor Booniga V2065-100L', 'Booniga', 'V2065-100L', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 280
  (280, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-007', NULL, 'Compresor Kaeser MOBILAIR M50 PE CL 7BAR', 'Kaeser', 'MOBILAIR M50 PE CL 7BAR', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 281
  (281, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-008', NULL, 'Compresor Kaeser MOBILAIR M50 PE CL 7BAR', 'Kaeser', 'MOBILAIR M50 PE CL 7BAR', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 282
  (282, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-009', NULL, 'Compresor Kaeser MOBILAIR M50', 'Kaeser', 'MOBILAIR M50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 283
  (283, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-010', NULL, 'Compresor Kaeser MOBILAIR M50', 'Kaeser', 'MOBILAIR M50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 284
  (284, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-011', NULL, 'Compresor Kaeser MOBILAIR M50', 'Kaeser', 'MOBILAIR M50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 285
  (285, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-011', NULL, 'Luminaria Wacker Neuson LTV 6K', 'Wacker Neuson', 'LTV 6K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 286
  (286, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-012', NULL, 'Luminaria Wacker Neuson LTV 6K', 'Wacker Neuson', 'LTV 6K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 287
  (287, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-013', NULL, 'Luminaria Wacker Neuson LTV 6K', 'Wacker Neuson', 'LTV 6K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 288
  (288, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-014', NULL, 'Luminaria Wacker Neuson LTV 6K', 'Wacker Neuson', 'LTV 6K', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 289
  (289, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-015', NULL, 'Luminaria Allmand NIGHT LITE PRO II', 'Allmand', 'NIGHT LITE PRO II', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 290
  (290, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-016', NULL, 'Luminaria Allmand NIGHT LITE PRO II', 'Allmand', 'NIGHT LITE PRO II', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 291
  (291, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-017', NULL, 'Luminaria Allmand NIGHT LITE PRO II', 'Allmand', 'NIGHT LITE PRO II', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 292
  (292, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-018', NULL, 'Luminaria Allmand NIGHT LITE PRO II', 'Allmand', 'NIGHT LITE PRO II', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 293
  (293, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-019', NULL, 'Luminaria Allmand NIGHT LITE PRO II', 'Allmand', 'NIGHT LITE PRO II', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 294
  (294, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-020', NULL, 'Luminaria Allmand NIGHT LITE PRO II', 'Allmand', 'NIGHT LITE PRO II', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 295
  (295, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-021', NULL, 'Luminaria Allmand NIGHT LITE PRO II', 'Allmand', 'NIGHT LITE PRO II', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 296
  (296, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-022', NULL, 'Luminaria Allmand NIGHT LITE PRO II', 'Allmand', 'NIGHT LITE PRO II', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 297
  (297, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-023', NULL, 'Luminaria Allmand NIGHT LITE PRO II', 'Allmand', 'NIGHT LITE PRO II', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 298
  (298, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-024', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 299
  (299, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-025', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 300
  (300, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-026', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 301
  (301, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-027', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 302
  (302, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-028', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 303
  (303, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-029', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 304
  (304, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-030', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 305
  (305, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-031', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 306
  (306, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-032', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 307
  (307, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-033', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 308
  (308, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-034', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 309
  (309, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-035', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 310
  (310, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-036', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 311
  (311, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-037', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 312
  (312, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-038', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 313
  (313, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-039', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 314
  (314, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-040', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 315
  (315, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-041', NULL, 'Luminaria Doosan LN LEK1.4-50HZ LED', 'Doosan', 'LN LEK1.4-50HZ LED', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 316
  (316, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-042', NULL, 'Luminaria Bobcat LED PL50', 'Bobcat', 'LED PL50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 317
  (317, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-043', NULL, 'Luminaria Bobcat LED PL50', 'Bobcat', 'LED PL50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 318
  (318, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-044', NULL, 'Luminaria Bobcat LED PL50', 'Bobcat', 'LED PL50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 319
  (319, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-045', NULL, 'Luminaria Bobcat LED PL50', 'Bobcat', 'LED PL50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 320
  (320, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-046', NULL, 'Luminaria Bobcat LED PL50', 'Bobcat', 'LED PL50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 321
  (321, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-047', NULL, 'Luminaria Bobcat LED PL50', 'Bobcat', 'LED PL50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 322
  (322, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-048', NULL, 'Luminaria Bobcat LED PL50', 'Bobcat', 'LED PL50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 323
  (323, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-049', NULL, 'Luminaria Bobcat LED PL50', 'Bobcat', 'LED PL50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 324
  (324, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-050', NULL, 'Luminaria Bobcat LED PL50', 'Bobcat', 'LED PL50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 325
  (325, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-051', NULL, 'Luminaria Bobcat LED PL50', 'Bobcat', 'LED PL50', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 326
  (326, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-012', NULL, 'Compresor Kaeser SK22 8BAR', 'Kaeser', 'SK22 8BAR', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 327
  (327, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LS'), 'LS-001', NULL, 'Luminaria solar Atlas Copco SOLAR HILIGHT MS 5', 'Atlas Copco', 'SOLAR HILIGHT MS 5', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 328
  (328, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LS'), 'LS-002', NULL, 'Luminaria solar Atlas Copco SOLAR HILIGHT MS 5', 'Atlas Copco', 'SOLAR HILIGHT MS 5', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 329
  (329, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LS'), 'LS-003', NULL, 'Luminaria solar Atlas Copco SOLAR HILIGHT MS 5', 'Atlas Copco', 'SOLAR HILIGHT MS 5', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 330
  (330, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LS'), 'LS-004', NULL, 'Luminaria solar Atlas Copco SOLAR HILIGHT MS 5', 'Atlas Copco', 'SOLAR HILIGHT MS 5', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 331
  (331, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LS'), 'LS-005', NULL, 'Luminaria solar Atlas Copco SOLAR HILIGHT MS 5', 'Atlas Copco', 'SOLAR HILIGHT MS 5', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 332
  (332, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LS'), 'LS-006', NULL, 'Luminaria solar Atlas Copco SOLAR HILIGHT MS 5', 'Atlas Copco', 'SOLAR HILIGHT MS 5', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 333
  (333, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CO'), 'CO-013', NULL, 'Compresor', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 334
  (334, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PN'), 'PN-001', NULL, 'Camión plano Mitsubishi Fuso CANTER 815 EURO V DUONIC 5 ton', 'Mitsubishi Fuso', 'CANTER 815 EURO V DUONIC', '5 ton', NULL, NULL, -20.244800, -70.139300),   -- fila 335
  (335, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-011', NULL, 'Camión pluma Mercedes-Benz AROCS 3342 PK 33002 EH 6x4', 'Mercedes-Benz', 'AROCS 3342', 'PK 33002 EH 6x4', NULL, NULL, -20.244800, -70.139300),   -- fila 336
  (336, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CA'), 'CA-002', NULL, 'Camión Mitsubishi Fuso CANTER 815 EURO V DUONIC', 'Mitsubishi Fuso', 'CANTER 815 EURO V DUONIC', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 337
  (337, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'MN'), 'MN-001', NULL, 'Motoniveladora Komatsu GD675-6E0', 'Komatsu', 'GD675-6E0', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 338
  (338, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TC'), 'TC-001', NULL, 'Tracto camión Freightliner CL 120', 'Freightliner', 'CL 120', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 339
  (339, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TC'), 'TC-002', NULL, 'Tracto camión Freightliner CL 120 6X4', 'Freightliner', 'CL 120 6X4', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 340
  (340, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CA'), 'CA-003', NULL, 'Camión Hino FC9JJSA', 'Hino', 'FC9JJSA', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 341
  (341, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TC'), 'TC-003', NULL, 'Tracto camión Freightliner SD 122', 'Freightliner', 'SD 122', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 342
  (342, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CA'), 'CA-004', NULL, 'Camión Hino FC9JJSA FULL', 'Hino', 'FC9JJSA FULL', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 343
  (343, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RS'), 'RS-001', NULL, 'Camión rescate Mitsubishi CANTER 7,5', 'Mitsubishi', 'CANTER 7,5', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 344
  (344, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CA'), 'CA-005', NULL, 'Camión Freightliner M2 106 (CUMMINS)', 'Freightliner', 'M2 106 (CUMMINS)', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 345
  (345, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CA'), 'CA-006', NULL, 'Camión Hino FC9JJTA FULL', 'Hino', 'FC9JJTA FULL', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 346
  (346, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TC'), 'TC-004', NULL, 'Tracto camión Freightliner SD 122', 'Freightliner', 'SD 122', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 347
  (347, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TC'), 'TC-005', NULL, 'Tracto camión Freightliner TRACTO NEW CA116 EPA', 'Freightliner', 'TRACTO NEW CA116 EPA', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 348
  (348, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TC'), 'TC-006', NULL, 'Tracto camión Freightliner TRACTO NEW CA116', 'Freightliner', 'TRACTO NEW CA116', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 349
  (349, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CA'), 'CA-007', NULL, 'Camión Mercedes-Benz NEW ACTROS 3358', 'Mercedes-Benz', 'NEW ACTROS 3358', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 350
  (350, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CA'), 'CA-008', NULL, 'Camión Hino FD 1121', 'Hino', 'FD 1121', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 351
  (351, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CA'), 'CA-009', NULL, 'Camión Freightliner SD114 PLUS SEG EURO V', 'Freightliner', 'SD114 PLUS SEG EURO V', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 352
  (352, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TC'), 'TC-007', NULL, 'Tracto camión Freightliner NEW CA116 60K DD13 505 DT12 SEG EURO V', 'Freightliner', 'NEW CA116 60K DD13 505 DT12 SEG EURO V', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 353
  (353, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'TC'), 'TC-008', NULL, 'Tracto camión Freightliner TRACTO NEW CA116 60K DD13 505 DT12 SEG EURO V', 'Freightliner', 'TRACTO NEW CA116 60K DD13 505 DT12 SEG EURO V', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 354
  (354, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CB'), 'CB-001', NULL, 'Cama baja Tremac', 'Tremac', NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 355
  (355, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-058', NULL, 'Generador JCB G165QS 165 kVA', 'JCB', 'G165QS', '165 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 356
  (356, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-059', NULL, 'Generador JCB G20QS 20 kVA', 'JCB', 'G20QS', '20 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 357
  (357, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PT'), 'PT-002', NULL, 'Plataforma tijera Snorkel S3246', 'Snorkel', 'S3246', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 358
  (358, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-060', NULL, 'Generador Hyundai DHY8000SE 6 kVA', 'Hyundai', 'DHY8000SE', '6 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 359
  (359, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-061', NULL, 'Generador JCB G545QX 545 kVA', 'JCB', 'G545QX', '545 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 360
  (360, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-062', NULL, 'Generador JCB G45QX 45 kVA', 'JCB', 'G45QX', '45 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 361
  (361, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'GE'), 'GE-063', NULL, 'Generador Hyundai DHY8000SE 6 kVA', 'Hyundai', 'DHY8000SE', '6 kVA', NULL, NULL, -20.244800, -70.139300),   -- fila 362
  (362, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CA'), 'CA-010', NULL, 'Camión JAC URBAN HFC 1035', 'JAC', 'URBAN HFC 1035', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 363
  (363, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PT'), 'PT-003', NULL, 'Plataforma tijera Haulotte COMPACT 12', 'Haulotte', 'COMPACT 12', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 364
  (364, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PA'), 'PA-001', NULL, 'Camión pantalla Foton AUMARK 814', 'Foton', 'AUMARK 814', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 365
  (365, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'AH'), 'AH-007', NULL, 'Alza hombre', NULL, NULL, NULL, NULL, 'S8510-8415', -20.244800, -70.139300),   -- fila 366
  (366, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CP'), 'CP-012', NULL, 'Camión pluma Freightliner M2 106 (DETROIT)', 'Freightliner', 'M2 106 (DETROIT)', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 367
  (367, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PL'), 'PL-010', NULL, 'Pluma', NULL, NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 368
  (368, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PT'), 'PT-004', NULL, 'Plataforma tijera Hangcha 140XEN eléctrica 14 m', 'Hangcha', '140XEN', 'eléctrica 14 m', NULL, NULL, -20.244800, -70.139300),   -- fila 369
  (369, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'PT'), 'PT-005', NULL, 'Plataforma tijera Hangcha 140XEN eléctrica 14 m', 'Hangcha', '140XEN', 'eléctrica 14 m', NULL, NULL, -20.244800, -70.139300),   -- fila 370
  (370, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-052', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 371
  (371, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-053', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 372
  (372, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-054', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 373
  (373, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-055', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 374
  (374, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-056', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 375
  (375, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-057', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 376
  (376, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-058', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 377
  (377, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-059', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 378
  (378, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-060', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 379
  (379, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-061', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 380
  (380, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-062', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 381
  (381, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-063', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 382
  (382, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-064', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 383
  (383, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-065', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 384
  (384, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-066', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 385
  (385, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'LU'), 'LU-067', NULL, 'Luminaria Atlas Copco HILIGHT V5+KD 50HZROW SV2A NEO', 'Atlas Copco', 'HILIGHT V5+KD 50HZROW SV2A NEO', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 386
  (386, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CB'), 'CB-002', NULL, 'Cama baja Randon SR CT PD 03 45', 'Randon', 'SR CT PD 03 45', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 387
  (387, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CB'), 'CB-003', NULL, 'Cama baja Randon SR CT PD 03 45', 'Randon', 'SR CT PD 03 45', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 388
  (388, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CB'), 'CB-004', NULL, 'Cama baja Ledwell LW48HTHT3', 'Ledwell', 'LW48HTHT3', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 389
  (389, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CB'), 'CB-005', NULL, 'Cama baja Ledwell LW48HTHT2', 'Ledwell', 'LW48HTHT2', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 390
  (390, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'SR'), 'SR-001', NULL, 'Semirremolque Tremac cama baja', 'Tremac', NULL, 'cama baja', NULL, NULL, -20.244800, -70.139300),   -- fila 391
  (391, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CB'), 'CB-006', NULL, 'Cama baja Tremac SR PLANO 13.5 MTS', 'Tremac', 'SR PLANO 13.5 MTS', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 392
  (392, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'RA'), 'RA-001', NULL, 'Rampla Tremac', 'Tremac', NULL, NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 393
  (393, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CB'), 'CB-007', NULL, 'Cama baja Goren SRCB 3M 3516', 'Goren', 'SRCB 3M 3516', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 394
  (394, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CB'), 'CB-008', NULL, 'Cama baja Goren SRR 3 N 30 12 5', 'Goren', 'SRR 3 N 30 12 5', NULL, NULL, NULL, -20.244800, -70.139300),   -- fila 395
  (395, (SELECT id_tipo_equipo FROM tipo_equipo WHERE prefijo = 'CB'), 'CB-009', NULL, 'Cama baja Goren', 'Goren', NULL, NULL, NULL, NULL, -20.244800, -70.139300);   -- fila 396

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

-- Receta de insumos por servicio (tipo, intervalo, insumo, cantidad).
-- Generador: pauta del modelo JCB G45QX (planilla). Grúa horquilla, excavadora,
-- retroexcavadora y camión: pautas de referencia hasta tener las de la empresa.
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
-- Órdenes de trabajo: historial real de la V168 (planilla de mantenciones)
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
) o
JOIN equipo e           ON e.codigo_anterior = o.equipo
JOIN plan_mantencion pm ON pm.id_tipo_equipo = e.id_tipo_equipo
JOIN servicio_plan sp   ON sp.id_plan = pm.id_plan AND sp.intervalo_horas = o.servicio
ORDER BY CAST(o.numero AS UNSIGNED);
