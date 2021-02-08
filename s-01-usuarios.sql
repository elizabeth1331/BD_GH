--@Autor(es): GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha creación: 05s/01/2021
--@Descripción: CREACION DE USUARIOS Y PERMISOS NECESARIOS PARA EL CASO DE ESTUDIOS 


-------------------------------------------------------------------------------------------------------------
----------------------------------------------CREANDO USUARIO------------------------------------------------
-------------------------------------------------------------------------------------------------------------

Prompt crear usuario invitado
--drop user mg_proy_invitado cascade;
create user mg_proy_invitado identified by mg quota unlimited on users;

Prompt crear usuario invitado
--drop user gm_proy_admin cascade;
create user gm_proy_admin identified by mg quota unlimited on users;

-------------------------------------------------------------------------------------------------------------
-----------------------------------------------CREANDO ROLES-------------------------------------------------
-------------------------------------------------------------------------------------------------------------

Prompt creando rol_admin 

--drop role rol_admin;
create role rol_admin;
grant create session,create table,create sequence ,create synonym, create public synonym ,create view,create trigger, create procedure to rol_admin;
 
Prompt creando rol_invitado 

--drop role rol_invitado;
create role rol_invitado;
grant create session, create synonym to rol_invitado;
-------------------------------------------------------------------------------------------------------------
----------------------------------------------ASIGNANDO ROLES------------------------------------------------
-------------------------------------------------------------------------------------------------------------

grant rol_invitado to mg_proy_invitado;
grant read, write on directory tmp_dir to mg_proy_invitado;
grant rol_admin to gm_proy_admin;
grant read, write on directory tmp_dir to gm_proy_admin;


prompt creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/bases';

prompt creando el directorio /tmp/bases en caso de no existir
!mkdir -p /tmp/bases
prompt copiando los archivos csv a /tmp/bases
!cp pago_vivienda_ext.csv /tmp/bases
!cp vivienda_venta_ext.csv /tmp/bases
!cp respaldo_usuario.csv /tmp/bases
prompt cambiando permisos
!chmod 777 /tmp/bases
!chmod 777 /home/dulce/Downloads/GH_BD-PROYECTO_FINAL_FUNCIONAL