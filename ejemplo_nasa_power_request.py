# Modelo ER — Explicación detallada

## Objetivo del modelo ER

El modelo Entidad-Relación representa la estructura lógica de la base de datos. Su función es mostrar qué entidades existen, qué atributos tiene cada una y cómo se relacionan entre sí.

## Entidades principales

### zona_invernadero
Representa las áreas físicas donde se toman mediciones. Puede ser una zona interior como "Nave 1" o una zona exterior como "Exterior norte".

### sensor
Representa un dispositivo o punto de captura de datos. Se relaciona con una zona porque cada sensor se instala o se asocia a un área específica.

### fuente_datos
Indica el origen de una medición. Puede ser sensor local, captura manual o datos externos, por ejemplo NASA POWER.

### registro_ambiental
Es la entidad central del sistema. Almacena las mediciones ambientales: temperatura, humedad relativa, humedad de suelo, radiación solar, índice UV, ventilación, fecha y hora.

### regla_negocio
Contiene los umbrales y criterios para evaluar las condiciones ambientales. Permite documentar por qué se genera una alerta.

### alerta
Guarda las alertas producidas por el sistema. Cada alerta puede relacionarse con un registro ambiental y con una regla de negocio.

### usuario_sistema
Representa a las personas que consultan o administran el sistema.

### bitacora_acceso
Registra eventos de acceso y administración. Es útil para documentar la operación local y el uso por SSH.

### estadistica_horaria y estadistica_diaria
Almacenan resultados agregados para facilitar reportes por hora y por día.

## Relaciones principales

| Relación | Tipo | Explicación |
|---|---|---|
| zona_invernadero 1:N sensor | Uno a muchos | Una zona puede tener varios sensores. |
| zona_invernadero 1:N registro_ambiental | Uno a muchos | Una zona puede tener muchos registros ambientales. |
| sensor 1:N registro_ambiental | Uno a muchos | Un sensor puede producir muchas mediciones. |
| fuente_datos 1:N registro_ambiental | Uno a muchos | Una fuente puede generar muchos registros. |
| registro_ambiental 1:N alerta | Uno a muchos | Un registro puede originar varias alertas. |
| regla_negocio 1:N alerta | Uno a muchos | Una regla puede generar muchas alertas. |
| usuario_sistema 1:N bitacora_acceso | Uno a muchos | Un usuario puede tener muchos eventos en bitácora. |

## Justificación del diseño

Se eligió un modelo relacional porque el proyecto requiere integridad, trazabilidad e historial. Las relaciones con llaves foráneas permiten saber de qué zona, sensor y fuente proviene cada registro, así como qué regla originó cada alerta.
