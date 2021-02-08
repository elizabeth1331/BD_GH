--@Autor(es): GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 07/02/2021
--@Descripción: Procedimiento registro_vivienda.

create or replace procedure registro_vivienda(
p_direccion           varchar2,
p_longitud            number,
p_latitud             number,
p_capacidad           number,
p_descripcion         varchar2,
p_fecha_status        date,
p_es_v_venta          number,
p_es_v_renta          number,
p_es_v_vacacionar     number,
p_usuario_id          number,
p_estaus_vivienda_id  number,
--parametros para vivienda_venta
p_precio_inicial      number default null,
p_comision            number default null,
--parametros para vivienda_renta
p_renta_mensual       number default null,
p_dia_deposito        date   default null,
--parametros para vivienda_vacacionar
p_deposito            number default null,
p_costo_dia           number default null,
p_max_dias            number default null
)is
v_vivienda_id         number;
v_clabe               number;
v_num_catastral       number;
begin
  dbms_output.put_line('Añadiendo vivienda al registro general de viviendas');
  dbms_output.put_line('-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --');
  v_vivienda_id := vivienda_seq.nextval; 
  v_clabe := trunc(dbms_random.value(755553333333333111,999999999999999999));
  v_num_catastral := trunc(dbms_random.value(7555533333,9999999999));
  --dbms_output.put_line(v_clabe);
  --dbms_output.put_line(v_num_catastral);
  insert into VIVIENDA(vivienda_id,direccion,longitud,latitud,capacidad_max,descripcion,fecha_estatus,es_v_venta,es_v_renta,es_v_vacacionar,usuario_id,estatus_vivienda_id) 
    values (v_vivienda_id,p_direccion,p_longitud, p_latitud,p_capacidad,p_descripcion,p_fecha_status,p_es_v_venta,p_es_v_renta,p_es_v_vacacionar,p_usuario_id,p_estaus_vivienda_id);
  dbms_output.put_line('La vivienda con id: '|| v_vivienda_id || ' se registro de forma correcta');
  dbms_output.put_line('-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --');
  dbms_output.put_line('Añadiendo vivienda a su registro particular según su tipo');
  dbms_output.put_line('-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --');
  if p_es_v_venta = 1 then
    insert into vivienda_venta (vivienda_id, num_catastral, clabe, folio,precio_inicial, avaluo, comision)
    values (v_vivienda_id, v_num_catastral, v_clabe, dbms_random.string('X',18),p_precio_inicial,empty_blob(),p_comision);
    dbms_output.put_line('Se realizo registro de vivienda venta.');
    dbms_output.put_line('-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --');
  end if;
  if p_es_v_renta = 1 then
    insert into vivienda_renta (vivienda_id,renta_mensual,dia_deposito)
    values (v_vivienda_id,p_renta_mensual,p_dia_deposito);
    dbms_output.put_line('Se realizo registro de vivienda renta.');
    dbms_output.put_line('-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --');
  end if;

  if p_es_v_vacacionar = 1 then
      insert into vivienda_vacacionar (vivienda_id, deposito, costo_dia, max_dias)
      values(v_vivienda_id, p_deposito,p_costo_dia ,p_max_dias); 
        dbms_output.put_line('Se realizo el registro de vivienda vacacionar');
        dbms_output.put_line('-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --');
  end if;
  exception
    when others then
      dbms_output.put_line('Error');
      raise_application_error (-20001,'ERROR: La vivienda no puede ser registrada, verifique los datos proporcionados');  
end;
/
show errors

-- commit;
--dbms_random.value: genra un numero aleatorio con un rango especifico
--dbms_random.string: genera cadenas aleatorias dependiendo del parametro -> 'X': caracteres  alfanumericos
