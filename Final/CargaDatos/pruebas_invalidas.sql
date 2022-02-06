SELECT 'Eliminar departamento con empleados' AS INFO;

DELETE FROM departamento WHERE departamento_id = 1;

------

SELECT 'Añadir departamento sin nombre' AS INFO;
INSERT INTO public.departamento (departamento_id, nombre)
VALUES (DEFAULT, NULL);

------

SELECT 'Añadir empleado con (dni, nombre, iban, rol, departamento, edificio) nulo' AS INFO;
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES (NULL, 'Invalido', 'ES7921000813610123456789', 0, 1, 1);
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('99999999', NULL, 'ES7921000813610123456789', 0, 1, 1);
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('99999999', 'Invalido', NULL, 0, 1, 1);
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('99999999', 'Invalido', 'ES7921000813610123456789', NULL, 1, 1);
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('99999999', 'Invalido', 'ES7921000813610123456789', 0, NULL, 1);
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('99999999', 'Invalido', 'ES7921000813610123456789', 0, 1, NULL);

------

SELECT 'Añadir empleado con rol invalido' AS INFO;
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('99999999', 'Invalido', 'ES7921000813610123456789', 42, 1, 1);

------

SELECT 'Ubicar un administrativo en un almacen' AS INFO;
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('99999999', 'Invalido', 'ES7921000813610123456789', 0, 1, 3);

------

SELECT 'Ubicar un operador en una oficina' AS INFO;
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('99999999', 'Invalido', 'ES7921000813610123456789', 1, 1, 1);

------

SELECT 'Ubicar un chofer en una oficina' AS INFO;
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('99999999', 'Invalido', 'ES7921000813610123456789', 2, 1, 1);

------

SELECT 'Añadir turno con (dni, comeynzo y final) nulo' AS INFO;
INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES (NULL, '2019-02-04 22:25:00.000000', '2019-02-05 04:25:15.000000', null);

INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000000', NULL, '2019-02-05 04:25:15.000000', null);

INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000000', '2019-02-04 22:25:00.000000', NULL, null);

------

SELECT 'Añadir turno solapado a un empleado (solapamiento completo, parcial por la izquierda, parcial por la derecha)' AS INFO;
INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000000', '2022-03-05 10:00:00.000000', '2022-03-05 12:30:00.000000', null);

INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000000', '2022-03-05 07:00:00.000000', '2022-03-05 12:30:00.000000', null);

INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000000', '2022-03-05 17:29:00.000000', '2022-03-05 20:30:00.000000', null);

------

SELECT 'Añadir turno con fecha de inicio posterior a la de finalización' AS INFO;
INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000000', '2019-02-05 04:25:00.000000', '2019-02-04 22:25:00.000000', null);

------

SELECT 'Añadir cliente con (nombre, telefono, email, gestor) nulo' AS INFO;

INSERT INTO public.cliente (cliente_id, nombre, telefono, email, gestor)
VALUES (DEFAULT, NULL, '900000000', 'invalido@doamin.tld', '00000000');

INSERT INTO public.cliente (cliente_id, nombre, telefono, email, gestor)
VALUES (DEFAULT, 'Invalido', NULL, 'invalido@doamin.tld', '00000000');

INSERT INTO public.cliente (cliente_id, nombre, telefono, email, gestor)
VALUES (DEFAULT, 'Invalido', '900000000',NULL, '00000000');

INSERT INTO public.cliente (cliente_id, nombre, telefono, email, gestor)
VALUES (DEFAULT, 'Invalido', '900000000', 'invalido@doamin.tld', NULL);

------

SELECT 'Añadir cliente con email duplicado' AS INFO;
INSERT INTO public.cliente (cliente_id, nombre, telefono, email, gestor)
VALUES (DEFAULT, 'Invalido', '900000000', 'email1@doamin.tld', '00000000');

------

SELECT 'Actualizar cliente con email duplicado' AS INFO;
UPDATE cliente SET email = 'email1@doamin.tld' WHERE cliente_id = 2; 

------

SELECT 'Añadir cliente con email invalido' AS INFO;
INSERT INTO public.cliente (cliente_id, nombre, telefono, email, gestor)
VALUES (DEFAULT, 'Invalido', '900000000', 'not-an-email', '00000000');

------

SELECT 'Actualizar cliente con email invalido' AS INFO;
UPDATE cliente SET email = 'not-an-email' WHERE cliente_id = 2; 

------

SELECT 'Añadir servicio con (punto_recogida, punto_entrega, fecha_recogida, fecha_entrega) nulo' AS INFO;

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, NULL, 'Invalido', '2022-02-03', '2022-02-04', null, 1, 1, 300.42);

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Invalido', NULL, '2022-02-03', '2022-02-04', null, 1, 1, 300.42);

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Invalido', 'Invalido', NULL, '2022-02-04', null, 1, 1, 300.42);

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Invalido', 'Invalido', '2022-02-03', NULL, null, 1, 1, 300.42);

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Invalido', 'Invalido', '2022-02-03', '2022-02-04', null, NULL, 1, 300.42);

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Invalido', 'Invalido', '2022-02-03', '2022-02-04', null, 1, NULL, 300.42);

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Invalido', 'Invalido', '2022-02-03', '2022-02-04', null, 1, 1, NULL);

