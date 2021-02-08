--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 03/02/2021
--@Descripción: CREACION DE FUNCIONES USADAS EN EL CAMBIO Y LIMPIEZA DE LA TABLA TARJETA_CREDITO


-- Ayuda a validar si es usuario inscribio, compro, alquilo o vacaciono alquina vivienda
--Verifica si es tipo venta

create or replace function tipo_venta(
v_email varchar2
) return char is
v_bandera char(2);
v_id number(10,0);
v_id_u number(10,0);
v_vv number;
v_count number;
begin

  select usuario_id
  into v_id_u
  from  usuario
  where email=v_email;
  v_id:=v_id_u;

  select count(*) into v_vv
  from  usuario
  natural join vivienda 
  natural join tarjeta_credito
  natural join vivienda_venta
  where usuario_id=v_id;
    
  if v_vv>0 then
    v_bandera:='vv';
  end if;


return v_bandera;
end;
/

--Vereifica si es tipo renta

show errors
create or replace function tipo_renta(
v_email varchar2
) return char is
v_bandera char(2);
v_id number(10,0);
v_id_u number(10,0);
v_vr number;
begin

  select usuario_id
  into v_id_u
  from  usuario
  where email=v_email;
  v_id:=v_id_u;

  select count(*) into v_vr
  from  usuario
  natural join vivienda 
  natural join tarjeta_credito
  join vivienda_renta
  using (vivienda_id)
  where usuario_id=v_id;
 

  if v_vr>0 then
    v_bandera:='vr';
  end if;
  
return v_bandera;
end;
/
show errors

--Verifica si es del tipo alquiler 

set serveroutput on
create or replace function tipo_alquiler(
v_email varchar2
) return char is
v_va number;
v_bandera char(2);
v_id number(10,0);
v_id_u number(10,0);
begin
  select usuario_id
  into v_id_u
  from  usuario
  where email=v_email;
  v_id:=v_id_u;


  select count(*) into v_va
  from  usuario
  natural join vivienda 
  natural join tarjeta_credito
  natural join vivienda_vacacionar
  where usuario_id=v_id;

  if v_va>0 then
    v_bandera:='va';
  end if;
  
return v_bandera;

end;
/
show errors

--Calcula meses del diferencia 

set serveroutput on
create or replace function resta_mes(
v_mes_exp number,
v_mes number
) return number is

v_result number;
begin
  v_result:=v_mes-v_mes_exp;


return v_result;
end;
/

--Se saca la diferencia de los años

show errors
set serveroutput on
create or replace function resta_anio(
v_anio number,
v_anio_exp number
) return number is

v_result number;
begin

  v_result:=v_anio-v_anio_exp;

return v_result;
end;
/
show errors


--Busca el id del usuario por medio del email (el cual es unico)

set serveroutput on
create or replace function buscar_id_usuario(
v_email varchar2
) return number is

v_id number(10,0);
v_id_u number(10,0);
begin
  select usuario_id
  into v_id_u
  from  usuario
  where email=v_email;
  v_id:=v_id_u;

return v_id;
end;
/
show errors







