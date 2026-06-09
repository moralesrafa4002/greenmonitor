USE greenmonitor_db;

INSERT INTO zona_invernadero (nombre, tipo_zona, descripcion, ubicacion_referencia) VALUES
('Nave 1 - Cultivo principal', 'INTERIOR', 'Zona interna donde se monitorea el cultivo principal.', 'Interior centro'),
('Nave 2 - Germinación', 'INTERIOR', 'Zona interna para germinación y plántulas.', 'Interior oriente'),
('Exterior norte', 'EXTERIOR', 'Punto exterior para comparar temperatura y radiación.', 'Norte del invernadero'),
('Exterior sur', 'EXTERIOR', 'Punto exterior para comparar condiciones UV.', 'Sur del invernadero');

INSERT INTO sensor (id_zona, codigo_sensor, tipo_sensor, unidad_medida, descripcion, fecha_instalacion) VALUES
(1, 'GM-MULTI-001', 'MULTIVARIABLE', 'varias', 'Sensor multivariable interior nave 1.', '2026-06-01'),
(2, 'GM-MULTI-002', 'MULTIVARIABLE', 'varias', 'Sensor multivariable interior nave 2.', '2026-06-01'),
(3, 'GM-EXT-001', 'MULTIVARIABLE', 'varias', 'Sensor exterior norte.', '2026-06-01'),
(4, 'GM-EXT-002', 'MULTIVARIABLE', 'varias', 'Sensor exterior sur.', '2026-06-01');

INSERT INTO fuente_datos (nombre_fuente, tipo_fuente, url_referencia, descripcion) VALUES
('Sensor local GreenMonitor', 'SENSOR_LOCAL', NULL, 'Datos capturados por sensores locales instalados en el invernadero.'),
('Captura manual operador', 'CAPTURA_MANUAL', NULL, 'Datos capturados desde la interfaz por el operador.'),
('NASA POWER Hourly API', 'API_EXTERNA', 'https://power.larc.nasa.gov/docs/services/api/temporal/hourly/', 'Datos meteorológicos exteriores de referencia.'),
('Simulación académica', 'SIMULACION', NULL, 'Datos generados para pruebas del proyecto académico.');

INSERT INTO regla_negocio (nombre_regla, descripcion, variable_evaluada, operador, valor_umbral, unidad, severidad, mensaje_alerta) VALUES
('Temperatura interior excesiva', 'Cuando una zona interior supera 32 °C se requiere revisar ventilación.', 'temperatura_c', '>', 32.00, '°C', 'ALTA', 'Temperatura interior excesiva. Revisar ventilación y sombreado.'),
('Temperatura exterior crítica', 'Cuando una zona exterior supera 35 °C se emite alerta de condición externa crítica.', 'temperatura_c', '>', 35.00, '°C', 'MEDIA', 'Temperatura exterior alta. Considerar protección térmica.'),
('Humedad relativa insuficiente', 'Cuando la humedad relativa baja de 45 % se alerta posible ambiente seco.', 'humedad_relativa_pct', '<', 45.00, '%', 'MEDIA', 'Humedad relativa insuficiente. Revisar nebulización o riego.'),
('Humedad de suelo baja', 'Cuando la humedad del suelo baja de 35 % se alerta necesidad de riego.', 'humedad_suelo_pct', '<', 35.00, '%', 'ALTA', 'Humedad del suelo baja. Revisar sistema de riego.'),
('Índice UV alto', 'Cuando el índice UV supera 8 se recomienda protección del cultivo.', 'indice_uv', '>', 8.00, 'UV', 'MEDIA', 'Índice UV alto. Revisar malla sombra o protección.'),
('Radiación solar alta', 'Cuando la radiación supera 800 W/m² se alerta riesgo por radiación.', 'radiacion_solar_wm2', '>', 800.00, 'W/m²', 'MEDIA', 'Radiación solar alta. Revisar sombreado.'),
('Estrés hídrico', 'Condición compuesta: temperatura alta y humedad de suelo baja.', 'estres_hidrico', 'COMPUESTA', NULL, NULL, 'CRITICA', 'Posible estrés hídrico. Priorizar riego y revisión del cultivo.');

INSERT INTO usuario_sistema (nombre, rol, usuario_login) VALUES
('Administrador local', 'ADMINISTRADOR', 'admin'),
('Operador invernadero', 'OPERADOR', 'operador'),
('Consulta académica', 'CONSULTA', 'consulta');

INSERT INTO registro_ambiental
(id_zona, id_sensor, id_fuente, fecha_hora, temperatura_c, humedad_relativa_pct, humedad_suelo_pct, radiacion_solar_wm2, indice_uv, estado_ventilacion, observaciones) VALUES
(1, 1, 4, '2026-06-08 08:00:00', 24.80, 67.00, 58.00, 310.00, 2.10, 'AUTOMATICA', 'Condición normal matutina.'),
(1, 1, 4, '2026-06-08 12:00:00', 33.70, 42.00, 31.00, 870.00, 8.50, 'ABIERTA', 'Condición calurosa con suelo bajo.'),
(2, 2, 4, '2026-06-08 12:00:00', 30.20, 55.00, 41.00, 650.00, 6.70, 'AUTOMATICA', 'Germinación estable.'),
(3, 3, 4, '2026-06-08 12:00:00', 36.10, 38.00, NULL, 910.00, 9.20, 'NO_APLICA', 'Exterior con alta radiación.'),
(4, 4, 4, '2026-06-08 15:00:00', 34.90, 40.00, NULL, 790.00, 8.90, 'NO_APLICA', 'Exterior sur con UV alto.');
