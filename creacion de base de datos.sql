create tablespace tbl_hotel
datafile 'C:\admin_bd\hotel.dbf' size 50M
default storage (initial 1m next 1m pctincrease 0);

/* Creaci�n de usuarios */
--usar este comando si no se tiene la vercion 11 --> alter session set "_ORACLE_SCRIPT"=true;
create user hotel identified by hotel
default tablespace tbl_hotel
temporary tablespace temp;

/* Otorgar permisos */
grant connect,resource to hotel;
/* Asignar quota */
alter user hotel quota unlimited on TBL_hotel;

-- creacion de tablas con el usuario creado anterior mente
-- GENERATED by default on null as IDENTITY es para verciones superiores a la 11c
--tipo de paquete
create table tipo_paquete(
id_tipo_paquete number GENERATED by default on null as IDENTITY primary key,
nombre varchar(20)
)

--datos
insert into tipo_paquete (nombre) values ('normal');
insert into tipo_paquete (nombre) values ('premiun');
insert into tipo_paquete (nombre) values ('platino');

--paquetes
create table paquetes(
id_paquete number(5) GENERATED by default on null as IDENTITY primary key,
descripcion varchar2(50),
id_tipo_paquete number,
CONSTRAINT fk_id_tipo_paquete FOREIGN KEY (id_tipo_paquete) REFERENCES tipo_paquete(id_tipo_paquete)
);

--datos
insert into paquetes (descripcion,id_tipo_paquete) values ('hospedaje por dos dias',1);
insert into paquetes (descripcion,id_tipo_paquete) values ('hospadaje por una semana mas comida incluida',2);
insert into paquetes (descripcion,id_tipo_paquete) values ('hospadeje por dos semanas con servicios',3);

-- reservaciones
create table reservaciones(
id_reservacion number GENERATED by default on null as IDENTITY primary key,
nombre varchar2(20),
descripcion varchar2(50),
id_paquete number(5),
CONSTRAINT fk_id_paquete FOREIGN KEY (id_paquete) REFERENCES paquetes(id_paquete)
);

--datos
insert into reservaciones (nombre,descripcion,id_paquete) values ('oscar','5 personas',1);
insert into reservaciones (nombre,descripcion,id_paquete) values ('pedro','2 personas',2);
insert into reservaciones (nombre,descripcion,id_paquete) values ('fulano','3 personas',3);

--roles
create table rol(
id_rol number GENERATED by default on null as IDENTITY primary key,
nombre varchar2(20),
descripcion varchar2(44)
);

--datos
insert into rol (nombre,descripcion) values ('administrador','encargador de administrar el programa');
insert into rol (nombre,descripcion) values ('empleado','atencion al cliente');

