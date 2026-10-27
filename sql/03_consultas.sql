-- =====================================================================
--  VILAS MOTOR - Consultas de la aplicación
--  Cada número del dashboard tiene aquí la lista que lo forma.
--  Si el número dice 3, su lista devuelve 3 filas: siempre calzan.
-- =====================================================================
USE vilas_motor;

-- ---------------------------------------------------------------------
-- 1. Números del dashboard
-- ---------------------------------------------------------------------
SELECT * FROM v_dashboard;

-- ---------------------------------------------------------------------
-- 2. Listas a las que lleva cada número (la más nueva primero)
-- ---------------------------------------------------------------------
-- "Equipos"
SELECT id_txt, codigo, codigo_anterior, nombre, ubicacion, estado, estado_mantencion
FROM v_proximo_mantenimiento ORDER BY id_equipo DESC;

-- "N disponibles"
SELECT id_txt, codigo, nombre, ubicacion FROM v_proximo_mantenimiento
WHERE estado = 'DISPONIBLE' ORDER BY id_equipo DESC;

-- "En faena" y "N clientes"
SELECT id_txt, codigo, nombre, cliente, arriendo, ubicacion FROM v_proximo_mantenimiento
WHERE estado = 'EN_FAENA' ORDER BY id_equipo DESC;

-- "Señal GPS" (con señal) y "N sin señal"
SELECT id_txt, codigo, ubicacion, ultima_senal FROM v_proximo_mantenimiento WHERE con_senal = 1 ORDER BY id_equipo DESC;
SELECT id_txt, codigo, ubicacion, ultima_senal FROM v_proximo_mantenimiento WHERE con_senal = 0 ORDER BY id_equipo DESC;

-- "Mantención vencida" y "Mantención por vencer" (la más urgente primero)
SELECT id_txt, codigo, tipo, proximo_servicio, restante FROM v_proximo_mantenimiento
WHERE estado_mantencion = 'VENCIDO' ORDER BY restante;
SELECT id_txt, codigo, tipo, proximo_servicio, restante FROM v_proximo_mantenimiento
WHERE estado_mantencion = 'POR_VENCER' ORDER BY restante;

-- "Órdenes abiertas" y "N en el historial" (la OT más reciente primero)
SELECT ot.numero_ot, e.codigo, sp.nombre AS servicio, ot.estado, ot.fecha_programada
FROM orden_trabajo ot JOIN equipo e ON e.id_equipo = ot.id_equipo
LEFT JOIN servicio_plan sp ON sp.id_servicio_plan = ot.id_servicio_plan
WHERE ot.estado <> 'CERRADA' ORDER BY ot.id_ot DESC;

SELECT ot.numero_ot, e.codigo, sp.nombre AS servicio, ot.estado, COALESCE(ot.fecha_ejecucion, ot.fecha_programada) AS fecha, ot.horometro_cierre
FROM orden_trabajo ot JOIN equipo e ON e.id_equipo = ot.id_equipo
LEFT JOIN servicio_plan sp ON sp.id_servicio_plan = ot.id_servicio_plan
ORDER BY ot.id_ot DESC;

-- ---------------------------------------------------------------------
-- 3. Filtro del dashboard por tipo / marca / modelo
--    (deja en NULL los que no quieras usar)
-- ---------------------------------------------------------------------
SET @tipo = NULL, @marca = 'JCB', @modelo = 'G45QX';
SELECT id_txt, codigo, nombre, estado, estado_mantencion, ubicacion
FROM v_proximo_mantenimiento
WHERE (@tipo   IS NULL OR tipo   = @tipo)
  AND (@marca  IS NULL OR marca  = @marca)
  AND (@modelo IS NULL OR modelo = @modelo)
ORDER BY id_equipo DESC;

-- ---------------------------------------------------------------------
-- 4. Pauta de insumos del próximo servicio de un equipo
-- ---------------------------------------------------------------------
SELECT pm.codigo, pm.proximo_servicio, i.nombre AS insumo, spi.cantidad, i.unidad_medida
FROM v_proximo_mantenimiento pm
JOIN plan_mantencion pl      ON pl.id_tipo_equipo = pm.id_tipo_equipo
JOIN servicio_plan sp        ON sp.id_plan = pl.id_plan AND sp.intervalo_horas = pm.proximo_servicio
JOIN servicio_plan_insumo spi ON spi.id_servicio_plan = sp.id_servicio_plan
JOIN insumo i                ON i.id_insumo = spi.id_insumo
WHERE pm.codigo_anterior = 'VG10';

