--@Autor(es): GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 05/01/2021
--@Descripción: Trigger que actualiza el estado de una vivienda a inactivo cuando se inserta un registro

create or replace trigger vivienda_alquiler_inactiva
  after update of calificacion on calificacion_alquiler
for each row
declare
  v_vivienda_id alquiler.vivienda_id%type;
begin 
  dbms_output.put_line('Verificando calificacion de la vivienda de alquiler');
  if :new.calificacion = 0 then
    dbms_output.put_line('La calificación es igual a 0');
    dbms_output.put_line('Por penalización el estatus de la vivienda se actualiza a inactivo');

    select vivienda_id into v_vivienda_id
      from alquiler
    where alquiler_id = :old.alquiler_id;

    update vivienda
      set estatus_vivienda_id = 6
    where vivienda_id = v_vivienda_id;
    
  end if;
end vivienda_alquiler_inactiva;
/
show errors