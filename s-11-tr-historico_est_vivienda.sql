--@Autor(es): GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 05/01/2021
--@Descripción: Trigger que actualiza el estado de una vivienda a inactivo o cuando se inserta un registro vivienda

set serveroutput on

create or replace trigger inserta_historico_est_vivienda
  after insert or update of estatus_vivienda_id on vivienda
for each row
declare
  v_vivienda_id alquiler.vivienda_id%type;
begin 
  insert into hist_estatus_vivienda (hist_estatus_vivienda_id,
    fecha_estatus, vivienda_id, estatus_vivienda_id)
  values (hist_estatus_v_seq.nextval, sysdate, :new.vivienda_id, 
    :new.estatus_vivienda_id);
end;
/
show errors