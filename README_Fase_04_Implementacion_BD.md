# Resumen ejecutivo del proyecto

GreenMonitor Local es un sistema local diseñado para apoyar la operación de un invernadero mediante el registro, análisis y consulta de variables ambientales. El sistema se enfoca en el almacenamiento organizado de información, la generación de alertas por reglas de negocio y la consulta de datos desde una interfaz web local.

El proyecto se desarrolló siguiendo una organización por fases para cumplir con los entregables solicitados. Primero se definió el problema y la metodología Scrum. Después se elaboraron los modelos de análisis estructurado: diagrama de contexto, DFD nivel 0 y DFD nivel 1. Posteriormente se diseñó el modelo de datos mediante un diccionario de datos y un modelo ER. Finalmente se implementó una base de datos y una interfaz web local funcional.

La base de datos almacena información de zonas del invernadero, sensores, fuentes de datos, registros ambientales, reglas de negocio y alertas. Cada registro ambiental contiene variables como temperatura, humedad relativa, humedad de suelo, radiación solar, índice UV, estado de ventilación, fecha y hora, zona y tipo de medición.

El sistema genera alertas cuando se detectan condiciones fuera de rango, por ejemplo temperatura excesiva, humedad insuficiente, radiación alta, índice UV alto o estrés hídrico. También permite visualizar estadísticas por hora y por día para facilitar el análisis histórico.

El resultado es un proyecto completo, coherente y ejecutable, con documentación suficiente para comprender qué se hizo, con qué objetivo, cómo se diseñó, cómo funciona y cómo puede probarse localmente.
