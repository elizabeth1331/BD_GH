--@Autor: Jeremy García Meneses, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 03/02/2021
--@Descripción: PRUEBA DE FUNCIONES

connect gm_proy_admin/mg
Prompt Creando Funció genera_csv
@@s-15-fx-genera_csv.sql

connect sys/system as sysdba
create or replace directory csv as '/home/jeremy/Desktop/Proy_VFinal';
grant read, write on directory csv to GM_PROY_ADMIN;
!rm respaldo_usuario.csv
connect gm_proy_admin/mg
set serveroutput on;
declare
    v_number number(1,0);
  cursor cur_usuario is
    select   u.usuario_id,nombre_usuario,email,
      contrasena,tarjeta_id,num_seguridad,
     num_tarjeta,anio_exp,mes_exp
    from usuario u,tarjeta_credito tc
    where u.usuario_id = tc.usuario_id;
begin
  dbms_output.put_line('Inicia prueba para generar copia de registros en archivos csv');
  for r in cur_usuario loop
    dbms_output.put_line('Insertando respaldo de usuario con identificador: ' || r.usuario_id);
    select genera_csv(
      'CSV',
      'respaldo_usuario.csv',
      r.usuario_id,
	    r.nombre_usuario,
	    r.email,
	    r.contrasena,
	    r.tarjeta_id,
	    r.num_seguridad,
	    r.num_tarjeta,
	    r.anio_exp,
	    r.mes_exp
	) into v_number from dual;
  end loop;
  if v_number = 0 then
    dbms_output.put_line('La función termino correctamente');
  end if;
  dbms_output.put_line('Fin prueba');
  exception
    when others then
    dbms_output.put_line('Algo salio mal en la función');
    dbms_output.put_line('Código: '  || sqlcode);
    dbms_output.put_line('Mensaje: ' || sqlerrm);

end;
/