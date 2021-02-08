--@Autor: Jeremy García Meneses, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 03/02/2021
--@Descripción: FUNCIONES
connect gm_proy_admin/mg

create or replace function genera_csv(
  p_directorio 		     varchar2,
  p_nombre_archivo     varchar2,
  p_usuario_id 		     usuario.usuario_id%type,
  p_nombre_usuario 	   usuario.nombre_usuario%type,
  p_email 			       usuario.email%type,
  p_contasena 		     usuario.contrasena%type,
  p_tarjeta_id         tarjeta_credito.tarjeta_id%type,
  p_num_seguridad      tarjeta_credito.num_seguridad%type,
  p_num_tarjeta        tarjeta_credito.anio_exp%type,
  p_anio_exp           tarjeta_credito.mes_exp%type,
  p_mes_exp            tarjeta_credito.mes_exp%type
) return number
is
--Paquete UTL_FILE leer y escribir archivos de texto en el sistema operativo.
--fopen(ubicacion,nombre_archivo) regresa el tipo de archivo
v_file utl_file.file_type;
begin
  --Abrimos el archivo en modo de lectura.
  v_file := utl_file.fopen(p_directorio,p_nombre_archivo,'A');
    utl_file.put(v_file, p_usuario_id 		  || ',');
    utl_file.put(v_file, p_nombre_usuario 	|| ',');
    utl_file.put(v_file, p_email		 	      || ',');
    utl_file.put(v_file, p_contasena        || ',');
    utl_file.put(v_file, p_tarjeta_id       || ',');
    utl_file.put(v_file, p_num_seguridad    || ',');
    utl_file.put(v_file, p_num_tarjeta      || ',');
    utl_file.put(v_file, p_anio_exp         || ',');
    utl_file.put(v_file, p_mes_exp);  
    --Hacemos un salto de linea en el archivo
    utl_file.new_line(v_file);
  --Cerramos el archivo
  utl_file.fclose(v_file);
return 0;
end;
/
show errors


