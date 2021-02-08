--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 03/02/2021
--@Descripción: CREACION DE UN PROCEDIMIENTO USADO EN LIMPIEZA DE LA TABLA TARJETA_CREDITO Y USUARIOS


set serveroutput on
create or replace procedure datos_usuario (
  v_mes_exp_est in number,
  v_anio_exp_est in number
) is
v_var                     varchar2(300);
v_num_tarjeta             tarjeta_credito.num_tarjeta%type;
v_tarjeta_id              tarjeta_credito.tarjeta_id%TYPE;
v_email                   usuario.email%type;
v_nombre_usuario          usuario.nombre_usuario%type;
v_nombre                  varchar2(40);
v_count                   number;
v_num_seguridad           TARJETA_CREDITO.num_seguridad%type;
v_mes_exp                 TARJETA_CREDITO.mes_exp%type;
v_anio_exp                TARJETA_CREDITO.anio_exp%type;
v_ap_paterno              usuario.ap_paterno%type;
v_ap_materno              usuario.ap_materno%type;
v_contrasena              usuario.contrasena%type;
v_tipo                    varchar2(2);
v_user_id                 number;
v_vivienda_id             number;
--Cursores
cursor cur_elim_tarjeta is
select t.tarjeta_id,t.num_seguridad,t.num_tarjeta, t.mes_exp,t.anio_exp
from  usuario u
natural join tarjeta_credito t
where t.mes_exp<v_mes_exp_est
and t.anio_exp<v_anio_exp_est;


begin

-------------------------------------------------------------------------------------------------------------------------------------------------------------

  open cur_elim_tarjeta;
    dbms_output.put_line('------------------------------CREANDO REGISTRO DE TARJETAS CADUCAS---------------------------------');
    loop
      fetch cur_elim_tarjeta into v_tarjeta_id,v_num_seguridad,v_num_tarjeta, v_mes_exp,v_anio_exp;      
    exit when cur_elim_tarjeta%notfound;

      insert into aux_elim_tarjeta(tarjeta_id,num_seguridad,num_tarjeta, mes_exp,anio_exp)
      values (v_tarjeta_id,v_num_seguridad,v_num_tarjeta,v_mes_exp,v_anio_exp);

    

   end loop;
  close cur_elim_tarjeta;



end;
/
show errors



