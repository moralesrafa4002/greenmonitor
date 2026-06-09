# Normalización de la base de datos

## Objetivo

Evitar duplicidad de datos, mejorar la integridad y hacer que la base sea más fácil de mantener.

## Primera Forma Normal (1FN)

Todas las tablas tienen atributos atómicos. Por ejemplo, `registro_ambiental` no guarda una lista de temperaturas, sino un registro por medición. Cada campo almacena un solo valor.

## Segunda Forma Normal (2FN)

Las tablas con llave primaria tienen atributos que dependen completamente de esa llave. Por ejemplo, los datos de una zona no se repiten dentro de cada registro ambiental; se guardan en `zona_invernadero` y se referencian con `id_zona`.

## Tercera Forma Normal (3FN)

No existen dependencias transitivas innecesarias. Por ejemplo, la información de la fuente de datos no se guarda en cada registro, sino en `fuente_datos`. El registro solamente almacena `id_fuente`.

## Ejemplo de mejora

Una tabla no normalizada podría tener:

| zona | tipo_zona | sensor | temperatura | fuente |
|---|---|---|---:|---|
| Nave 1 | Interior | Sensor T-01 | 33.5 | Sensor local |
| Nave 1 | Interior | Sensor T-01 | 34.1 | Sensor local |

El problema es que se repite la zona, tipo, sensor y fuente. En el modelo normalizado:

- `zona_invernadero` guarda Nave 1 una sola vez.
- `sensor` guarda Sensor T-01 una sola vez.
- `fuente_datos` guarda Sensor local una sola vez.
- `registro_ambiental` guarda las mediciones y usa llaves foráneas.

## Beneficio

La normalización permite que el sistema sea más consistente, evite errores de captura y facilite consultas históricas.