-- ---------------------------------------------------------------------
-- 5. Ejemplos: crear cosas nuevas (códigos e ID se generan solos)
--    Descomenta para probar.
-- ---------------------------------------------------------------------
-- Nuevo tipo: el prefijo sale solo ("Torre de iluminación" -> TI)
-- INSERT INTO tipo_equipo (nombre, unidad_medida) VALUES ('Torre de iluminación', 'HORAS');

-- Nuevo equipo: queda con el siguiente ID (#0007) y código CA-002
-- INSERT INTO equipo (id_tipo_equipo, codigo, nombre, marca, modelo, ubicacion, latitud, longitud)
-- VALUES ((SELECT id_tipo_equipo FROM tipo_equipo WHERE nombre = 'Camión'), '', '', 'Volvo', 'FH 540', 'Taller', -20.2448, -70.1393);

-- Nuevo arriendo: número ARR-0004; el equipo pasa a EN_FAENA y toma la ubicación de la faena
-- INSERT INTO arriendo (numero, id_equipo, id_cliente, id_faena, fecha_inicio)
-- VALUES ('', (SELECT id_equipo FROM equipo WHERE codigo = 'GE-002'),
--         (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'),
--         (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), CURDATE());

-- Terminar un arriendo: el equipo vuelve a DISPONIBLE en el taller
-- UPDATE arriendo SET estado = 'TERMINADO', fecha_termino = CURDATE() WHERE numero = 'ARR-0004';

-- Nueva OT con número correlativo
-- INSERT INTO orden_trabajo (id_equipo, id_servicio_plan, tipo, numero_ot, fecha_programada)
-- SELECT pm.id_equipo, sp.id_servicio_plan, 'PREVENTIVA',
--        (SELECT MAX(CAST(numero_ot AS UNSIGNED)) + 1 FROM orden_trabajo), CURDATE()
-- FROM v_proximo_mantenimiento pm
-- JOIN plan_mantencion pl ON pl.id_tipo_equipo = pm.id_tipo_equipo
-- JOIN servicio_plan sp ON sp.id_plan = pl.id_plan AND sp.intervalo_horas = pm.proximo_servicio
-- WHERE pm.codigo = 'GH-001';

-- Cerrar una OT: el último servicio del equipo se actualiza solo
-- UPDATE orden_trabajo SET estado = 'CERRADA', fecha_ejecucion = CURDATE(), horometro_cierre = 3620 WHERE numero_ot = '106949';

-- ---------------------------------------------------------------------
-- 6. Simular señales GPS (en producción las envía cada dispositivo)
--    Sin señales nuevas, a los 10 minutos todos aparecen "sin señal".
-- ---------------------------------------------------------------------
-- INSERT INTO telemetria_equipo (id_equipo, ts, latitud, longitud, velocidad_kmh)
-- SELECT id_equipo, NOW(), latitud, longitud, velocidad_kmh FROM equipo WHERE codigo_anterior <> 'EX-204';

-- ---------------------------------------------------------------------
-- 7. Verificación en dos pasos (lo que haría el backend)
-- ---------------------------------------------------------------------
-- a) Crear el código (la app genera 6 dígitos y lo envía por correo)
-- INSERT INTO codigo_verificacion (id_usuario, codigo_hash, vence_en)
-- VALUES ((SELECT id_usuario FROM usuario WHERE email = 'planificador@vilasmotor.cl'), SHA2('123456', 256), NOW() + INTERVAL 5 MINUTE);
-- b) Validar: vigente, no usado y con menos de 3 intentos
-- SELECT id_codigo FROM codigo_verificacion
--  WHERE id_usuario = 1 AND codigo_hash = SHA2('123456', 256)
--    AND usado_en IS NULL AND vence_en > NOW() AND intentos < 3
--  ORDER BY id_codigo DESC LIMIT 1;
