# Fase 2 — Análisis estructurado del sistema

## Objetivo de la fase

Representar el sistema desde el punto de vista de procesos y flujos de información. Esta fase ayuda a entender qué datos entran, qué procesos los transforman, dónde se almacenan y qué salidas produce el sistema.

## Qué se hizo

Se construyeron tres modelos principales:

1. **Diagrama de contexto:** muestra al sistema como una sola caja y sus relaciones con actores externos.
2. **DFD Nivel 0:** divide el sistema en procesos principales.
3. **DFD Nivel 1:** detalla el proceso de monitoreo, evaluación y generación de alertas.

## Cómo se realizó

Primero se identificaron los actores externos: usuario/operador, sensores locales, fuente meteorológica externa, administrador técnico y responsable del invernadero. Después se identificaron los datos que cada actor entrega o recibe. Con esa información se construyeron procesos, almacenes de datos y flujos.

## Funcionalidad representada

El análisis estructurado representa la lógica completa del sistema:

- Captura de mediciones ambientales.
- Validación de datos.
- Almacenamiento histórico.
- Consulta de registros.
- Evaluación automática de reglas.
- Generación de alertas.
- Cálculo de estadísticas.
- Administración local por SSH.
