-- =====================================================================
--  VILAS MOTOR - Datos SIMULADOS para la demostración (opcional)
--  Ejecutar después de 02_datos.sql. Pone a la flota "en operación" con los
--  mismos valores que la maqueta: estado, horómetro, arriendos, última señal
--  GPS y OT abiertas. No son datos reales de la empresa: sirven para mostrar
--  el dashboard funcionando. Para trabajar con datos reales, no lo ejecuten.
-- =====================================================================
USE vilas_motor;
SET @app_usuario = (SELECT id_usuario FROM usuario WHERE email = 'planificador@vilasmotor.cl');

-- Estados, horómetros y ubicación (los equipos en faena los marca el trigger del arriendo)
UPDATE equipo SET horometro_actual = 3620.0, ultimo_servicio = 3157 WHERE id_equipo = 1;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2259.2, ultimo_servicio = 2190, ubicacion = 'Taller' WHERE id_equipo = 2;
UPDATE equipo SET horometro_actual = 963.5, ultimo_servicio = 924 WHERE id_equipo = 3;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 7381.2, ultimo_servicio = 7065, ubicacion = 'Taller' WHERE id_equipo = 4;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8072.7, ultimo_servicio = 7833, ubicacion = 'Taller' WHERE id_equipo = 5;
UPDATE equipo SET horometro_actual = 5208.4, ultimo_servicio = 5066 WHERE id_equipo = 6;
UPDATE equipo SET horometro_actual = 4961.1, ultimo_servicio = 4867 WHERE id_equipo = 7;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 7655.7, ultimo_servicio = 7334, ubicacion = 'Taller' WHERE id_equipo = 8;
UPDATE equipo SET horometro_actual = 4215.8, ultimo_servicio = 4176 WHERE id_equipo = 9;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2627.5, ultimo_servicio = 2587, ubicacion = 'Taller' WHERE id_equipo = 10;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 3951.7, ultimo_servicio = 3931, ubicacion = 'Taller' WHERE id_equipo = 11;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5462.0, ultimo_servicio = 5069, ubicacion = 'Taller' WHERE id_equipo = 12;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1113.5, ultimo_servicio = 1084, ubicacion = 'Taller' WHERE id_equipo = 13;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 4205.0, ultimo_servicio = 3943, ubicacion = 'Taller' WHERE id_equipo = 14;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2837.6, ultimo_servicio = 2837, ubicacion = 'Taller' WHERE id_equipo = 15;
UPDATE equipo SET horometro_actual = 6017.8, ultimo_servicio = 5871 WHERE id_equipo = 16;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4473.0, ultimo_servicio = 4217, ubicacion = 'Taller' WHERE id_equipo = 17;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4379.4, ultimo_servicio = 4333, ubicacion = 'Taller' WHERE id_equipo = 18;
UPDATE equipo SET horometro_actual = 1122.1, ultimo_servicio = 1090 WHERE id_equipo = 19;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7045.5, ultimo_servicio = 6790, ubicacion = 'Taller' WHERE id_equipo = 20;
UPDATE equipo SET horometro_actual = 6650.4, ultimo_servicio = 6580 WHERE id_equipo = 21;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 686.5, ultimo_servicio = 685, ubicacion = 'Taller' WHERE id_equipo = 22;
UPDATE equipo SET horometro_actual = 3380.8, ultimo_servicio = 3239 WHERE id_equipo = 23;
UPDATE equipo SET horometro_actual = 8550.2, ultimo_servicio = 8252 WHERE id_equipo = 24;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 5329.1, ultimo_servicio = 4644, ubicacion = 'Taller' WHERE id_equipo = 25;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1105.3, ultimo_servicio = 1060, ubicacion = 'Taller' WHERE id_equipo = 26;
UPDATE equipo SET horometro_actual = 2247.9, ultimo_servicio = 2182 WHERE id_equipo = 27;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1592.8, ultimo_servicio = 1281, ubicacion = 'Taller' WHERE id_equipo = 28;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4227.5, ultimo_servicio = 4196, ubicacion = 'Taller' WHERE id_equipo = 29;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 5423.9, ultimo_servicio = 5115, ubicacion = 'Taller' WHERE id_equipo = 30;
UPDATE equipo SET horometro_actual = 711.3, ultimo_servicio = 708 WHERE id_equipo = 31;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5252.1, ultimo_servicio = 4930, ubicacion = 'Taller' WHERE id_equipo = 32;
UPDATE equipo SET horometro_actual = 2045.0, ultimo_servicio = 1825 WHERE id_equipo = 33;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 873.7, ultimo_servicio = 553, ubicacion = 'Taller' WHERE id_equipo = 34;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2226.8, ultimo_servicio = 2175, ubicacion = 'Taller' WHERE id_equipo = 35;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 8520.7, ultimo_servicio = 8129, ubicacion = 'Taller' WHERE id_equipo = 36;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 6558.2, ultimo_servicio = 6286, ubicacion = 'Taller' WHERE id_equipo = 37;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4748.3, ultimo_servicio = 4701, ubicacion = 'Taller' WHERE id_equipo = 38;
UPDATE equipo SET horometro_actual = 2805.6, ultimo_servicio = 2802 WHERE id_equipo = 39;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 6449.4, ultimo_servicio = 6376, ubicacion = 'Taller' WHERE id_equipo = 40;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 2325.0, ultimo_servicio = 2278, ubicacion = 'Taller' WHERE id_equipo = 41;
UPDATE equipo SET horometro_actual = 4401.0, ultimo_servicio = 4158 WHERE id_equipo = 42;
UPDATE equipo SET horometro_actual = 1650.8, ultimo_servicio = 1276 WHERE id_equipo = 43;
UPDATE equipo SET horometro_actual = 2393.5, ultimo_servicio = 2344 WHERE id_equipo = 44;
UPDATE equipo SET horometro_actual = 2004.3, ultimo_servicio = 1691 WHERE id_equipo = 45;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7658.7, ultimo_servicio = 7577, ubicacion = 'Taller' WHERE id_equipo = 46;
UPDATE equipo SET horometro_actual = 2738.5, ultimo_servicio = 2726 WHERE id_equipo = 47;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5148.3, ultimo_servicio = 4929, ubicacion = 'Taller' WHERE id_equipo = 48;
UPDATE equipo SET horometro_actual = 2270.5, ultimo_servicio = 2209 WHERE id_equipo = 49;
UPDATE equipo SET horometro_actual = 6002.0, ultimo_servicio = 5985 WHERE id_equipo = 50;
UPDATE equipo SET horometro_actual = 2723.9, ultimo_servicio = 2499 WHERE id_equipo = 51;
UPDATE equipo SET horometro_actual = 2705.3, ultimo_servicio = 2469 WHERE id_equipo = 52;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 4648.0, ultimo_servicio = 4321, ubicacion = 'Taller' WHERE id_equipo = 53;
UPDATE equipo SET horometro_actual = 9065.9, ultimo_servicio = 8980 WHERE id_equipo = 54;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7423.2, ultimo_servicio = 7358, ubicacion = 'Taller' WHERE id_equipo = 55;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7412.1, ultimo_servicio = 7327, ubicacion = 'Taller' WHERE id_equipo = 56;
UPDATE equipo SET horometro_actual = 4680.2, ultimo_servicio = 4531 WHERE id_equipo = 57;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7861.4, ultimo_servicio = 7184, ubicacion = 'Taller' WHERE id_equipo = 58;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 6029.0, ultimo_servicio = 5830, ubicacion = 'Taller' WHERE id_equipo = 59;
UPDATE equipo SET horometro_actual = 2189.9, ultimo_servicio = 2054 WHERE id_equipo = 60;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1917.2, ultimo_servicio = 1801, ubicacion = 'Taller' WHERE id_equipo = 61;
UPDATE equipo SET horometro_actual = 5829.1, ultimo_servicio = 5769 WHERE id_equipo = 62;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 1280.8, ultimo_servicio = 756, ubicacion = 'Taller' WHERE id_equipo = 63;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 7353.2, ultimo_servicio = 7095, ubicacion = 'Taller' WHERE id_equipo = 64;
UPDATE equipo SET horometro_actual = 5080.5, ultimo_servicio = 5071 WHERE id_equipo = 65;
UPDATE equipo SET horometro_actual = 7773.7, ultimo_servicio = 7609 WHERE id_equipo = 66;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 3267.4, ultimo_servicio = 3189, ubicacion = 'Taller' WHERE id_equipo = 67;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 5737.4, ultimo_servicio = 5475, ubicacion = 'Taller' WHERE id_equipo = 68;
UPDATE equipo SET horometro_actual = 5324.5, ultimo_servicio = 5227 WHERE id_equipo = 69;
UPDATE equipo SET horometro_actual = 3112.0, ultimo_servicio = 3099 WHERE id_equipo = 70;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 1947.5, ultimo_servicio = 1686, ubicacion = 'Taller' WHERE id_equipo = 71;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5178.7, ultimo_servicio = 5167, ubicacion = 'Taller' WHERE id_equipo = 72;
UPDATE equipo SET horometro_actual = 700.8, ultimo_servicio = 596 WHERE id_equipo = 73;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 277.3, ultimo_servicio = 49, ubicacion = 'Taller' WHERE id_equipo = 74;
UPDATE equipo SET horometro_actual = 6737.2, ultimo_servicio = 6669 WHERE id_equipo = 75;
UPDATE equipo SET horometro_actual = 7622.0, ultimo_servicio = 7519 WHERE id_equipo = 76;
UPDATE equipo SET horometro_actual = 1468.2, ultimo_servicio = 1359 WHERE id_equipo = 77;
UPDATE equipo SET horometro_actual = 4578.7, ultimo_servicio = 4478 WHERE id_equipo = 78;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 3292.4, ultimo_servicio = 3285, ubicacion = 'Taller' WHERE id_equipo = 79;
UPDATE equipo SET horometro_actual = 5823.9, ultimo_servicio = 5768 WHERE id_equipo = 80;
UPDATE equipo SET horometro_actual = 8363.0, ultimo_servicio = 8270 WHERE id_equipo = 81;
UPDATE equipo SET horometro_actual = 9440.2, ultimo_servicio = 9428 WHERE id_equipo = 82;
UPDATE equipo SET horometro_actual = 383.9, ultimo_servicio = 322 WHERE id_equipo = 83;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1728.0, ultimo_servicio = 1549, ubicacion = 'Taller' WHERE id_equipo = 84;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8576.5, ultimo_servicio = 8329, ubicacion = 'Taller' WHERE id_equipo = 85;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 1262.1, ultimo_servicio = 962, ubicacion = 'Taller' WHERE id_equipo = 86;
UPDATE equipo SET horometro_actual = 4790.2, ultimo_servicio = 4488 WHERE id_equipo = 87;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2312.7, ultimo_servicio = 2183, ubicacion = 'Taller' WHERE id_equipo = 88;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 317.7, ultimo_servicio = 93, ubicacion = 'Taller' WHERE id_equipo = 89;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 3049.2, ultimo_servicio = 3039, ubicacion = 'Taller' WHERE id_equipo = 90;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 3358.3, ultimo_servicio = 3042, ubicacion = 'Taller' WHERE id_equipo = 91;
UPDATE equipo SET horometro_actual = 8582.8, ultimo_servicio = 8553 WHERE id_equipo = 92;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2547.9, ultimo_servicio = 2127, ubicacion = 'Taller' WHERE id_equipo = 93;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5726.8, ultimo_servicio = 5621, ubicacion = 'Taller' WHERE id_equipo = 94;
UPDATE equipo SET horometro_actual = 2458.0, ultimo_servicio = 2253 WHERE id_equipo = 95;
UPDATE equipo SET horometro_actual = 3849.4, ultimo_servicio = 3651 WHERE id_equipo = 96;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2345.0, ultimo_servicio = 1929, ubicacion = 'Taller' WHERE id_equipo = 97;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4336.7, ultimo_servicio = 4201, ubicacion = 'Taller' WHERE id_equipo = 98;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1687.3, ultimo_servicio = 1679, ubicacion = 'Taller' WHERE id_equipo = 99;
UPDATE equipo SET horometro_actual = 5014.8, ultimo_servicio = 4941 WHERE id_equipo = 100;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8284.0, ultimo_servicio = 8212, ubicacion = 'Taller' WHERE id_equipo = 101;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2793.9, ultimo_servicio = 2661, ubicacion = 'Taller' WHERE id_equipo = 102;
UPDATE equipo SET horometro_actual = 294.8, ultimo_servicio = 217 WHERE id_equipo = 103;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4525.0, ultimo_servicio = 4322, ubicacion = 'Taller' WHERE id_equipo = 104;
UPDATE equipo SET horometro_actual = 2166.5, ultimo_servicio = 1980 WHERE id_equipo = 105;
UPDATE equipo SET horometro_actual = 1377.4, ultimo_servicio = 1164 WHERE id_equipo = 106;
UPDATE equipo SET horometro_actual = 4377.7, ultimo_servicio = 4313 WHERE id_equipo = 107;
UPDATE equipo SET horometro_actual = 1665.2, ultimo_servicio = 1609 WHERE id_equipo = 108;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7073.8, ultimo_servicio = 6982, ubicacion = 'Taller' WHERE id_equipo = 109;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 216.8, ultimo_servicio = 78, ubicacion = 'Taller' WHERE id_equipo = 110;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5693.8, ultimo_servicio = 5364, ubicacion = 'Taller' WHERE id_equipo = 111;
UPDATE equipo SET horometro_actual = 5511.9, ultimo_servicio = 5319 WHERE id_equipo = 112;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 1053.1, ultimo_servicio = 727, ubicacion = 'Taller' WHERE id_equipo = 113;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8113.3, ultimo_servicio = 8033, ubicacion = 'Taller' WHERE id_equipo = 114;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 423.2, ultimo_servicio = 89, ubicacion = 'Taller' WHERE id_equipo = 115;
UPDATE equipo SET horometro_actual = 1081.6, ultimo_servicio = 946 WHERE id_equipo = 116;
UPDATE equipo SET horometro_actual = 6737.6, ultimo_servicio = 6698 WHERE id_equipo = 117;
UPDATE equipo SET horometro_actual = 230022, ultimo_servicio = 217283 WHERE id_equipo = 118;
UPDATE equipo SET horometro_actual = 235586, ultimo_servicio = 226861 WHERE id_equipo = 119;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 122148, ultimo_servicio = 121925, ubicacion = 'Taller' WHERE id_equipo = 120;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 39918, ultimo_servicio = 34509, ubicacion = 'Taller' WHERE id_equipo = 121;
UPDATE equipo SET horometro_actual = 15360, ultimo_servicio = 11503 WHERE id_equipo = 122;
UPDATE equipo SET horometro_actual = 90363, ultimo_servicio = 86166 WHERE id_equipo = 123;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 153729, ultimo_servicio = 140526, ubicacion = 'Taller' WHERE id_equipo = 124;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 226926, ultimo_servicio = 224329, ubicacion = 'Taller' WHERE id_equipo = 125;
UPDATE equipo SET horometro_actual = 35105, ultimo_servicio = 34990 WHERE id_equipo = 126;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 189683, ultimo_servicio = 181223, ubicacion = 'Taller' WHERE id_equipo = 127;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 141946, ultimo_servicio = 137774, ubicacion = 'Taller' WHERE id_equipo = 128;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 243658, ultimo_servicio = 240063, ubicacion = 'Taller' WHERE id_equipo = 129;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 82635, ultimo_servicio = 76198, ubicacion = 'Taller' WHERE id_equipo = 130;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 124594, ultimo_servicio = 117669, ubicacion = 'Taller' WHERE id_equipo = 131;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 84532, ultimo_servicio = 73024, ubicacion = 'Taller' WHERE id_equipo = 132;
UPDATE equipo SET horometro_actual = 208147, ultimo_servicio = 202387 WHERE id_equipo = 133;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 255926, ultimo_servicio = 253527, ubicacion = 'Taller' WHERE id_equipo = 134;
UPDATE equipo SET horometro_actual = 69998, ultimo_servicio = 67898 WHERE id_equipo = 135;
UPDATE equipo SET horometro_actual = 181430, ultimo_servicio = 173932 WHERE id_equipo = 136;
UPDATE equipo SET horometro_actual = 126674, ultimo_servicio = 121380 WHERE id_equipo = 137;
UPDATE equipo SET horometro_actual = 258607, ultimo_servicio = 250363 WHERE id_equipo = 138;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 173004, ultimo_servicio = 159971, ubicacion = 'Taller' WHERE id_equipo = 139;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 136097, ultimo_servicio = 129380, ubicacion = 'Taller' WHERE id_equipo = 140;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 20052, ultimo_servicio = 12451, ubicacion = 'Taller' WHERE id_equipo = 141;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 161573, ultimo_servicio = 151048, ubicacion = 'Taller' WHERE id_equipo = 142;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 168540, ultimo_servicio = 166732, ubicacion = 'Taller' WHERE id_equipo = 143;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 259752, ultimo_servicio = 253542, ubicacion = 'Taller' WHERE id_equipo = 144;
UPDATE equipo SET horometro_actual = 165572, ultimo_servicio = 159606 WHERE id_equipo = 145;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 166363, ultimo_servicio = 161506, ubicacion = 'Taller' WHERE id_equipo = 146;
UPDATE equipo SET horometro_actual = 219912, ultimo_servicio = 217683 WHERE id_equipo = 147;
UPDATE equipo SET horometro_actual = 78228, ultimo_servicio = 77199 WHERE id_equipo = 148;
UPDATE equipo SET horometro_actual = 67174, ultimo_servicio = 67089 WHERE id_equipo = 149;
UPDATE equipo SET horometro_actual = 199858, ultimo_servicio = 186402 WHERE id_equipo = 150;
UPDATE equipo SET horometro_actual = 136511, ultimo_servicio = 127206 WHERE id_equipo = 151;
UPDATE equipo SET horometro_actual = 98246, ultimo_servicio = 92047 WHERE id_equipo = 152;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 252026, ultimo_servicio = 238922, ubicacion = 'Taller' WHERE id_equipo = 153;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 142785, ultimo_servicio = 129333, ubicacion = 'Taller' WHERE id_equipo = 154;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 249861, ultimo_servicio = 238482, ubicacion = 'Taller' WHERE id_equipo = 155;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 184964, ultimo_servicio = 171775, ubicacion = 'Taller' WHERE id_equipo = 156;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 143786, ultimo_servicio = 143114, ubicacion = 'Taller' WHERE id_equipo = 157;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 247040, ultimo_servicio = 235665, ubicacion = 'Taller' WHERE id_equipo = 158;
UPDATE equipo SET horometro_actual = 5600, ultimo_servicio = 4273 WHERE id_equipo = 159;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 29179, ultimo_servicio = 20381, ubicacion = 'Taller' WHERE id_equipo = 160;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 31656, ultimo_servicio = 21030, ubicacion = 'Taller' WHERE id_equipo = 161;
UPDATE equipo SET horometro_actual = 92103, ultimo_servicio = 79312 WHERE id_equipo = 162;
UPDATE equipo SET horometro_actual = 9427.3, ultimo_servicio = 9351 WHERE id_equipo = 163;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4189.3, ultimo_servicio = 4183, ubicacion = 'Taller' WHERE id_equipo = 164;
UPDATE equipo SET horometro_actual = 5668.7, ultimo_servicio = 5623 WHERE id_equipo = 165;
UPDATE equipo SET horometro_actual = 5028.5, ultimo_servicio = 4851 WHERE id_equipo = 166;
UPDATE equipo SET horometro_actual = 7142.2, ultimo_servicio = 7036 WHERE id_equipo = 167;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5995.3, ultimo_servicio = 5955, ubicacion = 'Taller' WHERE id_equipo = 168;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2397.4, ultimo_servicio = 2100, ubicacion = 'Taller' WHERE id_equipo = 169;
UPDATE equipo SET horometro_actual = 1662.3, ultimo_servicio = 1557 WHERE id_equipo = 170;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 3478.4, ultimo_servicio = 3350, ubicacion = 'Taller' WHERE id_equipo = 171;
UPDATE equipo SET horometro_actual = 4236.9, ultimo_servicio = 3978 WHERE id_equipo = 172;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2445.8, ultimo_servicio = 2368, ubicacion = 'Taller' WHERE id_equipo = 173;
UPDATE equipo SET horometro_actual = 1738.9, ultimo_servicio = 1609 WHERE id_equipo = 174;
UPDATE equipo SET horometro_actual = 5107.6, ultimo_servicio = 4944 WHERE id_equipo = 175;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5741.1, ultimo_servicio = 5738, ubicacion = 'Taller' WHERE id_equipo = 176;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8915.7, ultimo_servicio = 8679, ubicacion = 'Taller' WHERE id_equipo = 177;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4808.0, ultimo_servicio = 4679, ubicacion = 'Taller' WHERE id_equipo = 178;
UPDATE equipo SET horometro_actual = 4988.4, ultimo_servicio = 4785 WHERE id_equipo = 179;
UPDATE equipo SET horometro_actual = 3549.5, ultimo_servicio = 3371 WHERE id_equipo = 180;
UPDATE equipo SET horometro_actual = 6900.7, ultimo_servicio = 6792 WHERE id_equipo = 181;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 8132.5, ultimo_servicio = 7799, ubicacion = 'Taller' WHERE id_equipo = 182;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5084.1, ultimo_servicio = 4903, ubicacion = 'Taller' WHERE id_equipo = 183;
UPDATE equipo SET horometro_actual = 5882.7, ultimo_servicio = 5859 WHERE id_equipo = 184;
UPDATE equipo SET horometro_actual = 9299.4, ultimo_servicio = 9248 WHERE id_equipo = 185;
UPDATE equipo SET horometro_actual = 2251.4, ultimo_servicio = 1913 WHERE id_equipo = 186;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 150.0, ultimo_servicio = 74, ubicacion = 'Taller' WHERE id_equipo = 187;
UPDATE equipo SET horometro_actual = 7143.9, ultimo_servicio = 7003 WHERE id_equipo = 188;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 1412.2, ultimo_servicio = 1126, ubicacion = 'Taller' WHERE id_equipo = 189;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 6062.6, ultimo_servicio = 5937, ubicacion = 'Taller' WHERE id_equipo = 190;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7398.9, ultimo_servicio = 7367, ubicacion = 'Taller' WHERE id_equipo = 191;
UPDATE equipo SET horometro_actual = 4463.3, ultimo_servicio = 4265 WHERE id_equipo = 192;
UPDATE equipo SET horometro_actual = 5030.2, ultimo_servicio = 5018 WHERE id_equipo = 193;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7333.3, ultimo_servicio = 7249, ubicacion = 'Taller' WHERE id_equipo = 194;
UPDATE equipo SET horometro_actual = 2700.5, ultimo_servicio = 2498 WHERE id_equipo = 195;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 6023.5, ultimo_servicio = 6018, ubicacion = 'Taller' WHERE id_equipo = 196;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5936.8, ultimo_servicio = 5932, ubicacion = 'Taller' WHERE id_equipo = 197;
UPDATE equipo SET horometro_actual = 7621.7, ultimo_servicio = 7415 WHERE id_equipo = 198;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5786.6, ultimo_servicio = 5715, ubicacion = 'Taller' WHERE id_equipo = 199;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 9370.5, ultimo_servicio = 9021, ubicacion = 'Taller' WHERE id_equipo = 200;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 2623.3, ultimo_servicio = 2340, ubicacion = 'Taller' WHERE id_equipo = 201;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 2589.3, ultimo_servicio = 2303, ubicacion = 'Taller' WHERE id_equipo = 202;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7038.8, ultimo_servicio = 6940, ubicacion = 'Taller' WHERE id_equipo = 203;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1322.7, ultimo_servicio = 1209, ubicacion = 'Taller' WHERE id_equipo = 204;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 2900.3, ultimo_servicio = 2859, ubicacion = 'Taller' WHERE id_equipo = 205;
UPDATE equipo SET horometro_actual = 807.8, ultimo_servicio = 796 WHERE id_equipo = 206;
UPDATE equipo SET horometro_actual = 4235.3, ultimo_servicio = 4096 WHERE id_equipo = 207;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 2243.3, ultimo_servicio = 1905, ubicacion = 'Taller' WHERE id_equipo = 208;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5369.4, ultimo_servicio = 5336, ubicacion = 'Taller' WHERE id_equipo = 209;
UPDATE equipo SET horometro_actual = 2863.0, ultimo_servicio = 2834 WHERE id_equipo = 210;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8837.9, ultimo_servicio = 8836, ubicacion = 'Taller' WHERE id_equipo = 211;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8059.0, ultimo_servicio = 7918, ubicacion = 'Taller' WHERE id_equipo = 212;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 6591.7, ultimo_servicio = 6357, ubicacion = 'Taller' WHERE id_equipo = 213;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 5757.0, ultimo_servicio = 5413, ubicacion = 'Taller' WHERE id_equipo = 214;
UPDATE equipo SET horometro_actual = 5459.0, ultimo_servicio = 5441 WHERE id_equipo = 215;
UPDATE equipo SET horometro_actual = 1287.3, ultimo_servicio = 1179 WHERE id_equipo = 216;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 853.2, ultimo_servicio = 849, ubicacion = 'Taller' WHERE id_equipo = 217;
UPDATE equipo SET horometro_actual = 8859.0, ultimo_servicio = 8782 WHERE id_equipo = 218;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8211.5, ultimo_servicio = 8157, ubicacion = 'Taller' WHERE id_equipo = 219;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 6947.1, ultimo_servicio = 6842, ubicacion = 'Taller' WHERE id_equipo = 220;
UPDATE equipo SET horometro_actual = 1400.1, ultimo_servicio = 1279 WHERE id_equipo = 221;
UPDATE equipo SET horometro_actual = 4131.9, ultimo_servicio = 3907 WHERE id_equipo = 222;
UPDATE equipo SET horometro_actual = 2057.5, ultimo_servicio = 1815 WHERE id_equipo = 223;
UPDATE equipo SET horometro_actual = 8745.5, ultimo_servicio = 8553 WHERE id_equipo = 224;
UPDATE equipo SET horometro_actual = 8453.5, ultimo_servicio = 8384 WHERE id_equipo = 225;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1241.3, ultimo_servicio = 1119, ubicacion = 'Taller' WHERE id_equipo = 226;
UPDATE equipo SET horometro_actual = 4414.5, ultimo_servicio = 4360 WHERE id_equipo = 227;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 944.5, ultimo_servicio = 609, ubicacion = 'Taller' WHERE id_equipo = 228;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 6625.7, ultimo_servicio = 6597, ubicacion = 'Taller' WHERE id_equipo = 229;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 7042.0, ultimo_servicio = 6692, ubicacion = 'Taller' WHERE id_equipo = 230;
UPDATE equipo SET horometro_actual = 9261.7, ultimo_servicio = 9035 WHERE id_equipo = 231;
UPDATE equipo SET horometro_actual = 8547.4, ultimo_servicio = 8433 WHERE id_equipo = 232;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 1120.6, ultimo_servicio = 807, ubicacion = 'Taller' WHERE id_equipo = 233;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7237.4, ultimo_servicio = 7106, ubicacion = 'Taller' WHERE id_equipo = 234;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 7202.3, ultimo_servicio = 6907, ubicacion = 'Taller' WHERE id_equipo = 235;
UPDATE equipo SET horometro_actual = 7840.2, ultimo_servicio = 7708 WHERE id_equipo = 236;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7784.2, ultimo_servicio = 7687, ubicacion = 'Taller' WHERE id_equipo = 237;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8809.6, ultimo_servicio = 8685, ubicacion = 'Taller' WHERE id_equipo = 238;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4644.0, ultimo_servicio = 4504, ubicacion = 'Taller' WHERE id_equipo = 239;
UPDATE equipo SET horometro_actual = 638.9, ultimo_servicio = 614 WHERE id_equipo = 240;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4808.0, ultimo_servicio = 4718, ubicacion = 'Taller' WHERE id_equipo = 241;
UPDATE equipo SET horometro_actual = 246156, ultimo_servicio = 242721 WHERE id_equipo = 242;
UPDATE equipo SET horometro_actual = 7766.7, ultimo_servicio = 7390 WHERE id_equipo = 243;
UPDATE equipo SET horometro_actual = 198708, ultimo_servicio = 193750 WHERE id_equipo = 244;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 242231, ultimo_servicio = 236239, ubicacion = 'Taller' WHERE id_equipo = 245;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 237159, ultimo_servicio = 234970, ubicacion = 'Taller' WHERE id_equipo = 246;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 22222, ultimo_servicio = 12906, ubicacion = 'Taller' WHERE id_equipo = 247;
UPDATE equipo SET horometro_actual = 244326, ultimo_servicio = 237241 WHERE id_equipo = 248;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8152.7, ultimo_servicio = 7940, ubicacion = 'Taller' WHERE id_equipo = 249;
UPDATE equipo SET horometro_actual = 6852.6, ultimo_servicio = 6682 WHERE id_equipo = 250;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 3675.8, ultimo_servicio = 3582, ubicacion = 'Taller' WHERE id_equipo = 251;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 14938, ultimo_servicio = 3678, ubicacion = 'Taller' WHERE id_equipo = 252;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 88278, ultimo_servicio = 80772, ubicacion = 'Taller' WHERE id_equipo = 253;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7087.0, ultimo_servicio = 7038, ubicacion = 'Taller' WHERE id_equipo = 254;
UPDATE equipo SET horometro_actual = 155681, ultimo_servicio = 154993 WHERE id_equipo = 255;
UPDATE equipo SET horometro_actual = 8885.8, ultimo_servicio = 8404 WHERE id_equipo = 256;
UPDATE equipo SET horometro_actual = 54049, ultimo_servicio = 51751 WHERE id_equipo = 257;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 2598.6, ultimo_servicio = 2079, ubicacion = 'Taller' WHERE id_equipo = 258;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 173600, ultimo_servicio = 166595, ubicacion = 'Taller' WHERE id_equipo = 259;
UPDATE equipo SET horometro_actual = 1347.5, ultimo_servicio = 1022 WHERE id_equipo = 260;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 2637.2, ultimo_servicio = 1947, ubicacion = 'Taller' WHERE id_equipo = 261;
UPDATE equipo SET horometro_actual = 6249.7, ultimo_servicio = 6083 WHERE id_equipo = 262;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 5032.3, ultimo_servicio = 4357, ubicacion = 'Taller' WHERE id_equipo = 263;
UPDATE equipo SET horometro_actual = 239760, ultimo_servicio = 229943 WHERE id_equipo = 264;
UPDATE equipo SET horometro_actual = 2434.3, ultimo_servicio = 2221 WHERE id_equipo = 265;
UPDATE equipo SET horometro_actual = 118262, ultimo_servicio = 109731 WHERE id_equipo = 266;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 120446, ultimo_servicio = 112068, ubicacion = 'Taller' WHERE id_equipo = 267;
UPDATE equipo SET horometro_actual = 38104, ultimo_servicio = 33838 WHERE id_equipo = 268;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2108.9, ultimo_servicio = 1875, ubicacion = 'Taller' WHERE id_equipo = 269;
UPDATE equipo SET horometro_actual = 121423, ultimo_servicio = 120354 WHERE id_equipo = 270;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 6694.5, ultimo_servicio = 6317, ubicacion = 'Taller' WHERE id_equipo = 271;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 45787, ultimo_servicio = 35933, ubicacion = 'Taller' WHERE id_equipo = 272;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 33684, ultimo_servicio = 25138, ubicacion = 'Taller' WHERE id_equipo = 273;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 59608, ultimo_servicio = 49792, ubicacion = 'Taller' WHERE id_equipo = 274;
UPDATE equipo SET horometro_actual = 116604, ultimo_servicio = 113373 WHERE id_equipo = 275;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 98518, ultimo_servicio = 92121, ubicacion = 'Taller' WHERE id_equipo = 276;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 249077, ultimo_servicio = 242982, ubicacion = 'Taller' WHERE id_equipo = 277;
UPDATE equipo SET horometro_actual = 7417.7, ultimo_servicio = 7088 WHERE id_equipo = 278;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 6528.3, ultimo_servicio = 5867, ubicacion = 'Taller' WHERE id_equipo = 279;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1677.7, ultimo_servicio = 1673, ubicacion = 'Taller' WHERE id_equipo = 280;
UPDATE equipo SET horometro_actual = 6991.9, ultimo_servicio = 6807 WHERE id_equipo = 281;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2694.9, ultimo_servicio = 2376, ubicacion = 'Taller' WHERE id_equipo = 282;
UPDATE equipo SET horometro_actual = 5099.2, ultimo_servicio = 4816 WHERE id_equipo = 283;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8253.8, ultimo_servicio = 8086, ubicacion = 'Taller' WHERE id_equipo = 284;
UPDATE equipo SET horometro_actual = 2972.1, ultimo_servicio = 2872 WHERE id_equipo = 285;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 213.1, ultimo_servicio = 77, ubicacion = 'Taller' WHERE id_equipo = 286;
UPDATE equipo SET horometro_actual = 3012.4, ultimo_servicio = 2893 WHERE id_equipo = 287;
UPDATE equipo SET horometro_actual = 254.7, ultimo_servicio = 166 WHERE id_equipo = 288;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 3712.7, ultimo_servicio = 3711, ubicacion = 'Taller' WHERE id_equipo = 289;
UPDATE equipo SET horometro_actual = 8670.7, ultimo_servicio = 8553 WHERE id_equipo = 290;
UPDATE equipo SET horometro_actual = 8547.0, ultimo_servicio = 8445 WHERE id_equipo = 291;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 3916.2, ultimo_servicio = 3584, ubicacion = 'Taller' WHERE id_equipo = 292;
UPDATE equipo SET horometro_actual = 1157.3, ultimo_servicio = 1134 WHERE id_equipo = 293;
UPDATE equipo SET horometro_actual = 3336.9, ultimo_servicio = 3105 WHERE id_equipo = 294;
UPDATE equipo SET horometro_actual = 1164.9, ultimo_servicio = 1106 WHERE id_equipo = 295;
UPDATE equipo SET horometro_actual = 9455.8, ultimo_servicio = 9336 WHERE id_equipo = 296;
UPDATE equipo SET horometro_actual = 5162.0, ultimo_servicio = 5059 WHERE id_equipo = 297;
UPDATE equipo SET horometro_actual = 2694.5, ultimo_servicio = 2639 WHERE id_equipo = 298;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 6303.9, ultimo_servicio = 6175, ubicacion = 'Taller' WHERE id_equipo = 299;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7001.8, ultimo_servicio = 6859, ubicacion = 'Taller' WHERE id_equipo = 300;
UPDATE equipo SET horometro_actual = 4112.9, ultimo_servicio = 3980 WHERE id_equipo = 301;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 6786.6, ultimo_servicio = 6763, ubicacion = 'Taller' WHERE id_equipo = 302;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7927.1, ultimo_servicio = 7912, ubicacion = 'Taller' WHERE id_equipo = 303;
UPDATE equipo SET horometro_actual = 1998.4, ultimo_servicio = 1911 WHERE id_equipo = 304;
UPDATE equipo SET horometro_actual = 5561.7, ultimo_servicio = 5519 WHERE id_equipo = 305;
UPDATE equipo SET horometro_actual = 7231.3, ultimo_servicio = 7136 WHERE id_equipo = 306;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 9316.8, ultimo_servicio = 9027, ubicacion = 'Taller' WHERE id_equipo = 307;
UPDATE equipo SET horometro_actual = 9213.5, ultimo_servicio = 9121 WHERE id_equipo = 308;
UPDATE equipo SET horometro_actual = 9480.4, ultimo_servicio = 9422 WHERE id_equipo = 309;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1163.0, ultimo_servicio = 1038, ubicacion = 'Taller' WHERE id_equipo = 310;
UPDATE equipo SET horometro_actual = 6614.0, ultimo_servicio = 6497 WHERE id_equipo = 311;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 8370.4, ultimo_servicio = 8068, ubicacion = 'Taller' WHERE id_equipo = 312;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8785.6, ultimo_servicio = 8723, ubicacion = 'Taller' WHERE id_equipo = 313;
UPDATE equipo SET horometro_actual = 6236.1, ultimo_servicio = 6117 WHERE id_equipo = 314;
UPDATE equipo SET horometro_actual = 5576.4, ultimo_servicio = 5443 WHERE id_equipo = 315;
UPDATE equipo SET horometro_actual = 5065.8, ultimo_servicio = 4819 WHERE id_equipo = 316;
UPDATE equipo SET horometro_actual = 3338.7, ultimo_servicio = 3221 WHERE id_equipo = 317;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 8019.9, ultimo_servicio = 7931, ubicacion = 'Taller' WHERE id_equipo = 318;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 4352.7, ultimo_servicio = 4068, ubicacion = 'Taller' WHERE id_equipo = 319;
UPDATE equipo SET horometro_actual = 2625.1, ultimo_servicio = 2588 WHERE id_equipo = 320;
UPDATE equipo SET horometro_actual = 1311.7, ultimo_servicio = 1187 WHERE id_equipo = 321;
UPDATE equipo SET horometro_actual = 6330.4, ultimo_servicio = 6199 WHERE id_equipo = 322;
UPDATE equipo SET horometro_actual = 4029.4, ultimo_servicio = 3949 WHERE id_equipo = 323;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1505.1, ultimo_servicio = 1404, ubicacion = 'Taller' WHERE id_equipo = 324;
UPDATE equipo SET horometro_actual = 8395.8, ultimo_servicio = 8394 WHERE id_equipo = 325;
UPDATE equipo SET horometro_actual = 6641.3, ultimo_servicio = 6513 WHERE id_equipo = 326;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 8524.6, ultimo_servicio = 7160, ubicacion = 'Taller' WHERE id_equipo = 327;
UPDATE equipo SET horometro_actual = 7605.0, ultimo_servicio = 7107 WHERE id_equipo = 328;
UPDATE equipo SET horometro_actual = 6269.8, ultimo_servicio = 5832 WHERE id_equipo = 329;
UPDATE equipo SET horometro_actual = 6233.5, ultimo_servicio = 5730 WHERE id_equipo = 330;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8623.1, ultimo_servicio = 7364, ubicacion = 'Taller' WHERE id_equipo = 331;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 1448.8, ultimo_servicio = 148, ubicacion = 'Taller' WHERE id_equipo = 332;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 485.7, ultimo_servicio = 322, ubicacion = 'Taller' WHERE id_equipo = 333;
UPDATE equipo SET horometro_actual = 30373, ultimo_servicio = 30119 WHERE id_equipo = 334;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 182267, ultimo_servicio = 169029, ubicacion = 'Taller' WHERE id_equipo = 335;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 61763, ultimo_servicio = 50359, ubicacion = 'Taller' WHERE id_equipo = 336;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 6322.7, ultimo_servicio = 6266, ubicacion = 'Taller' WHERE id_equipo = 337;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 189194, ultimo_servicio = 176415, ubicacion = 'Taller' WHERE id_equipo = 338;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 119476, ultimo_servicio = 110981, ubicacion = 'Taller' WHERE id_equipo = 339;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 223240, ultimo_servicio = 209598, ubicacion = 'Taller' WHERE id_equipo = 340;
UPDATE equipo SET horometro_actual = 129767, ultimo_servicio = 121925 WHERE id_equipo = 341;
UPDATE equipo SET horometro_actual = 49598, ultimo_servicio = 47020 WHERE id_equipo = 342;
UPDATE equipo SET horometro_actual = 105737, ultimo_servicio = 105069 WHERE id_equipo = 343;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 130750, ultimo_servicio = 125643, ubicacion = 'Taller' WHERE id_equipo = 344;
UPDATE equipo SET horometro_actual = 127226, ultimo_servicio = 122021 WHERE id_equipo = 345;
UPDATE equipo SET horometro_actual = 99685, ultimo_servicio = 95826 WHERE id_equipo = 346;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 88093, ultimo_servicio = 74826, ubicacion = 'Taller' WHERE id_equipo = 347;
UPDATE equipo SET horometro_actual = 106117, ultimo_servicio = 100396 WHERE id_equipo = 348;
UPDATE equipo SET horometro_actual = 232708, ultimo_servicio = 230124 WHERE id_equipo = 349;
UPDATE equipo SET horometro_actual = 174348, ultimo_servicio = 173337 WHERE id_equipo = 350;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 229363, ultimo_servicio = 223783, ubicacion = 'Taller' WHERE id_equipo = 351;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 100315, ultimo_servicio = 93194, ubicacion = 'Taller' WHERE id_equipo = 352;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 13458, ultimo_servicio = 777, ubicacion = 'Taller' WHERE id_equipo = 353;
UPDATE equipo SET horometro_actual = 210517, ultimo_servicio = 191008 WHERE id_equipo = 354;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 6939.9, ultimo_servicio = 6880, ubicacion = 'Taller' WHERE id_equipo = 355;
UPDATE equipo SET horometro_actual = 8810.3, ultimo_servicio = 8703 WHERE id_equipo = 356;
UPDATE equipo SET horometro_actual = 6571.2, ultimo_servicio = 6544 WHERE id_equipo = 357;
UPDATE equipo SET horometro_actual = 7641.2, ultimo_servicio = 7594 WHERE id_equipo = 358;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 5929.5, ultimo_servicio = 5813, ubicacion = 'Taller' WHERE id_equipo = 359;
UPDATE equipo SET horometro_actual = 9175.4, ultimo_servicio = 9069 WHERE id_equipo = 360;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2709.4, ultimo_servicio = 2698, ubicacion = 'Taller' WHERE id_equipo = 361;
UPDATE equipo SET horometro_actual = 64981, ultimo_servicio = 55212 WHERE id_equipo = 362;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 946.5, ultimo_servicio = 945, ubicacion = 'Taller' WHERE id_equipo = 363;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 118693, ultimo_servicio = 111827, ubicacion = 'Taller' WHERE id_equipo = 364;
UPDATE equipo SET horometro_actual = 6439.4, ultimo_servicio = 6352 WHERE id_equipo = 365;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 48062, ultimo_servicio = 34863, ubicacion = 'Taller' WHERE id_equipo = 366;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7984.2, ultimo_servicio = 7959, ubicacion = 'Taller' WHERE id_equipo = 367;
UPDATE equipo SET horometro_actual = 1564.0, ultimo_servicio = 1505 WHERE id_equipo = 368;
UPDATE equipo SET horometro_actual = 3319.3, ultimo_servicio = 3109 WHERE id_equipo = 369;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 8266.8, ultimo_servicio = 8221, ubicacion = 'Taller' WHERE id_equipo = 370;
UPDATE equipo SET horometro_actual = 2601.8, ultimo_servicio = 2502 WHERE id_equipo = 371;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 9268.1, ultimo_servicio = 9153, ubicacion = 'Taller' WHERE id_equipo = 372;
UPDATE equipo SET horometro_actual = 9268.2, ultimo_servicio = 9178 WHERE id_equipo = 373;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 239.9, ultimo_servicio = 75, ubicacion = 'Taller' WHERE id_equipo = 374;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 3098.0, ultimo_servicio = 2967, ubicacion = 'Taller' WHERE id_equipo = 375;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 1838.6, ultimo_servicio = 1760, ubicacion = 'Taller' WHERE id_equipo = 376;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 2689.3, ultimo_servicio = 2460, ubicacion = 'Taller' WHERE id_equipo = 377;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7057.2, ultimo_servicio = 7037, ubicacion = 'Taller' WHERE id_equipo = 378;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 7120.9, ultimo_servicio = 7074, ubicacion = 'Taller' WHERE id_equipo = 379;
UPDATE equipo SET horometro_actual = 6714.2, ultimo_servicio = 6679 WHERE id_equipo = 380;
UPDATE equipo SET horometro_actual = 2971.4, ultimo_servicio = 2810 WHERE id_equipo = 381;
UPDATE equipo SET horometro_actual = 4016.8, ultimo_servicio = 3843 WHERE id_equipo = 382;
UPDATE equipo SET horometro_actual = 6535.7, ultimo_servicio = 6382 WHERE id_equipo = 383;
UPDATE equipo SET estado = 'INTERNO', estado_previo = NULL, horometro_actual = 304.1, ultimo_servicio = 297, ubicacion = 'Taller' WHERE id_equipo = 384;
UPDATE equipo SET estado = 'EN_MANTENIMIENTO', estado_previo = 'DISPONIBLE', horometro_actual = 6704.0, ultimo_servicio = 6444, ubicacion = 'Taller' WHERE id_equipo = 385;
UPDATE equipo SET horometro_actual = 32488, ultimo_servicio = 14573 WHERE id_equipo = 386;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 139845, ultimo_servicio = 136654, ubicacion = 'Taller' WHERE id_equipo = 387;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 123885, ultimo_servicio = 123462, ubicacion = 'Taller' WHERE id_equipo = 388;
UPDATE equipo SET horometro_actual = 65896, ultimo_servicio = 46289 WHERE id_equipo = 389;
UPDATE equipo SET horometro_actual = 49541, ultimo_servicio = 40603 WHERE id_equipo = 390;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 250593, ultimo_servicio = 250126, ubicacion = 'Taller' WHERE id_equipo = 391;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 256265, ultimo_servicio = 243389, ubicacion = 'Taller' WHERE id_equipo = 392;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 131846, ultimo_servicio = 114571, ubicacion = 'Taller' WHERE id_equipo = 393;
UPDATE equipo SET estado = 'DISPONIBLE', estado_previo = NULL, horometro_actual = 233220, ultimo_servicio = 220151, ubicacion = 'Taller' WHERE id_equipo = 394;
UPDATE equipo SET horometro_actual = 177882, ultimo_servicio = 157887 WHERE id_equipo = 395;

