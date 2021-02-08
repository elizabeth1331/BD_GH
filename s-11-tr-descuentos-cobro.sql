--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 03/02/2021
--@Descripción: CREACION DE TRIGGER TIPO ROW LEVEL


--FECHA DE PROMOCIONES, PARA LOS CLIENTES QUE HAN COMPRADO UNA CASA SE LES DARA
-- UN DESCUESTO AL REALIZAR SU PAGO NUMERO 8 DEL 10% O UN PAGO DE 15% PARA SU PAGO NUMERO 13
--TAMBIÉN SE SOLICITA CREAR UNA NUEVA TABLA DONDE SE LLEVARA EL REGISTRO DE LOS DESCUENTOS, 
--DICHA TABLA DEBERA LLAMARSE 'REGISTRO_PROMOCION' Y USANDO UNA SECUENCIA LLAMADA registro_promocion_seq

----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------TRIGGER DESCUENTO DE VENTA---------------------------------------------
----------------------------------------------------------------------------------------------------------------------

set serveroutput on
create or replace trigger tr_descuentos_venta 
before insert 
on pago_vivienda
for each row
declare
v_vivienda_id              REGISTRO_PROMOCION.vivienda_id%type;
v_monto_pagado             REGISTRO_PROMOCION.monto_pagado%type;
v_precio_inicial           vivienda_venta.precio_inicial%type;
v_ult_num_pag              pago_vivienda.num_pago%type;
v_ult_num_pago             pago_vivienda.num_pago%type;
v_importe                  pago_vivienda.importe%type;
v_usuario_id               usuario.usuario_id%type;
v_var                      varchar2(300);
v_restante                 number;
v_rp_id                    number;
v_num_promo                number;
begin
  case 
    when inserting then
      select  u.usuario_id,vv.precio_inicial, q1.monto_pagado, q1.num_ult_pago  
      into v_usuario_id,v_precio_inicial, v_monto_pagado,v_ult_num_pag
      from  usuario u
      join vivienda_venta vv
      on u.usuario_id=vv.usuario_id
      join (
        select vv.usuario_id, sum(pv.importe) as monto_pagado, max(num_pago) as num_ult_pago
        from vivienda v
        join vivienda_venta vv
        on v.vivienda_id=vv.vivienda_id
        join pago_vivienda pv
        on pv.vivienda_id=vv.vivienda_id
        group by vv.usuario_id
      ) q1 on q1.usuario_id=u.usuario_id
      where vv.vivienda_id=:new.vivienda_id;
      v_importe:= :new.importe;

      case 
        when v_ult_num_pag=8 then

          select registro_promocion_seq.nextval into v_num_promo from dual;
          v_vivienda_id:=:new.vivienda_id;
          v_ult_num_pago:=v_ult_num_pag+1;
          
          insert into REGISTRO_PROMOCION(registro_promocion_id, vivienda_id,usuario_id,precio_inicial,monto_pagado,numero_pago, tipo_descuento) 
          values (v_num_promo,v_vivienda_id,v_usuario_id,v_precio_inicial,v_monto_pagado,v_ult_num_pago, 'v1' );

        when v_ult_num_pag=13 then

           select registro_promocion_seq.nextval into v_num_promo from dual;
          insert into REGISTRO_PROMOCION(registro_promocion_id, vivienda_id,usuario_id,precio_inicial,monto_pagado,numero_pago,tipo_descuento) 
          values (v_num_promo,:new.vivienda_id,v_usuario_id,v_precio_inicial ,v_monto_pagado,v_ult_num_pag+1,'v2'); 

        else
          v_var :='Pago realizado con exito ';
          dbms_output.put_line(v_var);   
      end case;
  end case;
end;
/
show errors;
commit;

