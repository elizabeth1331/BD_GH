--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 03/02/2021
--@Descripción: Creacion de tablas, creacion de tabla de registros a conservar



set serveroutput on
declare
v_c number;
v_c2 number;
begin
  select count(*) into v_c
  from user_tables
  where table_name='AUX_ELIM_USUARIO';
  dbms_output.put_line('Crea tabla aux_elim_usuario y vista en caso de no existir ');
  if v_c=0 then
    execute immediate 'CREATE  GLOBAL TEMPORARY TABLE aux_elim_usuario(
    usuario_id          number(10,0),
    nombre_usuario     varchar2(20),
    nombre             varchar2(30),
    ap_paterno         varchar2(30),
    ap_materno         varchar2(30),
    email              varchar2(200),
    contrasena           varchar2(40),
    tipo               varchar2(2),
    vivienda_id         number(10,0)
    ) on commit preserve rows';  

  end if;
  if v_c>0 then    
    dbms_output.put_line('La tabla ya existe');
  end if;
  select count(*) into v_c2
  from user_tables
  where table_name='AUX_ELIM_TARJETA';
  dbms_output.put_line('Crea tabla aux_elim_tarjeta y vista en caso de no existir ');
  if v_c2=0 then
    execute immediate 'CREATE GLOBAL TEMPORARY TABLE aux_elim_tarjeta(
    tarjeta_id          number(10,0),
    num_seguridad       number(4,0),
    num_tarjeta         number(16,0), 
    mes_exp             number(2,0),
    anio_exp            number(4,0)
    ) on commit preserve rows';  
    
  end if;
  if v_c2>0 then    
    dbms_output.put_line('La table ya existe  ');
  end if;

end;
/
show errors


--SE BUSCA DEPURAR LOS REGISTROS DE LAS TARJETAS DE CREDITO ENCONTRADOS EN LA BD, ADEMAS DE LIMPIAR LOS USUARIOS
@@s-15-fx-buscar-usuario.sql
-- FUNCIONES USADAS EN EL PROCEDIMIENTO 
@@s-13-p-datos-usuario.sql
commit;

set serveroutput on
declare
v_var varchar2(400);
v_email varchar2(200);
v_nombre_usuario usuario.nombre_usuario%type;
v_nombre varchar2(40);
v_count number;
v_val number;
v_ap_paterno usuario.ap_paterno%type;
v_ap_materno varchar2(30);
v_contrasena usuario.contrasena%type;
v_tipo char(2);
v_id number(10,0);
v_id_u number(10,0);
v_usuario_id number(10,0);
cursor cur_elim_usuario is
select nombre_usuario,nombre,ap_paterno,ap_materno,email,contrasena
from(
select nombre_usuario,nombre,ap_paterno,ap_materno,email,contrasena
from  usuario u
natural join vivienda 
natural join vivienda_renta 
  union  
select nombre_usuario,nombre,ap_paterno,ap_materno,email,contrasena
from  usuario u
natural join vivienda  
join vivienda_venta 
using(vivienda_id)
  union 
select nombre_usuario,nombre,ap_paterno,ap_materno,email,contrasena
from  usuario u
natural join vivienda 
natural join vivienda_vacacionar);
begin
open cur_elim_usuario; 
    
    loop
      fetch cur_elim_usuario 
      into v_nombre_usuario,v_nombre,v_ap_paterno,v_ap_materno,v_email,v_contrasena;
    exit  when cur_elim_usuario%notfound;
      if tipo_renta(v_email)='vr'then 
        v_tipo:= 'vr';
      end if;
      if tipo_venta(v_email)='vv'then 
        v_tipo:= 'vv';
      end if;
      if tipo_alquiler(v_email)='va'then 
        v_tipo:= 'va';
      end if;


      select usuario_id
      into v_id_u
      from  usuario
      where email=v_email;
      v_usuario_id:=v_id_u;

      insert into aux_elim_usuario(usuario_id,nombre_usuario,nombre,ap_paterno,ap_materno,email,contrasena,tipo)
      values (v_usuario_id,v_nombre_usuario,v_nombre,v_ap_paterno,v_ap_materno,v_email,v_contrasena,v_tipo);

    end loop;
  close cur_elim_usuario;

end;
/
show errors
commit;