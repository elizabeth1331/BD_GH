--@Autor(es): GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 06/01/2021
--@Descripción: CARGA DE IMAGENES


  Prompt Conectando con usuario sys
  connect sys/system as sysdba

  Prompt Creando Objeto Directory para imagenes de vivienda
  create or replace directory fotos_dir_viv as '/home/jeremy/Desktop/proy_V7/VIVIENDAS';

  Prompt Creando Objeto Directory para imagenes de iconos de servicio
  create or replace directory fotos_dir_icon as '/home/jeremy/Desktop/proy_V7/ICONOS';

  Prompt Otorgando Permisos de lectura
  grant read on directory fotos_dir_viv to gm_proy_admin;
  grant read on directory fotos_dir_icon to gm_proy_admin;

  connect gm_proy_admin/mg;
  
set serveroutput on
--CREANDO PROCEDIMIENTO
Prompt Creando Procedimiento.
create or replace procedure carga_imagen(
  p_id_inicio number,
  p_num_imagenes number,
  p_directorio_imagenes varchar2
) is 

cursor cur_vivienda_imagen is
  select num_imagen, vivienda_id,
  imagen
  from imagen
  where vivienda_id between p_id_inicio
  and (p_id_inicio + p_num_imagenes);

cursor cur_servicio is
  select servicio_id, icono
  from servicio
  where servicio_id between p_id_inicio
  and (p_id_inicio + p_num_imagenes);

v_nombre_foto varchar2(30);
--Referencia hacia el archivo
v_bfile bfile;
v_foto blob;
--Se requieren porque el procedimiento necesita parametros de salida
v_src_offset  number;
v_dest_offset number;
v_src_length  number;
v_blob_length number;

begin 

  if p_directorio_imagenes = 'VIVIENDAS' then
    dbms_output.put_line('Se cargaran imagenes de viviendas');
   for r in cur_vivienda_imagen loop
        v_nombre_foto := r.vivienda_id || '-' || r.num_imagen || '.jpeg';
        v_bfile := bfilename('FOTOS_DIR_VIV', v_nombre_foto);
        --Verificar si el archivo existe
        if dbms_lob.fileexists(v_bfile) = 0 then
          dbms_output.put_line('No se encontro la imagen' || v_nombre_foto);
          dbms_output.put_line('Pasamos a la siguiente vivienda');

        --Verificar si el archivo esta cerrado
        elsif dbms_lob.fileisopen(v_bfile) = 1 then
          dbms_output.put_line('El archivo' || v_nombre_foto || 'esta abierto, debe estar cerrado');
        else
        --Se utiliza for update para evitar que otros usuarios intenten escribir/leer en la columna foto
        --mientras se ocupa el binario
        select imagen into v_foto
        from imagen 
        where vivienda_id = r.vivienda_id
        and num_imagen = r.num_imagen
        for update;
  
        dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
        v_src_offset  := 1;
        v_dest_offset := 1;
        v_src_length  := dbms_lob.getlength(v_bfile);

        dbms_lob.loadblobfromfile(
          dest_lob    => v_foto,
          src_bfile   => v_bfile,
          amount      => v_src_length,
          dest_offset => v_dest_offset,
          src_offset  => v_src_offset
        );
    --Cerrando el archivo
        dbms_lob.close(v_bfile);
    --Verificamos la cantidad de bytes escritos en el objeto blob
        v_blob_length := dbms_lob.getlength(v_foto);
        if v_src_length = v_blob_length then
          dbms_output.put_line('Carga exitosa,  para la foto' 
          || v_nombre_foto  
          || ', cantidad de bytes ' 
          || v_blob_length);
        else
          raise_application_error(-20001, 'Longitud cargada en la columna es invalida para'
          || 'la imagen: ' 
          || r.num_imagen 
          || 'de la vivienda: '
          || r.vivienda_id);
        end if;
      end if;
     end loop; 
  end if;

  if p_directorio_imagenes = 'ICONOS' then
    dbms_output.put_line('Se cargaran imagenes de iconos de servicios');
    for r in cur_servicio loop
        v_nombre_foto := 'servicio-' || r.servicio_id || '.jpeg';
        v_bfile := bfilename('FOTOS_DIR_ICON', v_nombre_foto);
        --Verificar si el archivo existe
        if dbms_lob.fileexists(v_bfile) = 0 then
          dbms_output.put_line('No se encontro la imagen' || v_nombre_foto);
          dbms_output.put_line('Pasamos a la siguiente vivienda');

        --Verificar si el archivo esta cerrado
        elsif dbms_lob.fileisopen(v_bfile) = 1 then
          dbms_output.put_line('El archivo' || v_nombre_foto || 'esta abierto, debe estar cerrado');
        else
        --Se utiliza for update para evitar que otros usuarios intenten escribir/leer en la columna foto
        --mientras se ocupa el binario
        select icono into v_foto
        from servicio
        where servicio_id = r.servicio_id
        for update;
  
        dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
        v_src_offset  := 1;
        v_dest_offset := 1;
        v_src_length  := dbms_lob.getlength(v_bfile);

        dbms_lob.loadblobfromfile(
          dest_lob    => v_foto,
          src_bfile   => v_bfile,
          amount      => v_src_length,
          dest_offset => v_dest_offset,
          src_offset  => v_src_offset
        );
    --Cerrando el archivo
        dbms_lob.close(v_bfile);
    --Verificamos la cantidad de bytes escritos en el objeto blob
        v_blob_length := dbms_lob.getlength(v_foto);
        if v_src_length = v_blob_length then
          dbms_output.put_line('Carga exitosa,  para la foto' 
          || v_nombre_foto  
          || ', cantidad de bytes ' 
          || v_blob_length);
        else
          raise_application_error(-20001, 'Longitud cargada en la columna es invalida para el servicio_id'
            || r.servicio_id);
        end if;
      end if;
     end loop; 
  end if;

end;
/
show errors


