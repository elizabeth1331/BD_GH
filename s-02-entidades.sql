--@Autor(es): GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: dd/01/2021
--@Descripción: CREACION TABLAS DEL CASO DE ESTUDIO 

Prompt conectando con usuario sys
connect sys/system as sysdba

--crear usuario 
Prompt conectando con el usuario administrador.
connect gm_proy_admin/mg

-------------------------------------------------------------------------------------------------------------
----------------------------------------CREANDO TABLA USUARIO------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE USUARIO(
    usuario_id         number(10,0)     not null,
    nombre_usuario     varchar2(20)     not null,
    nombre             varchar2(30)     not null,
    ap_paterno         varchar2(30)     not null,
    ap_materno         varchar2(30),
    email              varchar2(200)    not null,
    contrasena           varchar2(40)     not null,
    constraint empleado_pk primary key (usuario_id)
);


-------------------------------------------------------------------------------------------------------------
-------------------------------------CREANDO TABLA TARJETA_CREDITO-------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE TARJETA_CREDITO(
    tarjeta_id          number(10,0)    not null,
    num_seguridad       number(4,0)     not null,
    num_tarjeta         number(16,0)    not null constraint num_tarjeta_uk unique, 
    mes_exp             number(2,0)     not null,
    anio_exp            number(4,0)     not null,
    usuario_id          number(10,0)    not null,
    constraint tarjeta_pk primary key (tarjeta_id),
    constraint tc_usuario_id_fk foreign key(usuario_id)
    references usuario(usuario_id),
    constraint TARJETA_CREDITO_num_tarjeta_chk check(num_tarjeta >= 1000000000000000 and num_tarjeta <= 9999999999999999),
    constraint TARJETA_CREDITO_num_seguridad_chk check(num_seguridad >= 1000 and num_seguridad <= 9999),
    constraint TARJETA_CREDITO_anio_exp_chk check(anio_exp >= 1900 and anio_exp <= 3000),
    constraint TARJETA_CREDITO_mes_exp_chk check (mes_exp <= 12)
);


-------------------------------------------------------------------------------------------------------------
---------------------------------------CREANDO TABLA ESTATUS_VIVIENDA----------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE ESTATUS_VIVIENDA(
    estatus_vivienda_id number(10, 0)    not null,
    clave               varchar2(10)      not null,
    descripcion         varchar2(255)    not null,
    constraint estatus_vivienda_pk primary key (estatus_vivienda_id )
);


-------------------------------------------------------------------------------------------------------------
--------------------------------------------CREANDO TABLA VIVIENDA--------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE VIVIENDA(
    vivienda_id         number(10,0)     not null,
    direccion           varchar2(400)    not null,
    longitud            number(9,5)      not null,
    latitud             number(9,5)      not null,
    capacidad_max       number(4,0)      not null,
    descripcion         varchar2(2000)   not null,
    fecha_estatus       date             not null,
    es_v_venta          number(1,0)      not null,
    es_v_renta          number(1,0)      not null,
    es_v_vacacionar     number(1,0)      not null,
    usuario_id          number(10, 0)    not null,
    estatus_vivienda_id number(10, 0)    not null,
    constraint vivienda_pk primary key (vivienda_id),
    constraint vivienda_usuario_id_fk foreign key(usuario_id)
    references usuario(usuario_id),
    constraint vivienda_estatus_vivienda_id_fk foreign key(estatus_vivienda_id)
    references estatus_vivienda(estatus_vivienda_id),
    constraint vivienda_es_turista_chk check ( 
      es_v_renta = 0 and es_v_venta = 1  and es_v_vacacionar=0
      or es_v_renta = 1 and es_v_venta = 0 and es_v_vacacionar = 0
      or es_v_renta = 0 and es_v_vacacionar = 1 and es_v_venta = 0
      or es_v_renta = 1 and es_v_vacacionar = 1 and es_v_venta = 0
  )
);


-------------------------------------------------------------------------------------------------------------
--------------------------------------------CREANDO TABLA MENSAJE--------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE MENSAJE(
    mensaje_id          number(10,0)     not null,
    titulo              varchar2(40)     not null,
    texto               varchar2(500)    not null,
    visto               number(1,0)      not null,
    usuario_id          number(10, 0)    not null,
    respuesta_id        number(10, 0)    null,
    vivienda_id         number(10, 0)    not null,
    constraint mensaje_pk primary key (mensaje_id),
    constraint mensaje_usuario_id_fk foreign key(usuario_id)
    references usuario(usuario_id),
    constraint mensaje_respuesta_id_fk foreign key(respuesta_id)
    references mensaje(mensaje_id),
    constraint vivienda_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id)
);


