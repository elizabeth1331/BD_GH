--@Autor(es): GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 01/02/2021
--@Descripción: CREACION DE TRES VISTAS DEL CASO DE ESTUDIO


--En la empresa se implemento el manejo de vitas para controlar el acceso a algunos datos de
--los usuarios, mostrando el mes y año de expedición de la tarjeta de cada uno de los clientes
--esto con la finalidad de crear un registro de dichos usuarios con tarjetas expiradas

create or replace view v_usuario(
nombre_usuario,email
) as select nombre_usuario,email
from(
  select nombre_usuario,email
  from  usuario u
  join vivienda v
  on u.usuario_id=v.usuario_id
  join vivienda_renta r
  on r.vivienda_id=v.vivienda_id
    union  
  select nombre_usuario,email
  from  usuario u
  join vivienda v
  on u.usuario_id=v.usuario_id
  join vivienda_venta ve
  on ve.vivienda_id=v.vivienda_id
    union 
  select nombre_usuario,email
  from  usuario u
  join vivienda v
  on u.usuario_id=v.usuario_id
  join vivienda_vacacionar va
  on va.vivienda_id=v.vivienda_id);


--Vista usada para que los clientes vean las calificaciones y comenatarios de los clientes
--que alquilaron sus casas para vacacionar 

create or replace view v_vivienda_calificacion_arrendatario(
folio,vivienda_id,calificacion,descripcion, fecha
) as select folio,a.vivienda_id, calificacion,descripcion, fecha
from usuario u, calificacion_alquiler cv, alquiler a
where u.usuario_id=cv.usuario_id
and a.alquiler_id=cv.alquiler_id;

--vista para los usuarios busquen alquilar una casa puedan ver la reseñas de las casas a qluilar, ademas de datos de lugar

create or replace view v_vivienda_calificacion_cliente(
nombre_usuario,vivienda_id, calificacion, fecha, direccion, capacidad_max,costo_dia
) as select nombre_usuario,v.vivienda_id, calificacion, fecha, direccion, capacidad_max,costo_dia
from usuario u, calificacion_alquiler cv,  vivienda v, vivienda_vacacionar vv
where u.usuario_id=cv.usuario_id
and v.vivienda_id=vv.vivienda_id
and u.usuario_id=v.usuario_id;