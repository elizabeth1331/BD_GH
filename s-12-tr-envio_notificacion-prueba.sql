--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 05/02/2021
--@Descripción: Prueba Trigger para enviar notificación (mensaje) a todos los usuarios cuando se registra una vivienda.



connect gm_proy_admin/mg
Prompt Creando trigger envio_notificación
@@s-11-tr-envio_notificacion.sql

set serveroutput on
declare
  cursor cur_mensajes is
  select * from mensaje;

begin
  dbms_output.put_line('Realizando inserción de vivienda para vacacionar');
  registro_vivienda(
    p_direccion             =>  'Av. Plan Ayala 340, Cuernavaca Morelos',
    p_longitud              =>  18.924698,
    p_latitud               =>  -99.222696,
    p_capacidad             =>  5,
    p_descripcion           =>  'Casa mediana para vacacionar',
    p_fecha_status          =>  sysdate, 
    p_es_v_venta            =>  0,
    p_es_v_renta            =>  0,
    p_es_v_vacacionar       =>  1,
    p_usuario_id            =>  104,
    p_estaus_vivienda_id    =>  1,
    p_deposito              =>  12000,
    p_costo_dia             =>  4000,
    p_max_dias              =>  12
  ); 
  dbms_output.put_line('Visualizando nuevos registros de mensajes');
  commit;
  exception
  when others then
    dbms_output.put_line('Error en el código');
    dbms_output.put_line('Codigo: '  || sqlcode);
    dbms_output.put_line('Mensaje: ' || sqlcode);
    rollback;  

end;
/
show errors

col texto format A30;
select mensaje_id, titulo, texto, usuario_id
from mensaje
where titulo like 'NUEVA%';
