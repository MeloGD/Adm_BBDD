DROP DATABASE IF EXISTS viveros;
CREATE DATABASE viveros;
\c viveros;

DROP TABLE IF EXISTS Vivero ;

CREATE TABLE IF NOT EXISTS Vivero (
  Nombre VARCHAR(30) NOT NULL,
  Localidad VARCHAR(45) NULL,
  Latitud INT NULL,
  Longitud INT NULL,
  PRIMARY KEY (Nombre))
;


DROP TABLE IF EXISTS Zona ;

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

DROP TABLE IF EXISTS Producto ;

CREATE SEQUENCE Producto_seq;

CREATE TABLE IF NOT EXISTS Producto (
  Código INT NOT NULL,
  Precio DOUBLE PRECISION NULL,
  Stock INT DEFAULT NEXTVAL ('Producto_seq'),
  PRIMARY KEY (Código))
;


DROP TABLE IF EXISTS Cliente ;

CREATE SEQUENCE Cliente_seq;

CREATE SEQUENCE Cliente_seq2;

CREATE TABLE IF NOT EXISTS Cliente (
  Nombre VARCHAR,
  Apellido1 VARCHAR,
  Apellido2 VARCHAR,
  DNI VARCHAR(9) NOT NULL,
  Email VARCHAR(50),
  Bonificacion DOUBLE PRECISION DEFAULT NEXTVAL ('Cliente_seq'),
  Total_mensual DOUBLE PRECISION DEFAULT NEXTVAL ('Cliente_seq2'),
  PRIMARY KEY (DNI))
  ;


DROP TABLE IF EXISTS Municipio ;