-------------------------------------------------------------------------------------------------------------
--------------------------------------------CREANDO TABLA IMAGEN---------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE IMAGEN(
    num_imagen           number(1, 0)    not null, --No requiere secuencia.
    vivienda_id         number(10, 0)    not null,
    imagen              blob             not null,
    constraint imagen_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint imagen_pk primary key (vivienda_id,num_imagen)
);


-------------------------------------------------------------------------------------------------------------
-------------------------------------CREANDO TABLA HIST_ESTATUS_VIVIENDA-------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE HIST_ESTATUS_VIVIENDA(
    hist_estatus_vivienda_id   number(10, 0)    not null,
    fecha_estatus              date             not null,
    vivienda_id                number(10, 0)    not null,
    estatus_vivienda_id        number(10, 0)    not null,
    constraint hist_estatus_vivienda_pk primary key (hist_estatus_vivienda_id),
    constraint hev_estatus_vivienda_id_fk foreign key(estatus_vivienda_id)
    references estatus_vivienda(estatus_vivienda_id),
    constraint hev_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id)
);


-------------------------------------------------------------------------------------------------------------
--------------------------------------------CREANDO TABLA SERVICIO-------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE SERVICIO(
    servicio_id              number(2, 0)     not null,
    nombre                   varchar2(50)     not null,
    descripcion              varchar2(200)    not null,
    icono                    blob             not null,
    constraint servicio_pk primary key (servicio_id)
);


-------------------------------------------------------------------------------------------------------------
----------------------------------------CREANDO TABLA VIVIENDA_SERVICIO--------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE VIVIENDA_SERVICIO(
    servicio_id              number(2, 0)     not null,
    vivienda_id              number(10, 0)    not null,
    constraint vs_servicio_id_fk foreign key(servicio_id)
    references servicio(servicio_id),
    constraint vs_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint vivienda_servicio_pk primary key (vivienda_id,servicio_id)
);


-------------------------------------------------------------------------------------------------------------
--------------------------------------------CREANDO TABLA ALQUILER-------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE ALQUILER(
    alquiler_id         number(10,0)     not null,
    folio               varchar2(18)     not null,
    fecha_ini           date             not null,
    fecha_fin           date             not null,
    usuario_id          number(10, 0)    not null,
    vivienda_id         number(10, 0)    not null,
    constraint alquiler_pk primary key (alquiler_id),
    constraint alquiler_usuario_id_fk foreign key(usuario_id)
    references usuario(usuario_id),
    constraint alquiler_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint alquiler_folio_chk check(length(folio) = 18)
);


-------------------------------------------------------------------------------------------------------------
--------------------------------------------CREANDO TABLA APARTA_VIVIENDA-------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE APARTA_VIVIENDA(
    aparta_vivienda_id  number(10,0)     not null,
    enviada             number(1,0)      not null,
    num_celular         number(12,0)      not null,      
    usuario_id          number(10,0)      not null,
    vivienda_id         number(10,0)     not null,
    constraint aparta_vivienda_pk primary key (aparta_vivienda_id),
    constraint av_usuario_id_fk foreign key(usuario_id)
    references usuario(usuario_id),
    constraint av_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint aparta_vivienda_num_celular_chk check(num_celular >= 100000000000 and num_celular<= 999999999999)
);


-------------------------------------------------------------------------------------------------------------
--------------------------------------------CREANDO TABLA CALIFICACION_ALQUILER-------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE CALIFICACION_ALQUILER(
    CALIFICACION_ALQUILER_id  number(10,0)     not null,
    calificacion        number(1,0)     not null,   
    descripcion         varchar2(600)   not null,  
    usuario_id          number(10,0)    not null,
    fecha               date            not null,
    alquiler_id         number(10,0)    not null,
    constraint CALIFICACION_ALQUILER_pk primary key (CALIFICACION_ALQUILER_id),
    constraint cv_usuario_id_fk foreign key(usuario_id)
    references usuario(usuario_id),
    constraint cv_vivienda_id_fk foreign key(alquiler_id)
    references vivienda(vivienda_id),
    constraint CALIFICACION_ALQUILER_calificacion_chk check(calificacion <= 5)
);


