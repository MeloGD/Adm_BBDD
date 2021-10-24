# Práctica 2. Introducción a PostgreSQL

### 24/10/2021

## Objetivo
El objetivo de esta práctica es instalar el SGBD postgresql y crear una base de datos de prueba. 

## Histórico de comandos

```
usuario@ubuntu:~$ sudo apt-get install postgresql  
postgres=# sudo -u postgres psql
postgres=# CREATE DATABASE pract1;
postgres=# \c pract1
pract1=# create table usuarios (
pract1(# nombre varchar(30),
pract1(# clave varchar(10)
pract1(# );
CREATE TABLE
pract1=# insert into usuarios (nombre, clave) values ('Isa','asdf');
INSERT 0 1
pract1=# insert into usuarios (nombre, clave) values ('Pablo','jfx344');
INSERT 0 1
pract1=# insert into usuarios (nombre, clave) values ('Ana','tru3fal');
INSERT 0 1
pract1=# SELECT * FROM usuarios;
```
![alt text](https://github.com/alu0101060385/pruebaTDD/blob/master/tabla.PNG "Tabla resultante")
