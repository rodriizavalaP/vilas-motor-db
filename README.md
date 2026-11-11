# Vilas Motor · Base de datos y maqueta

Base de datos MySQL 8 y maqueta web del **Sistema de Gestión de Mantenimiento de Flota** de Vilas Motor (Iquique). Es el trabajo de datos y backend de Rodrigo Zavala para el proyecto integrado del equipo; el MVP del grupo está en [kbdd23/vilas_motorMVP_E2](https://github.com/kbdd23/vilas_motorMVP_E2) y las reglas de negocio de esta base son las mismas.

- **Maqueta en línea:** se publica en Vercel desde `index.html` (sitio estático, sin compilación).
- **Usuario de prueba:** `planificador@vilasmotor.cl` / `VilasMotor2026` (administrador). El código de verificación en dos pasos aparece en pantalla, porque la maqueta no envía correos.

## Estructura

```
index.html                  Maqueta completa (HTML, CSS y JS en un solo archivo)
sql/
  01_esquema.sql            Tablas, triggers, procedimiento y vistas
  02_datos.sql              Datos reales: 395 equipos, 33 tipos, planes, insumos y OT de la V168
  03_consultas.sql          Consultas del panel y ejemplos de uso
  04_datos_simulados.sql    Opcional: flota "en operación" para la demo (estados, arriendos, GPS)
datos/
  equipos_normalizados.csv  Inventario normalizado desde Equipos.xlsx (con el código nuevo y el anterior)
  correcciones.csv          Cada corrección hecha al inventario original y su motivo
```

## Cargar la base

Requiere MySQL 8.0.16 o superior (usa `CHECK`, columnas `JSON` y funciones de ventana).

```bash
mysql -u root -p < sql/01_esquema.sql
mysql -u root -p < sql/02_datos.sql
mysql -u root -p < sql/04_datos_simulados.sql   # opcional, para la demo
mysql -u root -p < sql/03_consultas.sql
```

En MySQL Workbench, abre cada archivo en orden y ejecútalo completo (el rayo, no "ejecutar línea"), porque los triggers usan `DELIMITER`.

## Reglas de negocio (iguales al MVP)

La base hace cumplir las reglas aunque se use sin la aplicación:

| Regla | Cómo se aplica |
|---|---|
| Próximo servicio | Por cada servicio del plan: `intervalo − (horómetro actual − horómetro de cierre de su última OT cerrada)`. Manda el más cercano a vencer (vista `v_proximo_mantenimiento`; el detalle por servicio está en `v_mantencion_servicio`). Si el equipo nunca hizo ese servicio, se parte de su último servicio registrado. |
| Por vencer | Quedan 100 h o menos (1.000 km en equipos que se miden en kilómetros). Vencido: el resultado es negativo. |
| Lecturas de horómetro | No pueden ser negativas ni menores a la actual (una igual es válida). Una lectura válida actualiza el horómetro del equipo. |
| Órdenes de trabajo | `PROGRAMADA → EN_CURSO → CERRADA`. Iniciar manda el equipo a `EN_MANTENIMIENTO` y solo se permite si estaba `DISPONIBLE` o `INTERNO`. Cerrar exige un horómetro de cierre igual o mayor al actual, deja la lectura del técnico y devuelve el equipo a su estado previo. Una OT cerrada no se modifica. |
| Arriendos | Solo se arrienda un equipo `DISPONIBLE` y sin otro arriendo vigente. Se terminan en dos pasos: cerrar el contrato (`estado = 'TERMINADO'`) y marcar el regreso (`CALL sp_marcar_regreso(id_equipo)`). |
| Códigos automáticos | Equipo `GH-001` (prefijo del tipo + correlativo), arriendo `ARR-0001`, ID `#0001` y telemetría `TLM-0001`. |
| Auditoría | Los triggers registran altas y cambios de equipos, arriendos, OT y usuarios. La aplicación indica quién hace el cambio con `SET @app_usuario = <id_usuario>;`. |

Los scripts de carga usan `SET @carga_datos = 1;` para saltarse las validaciones, porque los datos históricos ya vienen consistentes. Al terminar lo vuelven a `0`.

## Maqueta

Pantallas: inicio de sesión con verificación en dos pasos, panel, flota (tabla y mapa), arriendos, órdenes de trabajo, pautas de mantención y administración (usuarios, roles e historial de auditoría exportable a CSV). Los cambios se guardan en el navegador; el botón **Restablecer datos de ejemplo**, al pie de página, vuelve al estado inicial.

Roles: **administrador** (todo, más usuarios y auditoría), **planificador** (flota, arriendos, OT y pautas) y **técnico** (ve la flota y ejecuta OT).

Accesibilidad: navegación completa con teclado y foco visible, enlace para saltar al contenido, respeto de "reducir movimiento", contraste AA en el texto rojo sobre fondo negro, tablas desplazables en el celular con la primera columna fija y botones de 44 px en pantallas táctiles.

## Publicar en Vercel

Importa el repositorio en Vercel con el preset **Other**, sin comando de compilación y con la raíz del proyecto como carpeta de salida. Vercel sirve `index.html` directamente.
