# Diagrama de contexto — Explicación detallada

## Objetivo del diagrama

El diagrama de contexto muestra el sistema GreenMonitor Local como un único proceso central. Sirve para identificar qué entidades externas interactúan con el sistema y qué información fluye entre ellas.

## Entidades externas

| Entidad externa | Descripción | Información que envía | Información que recibe |
|---|---|---|---|
| Operador del invernadero | Persona que consulta y registra información ambiental. | Solicitudes de consulta, filtros, registros manuales. | Reportes, registros históricos y alertas. |
| Sensores locales | Dispositivos físicos o simulados que miden variables ambientales. | Temperatura, humedad, radiación, UV, humedad del suelo. | Confirmación de recepción de datos. |
| Fuente meteorológica externa | Servicio de datos externos como NASA POWER. | Datos meteorológicos exteriores. | Solicitud de datos por ubicación y fecha. |
| Administrador técnico | Persona que instala y administra el servidor local. | Configuración, conexión SSH, mantenimiento. | Estado del sistema, bitácora y respaldos. |
| Responsable del invernadero | Persona que toma decisiones operativas. | Reglas o criterios de operación. | Alertas y recomendaciones. |

## Proceso central

El proceso central es el **Sistema local de monitoreo ambiental y generación de alertas**. Este proceso recibe datos ambientales, los almacena, evalúa reglas y genera información útil para la toma de decisiones.

## Justificación

Este diagrama es importante porque delimita el alcance. El sistema no controla físicamente ventiladores o riego en esta versión; solamente registra, analiza, alerta y recomienda acciones.
