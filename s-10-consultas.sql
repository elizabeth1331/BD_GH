--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 04/01/2021
--@Descripción:REALIZACIÓN DE CONSULTAS

set linesize window
col direccion format A20
col nombre_usuario format A20
col clave format A2
col descripcion format A10

Prompt Consulta inner join notación estandar.
select v.vivienda_id, v.direccion, 
v.es_v_venta as v, v.es_v_renta as r, v.es_v_vacacionar as vv,
v.usuario_id,u.nombre_usuario, v.estatus_vivienda_id,
ev.clave, ev.descripcion
from vivienda v
join usuario u
on v.usuario_id = u.usuario_id
join estatus_vivienda ev
on v.estatus_vivienda_id = ev.estatus_vivienda_id;

Prompt Consulta datos de vivienda y su subtipo (left outer join).
select v.vivienda_id, v.direccion, to_char(vvent.num_catastral) as num_catastral, 
vvent.folio,vvent.precio_inicial,vr.renta_mensual, vr.dia_deposito,
vvac.deposito, vvac.costo_dia, vvac.max_dias
from vivienda v
left outer join vivienda_venta vvent
on v.vivienda_id = vvent.vivienda_id
left outer join vivienda_renta vr
on v.vivienda_id = vr.vivienda_id
left outer join vivienda_vacacionar vvac
on v.vivienda_id = vvac.vivienda_id;

Prompt Consulta de usuarios con tarjetas vigentes desde el año 2021 hasta 2023 con algebra relacional y subconsulta en el from
select u.usuario_id,u.nombre_usuario, u.email, tc.anio_exp, 
  to_char(tc.num_tarjeta) as num_tarjeta
from usuario u, tarjeta_credito tc
where u.usuario_id = tc.usuario_id
minus
select u.usuario_id,u.nombre_usuario, u.email, q.anio_exp, 
  to_char(q.num_tarjeta) as num_tarjeta
from(
  	select *
      from tarjeta_credito tc
    where tc.anio_exp < 2021
    union
  	select *
      from tarjeta_credito tc
    where tc.anio_exp > 2023
)q, usuario u
where q.usuario_id = u.usuario_id 
;

Prompt Consulta de usuarios asociados a viviendas con union
select u.nombre_usuario,u.nombre,u.ap_paterno,u.ap_materno,u.email,u.contrasena
from  usuario u
natural join vivienda 
natural join vivienda_renta 
  union  
select u.nombre_usuario,u.nombre,u.ap_paterno,u.ap_materno,u.email,u.contrasena
from  usuario u
natural join vivienda  
join vivienda_venta 
using(vivienda_id)
  union 
select u.nombre_usuario,u.nombre,u.ap_paterno,u.ap_materno,u.email,u.contrasena
from  usuario u
natural join vivienda 
natural join vivienda_vacacionar;

Prompt Consulta con función de agregación (mostrar el precio total de alquilar una vivienda).
select vivienda_id, costo_dia, max_dias,
sum(costo_dia*max_dias) as costo_total
from vivienda_vacacionar
group by vivienda_id, costo_dia, max_dias
having sum(costo_dia*max_dias) > 15000;


Prompt Consulta con subconsulta en el select.
select vivienda_id, num_pago, importe, (
  select max(importe)
  from pago_vivienda
) as mayor_importe_pagado
from pago_vivienda
where num_pago < 3;

Prompt Consulta con sinonimo realizada por usuario invitado
Prompt Conectando con usuario invitado
connect mg_proy_invitado/mg;
select u.nombre_usuario as usuario_dueño, v.vivienda_id, v.direccion, 
s.nombre, s.descripcion
from usuario u, vivienda v, vivienda_servicio vs, servicio s
where u.usuario_id = v.usuario_id
and v.vivienda_id = vs.vivienda_id
and vs.servicio_id = s.servicio_id
and v.vivienda_id <= 2;
disconnect;

connect gm_proy_admin/mg;
