--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 05/02/2021
--@Descripción: Trigger para enviar notificación (mensaje) a todos los usuarios cuando se registra una vivienda.
--necesitamos tr-vivienda-alquiler-inactiva. 
create or replace trigger envio_notificacion
  after insert on vivienda_vacacionar
  for each row
declare
  cursor cur_usuario is
    select usuario_id
  from usuario;
  --declaramos objeto type
  type usuario_obj_type is record (  
    mensaje_id     mensaje.mensaje_id%type,
    titulo         mensaje.titulo%type,
    texto          mensaje.texto%type,
    visto          mensaje.visto%type,
    usuario_id     mensaje.usuario_id%type,
    respuesta_id   mensaje.respuesta_id%type,
    vivienda_id    mensaje.vivienda_id%type);
  --creamos objeto coleccion de id's de usuarios
  type usuarios_list_type is table of usuario_obj_type;
  --Creamos una colección y la inicializamos
  usuarios_list usuarios_list_type := usuarios_list_type();
--inicia seccion before (inicialización de variables)
  v_indice_lista number;	
begin
    usuarios_list.extend;
    for r in cur_usuario loop
      v_indice_lista := usuarios_list.last;
      usuarios_list(v_indice_lista).usuario_id := r.usuario_id;
      usuarios_list(v_indice_lista).mensaje_id := mensaje_seq.nextval;
      usuarios_list(v_indice_lista).titulo := 'NUEVA VIVIENDA PARA ALQUILAR';
      usuarios_list(v_indice_lista).texto := 'Revisa la nueva vivienda disponible en nuestra plataforma';
      usuarios_list(v_indice_lista).respuesta_id := null;
      usuarios_list(v_indice_lista).vivienda_id := :new.vivienda_id;
      usuarios_list(v_indice_lista).visto := 0;
      insert into  MENSAJE(mensaje_id,titulo,texto,visto,usuario_id,respuesta_id,vivienda_id) 
        values (
          usuarios_list(v_indice_lista).mensaje_id,
          usuarios_list(v_indice_lista).titulo,
          usuarios_list(v_indice_lista).texto,
          usuarios_list(v_indice_lista).visto, 
          usuarios_list(v_indice_lista).usuario_id, 
          usuarios_list(v_indice_lista).respuesta_id,
          usuarios_list(v_indice_lista).vivienda_id);
    end loop;

end;
/
show errors


