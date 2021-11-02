DROP DATABASE IF EXISTS viveros;
CREATE DATABASE viveros;
\c viveros;

DROP TABLE IF EXISTS Vivero ;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS Vivero (
  Nombre VARCHAR(30) NOT NULL,
  Localidad VARCHAR(45) NULL,
  Latitud INT NULL,
  Longitud INT NULL,
  PRIMARY KEY (Nombre))
;


-- SQLINES DEMO *** ------------------------------------
-- Table Zona
-- SQLINES DEMO *** ------------------------------------
DROP TABLE IF EXISTS Zona ;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS Zona (
  Nombre VARCHAR(50) NOT NULL,
  Vivero_Nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (Nombre)
 ,
  CONSTRAINT fk_Zona_Vivero
    FOREIGN KEY (Vivero_Nombre)
    REFERENCES Vivero (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_Zona_Vivero_id ON Zona (Vivero_Nombre);


-- SQLINES DEMO *** ------------------------------------
-- Table Producto
-- SQLINES DEMO *** ------------------------------------
DROP TABLE IF EXISTS Producto ;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE SEQUENCE Producto_seq;

CREATE TABLE IF NOT EXISTS Producto (
  Código INT NOT NULL,
  Precio DOUBLE PRECISION NULL,
  Stock INT DEFAULT NEXTVAL ('Producto_seq'),
  PRIMARY KEY (Código))
;


-- SQLINES DEMO *** ------------------------------------
-- Table Cliente
-- SQLINES DEMO *** ------------------------------------
DROP TABLE IF EXISTS Cliente ;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE SEQUENCE Cliente_seq;

CREATE SEQUENCE Cliente_seq2;

CREATE TABLE IF NOT EXISTS Cliente (
  DNI VARCHAR(9) NOT NULL,
  Bonificacion DOUBLE PRECISION DEFAULT NEXTVAL ('Cliente_seq'),
  Total_mensual DOUBLE PRECISION DEFAULT NEXTVAL ('Cliente_seq2'),
  PRIMARY KEY (DNI))
  ;


-- SQLINES DEMO *** ------------------------------------
-- Table Empleado
-- SQLINES DEMO *** ------------------------------------
DROP TABLE IF EXISTS Empleado ;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS Empleado (
  DNI INT NOT NULL,
  Sueldo DOUBLE PRECISION NULL,
  Antiguedad INT NULL,
  Css INT NULL,
  PRIMARY KEY (DNI))
;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** s_Cliente
-- SQLINES DEMO *** ------------------------------------
DROP TABLE IF EXISTS Producto_has_Cliente ;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS Producto_has_Cliente (
  Producto_Código INT NOT NULL,
  Cliente_DNI VARCHAR(9) NOT NULL,
  Cantidad INT NULL,
  Fecha DATE NOT NULL,
  Empleado_DNI INT NOT NULL,
  PRIMARY KEY (Producto_Código, Cliente_DNI, Fecha, Empleado_DNI)
 ,
  CONSTRAINT fk_Producto_has_Cliente_Producto1
    FOREIGN KEY (Producto_Código)
    REFERENCES Producto (Código)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Producto_has_Cliente_Cliente1
    FOREIGN KEY (Cliente_DNI)
    REFERENCES Cliente (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Producto_has_Cliente_Empleado1
    FOREIGN KEY (Empleado_DNI)
    REFERENCES Empleado (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_Producto_has_Cliente_Cliente1_id ON Producto_has_Cliente (Cliente_DNI);
CREATE INDEX fk_Producto_has_Cliente_Producto1_id ON Producto_has_Cliente (Producto_Código);
CREATE INDEX fk_Producto_has_Cliente_Empleado1_id ON Producto_has_Cliente (Empleado_DNI);


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** s_Zona
-- SQLINES DEMO *** ------------------------------------
DROP TABLE IF EXISTS Empleado_has_Zona ;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE SEQUENCE Empleado_has_Zona_seq;

CREATE TABLE IF NOT EXISTS Empleado_has_Zona (
  Empleado_DNI INT NOT NULL,
  Zona_Nombre VARCHAR(50) NOT NULL,
  Fecha_ini DATE NOT NULL,
  Fecha_fin DATE NULL,
  Ventas INT DEFAULT NEXTVAL ('Empleado_has_Zona_seq'),
  PRIMARY KEY (Empleado_DNI, Zona_Nombre, Fecha_ini),
  CONSTRAINT fk_Empleado_has_Zona1_Empleado1
    FOREIGN KEY (Empleado_DNI)
    REFERENCES Empleado (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Empleado_has_Zona1_Zona1
    FOREIGN KEY (Zona_Nombre)
    REFERENCES Zona (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_Empleado_has_Zona1_Zona1_id ON Empleado_has_Zona (Zona_Nombre);
CREATE INDEX fk_Empleado_has_Zona1_Empleado1_id ON Empleado_has_Zona (Empleado_DNI);


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** s_Zona
-- SQLINES DEMO *** ------------------------------------
DROP TABLE IF EXISTS Producto_has_Zona ;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS Producto_has_Zona (
  Producto_Código INT NOT NULL,
  Zona_Nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (Producto_Código, Zona_Nombre)
 ,
  CONSTRAINT fk_Producto_has_Zona_Producto1
    FOREIGN KEY (Producto_Código)
    REFERENCES Producto (Código)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Producto_has_Zona_Zona1
    FOREIGN KEY (Zona_Nombre)
    REFERENCES Zona (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX fk_Producto_has_Zona_Zona1_id ON Producto_has_Zona (Zona_Nombre);
CREATE INDEX fk_Producto_has_Zona_Producto1_id ON Producto_has_Zona (Producto_Código);


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** vero
-- SQLINES DEMO *** ------------------------------------
START TRANSACTION;
INSERT INTO Vivero (Nombre, Localidad, Latitud, Longitud) VALUES ('Flores Pepe', 'Garachico', 1245, 02346);
INSERT INTO Vivero (Nombre, Localidad, Latitud, Longitud) VALUES ('Plantas Lucia', 'La Laguna', 44521, 45572);
INSERT INTO Vivero (Nombre, Localidad, Latitud, Longitud) VALUES ('Vivero Juan', 'Tegueste', 1344, 1354);

COMMIT;


-- SQLINES DEMO *** ------------------------------------
-- Data for table Zona
-- SQLINES DEMO *** ------------------------------------
START TRANSACTION;
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Almacen', 'Flores Pepe');
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Recogida', 'Vivero Juan');
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Entrega', 'Plantas Lucia');

COMMIT;


START TRANSACTION;
INSERT INTO Cliente (DNI, Bonificacion, Total_mensual) VALUES (543274, 1, 15);
INSERT INTO Cliente (DNI, Bonificacion, Total_mensual) VALUES (543275, 5, 10);
INSERT INTO Cliente (DNI, Bonificacion, Total_mensual) VALUES (543276, 1, 50);

COMMIT;

START TRANSACTION;
INSERT INTO Producto (Código, Precio, Stock) VALUES (13244, 1, NULL);
INSERT INTO Producto (Código, Precio, Stock) VALUES (13154, 2, NULL);
INSERT INTO Producto (Código, Precio, Stock) VALUES (13486, 0.5, NULL);

COMMIT;

START TRANSACTION;
INSERT INTO Empleado (DNI, Sueldo, Antiguedad, Css) VALUES (1245, 1200, 2, 124);
INSERT INTO Empleado (DNI, Sueldo, Antiguedad, Css) VALUES (1478, 1500, 4, 245);
INSERT INTO Empleado (DNI, Sueldo, Antiguedad, Css) VALUES (1369, 1000, 1, 785);

COMMIT;

START TRANSACTION;
INSERT INTO Producto_has_Cliente (Producto_Código, Cliente_DNI, Cantidad, Fecha, Empleado_DNI) VALUES (13244, 543274, NULL, '01/01/2017', 1245);
INSERT INTO Producto_has_Cliente (Producto_Código, Cliente_DNI, Cantidad, Fecha, Empleado_DNI) VALUES (13154, 543275, NULL, '04/06/2017', 1478);
INSERT INTO Producto_has_Cliente (Producto_Código, Cliente_DNI, Cantidad, Fecha, Empleado_DNI) VALUES (13486, 543276, NULL, '11/01/2021', 1369);

COMMIT;

START TRANSACTION;
INSERT INTO Empleado_has_Zona (Empleado_DNI, Zona_Nombre, Fecha_ini, Fecha_fin, Ventas) VALUES (1245, 'Almacen', '02/02/2016', '12/03/2021', NULL);
INSERT INTO Empleado_has_Zona (Empleado_DNI, Zona_Nombre, Fecha_ini, Fecha_fin, Ventas) VALUES (1478, 'Recogida', '11/01/2021', '02/01/2021', NULL);
INSERT INTO Empleado_has_Zona (Empleado_DNI, Zona_Nombre, Fecha_ini, Fecha_fin, Ventas) VALUES (1369, 'Entrega', '07/06/2003', '07/06/2010', NULL);

COMMIT;

START TRANSACTION;
INSERT INTO Producto_has_Zona (Producto_código, Zona_Nombre) VALUES (13244, 'Almacen');
INSERT INTO Producto_has_Zona (Producto_código, Zona_Nombre) VALUES (13154, 'Entrega');

COMMIT;
