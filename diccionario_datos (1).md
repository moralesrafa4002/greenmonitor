# Proyecto: Sistema local de monitoreo ambiental y generación de alertas para invernaderos

## Nombre del sistema

**GreenMonitor Local**

## Tipo de proyecto

Sistema de información local para monitoreo ambiental, consulta histórica, análisis de condiciones y generación automática de alertas dentro de un invernadero.

## Objetivo académico

Aplicar los principios del análisis estructurado en un caso realista que contiene procesos, entidades, flujos de información, reglas de negocio, almacenamiento de datos, toma de decisiones y modelado de base de datos.

## Problema que resuelve

Un invernadero necesita conocer sus condiciones internas y externas para tomar decisiones oportunas. Si no se monitorean variables como temperatura, humedad relativa, humedad del suelo, radiación solar, índice UV y ventilación, pueden presentarse daños en los cultivos, estrés hídrico, crecimiento deficiente o pérdida de productividad.

GreenMonitor Local centraliza los registros ambientales, permite consultarlos desde una red interna, genera alertas automáticas y facilita la revisión histórica por fecha, zona y tipo de condición ambiental.

## Alcance funcional

El sistema permite:

1. Registrar mediciones ambientales de zonas interiores y exteriores.
2. Consultar registros históricos.
3. Filtrar registros por fecha, zona y tipo de zona.
4. Visualizar alertas activas.
5. Calcular estadísticas básicas por hora y por día.
6. Evaluar reglas de negocio relacionadas con temperatura, humedad, UV, radiación, humedad de suelo, ventilación y estrés hídrico.
7. Ejecutarse localmente en una computadora servidor.
8. Ser consultado desde otras computadoras de la red interna.
9. Administrarse mediante conexión SSH.

## Alcance técnico

El proyecto incluye dos enfoques de base de datos:

- **MySQL:** versión formal para creación de base de datos del proyecto académico.
- **SQLite:** versión local automática para que la aplicación web pueda ejecutarse de inmediato sin instalaciones adicionales.

## Entregables principales

- Diagrama de contexto.
- DFD Nivel 0.
- DFD Nivel 1.
- Diccionario de datos.
- Modelo ER.
- Diagrama UML.
- Scripts SQL.
- Código de aplicación web local.
- Documentación por fase.
- Guía de despliegue local y uso por SSH.
- Referencias.
