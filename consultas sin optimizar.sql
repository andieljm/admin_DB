--activacion de cache manual
alter session set result_cache_mode=manual;
show parameter RESULT_CACHE_MODE;

-- consultas sin optimizar
--1
select p.nombre as empleado,c.nombre as cargo_laboral,e.id_empleado,f.fecha as factura 
FROM personas p,empleados e,cargo_laboral c,factura f
where p.id_persona = e.id_persona and 
c.id_cargo = e.id_cargo 
and f.id_empleado = e.id_empleado;
--2
SELECT p.nombre,p.apellido,co.descripcion as comentario
FROM clientes c,personas p,comentarios co
where p.id_persona = c.id_persona 
and co.id_comentario = c.id_comentario;

--3
select p.nombre as empleado,c.nombre as cargo_laboral,c.descripcion
FROM personas p,empleados e,cargo_laboral c
where p.id_persona = e.id_persona 
and e.id_cargo = c.id_cargo
and e.id_persona = 1;

--4
--solo se requiere el nombre y el apellido
select * FROM personas;

--5
select e.id_empleado,p.nombre,cl.salario
from  personas p,empleados e,cargo_laboral cl
where p.id_persona = e.id_persona and e.id_cargo = cl.id_cargo;

--6
select e.id_empleado,p.nombre,cl.salario
from  personas p,empleados e,cargo_laboral cl
where p.id_persona = e.id_persona and e.id_cargo = cl.id_cargo and 
cl.salario = 150000 or cl.salario > 2000000000;

--7
select * from detallefactura d,factura f
where f.id_detalle = d.id_detalle and f.id_cliente = 1;

--8
select f.fecha,d.id_detalle,f.iva,f.total from detallefactura d,factura f
where f.id_detalle = d.id_detalle and f.total = 100000 or f.total < 50000;

--9
select * from servicios s
where s.id_servicio in (2,3,4,5);

--10
select * from tipo_paquete t
where upper(t.nombre) = 'NORMAL';

--11
select r.id_reservacion,r.nombre,r.descripcion from clientes c,reservaciones r
where substr(to_char(c.id_reservacion),1) = substr(to_char(r.id_reservacion),1);

--12
SELECT u.id_usuario,u.nombre, decode(r.id_rol,2,'cajeros','administrador') as usuario
FROM usuarios u, rol r
where u.id_rol = r.id_rol;

-- consultas optimizadas
--1
select /* RESULT_CACHE  */ p.nombre as empleado,c.nombre as cargo_laboral,e.id_empleado,f.fecha as factura 
FROM personas p 
inner join empleados e
on p.id_persona = e.id_persona
INNER JOIN cargo_laboral c
on e.id_cargo = c.id_cargo
INNER JOIN factura f
on f.id_empleado = e.id_empleado;

