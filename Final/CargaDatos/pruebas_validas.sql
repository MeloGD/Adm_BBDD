BEGIN;
SELECT 'Eliminar un empleado' AS INFO;
DELETE FROM empleado WHERE dni = '00000003';


SELECT 'Actualizar turno y comprobar si se han recalculado las horas trabajadas' AS INFO;
UPDATE turno SET comienzo = '2022-02-04 21:25:00.000000', final = '2022-02-05 04:25:00.000000' WHERE dni = '00000000' AND comienzo = '2022-02-04 22:25:00.000000';

SELECT __assert((SELECT horas_trabajadas FROM turno WHERE dni = '00000000' AND comienzo = '2022-02-04 21:25:00.000000') = 7, 'Las horas trabajadas no se actualizaron correctamente');

SELECT 'Añadir turno con un el atributo horas_trabajadas definido y comprobar si se ha remplaxzado por el valor correcto' AS INFO;
INSERT INTO public.turno (dni, comienzo, final, horas_trabajadas)
VALUES ('00000000', '2019-02-04 22:25:00.000000', '2019-02-05 04:25:00.000000', 69);

SELECT __assert((SELECT horas_trabajadas FROM turno WHERE dni = '00000000' AND comienzo = '2019-02-04 22:25:00.000000') = 6, 'Las horas trabajadas no se actualizaron correctamente');


SELECT 'Se ha termindo la ejecución del script. Ahora mismo se encuentra en una transacción abierta, hecha con el objetivo de que pueda observar los cambios realizados por este script sin modificar realmente la base de datos (otros scripts esperan que la base de datos este tal cual la deja inserts,sql). Cuando termine de observar ejecute ROLLBACK para ver los cambios. Tenga en cuenta que la base de datos estara bloqueada para otras sesiones hasta entonces.' AS Mensaje;