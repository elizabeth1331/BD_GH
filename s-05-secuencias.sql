--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 04/01/2021
--@Descripción: CREACION DE SECUENCIAS

--Utilizaremos las secuencias para generar tosdos los id de forma unica y consecutiva.

connect gm_proy_admin/mg
-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA USUARIO------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE usuario_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA VIVIENDA------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE vivienda_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA MENSAJE------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE mensaje_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA TARJETA_CREDITO------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE tarjeta_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;


-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA ESTATUS_VIVIENDA------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE estatus_vivienda_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA HIST_ESTATUS_VIVIENDA------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE hist_estatus_v_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;


-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA SERVICIO------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE servicio_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA VIVIENDA_RENTA_USUARIO------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE v_renta_usuario_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA CLABE_RENTA------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE clabe_renta_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA ALQUILER------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE alquiler_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;
-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA APARTA_VIVIENDA------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE aparta_v_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE SECUENCIA PARA CALIFICACION_VIVIENDA------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE calif_v_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;

-------------------------------------------------------------------------------------------------------------
---------------------------------------CREACION DE SECUENCIA PARA EL REGISTRO DE UNA PROMOCION ------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE registro_promocion_seq
  start WITH 1 --La secuencia iniciara en 1
  increment by 1 --La secuencia incrementa de 1 en 1
  nominvalue --No se necesita un valor minimo ya que la secuencia no es ciclica
  nomaxvalue --No se establece un valor maximo para la secuencia
  nocycle --La secuencia no se repetira al alcanzar un valor maximo
  cache 10 --Se almacenan 10 valores de la secuencia en memoria (para mejor desempeño en una carga "masiva" de datos)
  order --Se garantiza que los valores se generen en el orden solicitado
;