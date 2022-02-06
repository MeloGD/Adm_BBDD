# Proyecto Final: Sistema de bases de datos para empresa logística

Descripcion de los scripts

## CÓDIGO DE COMPONENTES
En esta sección, el script se encarga de ir generando las diversas tablas que describen la base de datos para el problema de la Empresa Logística.  

Por último, tenemos una serie de inicializaciones de "enums" que son usados para insertar los datos compuestos en 
tipos_edificio, roles_empleado, estados_vehiculo y estados_pale.

## CÓDIGO DE PROCEDIMIENTOS DE OPERACIÓN Y SEGURIDAD
En cuanto a los triggers:  
- Validar Empleado: Comprueba que el empleado este asignado a un edificio de tipo adecuado.  
- Validar Cliente: Comprueba que el empleado gestor es administrativo.  
- Validar Turno: Comprueba que los turnos para un mismo empleado no se solapen y calcula las horas trabajadas.  
- Validar Servicio: Comprueba que todos los servicios asignados a una factura sean del mismo cliente y actualiza el total de la factura.  
- Validar Pale: Comprueba que un palé almacenado no se puede marcar como entregado.  
- Recalcular tras eliminar servicio: Actualiza la factura cuando se elimina un servicio.
- Validar almacen almacena: Evita que un palé en estado entregado sea almacenado y que un palé sea almacenado en dos lugares al mismo tiempo.  
- Validar conduce: Evita que un vehículo tenga dos chófers al mismo tiempo.  

En lo refente a seguridad, hemos implementado diversos checks para asegurarnos de que los valores son insertados de manera correcta:  
- En la tabla "turno" hay un check para comprobar que la hora de comienzo del turno sea anterior que la final.  
- En la tabla "cliente" hay un check para comprobar que el email tenga la sintaxis correcta.  
- En la tabla "chofer_conduce_vehiculo" hay un check para comprobar la hora que comienza el vehículo a rodar sea anterior a la de finalización.  
- En la tabla "factura" hay un check que comprueba que la fecha de emisión de la factura sea anterior a la fecha que se realizó pago.  
- En la tabla "servicio" hay un check que comprueba que la fecha de recogida del palé sea anterior a la fecha de entrega.  

## Autores
- J. Carmelo González Domínguez
- Carlota Marrero Morales
- Aday Padilla Amaya
- Claudio Néstor Yanes Mesa.
