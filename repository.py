# Reglas de negocio del sistema

## Objetivo

Definir los criterios que el sistema usa para determinar si una condición ambiental requiere una alerta.

## Reglas implementadas

| ID | Regla | Condición | Severidad | Acción recomendada |
|---|---|---|---|---|
| RN-01 | Temperatura interior excesiva | Zona interior y temperatura > 32 °C | Alta | Abrir ventilación, revisar sombreado y monitorear. |
| RN-02 | Temperatura exterior crítica | Zona exterior y temperatura > 35 °C | Media | Comparar exterior contra interior y proteger cultivo. |
| RN-03 | Humedad relativa insuficiente | Humedad relativa < 45 % | Media | Revisar nebulización o riego. |
| RN-04 | Humedad de suelo baja | Humedad del suelo < 35 % | Alta | Revisar sistema de riego. |
| RN-05 | Índice UV alto | Índice UV > 8 | Media | Usar malla sombra o protección. |
| RN-06 | Radiación solar alta | Radiación solar > 800 W/m² | Media | Revisar sombreado. |
| RN-07 | Estrés hídrico | Temperatura interior > 32 °C y humedad de suelo < 35 % | Crítica | Priorizar riego y revisión del cultivo. |

## Explicación

Las reglas se guardan en la tabla `regla_negocio` y se aplican desde la capa de aplicación. Esto permite que las reglas simples se documenten en la base, mientras que reglas compuestas como estrés hídrico puedan evaluarse con lógica programada.

## Ejemplo

Si se captura un registro de la Nave 1 con:

- Temperatura: 33.7 °C
- Humedad relativa: 42 %
- Humedad del suelo: 31 %
- Radiación solar: 870 W/m²
- Índice UV: 8.5

El sistema genera varias alertas:

1. Temperatura interior excesiva.
2. Humedad relativa insuficiente.
3. Humedad de suelo baja.
4. Índice UV alto.
5. Radiación solar alta.
6. Estrés hídrico.

Esto demuestra que un solo registro puede originar varias alertas.