------

SELECT 'Añadir servicio con fecha de entrega anterior a la de recogida' AS INFO;

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Invalido', 'Invalido', '2022-02-07', '2022-02-04', null, 1, 1, 300.42);

------

SELECT 'Añadir factura con fecha emision nula' AS INFO;
INSERT INTO public.factura (factura_id, fecha_de_emision, fecha_de_pago, total)
VALUES (DEFAULT, NULL, null, DEFAULT);

------

SELECT 'Añadir factura con fecha emision posterior a la de pago' AS INFO;

INSERT INTO public.factura (factura_id, fecha_de_emision, fecha_de_pago, total)
VALUES (DEFAULT, '2022-02-02', '2022-02-01', DEFAULT);

------

SELECT 'Eliminar factura con servicios' AS INFO;
DELETE FROM factura WHERE factura_id = 1;

------

SELECT 'Añadir pale con estado invalido' AS INFO;
INSERT INTO public.pale (pale_id, servicio_id, estado)
VALUES (20, 2, 68);
INSERT INTO public.pale (pale_id, servicio_id, estado)
VALUES (21, 2, NULL);


------

SELECT 'Marcar pale almacenado como entregado' AS INFO;
UPDATE pale SET estado = 3 WHERE  pale_id = 4 AND servicio_id = 4;

------

SELECT 'Almacenar un pale entregado' AS INFO;
INSERT INTO public.almacen_almacena_pale (edificio_id, pale_id, servicio_id, comienzo, final)
VALUES (3, 1, 1, '2022-02-04 23:45:51.000000', '2022-02-04 23:52:10.000000');

------

SELECT 'Almacenar un pale registrado' AS INFO;
INSERT INTO public.almacen_almacena_pale (edificio_id, pale_id, servicio_id, comienzo, final)
VALUES (3, 2, 2, '2022-02-04 23:45:51.000000', '2022-02-04 23:52:10.000000');

------

SELECT 'Almacenar un pale con fechas solapadas (izquierda, total y derecha)' AS INFO;
INSERT INTO public.almacen_almacena_pale (edificio_id, pale_id, servicio_id, comienzo, final)
VALUES (4, 3, 3, '2021-01-04 23:48:15.000000', NULL);

INSERT INTO public.almacen_almacena_pale (edificio_id, pale_id, servicio_id, comienzo, final)
VALUES (3, 4, 4, '2021-02-04 23:49:15.000000', '2021-02-05 23:48:15.000000');

INSERT INTO public.almacen_almacena_pale (edificio_id, pale_id, servicio_id, comienzo, final)
VALUES (3, 3, 3, '2022-02-04 23:50:10.000000', '2022-02-05 23:48:15.000000');

SELECT 'Almacenar un pale en una oficina' AS INFO;
INSERT INTO public.almacen_almacena_pale (edificio_id, pale_id, servicio_id, comienzo, final)
VALUES (1, 3, 3, '2021-02-04 23:45:51.000000', '2021-02-04 23:52:10.000000');

SELECT 'Almacenar con una fecha de comienzo posteior a la de final' AS INFO;
INSERT INTO public.almacen_almacena_pale (edificio_id, pale_id, servicio_id, comienzo, final)
VALUES (3, 3, 3, '2023-02-04 23:45:51.000000', '2021-02-04 23:52:10.000000');

------

SELECT 'Insertar un vehiculo con estado invalido' AS INFO;
INSERT INTO public.vehiculo (matricula, estado)
VALUES ('3488ABC', 67);

INSERT INTO public.vehiculo (matricula, estado)
VALUES ('3488DBC', NULL);

------

SELECT 'Insertar coduce solapado (izquierda, total, derecha) para un mismo vehiculo' AS INFO;
INSERT INTO public.chofer_conduce_vehiculo (dni, matricula, comienzo, final)
VALUES ('00000004', '3488ABQ', '2018-02-02 01:08:17.000000', '2020-02-05 01:08:24.000000');

INSERT INTO public.chofer_conduce_vehiculo (dni, matricula, comienzo, final)
VALUES ('00000004', '3488ABQ', '2018-02-07 01:08:17.000000', '2020-02-03 01:08:24.000000');

INSERT INTO public.chofer_conduce_vehiculo (dni, matricula, comienzo, final)
VALUES ('00000004', '3488ABQ', '2020-02-03 01:08:17.000000', NULL);

------

SELECT 'Insertar un edifico con un tipo invalido' AS INFO;
INSERT INTO public.edificio (edificio_id, nombre, direccion, tipo)
VALUES (DEFAULT, 'Invalido', 'C/ calle', 201);

