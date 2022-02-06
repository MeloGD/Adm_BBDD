-- Departamentos
INSERT INTO public.departamento (departamento_id, nombre)
VALUES (DEFAULT, 'Financiero');

INSERT INTO public.departamento (departamento_id, nombre)
VALUES (DEFAULT, 'Recursos humanos');

INSERT INTO public.departamento (departamento_id, nombre)
VALUES (DEFAULT, 'Marketing');

INSERT INTO public.departamento (departamento_id, nombre)
VALUES (DEFAULT, 'Logística');

INSERT INTO public.departamento (departamento_id, nombre)
VALUES (DEFAULT, 'Operaciones');

-- Edifcios
INSERT INTO public.edificio (edificio_id, nombre, direccion, tipo)
VALUES (DEFAULT, 'Oficina 1', 'C/ calle', 0);

INSERT INTO public.edificio (edificio_id, nombre, direccion, tipo)
VALUES (DEFAULT, 'Oficina 2', 'C/ calle', 0);

INSERT INTO public.edificio (edificio_id, nombre, direccion, tipo)
VALUES (DEFAULT, 'Almacén 1', 'C/ calle', 1);

INSERT INTO public.edificio (edificio_id, nombre, direccion, tipo)
VALUES (DEFAULT, 'Almacén 2', 'C/ calle', 1);

INSERT INTO public.edificio (edificio_id, nombre, direccion, tipo)
VALUES (DEFAULT, 'Almacén 3', 'C/ calle', 1);

-- Empleados
INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('00000000', 'Administrativo 1', 'ES7921000813610123456789', 0, 1, 1);

INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('00000001', 'Administrativo 2', 'ES7921000813610123456789', 0, 2, 1);

INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('00000002', 'Administrativo 3', 'ES7921000813610123456789', 0, 2, 2);

INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('00000003', 'Operador 1', 'ES7921000813610123456789', 1, 5, 3);

INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('00000004', 'Chofer 1', 'ES7921000813610123456789', 2, 5, 3);

INSERT INTO public.empleado (dni, nombre_completo, iban, rol, departamento_id, edificio_id)
VALUES ('00000005', 'Chofer 2', 'ES7921000813610123456789', 2, 5, 5);

-- Turnos
INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000000', '2022-02-04 22:25:00.000000', '2022-02-05 04:25:15.000000', null);

INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000000', '2022-03-05 08:00:00.000000', '2022-03-05 17:30:00.000000', null);

INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000001', '2022-03-05 08:00:00.000000', '2022-03-05 14:30:00.000000', null);

INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000003', '2022-02-04 09:00:00.000000', '2022-02-04 16:00:00.000000', null);

INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000004', '2021-12-20 16:00:00.000000', '2021-12-21 02:15:12.000000', null);

--Clientes
INSERT INTO public.cliente (cliente_id, nombre, telefono, email, gestor)
VALUES (DEFAULT, 'Cliente 1', '900000000', 'email1@doamin.tld', '00000000');

INSERT INTO public.cliente (cliente_id, nombre, telefono, email, gestor)
VALUES (DEFAULT, 'Cliente 2', '900000001', 'email2@doamin.tld', '00000000');

INSERT INTO public.cliente (cliente_id, nombre, telefono, email, gestor)
VALUES (DEFAULT, 'Cliente 3', '900000002', 'email3@doamin.tld', '00000001');

INSERT INTO public.cliente (cliente_id, nombre, telefono, email, gestor)
VALUES (DEFAULT, 'Cliente 4', '900000003', 'email4@doamin.tld', '00000001');

-- Factura
INSERT INTO public.factura (factura_id, fecha_de_emision, fecha_de_pago, total)
VALUES (DEFAULT, '2022-02-02', null, DEFAULT);

INSERT INTO public.factura (factura_id, fecha_de_emision, fecha_de_pago, total)
VALUES (DEFAULT, '2022-02-01', null, DEFAULT);

INSERT INTO public.factura (factura_id, fecha_de_emision, fecha_de_pago, total)
VALUES (DEFAULT, '2022-02-06', null, DEFAULT);

