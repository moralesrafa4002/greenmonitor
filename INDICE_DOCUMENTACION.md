# DFD Nivel 0 — Explicación detallada

## Objetivo

El DFD Nivel 0 divide el sistema en procesos principales para mostrar cómo se transforma la información.

## Procesos principales

### 1.0 Capturar registros ambientales
Recibe mediciones de sensores locales, cargas manuales o datos externos. Su objetivo es transformar datos crudos en registros válidos para almacenarse.

### 2.0 Administrar base de datos ambiental
Guarda zonas, sensores, fuentes de datos, registros, reglas y alertas. Es el núcleo de persistencia del sistema.

### 3.0 Evaluar reglas de negocio
Compara cada registro ambiental contra umbrales definidos. Si detecta una condición fuera de rango, produce una alerta.

### 4.0 Consultar información histórica
Permite buscar registros por fecha, zona y tipo de zona. Devuelve resultados comprensibles para el usuario.

### 5.0 Generar estadísticas y reportes
Calcula promedios, mínimos y máximos por hora y por día. Sirve para analizar tendencias.

### 6.0 Administrar acceso local/SSH
Representa la administración técnica del sistema instalado en una computadora servidor dentro de la red interna.

## Almacenes de datos

| Almacén | Contenido |
|---|---|
| D1 Zonas | Zonas interiores y exteriores del invernadero. |
| D2 Sensores | Sensores o fuentes de medición. |
| D3 Registros ambientales | Mediciones históricas. |
| D4 Reglas de negocio | Umbrales y criterios de alerta. |
| D5 Alertas | Alertas generadas por el sistema. |
| D6 Usuarios/Bitácora | Usuarios y eventos de administración. |

## Coherencia con la base de datos

Cada almacén del DFD se relaciona directamente con tablas del modelo ER. Esto permite que el análisis estructurado y la implementación de base de datos tengan continuidad.
