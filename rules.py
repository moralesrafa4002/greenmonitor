# Origen y obtención de los datos ambientales

## Tipos de datos usados por el sistema

El sistema contempla tres tipos principales de origen:

1. **Sensores locales:** mediciones generadas dentro del invernadero.
2. **Captura manual:** datos escritos por un operador desde la interfaz web.
3. **Fuente meteorológica externa:** datos exteriores de referencia, por ejemplo servicios como NASA POWER.

## Datos internos

Los datos internos corresponden a variables que se miden dentro del invernadero:

- Temperatura interior.
- Humedad relativa interior.
- Humedad del suelo.
- Radiación solar dentro de la nave.
- Índice UV estimado o medido.
- Estado de ventilación.

Estos datos normalmente provendrían de sensores físicos conectados a un microcontrolador o estación ambiental local. Para este proyecto académico se incluyeron datos simulados realistas para demostrar consultas, alertas y estadísticas.

## Datos exteriores

Los datos exteriores permiten comparar el ambiente interno contra condiciones externas. Por ejemplo, si afuera hay temperatura alta o radiación intensa, el sistema puede recomendar revisar ventilación y sombreado.

NASA POWER se toma como referencia porque permite obtener series de tiempo de variables meteorológicas y solares. En una implementación conectada, se solicitarían datos por latitud, longitud, fecha inicial, fecha final y parámetros requeridos.

## Ejemplo conceptual de solicitud NASA POWER

```text
https://power.larc.nasa.gov/api/temporal/hourly/point?parameters=T2M,RH2M,ALLSKY_SFC_SW_DWN&community=AG&longitude=-99.1332&latitude=19.4326&start=20260608&end=20260608&format=JSON
```

## Variables equivalentes

| Variable del sistema | Posible variable externa | Descripción |
|---|---|---|
| temperatura_c | T2M | Temperatura a 2 metros. |
| humedad_relativa_pct | RH2M | Humedad relativa a 2 metros. |
| radiacion_solar_wm2 | ALLSKY_SFC_SW_DWN | Radiación solar superficial. |
| indice_uv | UV o índice derivado | Condición UV si la fuente la proporciona. |

## Por qué se guardan fuentes de datos

La tabla `fuente_datos` permite saber si un registro proviene de sensor local, captura manual, simulación o API externa. Esto mejora la trazabilidad y permite explicar de dónde salió cada dato.

## Nota académica

Los datos incluidos en este repositorio son de prueba. Se diseñaron para representar condiciones normales y condiciones críticas. Su objetivo es demostrar que la base de datos, las reglas de negocio y la interfaz funcionan correctamente.
