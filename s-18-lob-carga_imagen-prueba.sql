--@Autor(es): GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 06/01/2021
--@Descripción: CARGA DE IMAGENES PRUEBA



connect gm_proy_admin/mg
Prompt Creando lob-carga_imagen
@@s-17-lob-carga_imagen.sql

set serveroutput on
declare
v_var number;
begin
  carga_imagen(1,6,'VIVIENDAS');
  carga_imagen(1,4,'ICONOS');
  commit;
  exception 
  when others then
    dbms_output.put_line('Error al ejecutar procedimiento');
    dbms_output.put_line('Codigo: '  || sqlcode);
    dbms_output.put_line('Mensaje: ' || sqlcode);
    rollback;
end;
/
show errors

/*
Consulta para ver imagenes en sqldeveloper.
select num_imagen, vivienda_id, imagen
from imagen;

select servicio_id, icono
from servicio;

*/