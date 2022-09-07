--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 27/07/2022
--@Descripción:    Script 2 del ejercicio 4: Revisión de roles y privilegios

whenever sqlerror exit rollback;

Prompt conectando como usuario sys
connect sys/system1 as sysdba

Prompt creando tabla de roles
create table karla0104.t02_db_roles as
  select role_id, role
  from dba_roles;

Prompt creando tabla de privilegios del rol dba_roles
create table karla0104.t03_dba_privs as
  select privilege
  from dba_sys_privs;

whenever sqlerror continue none;