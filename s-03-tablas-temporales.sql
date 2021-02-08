--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 04/01/2021
--@Descripción: CREACION DE TABLAS TEMPORALES

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE TABLA TEMPORAL------------------------------------------------
-------------------------------------------------------------------------------------------------------------

--Bloque anonimo que  valida si se puede o no crear la tabla temporal (si existe o no en el esquema)

set serveroutput on
declare
v_c number;
v_c2 number;
begin
  select count(*) into v_c
  from user_tables
  where table_name='aux_usuario_activo';
  dbms_output.put_line('Crea tabla aux_usuario_activo y vista en caso de no existir ');
  if v_c=0 then
    execute immediate 'CREATE  GLOBAL TEMPORARY TABLE aux_usuario_activo(
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