INSERT INTO public.factura (factura_id, fecha_de_emision, fecha_de_pago, total)
VALUES (DEFAULT, '2021-02-03', '2021-02-07', DEFAULT);

-- Servicios
INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Puerto', 'Vía láctea', '2022-02-03', '2022-02-04', null, 1, 1, 300.42);

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Puerto', 'Vía láctea', '2022-02-12', '2022-02-12', 'Frigo', 3, 3, 700.00);

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Santa''s workshop', 'Hogar de niños buenos', '2022-12-23', '2022-12-24',
        'Asegurarse de que los niños no los ven', 2, 2, 2512.22);

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Vía láctea', 'Andromeda', '2022-02-05', '2023-02-04', null, 4, 4, 35000.12);

INSERT INTO public.servicio (servicio_id, punto_de_recogida, punto_de_entrega, fecha_de_recogida, fecha_de_entrega,
                             requisitos_especiales, cliente_id, factura_id, coste)
VALUES (DEFAULT, 'Andromeda', 'Vía láctea', '2023-02-04', '2024-02-04', null, 4, 4, 20000.48);

-- Pale
INSERT INTO public.pale (pale_id, servicio_id, estado)
VALUES (DEFAULT, 1, 3);

INSERT INTO public.pale (pale_id, servicio_id, estado)
VALUES (DEFAULT, 2, 0);

INSERT INTO public.pale (pale_id, servicio_id, estado)
VALUES (DEFAULT, 3, 2);

INSERT INTO public.pale (pale_id, servicio_id, estado)
VALUES (DEFAULT, 4, 1);

INSERT INTO public.pale (pale_id, servicio_id, estado)
VALUES (DEFAULT, 1, 1);

INSERT INTO public.pale (pale_id, servicio_id, estado)
VALUES (1, 2, 0);

-- Almacena
INSERT INTO public.almacen_almacena_pale (edificio_id, pale_id, servicio_id, comienzo, final)
VALUES (3, 3, 3, '2022-02-04 23:45:51.000000', '2022-02-04 23:52:10.000000');

INSERT INTO public.almacen_almacena_pale (edificio_id, pale_id, servicio_id, comienzo, final)
VALUES (3, 4, 4, '2021-02-04 23:48:15.000000', NULL);

-- Vehiculos
INSERT INTO public.vehiculo (matricula, estado)
VALUES ('3488ABQ', 1);

INSERT INTO public.vehiculo (matricula, estado)
VALUES ('3783JEL', 0);

INSERT INTO public.vehiculo (matricula, estado)
VALUES ('9108ZFP', 0);

-- Conduce Vehiculo
INSERT INTO public.chofer_conduce_vehiculo (dni, matricula, comienzo, final)
VALUES ('00000004', '3488ABQ', '2018-02-05 01:08:17.000000', '2020-02-05 01:08:24.000000');

INSERT INTO public.chofer_conduce_vehiculo (dni, matricula, comienzo, final)
VALUES ('00000005', '3488ABQ', '2020-02-05 01:08:24.000000', '2022-02-02 01:08:52.000000');

INSERT INTO public.chofer_conduce_vehiculo (dni, matricula, comienzo, final)
VALUES ('00000004', '3783JEL ', '2020-02-02 01:08:24.000000', '2022-02-07 01:09:42.000000');

INSERT INTO public.chofer_conduce_vehiculo (dni, matricula, comienzo, final)
VALUES ('00000005', '9108ZFP', '2022-02-01 01:08:52.000000', null);



-- Rutas
INSERT INTO public.ruta (ruta_id, fecha, ruta, matricula)
VALUES (DEFAULT, '2021-02-05', DECODE('96AC0054E91E20EE0383B743AEDAACEB', 'hex'), '3488ABQ ');

INSERT INTO public.ruta (ruta_id, fecha, ruta, matricula)
VALUES (DEFAULT, '2022-02-06', null, '3783JEL');

-- Ruta distribvye
INSERT INTO public.ruta_distribuye_pale (ruta_id, pale_id, servicio_id)
VALUES (1, 1, 1);

INSERT INTO public.ruta_distribuye_pale (ruta_id, pale_id, servicio_id)
VALUES (2, 3, 3);
