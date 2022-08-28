--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 27/07/2022
--@Descripción:    Script 4 del ejercicio 4: Creación de usuarios y roles

whenever sqlerror exit rollback;

Prompt conectando como usuario sys
connect sys/Hola1234# as sysdba

declare
  v_count1 number;
  v_username1 varchar2(20) := 'KARLA0105';
  v_count2 number;
  v_username2 varchar2(20) := 'KARLA0106';
begin
  select count(*) into v_count1 from all_users where username=v_username1;
  if v_count1 >0 then
    execute immediate 'drop user '||v_username1|| 'cascade';
  end if;
  select count(*) into v_count2 from all_users where username=v_username2;
  if v_count2 >0 then
    execute immediate 'drop user '||v_username2|| 'cascade';
  end if;
end;
/

Prompt creando al usuario karla0105 y karla0106
create user karla0105 identified by karla quota unlimited on users;
create user karla0106 identified by karla quota unlimited on users;

Prompt Asignando permisos
grant sysdba to karla0104;
grant create session, create table to karla0105;
grant sysoper to karla0105;
grant create session, create table to karla0106;
grant sysbackup to karla0106;

whenever sqlerror continue none;