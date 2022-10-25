--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/10/2022
--@Descripción:    Script 1 del ejercicio 3 del Tema 4: Creación del usuario 0403

whenever sqlerror exit rollback;

Prompt conectando como usuario sys
connect sys/system2 as sysdba
declare
  v_count number;
  v_username varchar2(20) := 'KARLA0403';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count >0 then
    execute immediate 'drop user '||v_username|| ' cascade';
  end if;
end;
/
Prompt creando al usuario karla0403 y asignando privilegios
create user karla0403 identified by karla quota unlimited on users;
grant create session, create table, create sequence to karla0403;

disconnect;

whenever sqlerror continue none;