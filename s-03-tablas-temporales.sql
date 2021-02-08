--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 04/01/2021
--@Descripción: CREACION DE TABLAS TEMPORALES

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE TABLA TEMPORAL------------------------------------------------
-------------------------------------------------------------------------------------------------------------

--Contexto:
--El usuario podra tener un registro de las viviendas de interes,
--Se lleva el registro del usuario por si se confirman las opciones (id y nombre_usuario).
--Se registran datos de interes sobre la vivienda agregada (id, tipo de vivienda, estado de la vivienda)

CREATE GLOBAL TEMPORARY TABLE opciones_vivienda(
  usuario_id 				number(10,0)	not null,
  nombre_usuario 		 	number(10,0) 	not null,
  vivienda_id 				number(10,0) 	not null,
  es_v_venta 				number(1,0) 	not null,
  es_v_renta				number(1,0)		not null,
  es_v_vacacionar			number(1,0)		not null,
  --FECHA_ESTATUS DATE NOT NULL,
  estatus_vivienda_id		number(10,0)	not null 
) on commit preserve rows;

--Argumentación opciones tabla:
--global temporary:
--  Tenemos datos en memoria que pueden guardarse o no de forma permanente.
--on commit preserve rows:
--  Al realizar commit los registros segiran existiendo 
--  permitiendo el almacenado permanente de los datos en alguna otra tabla.