-- Arriendos vigentes (número en orden de fecha de inicio)
INSERT INTO arriendo (numero, id_equipo, id_cliente, id_faena, fecha_inicio, fecha_termino) VALUES
  ('ARR-0001', 137, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-05-04', '2026-12-21'),
  ('ARR-0002', 23, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-05-05', NULL),
  ('ARR-0003', 42, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-05-05', NULL),
  ('ARR-0004', 368, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-05-05', '2026-11-01'),
  ('ARR-0005', 389, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-05-05', '2026-12-04'),
  ('ARR-0006', 163, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-05-06', NULL),
  ('ARR-0007', 6, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-05-07', '2027-01-18'),
  ('ARR-0008', 126, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-05-07', '2026-11-08'),
  ('ARR-0009', 323, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-05-09', NULL),
  ('ARR-0010', 357, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-05-10', '2027-01-26'),
  ('ARR-0011', 386, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-05-14', '2027-01-15'),
  ('ARR-0012', 19, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-05-15', '2027-01-13'),
  ('ARR-0013', 100, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-05-15', NULL),
  ('ARR-0014', 75, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-05-17', '2026-11-04'),
  ('ARR-0015', 210, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-05-17', NULL),
  ('ARR-0016', 315, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-05-18', '2026-11-18'),
  ('ARR-0017', 82, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-05-20', '2027-01-25'),
  ('ARR-0018', 172, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-05-21', '2027-01-25'),
  ('ARR-0019', 76, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-05-22', '2026-12-20'),
  ('ARR-0020', 358, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-05-22', '2026-12-31'),
  ('ARR-0021', 268, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-05-26', NULL),
  ('ARR-0022', 145, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-05-28', '2026-11-04'),
  ('ARR-0023', 296, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-05-30', '2026-12-18'),
  ('ARR-0024', 216, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-05-31', '2026-12-01'),
  ('ARR-0025', 49, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-06-02', '2026-12-19'),
  ('ARR-0026', 106, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-06-02', '2027-01-24'),
  ('ARR-0027', 288, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-06-04', '2026-12-24'),
  ('ARR-0028', 175, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-06-06', NULL),
  ('ARR-0029', 221, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-06-06', NULL),
  ('ARR-0030', 348, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-06-08', '2027-01-15'),
  ('ARR-0031', 206, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-06-10', '2026-12-14'),
  ('ARR-0032', 291, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-06-10', '2026-11-05'),
  ('ARR-0033', 356, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-06-11', '2026-11-13'),
  ('ARR-0034', 95, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-06-12', '2026-11-23'),
  ('ARR-0035', 283, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-06-12', '2026-11-25'),
  ('ARR-0036', 266, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-06-13', NULL),
  ('ARR-0037', 295, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-06-13', NULL),
  ('ARR-0038', 311, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-06-13', '2026-11-13'),
  ('ARR-0039', 305, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-06-17', '2026-12-11'),
  ('ARR-0040', 314, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-06-17', '2026-11-12'),
  ('ARR-0041', 225, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-06-20', '2026-11-29'),
  ('ARR-0042', 341, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-06-21', '2026-12-29'),
  ('ARR-0043', 308, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-06-24', '2026-12-14'),
  ('ARR-0044', 112, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-06-25', '2026-12-27'),
  ('ARR-0045', 227, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-06-25', '2026-12-02'),
  ('ARR-0046', 345, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-06-25', '2026-12-28'),
  ('ARR-0047', 382, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-06-26', NULL),
  ('ARR-0048', 122, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-06-27', '2026-11-19'),
  ('ARR-0049', 362, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-06-27', '2026-11-19'),
  ('ARR-0050', 383, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-06-27', '2027-01-10'),
  ('ARR-0051', 62, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-06-28', NULL),
  ('ARR-0052', 135, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-06-28', '2026-12-26'),
  ('ARR-0053', 275, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-06-29', '2026-12-27'),
  ('ARR-0054', 185, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-01', '2026-11-02'),
  ('ARR-0055', 242, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-01', '2026-11-03'),
  ('ARR-0056', 293, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-07-01', '2026-11-18'),
  ('ARR-0057', 349, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-07-01', '2026-11-08'),
  ('ARR-0058', 373, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-07-03', '2027-01-19'),
  ('ARR-0059', 133, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-04', '2026-12-15'),
  ('ARR-0060', 80, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-07-05', '2027-01-07'),
  ('ARR-0061', 148, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-06', '2027-01-27'),
  ('ARR-0062', 320, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-06', '2026-11-11'),
  ('ARR-0063', 350, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-07-06', '2026-12-31'),
  ('ARR-0064', 215, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-07-07', '2026-11-28'),
  ('ARR-0065', 83, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-08', '2027-01-27'),
  ('ARR-0066', 298, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-08', '2026-12-19'),
  ('ARR-0067', 322, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-07-08', '2027-01-01'),
  ('ARR-0068', 325, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-07-09', '2026-12-26'),
  ('ARR-0069', 369, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-09', '2026-11-15'),
  ('ARR-0070', 96, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-07-10', '2026-12-07'),
  ('ARR-0071', 152, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-07-12', '2026-12-02'),
  ('ARR-0072', 301, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-07-12', '2027-01-19'),
  ('ARR-0073', 309, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-12', '2026-11-18'),
  ('ARR-0074', 51, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-13', '2027-01-15'),
  ('ARR-0075', 290, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-13', '2026-11-07'),
  ('ARR-0076', 390, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-13', '2027-01-05'),
  ('ARR-0077', 138, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-07-14', NULL),
  ('ARR-0078', 119, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-16', NULL),
  ('ARR-0079', 244, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-07-16', '2026-12-12'),
  ('ARR-0080', 365, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-07-18', '2026-12-30'),
  ('ARR-0081', 167, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-19', '2026-12-10'),
  ('ARR-0082', 186, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-07-19', NULL),
  ('ARR-0083', 317, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-19', '2026-11-28'),
  ('ARR-0084', 278, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-07-20', '2026-11-13'),
  ('ARR-0085', 108, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-21', '2026-12-05'),
  ('ARR-0086', 165, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-21', '2026-11-25'),
  ('ARR-0087', 16, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-07-22', '2026-11-13'),
  ('ARR-0088', 232, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-22', '2026-11-20'),
  ('ARR-0089', 66, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-23', '2026-12-04'),
  ('ARR-0090', 342, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-23', '2026-12-12'),
  ('ARR-0091', 224, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-07-24', '2027-01-02'),
  ('ARR-0092', 60, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-25', '2026-12-02'),
  ('ARR-0093', 326, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-25', '2026-12-02'),
  ('ARR-0094', 77, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-07-26', '2027-01-26'),
  ('ARR-0095', 116, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-07-26', '2026-12-30'),
  ('ARR-0096', 24, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-27', '2026-12-04'),
  ('ARR-0097', 103, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-07-29', NULL),
  ('ARR-0098', 329, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-29', NULL),
  ('ARR-0099', 334, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-29', '2026-11-09'),
  ('ARR-0100', 150, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-07-30', NULL),
  ('ARR-0101', 181, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-07-31', '2026-12-15'),
  ('ARR-0102', 222, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-08-01', '2027-01-20'),
  ('ARR-0103', 243, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-08-01', '2027-01-04'),
  ('ARR-0104', 248, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-08-02', '2027-01-20'),
  ('ARR-0105', 321, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-08-02', '2027-01-22'),
  ('ARR-0106', 3, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-08-04', '2027-01-30'),
  ('ARR-0107', 159, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-08-04', '2027-01-25'),
  ('ARR-0108', 306, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-08-04', '2026-11-15'),
  ('ARR-0109', 31, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-08-05', '2026-12-20'),
  ('ARR-0110', 193, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-08-05', '2026-11-24'),
  ('ARR-0111', 70, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-08-07', NULL),
  ('ARR-0112', 78, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-08-08', NULL),
  ('ARR-0113', 179, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-08-11', '2027-01-14'),
  ('ARR-0114', 260, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-08-13', NULL),
  ('ARR-0115', 81, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-08-17', '2027-02-04'),
  ('ARR-0116', 304, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-08-17', NULL),
  ('ARR-0117', 316, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-08-17', '2027-01-03'),
  ('ARR-0118', 195, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-08-18', '2027-03-04'),
  ('ARR-0119', 265, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-08-19', NULL),
  ('ARR-0120', 57, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-08-22', NULL),
  ('ARR-0121', 281, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-08-22', NULL),
  ('ARR-0122', 328, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-08-23', '2026-12-14'),
  ('ARR-0123', 7, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-08-24', '2027-03-06'),
  ('ARR-0124', 44, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-08-24', NULL),
  ('ARR-0125', 170, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-08-24', '2026-11-03'),
  ('ARR-0126', 207, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-08-25', '2026-12-03'),
  ('ARR-0127', 27, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-08-26', '2026-11-23'),
  ('ARR-0128', 47, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-08-26', NULL),
  ('ARR-0129', 1, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-09-01', '2026-12-31'),
  ('ARR-0130', 87, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-09-02', '2026-12-14'),
  ('ARR-0131', 69, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-09-03', '2026-12-20'),
  ('ARR-0132', 287, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-09-03', '2027-03-16'),
  ('ARR-0133', 39, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-09-05', NULL),
  ('ARR-0134', 43, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-09-05', '2027-02-22'),
  ('ARR-0135', 294, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-09-05', NULL),
  ('ARR-0136', 262, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-09-08', NULL),
  ('ARR-0137', 192, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-09-09', '2026-12-24'),
  ('ARR-0138', 270, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-09-09', '2026-11-08'),
  ('ARR-0139', 136, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-09-11', '2026-11-30'),
  ('ARR-0140', 54, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-09-12', '2026-11-06'),
  ('ARR-0141', 73, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-09-13', '2027-03-10'),
  ('ARR-0142', 346, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-09-16', NULL),
  ('ARR-0143', 371, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-09-16', NULL),
  ('ARR-0144', 118, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-09-17', '2026-11-16'),
  ('ARR-0145', 50, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-09-19', '2027-01-06'),
  ('ARR-0146', 223, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-09-22', '2027-02-14'),
  ('ARR-0147', 105, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-09-26', '2026-12-12'),
  ('ARR-0148', 264, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-09-27', '2027-01-23'),
  ('ARR-0149', 285, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-09-27', '2027-03-25'),
  ('ARR-0150', 107, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-09-30', NULL),
  ('ARR-0151', 123, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-10-02', '2026-12-18'),
  ('ARR-0152', 184, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-10-02', '2026-12-14'),
  ('ARR-0153', 360, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-10-03', '2026-12-03'),
  ('ARR-0154', 174, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-10-04', '2027-02-15'),
  ('ARR-0155', 343, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-10-06', NULL),
  ('ARR-0156', 354, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-10-06', '2026-11-19'),
  ('ARR-0157', 65, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-10-07', '2027-04-06'),
  ('ARR-0158', 166, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-10-07', '2027-01-25'),
  ('ARR-0159', 117, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-10-08', '2026-12-12'),
  ('ARR-0160', 151, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-10-10', '2027-02-03'),
  ('ARR-0161', 21, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-10-11', NULL),
  ('ARR-0162', 180, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-10-11', '2027-01-28'),
  ('ARR-0163', 33, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-10-12', '2027-04-24'),
  ('ARR-0164', 236, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-10-12', NULL),
  ('ARR-0165', 395, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-10-13', '2026-12-24'),
  ('ARR-0166', 52, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-10-14', '2027-03-30'),
  ('ARR-0167', 256, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-10-14', '2027-03-31'),
  ('ARR-0168', 380, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-10-16', '2027-04-29'),
  ('ARR-0169', 147, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-10-18', '2027-04-18'),
  ('ARR-0170', 231, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-10-18', '2027-03-02'),
  ('ARR-0171', 92, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-10-20', '2027-04-18'),
  ('ARR-0172', 381, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-10-20', '2027-01-10'),
  ('ARR-0173', 218, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-10-21', '2027-03-05'),
  ('ARR-0174', 297, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-10-21', NULL),
  ('ARR-0175', 330, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-10-21', '2027-04-30'),
  ('ARR-0176', 45, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-10-22', '2027-04-28'),
  ('ARR-0177', 250, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-10-23', '2026-12-10'),
  ('ARR-0178', 198, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-10-24', '2026-12-21'),
  ('ARR-0179', 9, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-10-25', NULL),
  ('ARR-0180', 255, (SELECT id_cliente FROM cliente WHERE razon_social = 'Áridos del Norte Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Faena Pozo Almonte'), '2026-10-25', '2027-04-29'),
  ('ARR-0181', 162, (SELECT id_cliente FROM cliente WHERE razon_social = 'Constructora Altiplano Ltda'), (SELECT id_faena FROM faena WHERE nombre = 'Alto Hospicio'), '2026-10-27', '2026-12-04'),
  ('ARR-0182', 188, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-10-28', '2027-02-21'),
  ('ARR-0183', 257, (SELECT id_cliente FROM cliente WHERE razon_social = 'Servicios Portuarios Iquique SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Puerto de Iquique'), '2026-10-28', '2027-03-19'),
  ('ARR-0184', 149, (SELECT id_cliente FROM cliente WHERE razon_social = 'Logística Tarapacá SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Zofri, Iquique'), '2026-10-29', '2027-03-27'),
  ('ARR-0185', 240, (SELECT id_cliente FROM cliente WHERE razon_social = 'Minera Cerro Dragón SpA'), (SELECT id_faena FROM faena WHERE nombre = 'Faena minera Cerro Colorado'), '2026-10-29', '2027-03-15');

-- Última señal GPS de cada equipo (los marcados "sin señal" reportaron por última vez hace 31 horas)
INSERT INTO telemetria_equipo (id_equipo, ts, horometro, latitud, longitud, velocidad_kmh) VALUES
  (1, NOW() - INTERVAL 1 MINUTE, 3620.0, -20.205200, -70.150800, 0),
  (2, NOW() - INTERVAL 1 MINUTE, 2259.2, -20.243875, -70.136899, 0),
  (3, NOW() - INTERVAL 1 MINUTE, 963.5, -20.199161, -70.156655, 0),
  (4, NOW() - INTERVAL 1 MINUTE, 7381.2, -20.245319, -70.140806, 0),
  (5, NOW() - INTERVAL 1 MINUTE, 8072.7, -20.244866, -70.139711, 0),
  (6, NOW() - INTERVAL 1 MINUTE, 5208.4, -20.219913, -70.138247, 0),
  (7, NOW() - INTERVAL 1 MINUTE, 4961.1, -20.257425, -69.791874, 0),
  (8, NOW() - INTERVAL 1 MINUTE, 7655.7, -20.245427, -70.140204, 0),
  (9, NOW() - INTERVAL 1 MINUTE, 4215.8, -20.256774, -69.791186, 0),
  (10, NOW() - INTERVAL 1 MINUTE, 2627.5, -20.244895, -70.139166, 0),
  (11, NOW() - INTERVAL 1 MINUTE, 3951.7, -20.244837, -70.137043, 0),
  (12, NOW() - INTERVAL 1 MINUTE, 5462.0, -20.243529, -70.137037, 0),
  (13, NOW() - INTERVAL 1 MINUTE, 1113.5, -20.246964, -70.137185, 0),
  (14, NOW() - INTERVAL 1 MINUTE, 4205.0, -20.246355, -70.139795, 0),
  (15, NOW() - INTERVAL 31 HOUR, 2837.6, -20.246194, -70.139085, 0),
  (16, NOW() - INTERVAL 1 MINUTE, 6017.8, -20.264577, -70.093189, 0),
  (17, NOW() - INTERVAL 1 MINUTE, 4473.0, -20.242940, -70.138473, 0),
  (18, NOW() - INTERVAL 1 MINUTE, 4379.4, -20.245480, -70.139062, 0),
  (19, NOW() - INTERVAL 1 MINUTE, 1122.1, -20.262408, -69.784510, 0),
  (20, NOW() - INTERVAL 1 MINUTE, 7045.5, -20.245228, -70.140856, 0),
  (21, NOW() - INTERVAL 1 MINUTE, 6650.4, -20.272668, -70.091088, 0),
  (22, NOW() - INTERVAL 1 MINUTE, 686.5, -20.243111, -70.140865, 0),
  (23, NOW() - INTERVAL 1 MINUTE, 3380.8, -20.212918, -70.131458, 0),
  (24, NOW() - INTERVAL 1 MINUTE, 8550.2, -20.198632, -70.157959, 0),
  (25, NOW() - INTERVAL 1 MINUTE, 5329.1, -20.242814, -70.141297, 0),
  (26, NOW() - INTERVAL 1 MINUTE, 1105.3, -20.244466, -70.138530, 0),
  (27, NOW() - INTERVAL 1 MINUTE, 2247.9, -20.042360, -69.257553, 0),
  (28, NOW() - INTERVAL 1 MINUTE, 1592.8, -20.245402, -70.137565, 0),
  (29, NOW() - INTERVAL 1 MINUTE, 4227.5, -20.242949, -70.139019, 0),
  (30, NOW() - INTERVAL 1 MINUTE, 5423.9, -20.245960, -70.138050, 0),
  (31, NOW() - INTERVAL 1 MINUTE, 711.3, -20.040354, -69.260313, 0),
  (32, NOW() - INTERVAL 1 MINUTE, 5252.1, -20.242759, -70.138763, 0),
  (33, NOW() - INTERVAL 1 MINUTE, 2045.0, -20.224915, -70.142666, 0),
  (34, NOW() - INTERVAL 1 MINUTE, 873.7, -20.246914, -70.140912, 0),
  (35, NOW() - INTERVAL 1 MINUTE, 2226.8, -20.246141, -70.137653, 0),
  (36, NOW() - INTERVAL 1 MINUTE, 8520.7, -20.245280, -70.138618, 0),
  (37, NOW() - INTERVAL 1 MINUTE, 6558.2, -20.242698, -70.140338, 0),
  (38, NOW() - INTERVAL 1 MINUTE, 4748.3, -20.243514, -70.140407, 0),
  (39, NOW() - INTERVAL 1 MINUTE, 2805.6, -20.225835, -70.132122, 0),
  (40, NOW() - INTERVAL 1 MINUTE, 6449.4, -20.242630, -70.137129, 0),
  (41, NOW() - INTERVAL 1 MINUTE, 2325.0, -20.246049, -70.138365, 0),
  (42, NOW() - INTERVAL 1 MINUTE, 4401.0, -20.254927, -69.784910, 0),
  (43, NOW() - INTERVAL 1 MINUTE, 1650.8, -20.215923, -70.140182, 0),
  (44, NOW() - INTERVAL 1 MINUTE, 2393.5, -20.205860, -70.157185, 0),
  (45, NOW() - INTERVAL 1 MINUTE, 2004.3, -20.201098, -70.150275, 0),
  (46, NOW() - INTERVAL 1 MINUTE, 7658.7, -20.244593, -70.140028, 0),
  (47, NOW() - INTERVAL 1 MINUTE, 2738.5, -20.258584, -69.790915, 0),
  (48, NOW() - INTERVAL 1 MINUTE, 5148.3, -20.243090, -70.140933, 0),
  (49, NOW() - INTERVAL 1 MINUTE, 2270.5, -20.263709, -70.100842, 0),
  (50, NOW() - INTERVAL 1 MINUTE, 6002.0, -20.253006, -69.793696, 0),
  (51, NOW() - INTERVAL 1 MINUTE, 2723.9, -20.207159, -70.158113, 0),
  (52, NOW() - INTERVAL 1 MINUTE, 2705.3, -20.049708, -69.254609, 0),
  (53, NOW() - INTERVAL 1 MINUTE, 4648.0, -20.243068, -70.140354, 0),
  (54, NOW() - INTERVAL 1 MINUTE, 9065.9, -20.262810, -69.787626, 0),
  (55, NOW() - INTERVAL 1 MINUTE, 7423.2, -20.245984, -70.139488, 0),
  (56, NOW() - INTERVAL 1 MINUTE, 7412.1, -20.245645, -70.141562, 0),
  (57, NOW() - INTERVAL 1 MINUTE, 4680.2, -20.261625, -69.784317, 0),
  (58, NOW() - INTERVAL 1 MINUTE, 7861.4, -20.244822, -70.139337, 0),
  (59, NOW() - INTERVAL 1 MINUTE, 6029.0, -20.242575, -70.140727, 0),
  (60, NOW() - INTERVAL 1 MINUTE, 2189.9, -20.200673, -70.156246, 0),
  (61, NOW() - INTERVAL 1 MINUTE, 1917.2, -20.245001, -70.140452, 0),
  (62, NOW() - INTERVAL 1 MINUTE, 5829.1, -20.040338, -69.258715, 0),
  (63, NOW() - INTERVAL 1 MINUTE, 1280.8, -20.243133, -70.138117, 0),
  (64, NOW() - INTERVAL 1 MINUTE, 7353.2, -20.243554, -70.141782, 0),
  (65, NOW() - INTERVAL 1 MINUTE, 5080.5, -20.264940, -70.090880, 0),
  (66, NOW() - INTERVAL 1 MINUTE, 7773.7, -20.040113, -69.257709, 0),
  (67, NOW() - INTERVAL 1 MINUTE, 3267.4, -20.245737, -70.138693, 0),
  (68, NOW() - INTERVAL 1 MINUTE, 5737.4, -20.244911, -70.140768, 0),
  (69, NOW() - INTERVAL 1 MINUTE, 5324.5, -20.256602, -69.791793, 0),
  (70, NOW() - INTERVAL 1 MINUTE, 3112.0, -20.205900, -70.151602, 0),
  (71, NOW() - INTERVAL 1 MINUTE, 1947.5, -20.245956, -70.138083, 0),
  (72, NOW() - INTERVAL 1 MINUTE, 5178.7, -20.244311, -70.139292, 0),
  (73, NOW() - INTERVAL 1 MINUTE, 700.8, -20.217250, -70.139616, 0),
  (74, NOW() - INTERVAL 1 MINUTE, 277.3, -20.245265, -70.137863, 0),
  (75, NOW() - INTERVAL 1 MINUTE, 6737.2, -20.264900, -70.092011, 0),
  (76, NOW() - INTERVAL 1 MINUTE, 7622.0, -20.220436, -70.142142, 0),
  (77, NOW() - INTERVAL 1 MINUTE, 1468.2, -20.265434, -70.095399, 0),
  (78, NOW() - INTERVAL 1 MINUTE, 4578.7, -20.276280, -70.092466, 0),
  (79, NOW() - INTERVAL 1 MINUTE, 3292.4, -20.245969, -70.137801, 0),
  (80, NOW() - INTERVAL 1 MINUTE, 5823.9, -20.266177, -70.092208, 0),
  (81, NOW() - INTERVAL 1 MINUTE, 8363.0, -20.202364, -70.148038, 0),
  (82, NOW() - INTERVAL 1 MINUTE, 9440.2, -20.042648, -69.255464, 0),
  (83, NOW() - INTERVAL 1 MINUTE, 383.9, -20.204009, -70.153378, 0),
  (84, NOW() - INTERVAL 1 MINUTE, 1728.0, -20.245766, -70.139902, 0),
  (85, NOW() - INTERVAL 1 MINUTE, 8576.5, -20.245477, -70.136835, 0),
  (86, NOW() - INTERVAL 1 MINUTE, 1262.1, -20.245711, -70.136848, 0),
  (87, NOW() - INTERVAL 1 MINUTE, 4790.2, -20.209395, -70.148483, 0),
  (88, NOW() - INTERVAL 1 MINUTE, 2312.7, -20.245364, -70.141213, 0),
  (89, NOW() - INTERVAL 1 MINUTE, 317.7, -20.247283, -70.139236, 0),
  (90, NOW() - INTERVAL 31 HOUR, 3049.2, -20.247230, -70.141404, 0),
  (91, NOW() - INTERVAL 1 MINUTE, 3358.3, -20.242302, -70.141006, 0),
  (92, NOW() - INTERVAL 1 MINUTE, 8582.8, -20.262266, -69.785607, 0),
  (93, NOW() - INTERVAL 1 MINUTE, 2547.9, -20.246693, -70.140010, 0),
  (94, NOW() - INTERVAL 1 MINUTE, 5726.8, -20.245403, -70.139226, 0),
  (95, NOW() - INTERVAL 1 MINUTE, 2458.0, -20.204928, -70.143654, 0),
  (96, NOW() - INTERVAL 1 MINUTE, 3849.4, -20.256211, -69.791353, 0),
  (97, NOW() - INTERVAL 1 MINUTE, 2345.0, -20.245914, -70.138564, 0),
  (98, NOW() - INTERVAL 1 MINUTE, 4336.7, -20.246756, -70.140756, 0),
  (99, NOW() - INTERVAL 1 MINUTE, 1687.3, -20.244136, -70.141607, 0),
  (100, NOW() - INTERVAL 1 MINUTE, 5014.8, -20.201515, -70.147368, 0),
  (101, NOW() - INTERVAL 1 MINUTE, 8284.0, -20.246964, -70.138347, 0),
  (102, NOW() - INTERVAL 1 MINUTE, 2793.9, -20.246237, -70.140218, 0),
  (103, NOW() - INTERVAL 1 MINUTE, 294.8, -20.251352, -69.782500, 0),
  (104, NOW() - INTERVAL 1 MINUTE, 4525.0, -20.243793, -70.139898, 0),
  (105, NOW() - INTERVAL 31 HOUR, 2166.5, -20.276558, -70.106038, 0),
  (106, NOW() - INTERVAL 1 MINUTE, 1377.4, -20.044769, -69.264842, 0),
  (107, NOW() - INTERVAL 1 MINUTE, 4377.7, -20.037362, -69.258261, 0),
  (108, NOW() - INTERVAL 1 MINUTE, 1665.2, -20.038025, -69.264514, 0),
  (109, NOW() - INTERVAL 1 MINUTE, 7073.8, -20.245230, -70.139098, 0),
  (110, NOW() - INTERVAL 1 MINUTE, 216.8, -20.243409, -70.137078, 0),
  (111, NOW() - INTERVAL 1 MINUTE, 5693.8, -20.242697, -70.140047, 0),
  (112, NOW() - INTERVAL 1 MINUTE, 5511.9, -20.209692, -70.157211, 0),
  (113, NOW() - INTERVAL 1 MINUTE, 1053.1, -20.244773, -70.140204, 0),
  (114, NOW() - INTERVAL 1 MINUTE, 8113.3, -20.245617, -70.136958, 0),
  (115, NOW() - INTERVAL 1 MINUTE, 423.2, -20.243780, -70.137904, 0),
  (116, NOW() - INTERVAL 1 MINUTE, 1081.6, -20.219297, -70.135355, 0),
  (117, NOW() - INTERVAL 1 MINUTE, 6737.6, -20.260089, -69.781972, 0),
  (118, NOW() - INTERVAL 1 MINUTE, 230022, -20.268934, -70.105065, 0),
  (119, NOW() - INTERVAL 1 MINUTE, 235586, -20.039476, -69.262598, 0),
  (120, NOW() - INTERVAL 31 HOUR, 122148, -20.244805, -70.139499, 0),
  (121, NOW() - INTERVAL 1 MINUTE, 39918, -20.243521, -70.138747, 0),
  (122, NOW() - INTERVAL 1 MINUTE, 15360, -20.038793, -69.256755, 0),
  (123, NOW() - INTERVAL 1 MINUTE, 90363, -20.049748, -69.264259, 70),
  (124, NOW() - INTERVAL 1 MINUTE, 153729, -20.246742, -70.139410, 0),
  (125, NOW() - INTERVAL 1 MINUTE, 226926, -20.247151, -70.140039, 0),
  (126, NOW() - INTERVAL 1 MINUTE, 35105, -20.263155, -70.091020, 0),
  (127, NOW() - INTERVAL 1 MINUTE, 189683, -20.244718, -70.141582, 0),
  (128, NOW() - INTERVAL 1 MINUTE, 141946, -20.246597, -70.137353, 0),
  (129, NOW() - INTERVAL 1 MINUTE, 243658, -20.243773, -70.137471, 0),
  (130, NOW() - INTERVAL 1 MINUTE, 82635, -20.242640, -70.138167, 0),
  (131, NOW() - INTERVAL 1 MINUTE, 124594, -20.244578, -70.141759, 0),
  (132, NOW() - INTERVAL 1 MINUTE, 84532, -20.243361, -70.139664, 0),
  (133, NOW() - INTERVAL 1 MINUTE, 208147, -20.211997, -70.149065, 70),
  (134, NOW() - INTERVAL 1 MINUTE, 255926, -20.244879, -70.138104, 0),
  (135, NOW() - INTERVAL 1 MINUTE, 69998, -20.262475, -69.784499, 0),
  (136, NOW() - INTERVAL 1 MINUTE, 181430, -20.202506, -70.153024, 0),
  (137, NOW() - INTERVAL 1 MINUTE, 126674, -20.261028, -69.790013, 70),
  (138, NOW() - INTERVAL 1 MINUTE, 258607, -20.256582, -69.787330, 0),
  (139, NOW() - INTERVAL 1 MINUTE, 173004, -20.246112, -70.138461, 0),
  (140, NOW() - INTERVAL 31 HOUR, 136097, -20.244999, -70.141067, 0),
  (141, NOW() - INTERVAL 1 MINUTE, 20052, -20.242902, -70.140145, 0),
  (142, NOW() - INTERVAL 1 MINUTE, 161573, -20.244546, -70.141244, 0),
  (143, NOW() - INTERVAL 1 MINUTE, 168540, -20.245330, -70.137645, 0),
  (144, NOW() - INTERVAL 31 HOUR, 259752, -20.243395, -70.139427, 0),
  (145, NOW() - INTERVAL 1 MINUTE, 165572, -20.203109, -70.144359, 0),
  (146, NOW() - INTERVAL 1 MINUTE, 166363, -20.245046, -70.139782, 0),
  (147, NOW() - INTERVAL 1 MINUTE, 219912, -20.223921, -70.143815, 0),
  (148, NOW() - INTERVAL 1 MINUTE, 78228, -20.201711, -70.148767, 0),
  (149, NOW() - INTERVAL 1 MINUTE, 67174, -20.226841, -70.134634, 0),
  (150, NOW() - INTERVAL 1 MINUTE, 199858, -20.199795, -70.149978, 70),
  (151, NOW() - INTERVAL 1 MINUTE, 136511, -20.207666, -70.151315, 0),
  (152, NOW() - INTERVAL 1 MINUTE, 98246, -20.225856, -70.135763, 0),
  (153, NOW() - INTERVAL 1 MINUTE, 252026, -20.246666, -70.140223, 0),
  (154, NOW() - INTERVAL 1 MINUTE, 142785, -20.247029, -70.139067, 0),
  (155, NOW() - INTERVAL 1 MINUTE, 249861, -20.244334, -70.139566, 0),
  (156, NOW() - INTERVAL 1 MINUTE, 184964, -20.245840, -70.140380, 0),
  (157, NOW() - INTERVAL 1 MINUTE, 143786, -20.244321, -70.141362, 0),
  (158, NOW() - INTERVAL 1 MINUTE, 247040, -20.244152, -70.139487, 0),
  (159, NOW() - INTERVAL 1 MINUTE, 5600, -20.267359, -70.106251, 0),
  (160, NOW() - INTERVAL 31 HOUR, 29179, -20.247286, -70.140893, 0),
  (161, NOW() - INTERVAL 1 MINUTE, 31656, -20.242975, -70.138255, 0),
  (162, NOW() - INTERVAL 1 MINUTE, 92103, -20.267911, -70.101979, 0),
  (163, NOW() - INTERVAL 31 HOUR, 9427.3, -20.223513, -70.134119, 0),
  (164, NOW() - INTERVAL 1 MINUTE, 4189.3, -20.243008, -70.139286, 0),
  (165, NOW() - INTERVAL 1 MINUTE, 5668.7, -20.212617, -70.144023, 0),
  (166, NOW() - INTERVAL 1 MINUTE, 5028.5, -20.052495, -69.265722, 0),
  (167, NOW() - INTERVAL 1 MINUTE, 7142.2, -20.203788, -70.158197, 0),
  (168, NOW() - INTERVAL 1 MINUTE, 5995.3, -20.242961, -70.141151, 0),
  (169, NOW() - INTERVAL 1 MINUTE, 2397.4, -20.243335, -70.140492, 0),
  (170, NOW() - INTERVAL 1 MINUTE, 1662.3, -20.042933, -69.265388, 0),
  (171, NOW() - INTERVAL 1 MINUTE, 3478.4, -20.246004, -70.137974, 0),
  (172, NOW() - INTERVAL 1 MINUTE, 4236.9, -20.218367, -70.144439, 0),
  (173, NOW() - INTERVAL 31 HOUR, 2445.8, -20.246224, -70.138083, 0),
  (174, NOW() - INTERVAL 1 MINUTE, 1738.9, -20.050762, -69.268068, 0),
  (175, NOW() - INTERVAL 1 MINUTE, 5107.6, -20.213350, -70.137015, 0),
  (176, NOW() - INTERVAL 1 MINUTE, 5741.1, -20.244285, -70.137563, 0),
  (177, NOW() - INTERVAL 1 MINUTE, 8915.7, -20.246001, -70.140467, 0),
  (178, NOW() - INTERVAL 1 MINUTE, 4808.0, -20.245264, -70.137096, 0),
  (179, NOW() - INTERVAL 1 MINUTE, 4988.4, -20.218881, -70.141171, 0),
  (180, NOW() - INTERVAL 1 MINUTE, 3549.5, -20.215186, -70.137209, 0),
  (181, NOW() - INTERVAL 1 MINUTE, 6900.7, -20.052694, -69.261395, 0),
  (182, NOW() - INTERVAL 1 MINUTE, 8132.5, -20.242613, -70.137303, 0),
  (183, NOW() - INTERVAL 1 MINUTE, 5084.1, -20.244721, -70.136844, 0),
  (184, NOW() - INTERVAL 1 MINUTE, 5882.7, -20.040124, -69.255838, 0),
  (185, NOW() - INTERVAL 1 MINUTE, 9299.4, -20.201456, -70.150395, 0),
  (186, NOW() - INTERVAL 1 MINUTE, 2251.4, -20.267896, -70.101133, 0),
  (187, NOW() - INTERVAL 1 MINUTE, 150.0, -20.246136, -70.140614, 0),
  (188, NOW() - INTERVAL 1 MINUTE, 7143.9, -20.211860, -70.147744, 0),
  (189, NOW() - INTERVAL 1 MINUTE, 1412.2, -20.243396, -70.139507, 0),
  (190, NOW() - INTERVAL 1 MINUTE, 6062.6, -20.242324, -70.139824, 0),
  (191, NOW() - INTERVAL 1 MINUTE, 7398.9, -20.242748, -70.140518, 0),
  (192, NOW() - INTERVAL 1 MINUTE, 4463.3, -20.200185, -70.154982, 0),
  (193, NOW() - INTERVAL 1 MINUTE, 5030.2, -20.201453, -70.146590, 0),
  (194, NOW() - INTERVAL 1 MINUTE, 7333.3, -20.244131, -70.141256, 0),
  (195, NOW() - INTERVAL 1 MINUTE, 2700.5, -20.221811, -70.132321, 0),
  (196, NOW() - INTERVAL 1 MINUTE, 6023.5, -20.242933, -70.139205, 0),
  (197, NOW() - INTERVAL 1 MINUTE, 5936.8, -20.242596, -70.139192, 0),
  (198, NOW() - INTERVAL 1 MINUTE, 7621.7, -20.052707, -69.260754, 0),
  (199, NOW() - INTERVAL 1 MINUTE, 5786.6, -20.246045, -70.138646, 0),
  (200, NOW() - INTERVAL 1 MINUTE, 9370.5, -20.244890, -70.140287, 0),
  (201, NOW() - INTERVAL 1 MINUTE, 2623.3, -20.244440, -70.137773, 0),
  (202, NOW() - INTERVAL 1 MINUTE, 2589.3, -20.247222, -70.137027, 0),
  (203, NOW() - INTERVAL 1 MINUTE, 7038.8, -20.242859, -70.138756, 0),
  (204, NOW() - INTERVAL 1 MINUTE, 1322.7, -20.244224, -70.141755, 0),
  (205, NOW() - INTERVAL 1 MINUTE, 2900.3, -20.244196, -70.140411, 0),
  (206, NOW() - INTERVAL 1 MINUTE, 807.8, -20.226098, -70.138457, 0),
  (207, NOW() - INTERVAL 1 MINUTE, 4235.3, -20.268577, -70.095032, 0),
  (208, NOW() - INTERVAL 1 MINUTE, 2243.3, -20.242455, -70.139101, 0),
  (209, NOW() - INTERVAL 1 MINUTE, 5369.4, -20.245675, -70.137481, 0),
  (210, NOW() - INTERVAL 1 MINUTE, 2863.0, -20.263239, -70.092384, 0),
  (211, NOW() - INTERVAL 1 MINUTE, 8837.9, -20.245159, -70.141642, 0),
  (212, NOW() - INTERVAL 1 MINUTE, 8059.0, -20.245734, -70.140508, 0),
  (213, NOW() - INTERVAL 1 MINUTE, 6591.7, -20.245529, -70.140754, 0),
  (214, NOW() - INTERVAL 1 MINUTE, 5757.0, -20.246881, -70.139934, 0),
  (215, NOW() - INTERVAL 1 MINUTE, 5459.0, -20.268230, -70.099611, 0),
  (216, NOW() - INTERVAL 1 MINUTE, 1287.3, -20.037199, -69.262943, 0),
  (217, NOW() - INTERVAL 1 MINUTE, 853.2, -20.242890, -70.139546, 0),
  (218, NOW() - INTERVAL 1 MINUTE, 8859.0, -20.203335, -70.153494, 0),
  (219, NOW() - INTERVAL 1 MINUTE, 8211.5, -20.243145, -70.139677, 0),
  (220, NOW() - INTERVAL 1 MINUTE, 6947.1, -20.244059, -70.141113, 0),
  (221, NOW() - INTERVAL 1 MINUTE, 1400.1, -20.266484, -70.106571, 0),
  (222, NOW() - INTERVAL 1 MINUTE, 4131.9, -20.047317, -69.254475, 0),
  (223, NOW() - INTERVAL 1 MINUTE, 2057.5, -20.257376, -69.779435, 0),
  (224, NOW() - INTERVAL 1 MINUTE, 8745.5, -20.262908, -70.096766, 0),
  (225, NOW() - INTERVAL 1 MINUTE, 8453.5, -20.220072, -70.139398, 0),
  (226, NOW() - INTERVAL 1 MINUTE, 1241.3, -20.246726, -70.140224, 0),
  (227, NOW() - INTERVAL 1 MINUTE, 4414.5, -20.203849, -70.145456, 0),
  (228, NOW() - INTERVAL 1 MINUTE, 944.5, -20.243472, -70.140855, 0),
  (229, NOW() - INTERVAL 1 MINUTE, 6625.7, -20.245129, -70.139159, 0),
  (230, NOW() - INTERVAL 1 MINUTE, 7042.0, -20.244862, -70.139780, 0),
  (231, NOW() - INTERVAL 1 MINUTE, 9261.7, -20.218593, -70.141017, 0),
  (232, NOW() - INTERVAL 1 MINUTE, 8547.4, -20.197732, -70.143654, 0),
  (233, NOW() - INTERVAL 1 MINUTE, 1120.6, -20.243293, -70.140230, 0),
  (234, NOW() - INTERVAL 1 MINUTE, 7237.4, -20.245679, -70.140936, 0),
  (235, NOW() - INTERVAL 1 MINUTE, 7202.3, -20.246657, -70.139548, 0),
  (236, NOW() - INTERVAL 1 MINUTE, 7840.2, -20.221792, -70.131849, 0),
  (237, NOW() - INTERVAL 1 MINUTE, 7784.2, -20.243719, -70.139535, 0),
  (238, NOW() - INTERVAL 1 MINUTE, 8809.6, -20.243533, -70.141519, 0),
  (239, NOW() - INTERVAL 1 MINUTE, 4644.0, -20.244484, -70.141652, 0),
  (240, NOW() - INTERVAL 1 MINUTE, 638.9, -20.046720, -69.254968, 0),
  (241, NOW() - INTERVAL 1 MINUTE, 4808.0, -20.245700, -70.138004, 0),
  (242, NOW() - INTERVAL 1 MINUTE, 246156, -20.209198, -70.151885, 0),
  (243, NOW() - INTERVAL 1 MINUTE, 7766.7, -20.209798, -70.148938, 0),
  (244, NOW() - INTERVAL 1 MINUTE, 198708, -20.258350, -69.779896, 70),
  (245, NOW() - INTERVAL 1 MINUTE, 242231, -20.244975, -70.137633, 0),
  (246, NOW() - INTERVAL 1 MINUTE, 237159, -20.242706, -70.138792, 0),
  (247, NOW() - INTERVAL 1 MINUTE, 22222, -20.245269, -70.140913, 0),
  (248, NOW() - INTERVAL 1 MINUTE, 244326, -20.207881, -70.152262, 0),
  (249, NOW() - INTERVAL 1 MINUTE, 8152.7, -20.245510, -70.137829, 0),
  (250, NOW() - INTERVAL 1 MINUTE, 6852.6, -20.206044, -70.150629, 0),
  (251, NOW() - INTERVAL 1 MINUTE, 3675.8, -20.245246, -70.138078, 0),
  (252, NOW() - INTERVAL 31 HOUR, 14938, -20.244524, -70.140671, 0),
  (253, NOW() - INTERVAL 1 MINUTE, 88278, -20.245981, -70.139555, 0),
  (254, NOW() - INTERVAL 1 MINUTE, 7087.0, -20.245713, -70.140505, 0),
  (255, NOW() - INTERVAL 1 MINUTE, 155681, -20.251069, -69.792575, 0),
  (256, NOW() - INTERVAL 1 MINUTE, 8885.8, -20.269604, -70.094579, 0),
  (257, NOW() - INTERVAL 1 MINUTE, 54049, -20.203789, -70.150901, 0),
  (258, NOW() - INTERVAL 1 MINUTE, 2598.6, -20.247191, -70.139357, 0),
  (259, NOW() - INTERVAL 1 MINUTE, 173600, -20.244078, -70.138391, 0),
  (260, NOW() - INTERVAL 1 MINUTE, 1347.5, -20.212241, -70.154307, 0),
  (261, NOW() - INTERVAL 1 MINUTE, 2637.2, -20.246944, -70.136875, 0),
  (262, NOW() - INTERVAL 1 MINUTE, 6249.7, -20.216294, -70.139245, 0),
  (263, NOW() - INTERVAL 1 MINUTE, 5032.3, -20.245144, -70.137820, 0),
  (264, NOW() - INTERVAL 1 MINUTE, 239760, -20.253380, -69.787447, 0),
  (265, NOW() - INTERVAL 1 MINUTE, 2434.3, -20.197456, -70.156565, 0),
  (266, NOW() - INTERVAL 1 MINUTE, 118262, -20.226559, -70.130379, 0),
  (267, NOW() - INTERVAL 1 MINUTE, 120446, -20.246579, -70.141153, 0),
  (268, NOW() - INTERVAL 1 MINUTE, 38104, -20.267535, -70.102184, 70),
  (269, NOW() - INTERVAL 31 HOUR, 2108.9, -20.246704, -70.140576, 0),
  (270, NOW() - INTERVAL 31 HOUR, 121423, -20.261079, -70.096781, 70),
  (271, NOW() - INTERVAL 1 MINUTE, 6694.5, -20.246365, -70.136811, 0),
  (272, NOW() - INTERVAL 1 MINUTE, 45787, -20.244691, -70.141012, 0),
  (273, NOW() - INTERVAL 1 MINUTE, 33684, -20.244668, -70.141554, 0),
  (274, NOW() - INTERVAL 31 HOUR, 59608, -20.247290, -70.137603, 0),
  (275, NOW() - INTERVAL 1 MINUTE, 116604, -20.264792, -69.787069, 0),
  (276, NOW() - INTERVAL 1 MINUTE, 98518, -20.246127, -70.139103, 0),
  (277, NOW() - INTERVAL 1 MINUTE, 249077, -20.246518, -70.137208, 0),
  (278, NOW() - INTERVAL 31 HOUR, 7417.7, -20.268724, -70.103236, 0),
  (279, NOW() - INTERVAL 1 MINUTE, 6528.3, -20.246974, -70.136890, 0),
  (280, NOW() - INTERVAL 1 MINUTE, 1677.7, -20.244829, -70.139533, 0),
  (281, NOW() - INTERVAL 1 MINUTE, 6991.9, -20.213134, -70.147369, 0),
  (282, NOW() - INTERVAL 1 MINUTE, 2694.9, -20.245613, -70.137347, 0),
  (283, NOW() - INTERVAL 1 MINUTE, 5099.2, -20.041206, -69.258635, 0),
  (284, NOW() - INTERVAL 1 MINUTE, 8253.8, -20.243703, -70.140035, 0),
  (285, NOW() - INTERVAL 1 MINUTE, 2972.1, -20.251059, -69.784993, 0),
  (286, NOW() - INTERVAL 1 MINUTE, 213.1, -20.243720, -70.139448, 0),
  (287, NOW() - INTERVAL 1 MINUTE, 3012.4, -20.225570, -70.135065, 0),
  (288, NOW() - INTERVAL 1 MINUTE, 254.7, -20.197228, -70.157809, 0),
  (289, NOW() - INTERVAL 1 MINUTE, 3712.7, -20.243722, -70.138567, 0),
  (290, NOW() - INTERVAL 1 MINUTE, 8670.7, -20.048924, -69.259555, 0),
  (291, NOW() - INTERVAL 1 MINUTE, 8547.0, -20.203593, -70.151360, 0),
  (292, NOW() - INTERVAL 1 MINUTE, 3916.2, -20.243734, -70.140277, 0),
  (293, NOW() - INTERVAL 1 MINUTE, 1157.3, -20.220151, -70.142219, 0),
  (294, NOW() - INTERVAL 1 MINUTE, 3336.9, -20.217940, -70.133614, 0),
  (295, NOW() - INTERVAL 1 MINUTE, 1164.9, -20.207275, -70.157112, 0),
  (296, NOW() - INTERVAL 1 MINUTE, 9455.8, -20.259713, -69.778469, 0),
  (297, NOW() - INTERVAL 1 MINUTE, 5162.0, -20.225588, -70.134763, 0),
  (298, NOW() - INTERVAL 1 MINUTE, 2694.5, -20.040351, -69.255124, 0),
  (299, NOW() - INTERVAL 1 MINUTE, 6303.9, -20.245102, -70.137924, 0),
  (300, NOW() - INTERVAL 1 MINUTE, 7001.8, -20.245708, -70.136966, 0),
  (301, NOW() - INTERVAL 1 MINUTE, 4112.9, -20.250832, -69.790975, 0),
  (302, NOW() - INTERVAL 1 MINUTE, 6786.6, -20.243184, -70.138085, 0),
  (303, NOW() - INTERVAL 1 MINUTE, 7927.1, -20.245921, -70.138318, 0),
  (304, NOW() - INTERVAL 1 MINUTE, 1998.4, -20.038389, -69.262221, 0),
  (305, NOW() - INTERVAL 1 MINUTE, 5561.7, -20.262317, -69.779378, 0),
  (306, NOW() - INTERVAL 1 MINUTE, 7231.3, -20.268655, -70.091713, 0),
  (307, NOW() - INTERVAL 1 MINUTE, 9316.8, -20.245366, -70.141143, 0),
  (308, NOW() - INTERVAL 1 MINUTE, 9213.5, -20.043896, -69.265437, 0),
  (309, NOW() - INTERVAL 1 MINUTE, 9480.4, -20.205439, -70.150791, 0),
  (310, NOW() - INTERVAL 1 MINUTE, 1163.0, -20.243142, -70.137701, 0),
  (311, NOW() - INTERVAL 1 MINUTE, 6614.0, -20.041413, -69.260176, 0),
  (312, NOW() - INTERVAL 1 MINUTE, 8370.4, -20.245795, -70.137749, 0),
  (313, NOW() - INTERVAL 1 MINUTE, 8785.6, -20.246087, -70.139428, 0),
  (314, NOW() - INTERVAL 1 MINUTE, 6236.1, -20.208440, -70.148807, 0),
  (315, NOW() - INTERVAL 1 MINUTE, 5576.4, -20.037427, -69.267797, 0),
  (316, NOW() - INTERVAL 1 MINUTE, 5065.8, -20.270214, -70.093669, 0),
  (317, NOW() - INTERVAL 1 MINUTE, 3338.7, -20.041910, -69.265876, 0),
  (318, NOW() - INTERVAL 1 MINUTE, 8019.9, -20.244913, -70.139648, 0),
  (319, NOW() - INTERVAL 1 MINUTE, 4352.7, -20.247230, -70.141452, 0),
  (320, NOW() - INTERVAL 1 MINUTE, 2625.1, -20.037541, -69.262441, 0),
  (321, NOW() - INTERVAL 1 MINUTE, 1311.7, -20.043374, -69.264307, 0),
  (322, NOW() - INTERVAL 1 MINUTE, 6330.4, -20.276857, -70.103857, 0),
  (323, NOW() - INTERVAL 1 MINUTE, 4029.4, -20.262818, -69.784591, 0),
  (324, NOW() - INTERVAL 1 MINUTE, 1505.1, -20.246414, -70.141039, 0),
  (325, NOW() - INTERVAL 1 MINUTE, 8395.8, -20.255340, -69.780035, 0),
  (326, NOW() - INTERVAL 1 MINUTE, 6641.3, -20.041712, -69.269217, 0),
  (327, NOW() - INTERVAL 1 MINUTE, 8524.6, -20.244448, -70.139956, 0),
  (328, NOW() - INTERVAL 1 MINUTE, 7605.0, -20.275434, -70.101187, 0),
  (329, NOW() - INTERVAL 1 MINUTE, 6269.8, -20.212181, -70.148238, 0),
  (330, NOW() - INTERVAL 1 MINUTE, 6233.5, -20.041882, -69.266375, 0),
  (331, NOW() - INTERVAL 1 MINUTE, 8623.1, -20.243719, -70.139223, 0),
  (332, NOW() - INTERVAL 1 MINUTE, 1448.8, -20.244474, -70.138819, 0),
  (333, NOW() - INTERVAL 1 MINUTE, 485.7, -20.247190, -70.141149, 0),
  (334, NOW() - INTERVAL 1 MINUTE, 30373, -20.048612, -69.255167, 0),
  (335, NOW() - INTERVAL 1 MINUTE, 182267, -20.243661, -70.141008, 0),
  (336, NOW() - INTERVAL 1 MINUTE, 61763, -20.246489, -70.141650, 0),
  (337, NOW() - INTERVAL 1 MINUTE, 6322.7, -20.243605, -70.138957, 0),
  (338, NOW() - INTERVAL 1 MINUTE, 189194, -20.243455, -70.138875, 0),
  (339, NOW() - INTERVAL 1 MINUTE, 119476, -20.245501, -70.138583, 0),
  (340, NOW() - INTERVAL 31 HOUR, 223240, -20.246652, -70.137220, 0),
  (341, NOW() - INTERVAL 1 MINUTE, 129767, -20.197313, -70.144614, 0),
  (342, NOW() - INTERVAL 1 MINUTE, 49598, -20.208802, -70.144536, 0),
  (343, NOW() - INTERVAL 1 MINUTE, 105737, -20.250931, -69.778626, 0),
  (344, NOW() - INTERVAL 1 MINUTE, 130750, -20.245763, -70.138116, 0),
  (345, NOW() - INTERVAL 1 MINUTE, 127226, -20.219328, -70.142917, 0),
  (346, NOW() - INTERVAL 1 MINUTE, 99685, -20.218862, -70.141001, 0),
  (347, NOW() - INTERVAL 1 MINUTE, 88093, -20.245247, -70.137885, 0),
  (348, NOW() - INTERVAL 1 MINUTE, 106117, -20.046868, -69.265210, 70),
  (349, NOW() - INTERVAL 1 MINUTE, 232708, -20.258210, -69.789726, 0),
  (350, NOW() - INTERVAL 1 MINUTE, 174348, -20.262963, -69.784529, 0),
  (351, NOW() - INTERVAL 1 MINUTE, 229363, -20.245975, -70.139100, 0),
  (352, NOW() - INTERVAL 1 MINUTE, 100315, -20.243510, -70.140375, 0),
  (353, NOW() - INTERVAL 1 MINUTE, 13458, -20.243503, -70.137105, 0),
  (354, NOW() - INTERVAL 1 MINUTE, 210517, -20.271728, -70.094416, 0),
  (355, NOW() - INTERVAL 1 MINUTE, 6939.9, -20.244302, -70.138410, 0),
  (356, NOW() - INTERVAL 1 MINUTE, 8810.3, -20.272622, -70.096924, 0),
  (357, NOW() - INTERVAL 1 MINUTE, 6571.2, -20.218956, -70.135254, 0),
  (358, NOW() - INTERVAL 1 MINUTE, 7641.2, -20.213441, -70.140863, 0),
  (359, NOW() - INTERVAL 1 MINUTE, 5929.5, -20.242357, -70.140189, 0),
  (360, NOW() - INTERVAL 1 MINUTE, 9175.4, -20.265463, -70.106039, 0),
  (361, NOW() - INTERVAL 1 MINUTE, 2709.4, -20.243223, -70.136874, 0),
  (362, NOW() - INTERVAL 1 MINUTE, 64981, -20.268804, -70.090753, 0),
  (363, NOW() - INTERVAL 1 MINUTE, 946.5, -20.246283, -70.137697, 0),
  (364, NOW() - INTERVAL 1 MINUTE, 118693, -20.246147, -70.138510, 0),
  (365, NOW() - INTERVAL 1 MINUTE, 6439.4, -20.216819, -70.132382, 0),
  (366, NOW() - INTERVAL 1 MINUTE, 48062, -20.246372, -70.141748, 0),
  (367, NOW() - INTERVAL 1 MINUTE, 7984.2, -20.242562, -70.139097, 0),
  (368, NOW() - INTERVAL 1 MINUTE, 1564.0, -20.205278, -70.144797, 0),
  (369, NOW() - INTERVAL 1 MINUTE, 3319.3, -20.050390, -69.260412, 0),
  (370, NOW() - INTERVAL 1 MINUTE, 8266.8, -20.247049, -70.139045, 0),
  (371, NOW() - INTERVAL 1 MINUTE, 2601.8, -20.213501, -70.140537, 0),
  (372, NOW() - INTERVAL 1 MINUTE, 9268.1, -20.242776, -70.137383, 0),
  (373, NOW() - INTERVAL 1 MINUTE, 9268.2, -20.276135, -70.092093, 0),
  (374, NOW() - INTERVAL 1 MINUTE, 239.9, -20.243334, -70.137436, 0),
  (375, NOW() - INTERVAL 1 MINUTE, 3098.0, -20.247190, -70.141575, 0),
  (376, NOW() - INTERVAL 1 MINUTE, 1838.6, -20.243129, -70.140973, 0),
  (377, NOW() - INTERVAL 1 MINUTE, 2689.3, -20.246295, -70.139049, 0),
  (378, NOW() - INTERVAL 1 MINUTE, 7057.2, -20.243169, -70.140220, 0),
  (379, NOW() - INTERVAL 1 MINUTE, 7120.9, -20.247282, -70.138684, 0),
  (380, NOW() - INTERVAL 1 MINUTE, 6714.2, -20.197785, -70.147718, 0),
  (381, NOW() - INTERVAL 1 MINUTE, 2971.4, -20.047507, -69.265496, 0),
  (382, NOW() - INTERVAL 1 MINUTE, 4016.8, -20.215717, -70.134463, 0),
  (383, NOW() - INTERVAL 1 MINUTE, 6535.7, -20.202573, -70.152948, 0),
  (384, NOW() - INTERVAL 1 MINUTE, 304.1, -20.244617, -70.137200, 0),
  (385, NOW() - INTERVAL 1 MINUTE, 6704.0, -20.246877, -70.141643, 0),
  (386, NOW() - INTERVAL 1 MINUTE, 32488, -20.216123, -70.139562, 0),
  (387, NOW() - INTERVAL 1 MINUTE, 139845, -20.244356, -70.139771, 0),
  (388, NOW() - INTERVAL 1 MINUTE, 123885, -20.246101, -70.136908, 0),
  (389, NOW() - INTERVAL 1 MINUTE, 65896, -20.206661, -70.149803, 0),
  (390, NOW() - INTERVAL 1 MINUTE, 49541, -20.212474, -70.144403, 0),
  (391, NOW() - INTERVAL 1 MINUTE, 250593, -20.244388, -70.139405, 0),
  (392, NOW() - INTERVAL 1 MINUTE, 256265, -20.246743, -70.141481, 0),
  (393, NOW() - INTERVAL 1 MINUTE, 131846, -20.245398, -70.139705, 0),
  (394, NOW() - INTERVAL 1 MINUTE, 233220, -20.245193, -70.141050, 0),
  (395, NOW() - INTERVAL 1 MINUTE, 177882, -20.040008, -69.264176, 0);

UPDATE equipo SET ubicacion = 'Ruta 16, en tránsito' WHERE id_equipo IN (123, 133, 137, 150, 244, 268, 270, 348);

-- OT simuladas: en curso para equipos en mantención y programadas para algunas mantenciones vencidas
INSERT INTO orden_trabajo (id_equipo, id_servicio_plan, tipo, estado, numero_ot, fecha_programada) VALUES
  (4, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 4 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107001', '2026-10-24'),
  (8, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 8 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107002', '2026-10-29'),
  (14, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 14 AND sp.intervalo_horas = 2000), 'PREVENTIVA', 'EN_CURSO', '107003', '2026-10-26'),
  (17, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 17 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'PROGRAMADA', '107004', '2026-11-05'),
  (25, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 25 AND sp.intervalo_horas = 1000), 'PREVENTIVA', 'EN_CURSO', '107005', '2026-10-27'),
  (28, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 28 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'PROGRAMADA', '107006', '2026-11-03'),
  (30, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 30 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107007', '2026-10-25'),
  (32, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 32 AND sp.intervalo_horas = 1000), 'PREVENTIVA', 'PROGRAMADA', '107008', '2026-11-07'),
  (37, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 37 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107009', '2026-10-29'),
  (53, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 53 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107010', '2026-10-28'),
  (58, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 58 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'PROGRAMADA', '107011', '2026-11-05'),
  (63, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 63 AND sp.intervalo_horas = 1000), 'PREVENTIVA', 'EN_CURSO', '107012', '2026-10-26'),
  (64, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 64 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107013', '2026-10-28'),
  (68, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 68 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107014', '2026-10-25'),
  (71, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 71 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107015', '2026-10-28'),
  (86, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 86 AND sp.intervalo_horas = 1000), 'PREVENTIVA', 'EN_CURSO', '107016', '2026-10-24'),
  (87, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 87 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'PROGRAMADA', '107017', '2026-11-03'),
  (111, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 111 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'PROGRAMADA', '107018', '2026-11-03'),
  (113, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 113 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107019', '2026-10-25'),
  (115, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 115 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107020', '2026-10-29'),
  (124, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 124 AND sp.intervalo_horas = 10000), 'PREVENTIVA', 'PROGRAMADA', '107021', '2026-11-06'),
  (132, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 132 AND sp.intervalo_horas = 20000), 'PREVENTIVA', 'EN_CURSO', '107022', '2026-10-27'),
  (139, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 139 AND sp.intervalo_horas = 20000), 'PREVENTIVA', 'EN_CURSO', '107023', '2026-10-29'),
  (142, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 142 AND sp.intervalo_horas = 20000), 'PREVENTIVA', 'EN_CURSO', '107024', '2026-10-27'),
  (150, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 150 AND sp.intervalo_horas = 10000), 'PREVENTIVA', 'PROGRAMADA', '107025', '2026-11-03'),
  (153, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 153 AND sp.intervalo_horas = 20000), 'PREVENTIVA', 'PROGRAMADA', '107026', '2026-10-31'),
  (154, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 154 AND sp.intervalo_horas = 10000), 'PREVENTIVA', 'EN_CURSO', '107027', '2026-10-24'),
  (155, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 155 AND sp.intervalo_horas = 20000), 'PREVENTIVA', 'EN_CURSO', '107028', '2026-10-25'),
  (156, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 156 AND sp.intervalo_horas = 20000), 'PREVENTIVA', 'EN_CURSO', '107029', '2026-10-25'),
  (158, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 158 AND sp.intervalo_horas = 20000), 'PREVENTIVA', 'EN_CURSO', '107030', '2026-10-28'),
  (161, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 161 AND sp.intervalo_horas = 10000), 'PREVENTIVA', 'PROGRAMADA', '107031', '2026-11-07'),
  (182, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 182 AND sp.intervalo_horas = 2000), 'PREVENTIVA', 'EN_CURSO', '107032', '2026-10-25'),
  (189, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 189 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107033', '2026-10-27'),
  (200, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 200 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107034', '2026-10-24'),
  (201, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 201 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107035', '2026-10-26'),
  (202, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 202 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107036', '2026-10-25'),
  (208, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 208 AND sp.intervalo_horas = 2000), 'PREVENTIVA', 'EN_CURSO', '107037', '2026-10-26'),
  (214, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 214 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107038', '2026-10-24'),
  (228, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 228 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107039', '2026-10-27'),
  (230, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 230 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107040', '2026-10-27'),
  (233, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 233 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107041', '2026-10-28'),
  (235, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 235 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107042', '2026-10-27'),
  (252, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 252 AND sp.intervalo_horas = 10000), 'PREVENTIVA', 'EN_CURSO', '107043', '2026-10-27'),
  (258, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 258 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107044', '2026-10-24'),
  (261, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 261 AND sp.intervalo_horas = 1000), 'PREVENTIVA', 'EN_CURSO', '107045', '2026-10-24'),
  (263, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 263 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107046', '2026-10-27'),
  (279, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 279 AND sp.intervalo_horas = 1000), 'PREVENTIVA', 'EN_CURSO', '107047', '2026-10-28'),
  (292, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 292 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107048', '2026-10-28'),
  (307, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 307 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107049', '2026-10-29'),
  (312, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 312 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'EN_CURSO', '107050', '2026-10-27'),
  (319, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 319 AND sp.intervalo_horas = 250), 'PREVENTIVA', 'PROGRAMADA', '107051', '2026-11-07'),
  (327, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 327 AND sp.intervalo_horas = 2000), 'PREVENTIVA', 'EN_CURSO', '107052', '2026-10-28'),
  (331, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 331 AND sp.intervalo_horas = 2000), 'PREVENTIVA', 'PROGRAMADA', '107053', '2026-11-08'),
  (332, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 332 AND sp.intervalo_horas = 1000), 'PREVENTIVA', 'EN_CURSO', '107054', '2026-10-24'),
  (335, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 335 AND sp.intervalo_horas = 10000), 'PREVENTIVA', 'PROGRAMADA', '107055', '2026-10-31'),
  (336, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 336 AND sp.intervalo_horas = 20000), 'PREVENTIVA', 'EN_CURSO', '107056', '2026-10-25'),
  (338, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 338 AND sp.intervalo_horas = 20000), 'PREVENTIVA', 'EN_CURSO', '107057', '2026-10-24'),
  (340, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 340 AND sp.intervalo_horas = 10000), 'PREVENTIVA', 'EN_CURSO', '107058', '2026-10-25'),
  (347, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 347 AND sp.intervalo_horas = 20000), 'PREVENTIVA', 'PROGRAMADA', '107059', '2026-11-08'),
  (353, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 353 AND sp.intervalo_horas = 10000), 'PREVENTIVA', 'EN_CURSO', '107060', '2026-10-29'),
  (385, (SELECT sp.id_servicio_plan FROM servicio_plan sp JOIN plan_mantencion pm ON pm.id_plan = sp.id_plan JOIN equipo e ON e.id_tipo_equipo = pm.id_tipo_equipo WHERE e.id_equipo = 385 AND sp.intervalo_horas = 500), 'PREVENTIVA', 'EN_CURSO', '107061', '2026-10-24');
