--@Autor(es): GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 07/02/2021
--@Descripción: Prueba procedimiento registro_vivienda.

connect gm_proy_admin/mg

Prompt Creando trigger historico_est_vivienda
@@s-11-tr-historico_est_vivienda.sql
Prompt Creando procedimiento registro_vivienda
@@s-13-p-registro-vivienda.sql

set serveroutput on
begin
  dbms_output.put_line('Realizando inserción de vivienda para comprar');
  registro_vivienda(
    p_direccion 			=>	'Av. de las fuentes 453, Jardines del Pedregal, Álvaro Obregón, 1900, Ciudadad de México,CDMX',
    p_longitud				=> 	19.327122,
    p_latitud				=>  -99.205315,
    p_capacidad				=>  6,
    p_descripcion			=>  'Casa mediana en la ciudad',
    p_fecha_status			=>  sysdate, 
    p_es_v_venta			=>  1,
    p_es_v_renta			=>  0,
    p_es_v_vacacionar		=>  0,
    p_usuario_id 			=>  100,
    p_estaus_vivienda_id	=>  1,
    p_precio_inicial        =>  6000000,
    p_comision              =>  30
  );

  dbms_output.put_line('Realizando inserción de vivienda para renta');
  registro_vivienda(
    p_direccion 			=>	'Lluvia 302, Jardines del Pedregal, Álvaro Obregón, 1900, Ciudadad de México,CDMX',
    p_longitud				=> 	19.325162,
    p_latitud				=>  -99.245315,
    p_capacidad				=>  4,
    p_descripcion			=>  'Casa chica en la ciudad',
    p_fecha_status			=>  sysdate, 
    p_es_v_venta			=>  0,
    p_es_v_renta			=>  1,
    p_es_v_vacacionar		=>  0,
    p_usuario_id 			=>  101,
    p_estaus_vivienda_id	=>  1,
    p_renta_mensual         =>  12000,
    p_dia_deposito          =>  sysdate+20
  );

  dbms_output.put_line('Realizando inserción de vivienda para vacacionar');
  registro_vivienda(
    p_direccion 			=>	'Av. Plan Ayala 340, Cuernavaca Morelos',
    p_longitud				=> 	18.924698,
    p_latitud				=>  -99.222696,
    p_capacidad				=>  5,
    p_descripcion			=>  'Casa mediana para vacacionar',
    p_fecha_status			=>  sysdate, 
    p_es_v_venta			=>  0,
    p_es_v_renta			=>  0,
    p_es_v_vacacionar		=>  1,
    p_usuario_id 			=>  102,
    p_estaus_vivienda_id	=>  1,
    p_deposito              =>  12000,
    p_costo_dia             =>  4000,
    p_max_dias 				=>  12

  );  

  dbms_output.put_line('Realizando inserción de vivienda para vacacionar y rentar');
  registro_vivienda(
    p_direccion       =>  'Av. Plan Ayala 340, Cuernavaca Morelos',
    p_longitud        =>  18.924698,
    p_latitud       =>  -99.222696,
    p_capacidad       =>  5,
    p_descripcion     =>  'Casa mediana para vacacionar',
    p_fecha_status      =>  sysdate, 
    p_es_v_venta      =>  0,
    p_es_v_renta      =>   1,
    p_es_v_vacacionar   =>  1,
    p_usuario_id      =>  103,
    p_estaus_vivienda_id  =>  1,
    p_renta_mensual         =>  12000,
    p_dia_deposito          =>  sysdate+20,
    p_deposito              =>  12000,
    p_costo_dia             =>  4000,
    p_max_dias        =>  12
  );   
/*
  dbms_output.put_line('Realizando inserción de vivienda sin tipo');
  registro_vivienda(
    p_direccion 			=>	'casa con datos erronos',
    p_longitud				=> 	18.924698,
    p_latitud				=>  -99.222696,
    p_capacidad				=>  5,
    p_descripcion			=>  'Casa que provoca error',
    p_fecha_status			=>  sysdate, 
    p_es_v_venta			=>  0,
    p_es_v_renta			=>  0,
    p_es_v_vacacionar		=>  0,
    p_usuario_id 			=>  102,
    p_estaus_vivienda_id	=>  1,
    p_deposito              =>  12000,
    p_costo_dia             =>  4000,
    p_max_dias 				=>  12
  );  
*/
  commit;

  exception
    when others then
      dbms_output.put_line('Codigo: ' || sqlcode);
      dbms_output.put_line('Mensaje: ' || sqlerrm);
      rollback;
end;
/

select v.vivienda_id,v.usuario_id, vr.renta_mensual, vr.dia_deposito
from vivienda v, vivienda_renta vr  
where v.usuario_id = 101
and v.vivienda_id = vr.vivienda_id;

select v.vivienda_id,v.usuario_id,to_char(vv.num_catastral) as num_catastral, vv.folio
from vivienda v, vivienda_venta vv  
where v.usuario_id = 100
and v.vivienda_id = vv.vivienda_id;

select v.vivienda_id,v.usuario_id, vv.deposito, vv.costo_dia, vv.max_dias
from vivienda v, vivienda_vacacionar vv  
where v.usuario_id = 102
and v.vivienda_id = vv.vivienda_id;

select v.vivienda_id,v.usuario_id, vr.renta_mensual, vr.dia_deposito
from vivienda v, vivienda_renta vr  
where v.usuario_id = 103
and v.vivienda_id = vr.vivienda_id;

select v.vivienda_id,v.usuario_id, vv.deposito, vv.costo_dia, vv.max_dias
from vivienda v, vivienda_vacacionar vv  
where v.usuario_id = 103
and v.vivienda_id = vv.vivienda_id;


select hev.hist_estatus_vivienda_id,
hev.fecha_estatus, hev.vivienda_id, hev.estatus_vivienda_id
from hist_estatus_vivienda hev, vivienda v
where v.vivienda_id = hev.vivienda_id
and (v.usuario_id = 100 or v.usuario_id = 101 or v.usuario_id = 102 or v.usuario_id = 103);