# Vilas Motor · Base de datos y maqueta

Sistema de gestión de mantenimiento de flota para Vilas Motor (Iquique).
Incluye la base de datos MySQL completa y la maqueta navegable de la aplicación.

```
vilas-motor-db/
├── sql/
│   ├── 01_esquema.sql     tablas, triggers y vistas
│   ├── 02_datos.sql       datos iniciales (planillas V168 y G45QX + ejemplos)
│   └── 03_consultas.sql   consultas del dashboard y ejemplos de uso
└── index.html             maqueta de la aplicación (se abre en el navegador)
```

## Cómo cargar la base de datos

Requiere **MySQL 8.0** o superior.

**Con MySQL Workbench:** abre cada archivo con *File → Open SQL Script* y ejecútalo con el rayo, en orden: `01`, `02` y `03`.

**Por consola:**

```bash
mysql -u root -p < sql/01_esquema.sql
mysql -u root -p < sql/02_datos.sql
mysql -u root -p < sql/03_consultas.sql
```

`01_esquema.sql` borra y vuelve a crear la base `vilas_motor`, así que se puede ejecutar las veces que haga falta.

## Usuario de prueba

| Email | Contraseña |
|---|---|
| planificador@vilasmotor.cl | VilasMotor2026 |

En la base, la contraseña se guarda como hash (formato Django `pbkdf2_sha256`), nunca en texto. Es una clave **solo para la demo**: no usen una contraseña real.

## Qué tiene

Se mantienen todas las tablas del `schema.sql` del equipo (corregido, porque los comentarios `--TODO` sin espacio daban error en MySQL) y se agregó:

- **ID correlativo de cada máquina**: `id_equipo` (se muestra como `#0001`, `#0002`…). Cada equipo nuevo toma el siguiente.
- **Código y nombre automáticos**: al insertar un equipo con `codigo = ''` y `nombre = ''`, un trigger arma el código con el prefijo del tipo más un correlativo (`GH-001`, `GE-002`) y el nombre con tipo, marca y modelo.
- **Prefijo automático por tipo**: "Grúa horquilla" → `GH`, "Generador" → `GE`, "Camión" → `CA`.
- **ID de telemetría** correlativo (`TLM-0001`), visible en la vista `v_equipo`.
- **Geolocalización GPS**: cada señal en `telemetria_equipo` actualiza la posición, la velocidad, el horómetro y la hora de la última señal del equipo. Un equipo que no reporta en 10 minutos queda "sin señal".
- **Arriendos** con número `ARR-0001` automático, faena y estado. Al arrendar, el equipo pasa a "en faena" y toma la ubicación de la faena; al terminar, vuelve al taller como disponible.
- **Cierre de OT**: al cerrar una orden, el horómetro de cierre queda como último servicio y el equipo vuelve a su estado anterior.
- **Verificación en dos pasos**: tablas `codigo_verificacion` (código de 6 dígitos guardado como hash, vence en 5 minutos, máximo 3 intentos) y `dispositivo_confiable` (opción "confiar 30 días").

## Vistas

| Vista | Para qué |
|---|---|
| `v_equipo` | Ficha completa: ID, código, tipo, telemetría, GPS, señal y arriendo vigente |
| `v_proximo_mantenimiento` | Próximo servicio, horas o km restantes y estado (vencida, por vencer, al día) |
| `v_dashboard` | Todos los números del dashboard |
| `v_disponibles_arriendo` | Equipos que se pueden arrendar, el más nuevo primero |

Cada número de `v_dashboard` se calcula con la misma vista que la lista a la que lleva (ver `03_consultas.sql`), así **el número y la lista siempre coinciden**.

## Datos de origen

- `PLANILLA DE V168.xlsx`: grúa horquilla 3,5 ton, patente SVTJ39, con sus 10 mantenciones reales (OT 89867 a 106948).
- `PAUTA INSUMOS GENERADOR G45QX.xlsx`: insumos de los servicios de 250, 500, 1.000 y 2.000 h de los generadores VG10 y VG11.

Las coordenadas de las faenas y el resto de los equipos son de ejemplo.

## Maqueta

`index.html` se abre con doble clic (necesita internet para el mapa). Si activan **GitHub Pages** en el repositorio (*Settings → Pages → Branch: main*), queda publicada en `https://<usuario>.github.io/<repositorio>/`.

La maqueta guarda los datos en el navegador. Esta base de datos es la que usaría la aplicación real.
