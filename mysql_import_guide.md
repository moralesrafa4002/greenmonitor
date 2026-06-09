# Fase 3 — Modelado de base de datos

## Objetivo de la fase

Diseñar una base de datos coherente, normalizada y capaz de almacenar la información ambiental del invernadero, las fuentes de datos, las reglas de negocio y las alertas generadas.

## Qué se hizo

Se identificaron las entidades principales del sistema:

- Zona del invernadero.
- Sensor.
- Fuente de datos.
- Registro ambiental.
- Regla de negocio.
- Alerta.
- Usuario del sistema.
- Bitácora de acceso.
- Estadística horaria.
- Estadística diaria.

## Criterios de diseño

La base de datos se diseñó con los siguientes criterios:

1. **Separación de entidades:** las zonas, sensores, fuentes, reglas y alertas se almacenan en tablas distintas.
2. **Integridad referencial:** se usan llaves foráneas para relacionar registros con zonas, sensores y fuentes.
3. **Historial completo:** los registros ambientales no se sobrescriben; se almacenan como serie histórica.
4. **Flexibilidad:** una medición puede provenir de sensor local, captura manual o fuente externa.
5. **Trazabilidad:** las alertas se relacionan con el registro que las originó.
6. **Consulta eficiente:** se incluyen campos de fecha, hora, zona y tipo de zona para filtrar información.

## Resultado

El resultado es un modelo ER que permite implementar el sistema solicitado y extenderlo posteriormente a sensores reales, APIs externas o actuadores físicos.