CREATE TABLE IF NOT EXISTS Municipio (
  Nombre VARCHAR(30) NOT NULL,
  Vivienda VARCHAR(45),
  Cliente_DNI VARCHAR(9),

  CONSTRAINT fk_Cliente
    FOREIGN KEY (Cliente_DNI)
    REFERENCES Cliente (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;



DROP TABLE IF EXISTS Empleado ;

CREATE TABLE IF NOT EXISTS Empleado (
  DNI INT NOT NULL,
  Sueldo DOUBLE PRECISION NULL,
  Antiguedad INT NULL,
  Css INT NULL,
  PRIMARY KEY (DNI))
;


DROP TABLE IF EXISTS Producto_has_Cliente ;

CREATE TABLE IF NOT EXISTS Producto_has_Cliente (
  Producto_Código INT NOT NULL,
  Cliente_DNI VARCHAR(9) NOT NULL,
  Cantidad INT NULL,
  --Fecha DATE NOT NULL,
  Fecha TIMESTAMP NOT NULL,
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


DROP TABLE IF EXISTS Empleado_has_Zona ;

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


DROP TABLE IF EXISTS Producto_has_Zona ;

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

-- TRIGGERS --------------------------------------------

CREATE OR REPLACE FUNCTION crear_email() RETURNS TRIGGER AS $example_table$
	BEGIN
		IF new.Email IS NULL THEN
		new.Email := concat(new.Nombre,new.Apellido1,'@',TG_ARGV[0]);
		END IF;
		IF new.Email IS NOT NULL THEN
			IF new.Email !~ '^[a-zA-Z0-9_.+-]+@(?:(?:[a-zA-Z0-9-]+\.)?[a-zA-Z]+\.)?(gmail|yahoo)\.com$' THEN
			RAISE EXCEPTION '% wrong email type', new.Email;
			END IF;
		END IF;
		RETURN new;
	END;
$example_table$ LANGUAGE plpgsql;

CREATE TRIGGER email_trigger BEFORE INSERT OR UPDATE ON CLIENTE 
FOR EACH ROW EXECUTE PROCEDURE crear_email('gmail.com');


CREATE OR REPLACE FUNCTION stock_update() RETURNS TRIGGER AS $example_dinero$
	DECLARE
		stock_inicial integer := (SELECT Stock FROM Producto WHERE Código = new.Producto_Código);
	BEGIN
    IF (new.Cantidad <= stock_inicial) THEN
      UPDATE Producto SET Stock = (stock_inicial - new.Cantidad) WHERE Código = new.Producto_Código;
    END IF;
    IF (new.Cantidad > stock_inicial) THEN
      RAISE EXCEPTION 'La venta de producto supera al stock actual';
    END IF;
    RETURN new;
	END;
$example_dinero$ LANGUAGE plpgsql;

CREATE TRIGGER stock_update AFTER INSERT OR UPDATE ON Producto_has_Cliente
FOR EACH ROW EXECUTE PROCEDURE stock_update();


CREATE OR REPLACE FUNCTION check_catastro() RETURNS TRIGGER AS $example_catastro$
	BEGIN
		IF (SELECT EXISTS(SELECT Nombre FROM Municipio WHERE Nombre = New.Nombre)) THEN
			IF (SELECT EXISTS(SELECT Vivienda FROM Municipio WHERE Vivienda = New.Vivienda)) THEN
        IF (SELECT EXISTS(SELECT Cliente_DNI FROM Municipio WHERE Cliente_DNI = New.Cliente_DNI)) THEN
          RAISE EXCEPTION 'Un cliente no puede vivir en dos viviendas diferentes del mismo municipio';
        END IF;
			END IF;
		END IF;
		RETURN new;
		
	END;
$example_catastro$ LANGUAGE plpgsql;

CREATE TRIGGER check_catastro BEFORE INSERT OR UPDATE ON Municipio
FOR EACH ROW EXECUTE PROCEDURE check_catastro();

START TRANSACTION;
INSERT INTO Vivero (Nombre, Localidad, Latitud, Longitud) VALUES ('Flores Pepe', 'Garachico', 1245, 02346);
INSERT INTO Vivero (Nombre, Localidad, Latitud, Longitud) VALUES ('Plantas Lucia', 'La Laguna', 44521, 45572);
INSERT INTO Vivero (Nombre, Localidad, Latitud, Longitud) VALUES ('Vivero Juan', 'Tegueste', 1344, 1354);

COMMIT;


START TRANSACTION;
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Almacen', 'Flores Pepe');
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Recogida', 'Vivero Juan');
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Entrega', 'Plantas Lucia');

COMMIT;


START TRANSACTION;
INSERT INTO Cliente (Nombre, Apellido1, Apellido2, DNI, Email, Bonificacion, Total_mensual) VALUES ('Aday', 'Pa', 'Am', 543274, NULL, 1, 15);
INSERT INTO Cliente (Nombre, Apellido1, Apellido2, DNI, Email, Bonificacion, Total_mensual) VALUES ('Jesus', 'Go', 'Do', 543275, NULL, 5, 10);
INSERT INTO Cliente (Nombre, Apellido1, Apellido2, DNI, Email, Bonificacion, Total_mensual) VALUES ('Carlota', 'Ma', 'Mo', 543276, NULL, 1, 50);
--INSERT INTO Cliente (Nombre, Apellido1, Apellido2, DNI, Email, Bonificacion, Total_mensual) VALUES ('OIIOIO', 'xd', 'dx', 5445326, 'iooioi', 1, 50);

COMMIT;

START TRANSACTION;
INSERT INTO Municipio (Nombre, Vivienda, Cliente_DNI) VALUES ('Tacoronte', 'Calle del Olvido', 543276);
INSERT INTO Municipio (Nombre, Vivienda, Cliente_DNI) VALUES ('La Orotava', 'Calle la Zamora', 543275);
INSERT INTO Municipio (Nombre, Vivienda, Cliente_DNI) VALUES ('La Laguna', 'Carretera Palo', 543274);

COMMIT;


START TRANSACTION;
INSERT INTO Producto (Código, Precio, Stock) VALUES (13244, 1, 50);
INSERT INTO Producto (Código, Precio, Stock) VALUES (13154, 2, 50);
INSERT INTO Producto (Código, Precio, Stock) VALUES (13486, 0.5, 50);

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
