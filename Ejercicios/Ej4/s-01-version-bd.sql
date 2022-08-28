--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 27/08/2022
--@Descripción:    Script 1 del ejercicio 4: Creación del usuario 0104 y revisión de versión de la BD

--esta instrucción permite detener la ejecución del script al primer error
--útil para detectar errores de forma rápida.
--al final del script se debe invocar a whenever sqlerror continue none
--para regresar a la configuración original.
whenever sqlerror exit rollback;
-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.
Prompt conectando como usuario sys
connect sys/system1 as sysdba
declare
  v_count number;
  v_username varchar2(20) := 'KARLA0104';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count >0 then
    execute immediate 'drop user '||v_username|| 'cascade';
  end if;
end;
/
Prompt creando al usuario karla0104
create user karla0104 identified by karla quota unlimited on users;
grant create session, create table to karla0104;

Prompt creando tabla de version
create table karla0104.t01_db_version as
  select product,version,version_full
    from product_component_version;

whenever sqlerror continue none;