# Fase 6 — Pruebas y evidencias

## Objetivo

Comprobar que el sistema cumple con las funcionalidades solicitadas.

## Pruebas realizadas

| ID | Prueba | Resultado esperado |
|---|---|---|
| P-01 | Ejecutar `python run.py` | El servidor inicia en `localhost:8000`. |
| P-02 | Abrir dashboard | Se muestran totales de registros y alertas. |
| P-03 | Consultar registros | Aparece una tabla con mediciones ambientales. |
| P-04 | Filtrar por zona | Solo se muestran registros de la zona seleccionada. |
| P-05 | Filtrar por fecha | Solo se muestran registros del día indicado. |
| P-06 | Ver alertas activas | Se muestran alertas no resueltas. |
| P-07 | Agregar registro con temperatura alta | Se genera alerta automática. |
| P-08 | Consultar estadísticas por hora | Se muestran promedios por fecha/hora. |
| P-09 | Consultar estadísticas por día | Se muestran promedios diarios. |
| P-10 | Revisar scripts SQL | Las tablas tienen llaves primarias y foráneas. |

## Evidencia sugerida para entregar

Para complementar la entrega, se recomienda tomar capturas de:

1. Carpeta del repositorio en GitHub.
2. Ejecución de `python run.py`.
3. Dashboard en navegador.
4. Tabla de registros.
5. Pantalla de alertas activas.
6. Formulario de carga de registro.
7. Estadísticas por hora y por día.
8. Diagrama ER.
9. Script MySQL abierto en Workbench.
10. Conexión SSH al servidor local.
