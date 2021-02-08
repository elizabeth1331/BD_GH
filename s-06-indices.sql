--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 05/01/2021
--@Descripción: CREACION DE INDICES.


-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE ÍNDICE NONUNIQUE------------------------------------------------
-------------------------------------------------------------------------------------------------------------

--Índice para facilitar desempeño en consulta de viviendas en venta o vendidas a partir de su número catastral.
CREATE INDEX V_VENTA_NUM_CATASTRAL_IX ON VIVIENDA_VENTA(num_catastral);

--Índice para facilitar desempeño en consulta de viviendas rentadas por su folio.
CREATE INDEX V_RENTA_USUARIO_FOLIO_IX ON VIVIENDA_RENTA_USUARIO(folio);

--Índice para facilitar desempeño en consulta de viviendas alquiladas por su folio.
CREATE INDEX ALQUILER_FOLIO_IX ON ALQUILER(folio);


-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE ÍNDICE UNIQUE------------------------------------------------
-------------------------------------------------------------------------------------------------------------

--Índice que verifica unicidad en el nombre del usuario.
CREATE UNIQUE INDEX USUARIO_NOM_USUARIO_IUK ON USUARIO(nombre_usuario);

--Índice que verifica unicidad en las CLABE para las rentas
CREATE UNIQUE INDEX CLABE_RENTA_CLABE_IUK ON CLABE_RENTA(clabe); 

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE ÍNDICE COMPUESTO UNIQUE------------------------------------------------
-------------------------------------------------------------------------------------------------------------

--Índice que verifica que la combinación vivienda_id y dirección sea única.
CREATE UNIQUE INDEX VIVENDA_ID_DIRECCION_IUK ON VIVIENDA(vivienda_id,direccion);

--Índice que verifica que la combinación folio e id sea únca.
CREATE UNIQUE INDEX V_RENTA_UUSUARIO_ID_FOLIO_IUK ON VIVIENDA_RENTA_USUARIO(vivienda_renta_usuario_id, folio);

--Índice que valida que la combinación nombre e id sea única.
CREATE UNIQUE INDEX SERVICIO_ID_NOMBRE_IUK ON SERVICIO(servicio_id, nombre);

-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREACION DE ÍNDICES BASADOS EN FUNCIONES------------------------------------------------
-------------------------------------------------------------------------------------------------------------

--Indice para mejorar el desempeño al buscar el nombre y apellidos del usuario.
CREATE INDEX USUARIO_NOMBRE_AP_PAT_AP_MAT_IX ON USUARIO(UPPER(nombre),UPPER(ap_paterno),UPPER(ap_materno));


