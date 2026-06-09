# Fase 4 — Implementación de base de datos

## Objetivo de la fase

Convertir el modelo ER en una base de datos funcional mediante scripts SQL. Esta fase incluye la creación de tablas, relaciones, datos de prueba, vistas, consultas y reglas automáticas.

## Archivos principales

| Archivo | Función |
|---|---|
| `database/mysql/01_create_database.sql` | Crea la base de datos y sus tablas en MySQL. |
| `database/mysql/02_insert_seed_data.sql` | Inserta zonas, sensores, fuentes, reglas y registros de prueba. |
| `database/mysql/03_views_and_queries.sql` | Crea vistas y consultas útiles para reportes. |
| `database/mysql/04_triggers.sql` | Incluye triggers de apoyo para auditoría o actualización. |
| `database/mysql/05_full_script_greenmonitor.sql` | Script completo para ejecutar todo junto. |
| `database/sqlite/greenmonitor_sqlite_schema.sql` | Versión compatible con SQLite para ejecución local. |

## Cómo se realizó

1. Se tomaron las entidades del modelo ER.
2. Cada entidad se transformó en una tabla.
3. Cada atributo se convirtió en una columna.
4. Se definieron tipos de datos adecuados.
5. Se agregaron llaves primarias.
6. Se agregaron llaves foráneas.
7. Se agregaron restricciones `CHECK` para rangos ambientales.
8. Se insertaron datos de prueba.
9. Se crearon vistas para registros, alertas y estadísticas.

## Funcionalidad lograda

La base de datos permite:

- Almacenar registros históricos.
- Consultar mediciones por zona y fecha.
- Relacionar alertas con reglas de negocio.
- Documentar el origen de cada registro.
- Generar estadísticas por hora y día.
- Mantener integridad entre tablas.
