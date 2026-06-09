CREATE DATABASE IF NOT EXISTS greenmonitor_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE greenmonitor_db;

DROP TABLE IF EXISTS bitacora_acceso;
DROP TABLE IF EXISTS estadistica_diaria;
DROP TABLE IF EXISTS estadistica_horaria;
DROP TABLE IF EXISTS alerta;
DROP TABLE IF EXISTS registro_ambiental;
DROP TABLE IF EXISTS regla_negocio;
DROP TABLE IF EXISTS sensor;
DROP TABLE IF EXISTS fuente_datos;
DROP TABLE IF EXISTS zona_invernadero;
DROP TABLE IF EXISTS usuario_sistema;

CREATE TABLE zona_invernadero (
    id_zona INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    tipo_zona ENUM('INTERIOR','EXTERIOR') NOT NULL,
    descripcion VARCHAR(255),
    ubicacion_referencia VARCHAR(120),
    activa BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE sensor (
    id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    id_zona INT NOT NULL,
    codigo_sensor VARCHAR(40) NOT NULL UNIQUE,
    tipo_sensor ENUM('TEMPERATURA','HUMEDAD_RELATIVA','HUMEDAD_SUELO','RADIACION_SOLAR','UV','MULTIVARIABLE','VENTILACION') NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL,
    descripcion VARCHAR(255),
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_instalacion DATE,
    CONSTRAINT fk_sensor_zona
        FOREIGN KEY (id_zona) REFERENCES zona_invernadero(id_zona)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE fuente_datos (
    id_fuente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_fuente VARCHAR(100) NOT NULL UNIQUE,
    tipo_fuente ENUM('SENSOR_LOCAL','CAPTURA_MANUAL','API_EXTERNA','SIMULACION') NOT NULL,
    url_referencia VARCHAR(255),
    descripcion VARCHAR(255),
    activa BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE regla_negocio (
    id_regla INT AUTO_INCREMENT PRIMARY KEY,
    nombre_regla VARCHAR(120) NOT NULL UNIQUE,
    descripcion VARCHAR(255) NOT NULL,
    variable_evaluada ENUM('temperatura_c','humedad_relativa_pct','humedad_suelo_pct','radiacion_solar_wm2','indice_uv','estado_ventilacion','estres_hidrico') NOT NULL,
    operador ENUM('>','>=','<','<=','=','!=','COMPUESTA') NOT NULL,
    valor_umbral DECIMAL(10,2),
    unidad VARCHAR(20),
    severidad ENUM('BAJA','MEDIA','ALTA','CRITICA') NOT NULL,
    mensaje_alerta VARCHAR(255) NOT NULL,
    activa BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE registro_ambiental (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    id_zona INT NOT NULL,
    id_sensor INT NULL,
    id_fuente INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    temperatura_c DECIMAL(5,2),
    humedad_relativa_pct DECIMAL(5,2),
    humedad_suelo_pct DECIMAL(5,2),
    radiacion_solar_wm2 DECIMAL(8,2),
    indice_uv DECIMAL(4,2),
    estado_ventilacion ENUM('ABIERTA','CERRADA','AUTOMATICA','NO_APLICA') NOT NULL DEFAULT 'NO_APLICA',
    observaciones VARCHAR(255),
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_registro_zona
        FOREIGN KEY (id_zona) REFERENCES zona_invernadero(id_zona)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_registro_sensor
        FOREIGN KEY (id_sensor) REFERENCES sensor(id_sensor)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_registro_fuente
        FOREIGN KEY (id_fuente) REFERENCES fuente_datos(id_fuente)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_humedad_relativa CHECK (humedad_relativa_pct IS NULL OR humedad_relativa_pct BETWEEN 0 AND 100),
    CONSTRAINT chk_humedad_suelo CHECK (humedad_suelo_pct IS NULL OR humedad_suelo_pct BETWEEN 0 AND 100),
    CONSTRAINT chk_indice_uv CHECK (indice_uv IS NULL OR indice_uv >= 0),
    INDEX idx_registro_fecha (fecha_hora),
    INDEX idx_registro_zona_fecha (id_zona, fecha_hora)
) ENGINE=InnoDB;

CREATE TABLE alerta (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    id_registro INT NOT NULL,
    id_regla INT NOT NULL,
    fecha_hora_alerta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    severidad ENUM('BAJA','MEDIA','ALTA','CRITICA') NOT NULL,
    mensaje VARCHAR(255) NOT NULL,
    estado_alerta ENUM('ACTIVA','ATENDIDA','DESCARTADA') NOT NULL DEFAULT 'ACTIVA',
    accion_recomendada VARCHAR(255),
    fecha_atencion DATETIME NULL,
    CONSTRAINT fk_alerta_registro
        FOREIGN KEY (id_registro) REFERENCES registro_ambiental(id_registro)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_alerta_regla
        FOREIGN KEY (id_regla) REFERENCES regla_negocio(id_regla)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_alerta_estado (estado_alerta),
    INDEX idx_alerta_fecha (fecha_hora_alerta)
) ENGINE=InnoDB;

CREATE TABLE usuario_sistema (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    rol ENUM('ADMINISTRADOR','OPERADOR','CONSULTA') NOT NULL DEFAULT 'CONSULTA',
    usuario_login VARCHAR(60) NOT NULL UNIQUE,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE bitacora_acceso (
    id_bitacora INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NULL,
    fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    accion VARCHAR(80) NOT NULL,
    detalle VARCHAR(255),
    ip_origen VARCHAR(45),
    CONSTRAINT fk_bitacora_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario_sistema(id_usuario)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE estadistica_horaria (
    id_estadistica_horaria INT AUTO_INCREMENT PRIMARY KEY,
    id_zona INT NOT NULL,
    fecha DATE NOT NULL,
    hora TINYINT NOT NULL,
    temperatura_promedio DECIMAL(5,2),
    temperatura_min DECIMAL(5,2),
    temperatura_max DECIMAL(5,2),
    humedad_promedio DECIMAL(5,2),
    humedad_suelo_promedio DECIMAL(5,2),
    radiacion_promedio DECIMAL(8,2),
    uv_promedio DECIMAL(4,2),
    total_registros INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_est_horaria_zona
        FOREIGN KEY (id_zona) REFERENCES zona_invernadero(id_zona)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT uq_est_horaria UNIQUE (id_zona, fecha, hora)
) ENGINE=InnoDB;

CREATE TABLE estadistica_diaria (
    id_estadistica_diaria INT AUTO_INCREMENT PRIMARY KEY,
    id_zona INT NOT NULL,
    fecha DATE NOT NULL,
    temperatura_promedio DECIMAL(5,2),
    temperatura_min DECIMAL(5,2),
    temperatura_max DECIMAL(5,2),
    humedad_promedio DECIMAL(5,2),
    humedad_suelo_promedio DECIMAL(5,2),
    radiacion_promedio DECIMAL(8,2),
    uv_promedio DECIMAL(4,2),
    total_registros INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_est_diaria_zona
        FOREIGN KEY (id_zona) REFERENCES zona_invernadero(id_zona)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT uq_est_diaria UNIQUE (id_zona, fecha)
) ENGINE=InnoDB;



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



USE greenmonitor_db;

DELIMITER $$

DROP TRIGGER IF EXISTS trg_bitacora_registro_ambiental $$
CREATE TRIGGER trg_bitacora_registro_ambiental
AFTER INSERT ON registro_ambiental
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_acceso (id_usuario, accion, detalle, ip_origen)
    VALUES (NULL, 'INSERT_REGISTRO_AMBIENTAL', CONCAT('Se insertó el registro ambiental ID ', NEW.id_registro), 'LOCAL');
END $$

DELIMITER ;

-- Nota:
-- La generación completa de alertas se implementa en la capa de aplicación porque algunas reglas son compuestas.
-- El trigger documenta la trazabilidad de inserción, mientras que la lógica de negocio evalúa condiciones simples y compuestas.
