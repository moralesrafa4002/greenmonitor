# Fase 5 — Interfaz web local

## Objetivo de la fase

Implementar una interfaz web local que permita consultar y actualizar información del sistema desde un navegador dentro de la red interna.

## Qué se implementó

La aplicación permite:

1. Ver un dashboard general.
2. Consultar registros ambientales.
3. Filtrar por fecha, zona y tipo de zona.
4. Visualizar alertas activas.
5. Consultar estadísticas por hora y por día.
6. Agregar nuevos registros ambientales.
7. Evaluar reglas de negocio automáticamente al insertar registros.

## Tecnología utilizada

Se utilizó Python con módulos estándar:

- `http.server` para levantar el servidor local.
- `sqlite3` para la base de datos local.
- `json` para respuestas API.
- HTML, CSS y JavaScript para la interfaz.

## Por qué se usó esta tecnología

La finalidad es que el sistema pueda ejecutarse de forma sencilla en cualquier computadora sin instalar frameworks adicionales. Esto facilita la revisión del profesor y permite probar el funcionamiento inmediatamente.

## Cómo ejecutar

Desde la raíz del proyecto:

```bash
python run.py
```

Luego abrir:

```text
http://localhost:8000
```

## Relación con la base de datos MySQL

La aplicación local usa SQLite para ejecutarse de inmediato, pero el diseño formal de la base de datos se entrega en MySQL. Las tablas y relaciones principales son equivalentes, por lo que el proyecto puede migrarse a MySQL si el equipo instala un servidor MySQL local.
