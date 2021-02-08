--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 03/02/2021
--@Descripción: Procedimiento para penalizar la calificación de una vivienda para alquiler que no responde mensajes.
--Se valida trigger vivienda-alquiler-inactiva y historico_est_vivienda

connect gm_proy_admin/mg

create or replace procedure penalizacion_calificacion
is
cursor cur_mensaje is
  select q.mensaje_id,q.visto,q.respuesta_id,q.vivienda_id,v.usuario_id,
    a.alquiler_id, ca.calificacion_alquiler_id,ca.calificacion
  from(
  select *
  from mensaje
  where visto = 1
  intersect
  select *
  from mensaje
  where respuesta_id is null
  intersect
  select *
  from mensaje 
  ) q 
  join vivienda v
  on v.vivienda_id = q.vivienda_id
  join vivienda_vacacionar vv
  on v.vivienda_id = vv.vivienda_id
  join alquiler a
  on vv.vivienda_id = a.vivienda_id
  join calificacion_alquiler ca
  on ca.alquiler_id = a.alquiler_id;

begin
  dbms_output.put_line('Registros antes de la penalización');
  for r in cur_mensaje loop
    dbms_output.put_line('-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --');
    dbms_output.put_line('Identificador del mensaje: ' || r.mensaje_id);
    dbms_output.put_line('Identificador vivienda asociada al mensaje: ' || r.vivienda_id);
    dbms_output.put_line('Estado del mensaje: visto');
    dbms_output.put_line('Respuesta: Sin respuesta');
    dbms_output.put_line('Identificador del usuario del dueño de la vivienda:' || r.usuario_id);  
    dbms_output.put_line('Identificador del alquiler: ' || r.alquiler_id);
    dbms_output.put_line('Identificador de la calificación del alquiler: ' || r.calificacion_alquiler_id);
    dbms_output.put_line('calificación de la vivienda: ' || r.calificacion);
    dbms_output.put_line('Aplicando penalización...');
    update calificacion_alquiler
      set calificacion = calificacion-1 
      where calificacion_alquiler_id = r.calificacion_alquiler_id
      and calificacion-1 >= 0;
  end loop;
  dbms_output.put_line('Registros después de la penalización: ');
  for r in cur_mensaje loop
    dbms_output.put_line('-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --');
    dbms_output.put_line('Identificador del mensaje: ' || r.mensaje_id);
    dbms_output.put_line('Identificador vivienda asociada al mensaje: ' || r.vivienda_id);
    dbms_output.put_line('Estado del mensaje: visto');
    dbms_output.put_line('Respuesta: Sin respuesta');
    dbms_output.put_line('Identificador del usuario del dueño de la vivienda:' || r.usuario_id);  
    dbms_output.put_line('Identificador del alquiler: ' || r.alquiler_id);
    dbms_output.put_line('Identificador de la calificación del alquiler: ' || r.calificacion_alquiler_id);
    dbms_output.put_line('calificación de la vivienda: ' || r.calificacion);
  end loop;
end;
/
show errors