--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 12/11/2022
--@Descripción:    Script 1 del ejercicio 1 del Tema 5: Creación del usuario 0501

whenever sqlerror exit rollback;

Prompt conectando como usuario sys
connect sys/system2 as sysdba
declare
  v_count number;
  v_username varchar2(20) := 'KARLA0501';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count >0 then
    execute immediate 'drop user '||v_username || ' cascade';
  end if;
end;
/
Prompt creando al usuario karla0501 y asignando privilegios
create user karla0501 identified by karla quota unlimited on users;
grant create session, create procedure, create table, create sequence to karla0501;

disconnect;

whenever sqlerror continue none;