--usuarios
create table usuarios(
id_usuario number GENERATED by default on null as IDENTITY primary key,
id_rol number,
nombre varchar2(20),
clave varchar2(10),
CONSTRAINT fk_id_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

--datos
insert into usuarios (id_rol,nombre,clave) values (1,'admin','admin');
insert into usuarios (id_rol,nombre,clave) values (2,'juan','123');
insert into usuarios (id_rol,nombre,clave) values (2,'vanesa','123');

--personas
create table personas(
id_persona number GENERATED by default on null as IDENTITY primary key,
nombre varchar2(10),
apellido varchar2(10),
cedula varchar2(10),
ubicacion varchar2(50)
);

insert into personas (nombre,apellido,cedula,ubicacion) values ('lucas','madrigal','52525','Heredia');
insert into personas (nombre,apellido,cedula,ubicacion) values ('juan','soto','333233','Sanjose');
insert into personas (nombre,apellido,cedula,ubicacion) values ('homero','madrigal','5566','Cartago');
insert into personas (nombre,apellido,cedula,ubicacion) values ('perez','madrigal','12345','Limon');
insert into personas (nombre,apellido,cedula,ubicacion) values ('ronal','venegaz','3324442','Puntarenas');
insert into personas (nombre,apellido,cedula,ubicacion) values ('angie','madrigal','456777','Heredia');

--cargo laboral
create table cargo_laboral(
id_cargo number GENERATED by default on null as IDENTITY primary key,
nombre varchar2(10),
descripcion varchar2(50),
salario float(10)
);

--datos
insert into cargo_laboral (nombre,descripcion,salario) values ('cajero','encargado de facturar',180000);
insert into cargo_laboral (nombre,descripcion,salario) values ('servicios','encargado de los servicios del cliente',200000);
insert into cargo_laboral (nombre,descripcion,salario) values ('conserje','encargado de la limpieza',150000);

--empleados
create table empleados(
id_empleado number GENERATED by default on null as IDENTITY primary key,
id_persona number,
horas_laboradas number,
id_cargo number,
CONSTRAINT fk_id_persona FOREIGN KEY (id_persona) REFERENCES personas(id_persona),
CONSTRAINT fk_id_cargo FOREIGN KEY (id_cargo) REFERENCES cargo_laboral(id_cargo)
);

--datos
insert into empleados (id_persona,horas_laboradas,id_cargo) values (1,999,1);
insert into empleados (id_persona,horas_laboradas,id_cargo) values (2,777,2);
insert into empleados (id_persona,horas_laboradas,id_cargo) values (3,888,3);

--comentarios
create table comentarios(
id_comentario number GENERATED by default on null as IDENTITY primary key,
descripcion varchar2(50)
);

--datos
insert into comentarios (descripcion) values ('pesimo servicio');
insert into comentarios (descripcion) values ('execelente servicio');
insert into comentarios (descripcion) values ('execelente comida');

--clientes
create table clientes(
id_cliente number GENERATED by default on null as IDENTITY primary key,
id_persona number(10),
id_comentario number(10),
id_reservacion number(10),
CONSTRAINT fk_id_personaC FOREIGN KEY (id_persona) REFERENCES personas(id_persona),
CONSTRAINT fk_id_comentarioC FOREIGN KEY (id_comentario) REFERENCES comentarios(id_comentario),
CONSTRAINT fk_id_reservacionC FOREIGN KEY (id_reservacion) REFERENCES reservaciones(id_reservacion)
);

--datos
insert into clientes (id_persona,id_comentario,id_reservacion) values (4,1,1);
insert into clientes (id_persona,id_comentario,id_reservacion) values (5,2,2);
insert into clientes (id_persona,id_comentario,id_reservacion) values (6,3,3);

--tabla tipos de servicios
create table tipo_servicios(
id_tipo_servicio number(5) GENERATED by default on null as IDENTITY primary key,
nombre varchar2(12) not null
)
--datos
insert into tipo_servicios (nombre) VALUES ('Hospedaje');
insert into tipo_servicios (nombre) VALUES ('Visita');
insert into tipo_servicios (nombre) VALUES ('Comida');

--tabla servicios
create table servicios ( 
id_servicio number(5) GENERATED by default on null as IDENTITY primary key,
descripcion VARCHAR2(50) not null,
id_tipo_de_servicio,
CONSTRAINT fk_id_tipo_de_servicio FOREIGN KEY (id_tipo_de_servicio) REFERENCES tipo_servicios(id_tipo_servicio)
);
--datos
insert into servicios (descripcion,id_tipo_de_servicio) VALUES ('Hospedaje de dos dias',1);
insert into servicios (descripcion,id_tipo_de_servicio) VALUES ('Visita el hotel de 12 am a 8 pm',2);
insert into servicios (descripcion,id_tipo_de_servicio) VALUES ('Comida de dos restaurantes diferentes',3);

--dellate factura
create table detallefactura(
id_detalle number GENERATED by default on null as IDENTITY primary key,
descripcion varchar2(50),
id_servicio number,
CONSTRAINT fk_id_servicio FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);
--datos
insert into detallefactura (descripcion,id_servicio) VALUES ('paquete normal,restaurante italiano,iva',1);
insert into detallefactura (descripcion,id_servicio) VALUES ('restaurantes,iva',2);
insert into detallefactura (descripcion,id_servicio) VALUES ('paquete platino,servicios extras,iva',3);
--facturas
create table factura(
id_factura number GENERATED by default on null as IDENTITY primary key,
fecha varchar2(20),
pago varchar2(10),
iva number(10),
total number(10),
id_cliente number(10),
id_empleado number(10),
id_detalle number(10),
CONSTRAINT fk_id_clienteF FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
CONSTRAINT fk_id_empleadoF FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
CONSTRAINT fk_id_detalle FOREIGN KEY (id_detalle) REFERENCES detallefactura(id_detalle)
);
--datos
insert into factura (fecha,pago,iva,total,id_cliente,id_empleado,id_detalle) 
VALUES ('2021-10-05','colones',13,100000,1,1,1);
insert into factura (fecha,pago,iva,total,id_cliente,id_empleado,id_detalle) 
VALUES ('2021-10-10','dolares',13,50000,2,2,2);
insert into factura (fecha,pago,iva,total,id_cliente,id_empleado,id_detalle) 
VALUES ('2021-10-15','euros',13,200000,3,3,3);

