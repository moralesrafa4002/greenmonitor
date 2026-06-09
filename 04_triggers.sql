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
