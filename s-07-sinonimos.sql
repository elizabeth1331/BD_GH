--@Autor(es): GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 01/02/2021
--@Descripción: CREACION DE TRES O MAS SINONIMOS DEL CASO DE ESTUDIO


create or replace public synonym usuario for gm_proy_admin.usuario;
create or replace public synonym vivienda for gm_proy_admin.vivienda;
create or replace public synonym vivienda_servicio for gm_proy_admin.vivienda_servicio;
create or replace public synonym servicio for gm_proy_admin.servicio;

grant select on usuario to mg_proy_invitado;
grant select on vivienda to mg_proy_invitado;
grant select on vivienda_servicio to mg_proy_invitado;
grant select on servicio to mg_proy_invitado;

create or replace  synonym new_usuario for mg_proy_invitado.usuario;
create or replace  synonym new_vivienda for mg_proy_invitado.vivienda;
create or replace synonym new_vivienda_servicio for mg_proy_invitado.vivienda_servicio;
create or replace synonym new_servicio for mg_proy_invitado.servicio;

set serveroutput on
declare
--declaración del cursor
cursor cur_crea_synonym is
select table_name 
from user_tables;
--declaración de variables
v_nombre_tabla varchar2(40);
v_nombre varchar2(40);
begin

dbms_output.put_line('creacion de sinonimos');
open cur_crea_synonym;
loop
  fetch cur_crea_synonym 
  into v_nombre_tabla;
  exit when cur_crea_synonym%notfound;
  
  v_nombre:='GM_'||v_nombre_tabla;
  execute immediate 'create or replace synonym '|| v_nombre ||' for '||'gm_proy_admin.'||v_nombre_tabla;
  dbms_output.put_line('Se obtiene '||v_nombre||' de '||v_nombre_tabla);


end loop;
close cur_crea_synonym;
end;
/
show errors;

Select synonym_name from user_synonyms;
