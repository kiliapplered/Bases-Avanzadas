--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 27/09/2022
--@Descripción:    Script 1 del ejercicio 2 del Tema 4: Creación del usuario 0401

whenever sqlerror exit rollback;

Prompt conectando como usuario sys
connect sys/system2 as sysdba
declare
  v_count number;
  v_username varchar2(20) := 'KARLA0402';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count >0 then
    execute immediate 'drop user '||v_username|| ' cascade';
  end if;
end;
/
Prompt creando al usuario karla0401 y asignando privilegios
create user karla0402 identified by karla quota unlimited on users;
grant create session, create table to karla0402;

disconnect;

whenever sqlerror continue none;