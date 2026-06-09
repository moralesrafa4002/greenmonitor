USE greenmonitor_db;

CREATE OR REPLACE VIEW vw_registros_detallados AS
SELECT
    r.id_registro,
    r.fecha_hora,
    z.nombre AS zona,
    z.tipo_zona,
    s.codigo_sensor,
    f.nombre_fuente,
    r.temperatura_c,
    r.humedad_relativa_pct,
    r.humedad_suelo_pct,
    r.radiacion_solar_wm2,
    r.indice_uv,
    r.estado_ventilacion,
    r.observaciones
FROM registro_ambiental r
JOIN zona_invernadero z ON r.id_zona = z.id_zona
LEFT JOIN sensor s ON r.id_sensor = s.id_sensor
JOIN fuente_datos f ON r.id_fuente = f.id_fuente;

CREATE OR REPLACE VIEW vw_alertas_activas AS
SELECT
    a.id_alerta,
    a.fecha_hora_alerta,
    a.severidad,
    a.mensaje,
    a.estado_alerta,
    z.nombre AS zona,
    z.tipo_zona,
    r.fecha_hora AS fecha_registro,
    rn.nombre_regla
FROM alerta a
JOIN registro_ambiental r ON a.id_registro = r.id_registro
JOIN zona_invernadero z ON r.id_zona = z.id_zona
JOIN regla_negocio rn ON a.id_regla = rn.id_regla
WHERE a.estado_alerta = 'ACTIVA';

-- Consulta: registros por fecha y zona
SELECT *
FROM vw_registros_detallados
WHERE DATE(fecha_hora) = '2026-06-08'
  AND zona = 'Nave 1 - Cultivo principal';

-- Consulta: promedio por hora
SELECT
    z.nombre AS zona,
    DATE(r.fecha_hora) AS fecha,
    HOUR(r.fecha_hora) AS hora,
    ROUND(AVG(r.temperatura_c), 2) AS temp_promedio,
    ROUND(AVG(r.humedad_relativa_pct), 2) AS humedad_promedio,
    ROUND(AVG(r.humedad_suelo_pct), 2) AS humedad_suelo_promedio,
    COUNT(*) AS total_registros
FROM registro_ambiental r
JOIN zona_invernadero z ON r.id_zona = z.id_zona
GROUP BY z.nombre, DATE(r.fecha_hora), HOUR(r.fecha_hora);

-- Consulta: promedio diario
SELECT
    z.nombre AS zona,
    DATE(r.fecha_hora) AS fecha,
    ROUND(AVG(r.temperatura_c), 2) AS temp_promedio,
    ROUND(MIN(r.temperatura_c), 2) AS temp_min,
    ROUND(MAX(r.temperatura_c), 2) AS temp_max,
    ROUND(AVG(r.humedad_relativa_pct), 2) AS humedad_promedio,
    COUNT(*) AS total_registros
FROM registro_ambiental r
JOIN zona_invernadero z ON r.id_zona = z.id_zona
GROUP BY z.nombre, DATE(r.fecha_hora);
