-- @Autor Najera Noyola Karla Andrea
-- @Fecha 16 de septiembre de 2022
-- @Descripción Creación de un pfile a partir de un spfile. Tabla con datos de parámetros.

whenever sqlerror exit rollback;

Prompt Accediendo como usuario sys
connect sys/system2 as sysdba

create pfile='/unam-bda/ejercicios-practicos/t0204/e-02-spparameter-pfile.txt' from spfile;

Prompt Verificando la existencia del nuevo spfile. 
!ls -l /unam-bda/ejercicios-practicos/t0204/e-02-spparameter-pfile.txt

Prompt Creando usuario karla0204
declare
  v_count number;
  v_username varchar2(20) := 'KARLA0204';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count >0 then
    execute immediate 'drop user '||v_username|| ' cascade';
  end if;
end;
/
create user karla0204 identified by karla quota unlimited on users;

Prompt Asignando permisos
grant create session, create table, create sequence, create procedure to karla0204;

Prompt Creando tabla t_01_spparameters
create table karla0204.t_01_spparameters as 
  (select name, value from v$spparameter where value is not null);

Prompt Mostrando datos de la tabla creada
set linesize window;
column name format a25;
column value format a60;
select * from karla0204.t_01_spparameters;

whenever sqlerror continue none;