-------------------------------------------------------------------------------------------------------------
-------------------------------------------CREANDO TABLA CLAVE_RENTA-----------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE CLABE_RENTA(
    clabe_renta_id  number(10,0)     not null,
    clabe           number(18,0)     not null,   
    vivienda_id     number(10,0)     not null,
    constraint clabe_renta_clabe_renta_pk primary key (clabe_renta_id),
    constraint cr_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint clabe_renta_chk check(clabe >= 100000000000000000 and clabe <= 999999999999999999)
);


-------------------------------------------------------------------------------------------------------------
---------------------------------------CREANDO TABLA VIVIENDA_VACACIONAR-------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE VIVIENDA_VACACIONAR(
    vivienda_id         number(10,0)     not null,
    deposito            number(5,0)      not null,
    costo_dia           number(4,0)      not null,
    max_dias            number(2,0)      not null,
    constraint vivienda_vacacionar_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint vivienda_vacacionar_vivienda_pk primary key (vivienda_id)
);


-------------------------------------------------------------------------------------------------------------
------------------------------------------CREANDO TABLA VIVIENDA_RENTA---------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE VIVIENDA_RENTA(
    vivienda_id         number(10,0)     not null,
    renta_mensual       number(6,0)      not null,
    dia_deposito        date             not null,
    constraint vivienda_renta_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint vivienda_renta_vivienda_pk primary key (vivienda_id)
);


-------------------------------------------------------------------------------------------------------------
------------------------------------------CREANDO TABLA VIVIENDA_VENTA---------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE VIVIENDA_VENTA(
    vivienda_id         number(10,0)     not null,
    num_catastral       number(10,0)     not null,
    clabe               number(18,0)     not null,
    folio               varchar2(18)     not null,
    precio_inicial       number(10,2)     not null,
    avaluo              blob             not null,
    comision            number(3,0)      not null,
    usuario_id          number(10,0),
    constraint vv_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint vv_usuario_id_fk foreign key(usuario_id)
    references usuario(usuario_id),
    constraint vivienda_venta_vivienda_pk primary key (vivienda_id),
    constraint vivienda_venta_folio_chk check(length(folio) = 18),
    constraint vivienda_venta_clabe_chk check(clabe >= 100000000000000000 and clabe <= 999999999999999999)
);


-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREANDO TABLA PAGO---------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE PAGO_VIVIENDA(
    vivienda_id         number(10,0)     not null,
    num_pago            number(3,0)      not null,
    fecha               date             not null,
    pdf_pago            blob             not null,
    importe             number(7,2)      not null,
    constraint pago_vivienda_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint pago_vivienda_pago_vivienda_pk primary key (vivienda_id,num_pago)
);

-------------------------------------------------------------------------------------------------------------
------------------------------------------CREANDO TABLA VIVIENDA__RENTA_USUARIO---------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE VIVIENDA_RENTA_USUARIO(
    vivienda_renta_usuario_id   number(10,0)    not null,
    vivienda_id                 number(10,0)    not null,
    folio                       varchar2(18)    not null,
    fecha_contrato              date            not null,
    pdf_contrato                blob            not null,
    usuario_id                  number(10,0)    not null,
    constraint vru_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint vru_usuario_id_fk foreign key(usuario_id)
    references usuario(usuario_id),
    constraint vru_vivienda_renta_usuario_pk primary key (vivienda_renta_usuario_id),
    constraint vivienda_renta_folio_chk check(length(folio) = 18)
);




-------------------------------------------------------------------------------------------------------------
-------------------------------------------CREANDO TABLA REGISTRO_PROMOCION-----------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE TABLE REGISTRO_PROMOCION(
    registro_promocion_id  number(10,0)     not null, 
    vivienda_id     number(10,0)     not null,
    usuario_id      number(10,0)     not null,
    precio_inicial  number(10,2)     not null, 
    monto_pagado    number(10,2)     not null, 
    numero_pago     number(3,0)     not null,
    tipo_descuento  varchar2(3)      not null,
    constraint registro_promocion_pk primary key (registro_promocion_id),
    constraint rp_vivienda_id_fk foreign key(vivienda_id)
    references vivienda(vivienda_id),
    constraint rp_usurario_id_fk foreign key(usuario_id)
    references usuario(usuario_id)
);