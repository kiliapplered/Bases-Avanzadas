--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 27/07/2022
--@Descripción:    Script 4 del ejercicio 4: Creación de usuarios y roles

whenever sqlerror exit rollback;

Prompt Conectando como usuario karla0104
connect karla0104/karla

Prompt Creando tabla
create table t04_my_schema (
  username      varchar2(128),
  schema_name   varchar2(128)
);

Prompt Otorgando permisos a usuarios
grant insert on karla0104.t04_my_schema to sys;
grant insert on karla0104.t04_my_schema to public;
grant insert on karla0104.t04_my_schema to sysbackup;

Prompt Insertando datos como sysdba
connect karla0104/karla as sysdba
insert into karla0104.t04_my_schema (username, schema_name)
values (
  sys_context('USERENV', 'CURRENT_USER'),
  sys_context('USERENV', 'CURRENT_SCHEMA')
);

Prompt Insertando datos como sysoper
connect karla0105/karla as sysoper
insert into karla0104.t04_my_schema (username, schema_name)
values (
  sys_context('USERENV', 'CURRENT_USER'),
  sys_context('USERENV', 'CURRENT_SCHEMA')
);

Prompt Insertando datos como sysbackup
connect karla0106/karla as sysbackup
insert into karla0104.t04_my_schema (username, schema_name)
values (
  sys_context('USERENV', 'CURRENT_USER'),
  sys_context('USERENV', 'CURRENT_SCHEMA')
);

Prompt Guardando cambios y conectandonos como sysdba
commit;
connect sys/Hola1234# as sysdba

select username,sysdba,sysoper,sysbackup,last_login 
  from v$pwfile_users;

Prompt Regresando contraseña anterior a sys
alter user sys identified by system1;

whenever sqlerror continue none;