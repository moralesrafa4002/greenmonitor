# DFD Nivel 1 — Explicación detallada

## Objetivo

El DFD Nivel 1 detalla el proceso de monitoreo ambiental y generación de alertas. Muestra cómo se recibe un registro, cómo se valida, cómo se almacena y cómo se decide si se genera una alerta.

## Descomposición del proceso

### 1.1 Recibir medición
El sistema recibe datos desde sensores locales, captura manual o fuente externa. Cada medición debe incluir zona, fecha, hora y variables ambientales.

### 1.2 Validar medición
Se revisa que los valores sean numéricos, que la zona exista y que los rangos sean razonables. Por ejemplo, la humedad relativa debe estar entre 0 y 100 %.

### 1.3 Guardar registro ambiental
Si la medición es válida, se almacena en la tabla `registro_ambiental`.

### 1.4 Consultar reglas activas
El sistema obtiene las reglas de negocio vigentes desde la tabla `regla_negocio`.

### 1.5 Evaluar condiciones ambientales
Compara el registro contra las reglas. Por ejemplo, si la temperatura interior supera 32 °C, se considera temperatura excesiva.

### 1.6 Generar alerta
Si una regla se cumple, se crea un registro en la tabla `alerta` con severidad, mensaje, fecha y estado.

### 1.7 Actualizar estadísticas
El sistema calcula información agregada por hora y por día para consulta histórica.

## Resultado

El DFD Nivel 1 permite explicar la lógica completa desde la entrada de datos hasta la salida de alertas y estadísticas.
