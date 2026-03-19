-- ============================================================
-- BASE DE DATOS: inmobiliaria_db
-- Proyecto: InmobiliariaApp - Sprint 1
-- ============================================================

CREATE DATABASE IF NOT EXISTS inmobiliaria_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE inmobiliaria_db;

-- ------------------------------------------------------------
-- TABLA: roles
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(200)
) ENGINE=InnoDB;

INSERT INTO roles (nombre, descripcion) VALUES
('admin',        'Acceso total al sistema'),
('usuario',      'Solo puede visitar la página'),
('cliente',      'Puede buscar propiedades y solicitar citas'),
('inmobiliaria', 'Gestiona propiedades y solicitudes');

-- ------------------------------------------------------------
-- TABLA: usuarios
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS usuarios (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    apellido    VARCHAR(100) NOT NULL,
    email       VARCHAR(150) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    telefono    VARCHAR(20),
    foto        VARCHAR(255) DEFAULT 'default.png',
    rol_id      INT NOT NULL DEFAULT 2,
    activo      TINYINT(1) DEFAULT 1,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rol_id) REFERENCES roles(id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- TABLA: propiedades
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS propiedades (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    titulo          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    tipo            ENUM('casa','apartamento','terreno','oficina','local') NOT NULL,
    operacion       ENUM('venta','arriendo') NOT NULL,
    precio          DECIMAL(15,2) NOT NULL,
    area_m2         DECIMAL(10,2),
    habitaciones    INT DEFAULT 0,
    banos           INT DEFAULT 0,
    parqueaderos    INT DEFAULT 0,
    direccion       VARCHAR(255),
    ciudad          VARCHAR(100),
    barrio          VARCHAR(100),
    foto_principal  VARCHAR(255) DEFAULT 'prop_default.jpg',
    disponible      TINYINT(1) DEFAULT 1,
    usuario_id      INT NOT NULL,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- TABLA: citas
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS citas (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id      INT NOT NULL,
    propiedad_id    INT NOT NULL,
    fecha_cita      DATETIME NOT NULL,
    mensaje         TEXT,
    estado          ENUM('pendiente','confirmada','cancelada','completada') DEFAULT 'pendiente',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id)   REFERENCES usuarios(id),
    FOREIGN KEY (propiedad_id) REFERENCES propiedades(id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- TABLA: solicitudes (papeles de compra/arriendo)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS solicitudes (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id      INT NOT NULL,
    propiedad_id    INT NOT NULL,
    tipo            ENUM('compra','arriendo') NOT NULL,
    estado          ENUM('pendiente','en_revision','aprobada','rechazada') DEFAULT 'pendiente',
    documentos      VARCHAR(255),
    notas           TEXT,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id)   REFERENCES usuarios(id),
    FOREIGN KEY (propiedad_id) REFERENCES propiedades(id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- DATOS DE PRUEBA
-- ------------------------------------------------------------

-- Admin por defecto (password: Admin123!)
INSERT INTO usuarios (nombre, apellido, email, password, rol_id) VALUES
('Admin', 'Sistema', 'admin@inmobiliaria.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lbu2', 1);

-- Usuario inmobiliaria de prueba (password: Inmo123!)
INSERT INTO usuarios (nombre, apellido, email, password, rol_id) VALUES
('Carlos', 'Ramirez', 'inmo@inmobiliaria.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lbu2', 4);

-- Propiedades de ejemplo
INSERT INTO propiedades (titulo, descripcion, tipo, operacion, precio, area_m2, habitaciones, banos, ciudad, barrio, usuario_id) VALUES
('Apartamento moderno en Cabecera', 'Hermoso apartamento con vista a la ciudad, totalmente remodelado', 'apartamento', 'arriendo', 1800000, 75, 3, 2, 'Bucaramanga', 'Cabecera', 2),
('Casa campestre en Lagos', 'Amplia casa con jardín y piscina privada en zona residencial', 'casa', 'venta', 450000000, 200, 4, 3, 'Bucaramanga', 'Lagos del Cacique', 2),
('Local comercial centro', 'Local en primer piso, alto flujo peatonal, ideal para negocio', 'local', 'arriendo', 2500000, 45, 0, 1, 'Bucaramanga', 'Centro', 2),
('Terreno en Floridablanca', 'Terreno plano con todos los servicios, excelente ubicación', 'terreno', 'venta', 120000000, 300, 0, 0, 'Floridablanca', 'Villabel', 2);

