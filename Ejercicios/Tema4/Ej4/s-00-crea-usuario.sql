--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 30/10/2022
--@Descripción:    Script 1 del ejercicio 4 del Tema 4: Creación del usuario 0404

whenever sqlerror exit rollback;

Prompt conectando como usuario sys
connect sys/system2 as sysdba
declare
  v_count number;
  v_username varchar2(20) := 'KARLA0404';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count >0 then
    execute immediate 'drop user '||v_username || ' cascade';
  end if;
end;
/
Prompt creando al usuario karla0404 y asignando privilegios
create user karla0404 identified by karla quota unlimited on users;
grant create session, create procedure, create table, create sequence to karla0404;

disconnect;

whenever sqlerror continue none;