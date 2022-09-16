-- @Autor Najera Noyola Karla Andrea
-- @Fecha 16 de septiembre de 2022
-- @Descripción Creación de tabla con parámetros de la vista v$system_parameter

whenever sqlerror exit rollback;

Prompt Accediendo como usuario sys
connect sys/system2 as sysdba

Prompt Aplicando modificación de parámetros básicos

--A) nls_date_format a nivel sesión
alter session set nls_date_format="dd/mm/yyyy hh24:mi:ss";

--B) db_writer_processes
alter system set db_writer_processes=2 scope=spfile;

--C) log_buffer
alter system set log_buffer=10485760 scope=spfile;

--D) db_files
alter system set db_files=250 scope=spfile;

--E) dml_locks
alter system set dml_locks=2500 scope=spfile;

--F) transactions
alter system set transactions=600 scope=spfile;

--G) hash_area_size
alter session set hash_area_size=2097152;
alter system set hash_area_size=2097152 scope=spfile;

--H) sort_area_size
alter session set sort_area_size=1048576;

--I) sql_trace
alter system set sql_trace=true scope=memory;

--J) optimizer_mode
alter system set optimizer_mode=FIRST_ROWS_100 scope=both;

--K) cursor_invalidation
alter session set cursor_invalidation=DEFERRED;

--Parámetros modificados en la sesión del usuario
create table karla0204.t03_update_param_session as
  select name,value
  from v$parameter
  where name in (
    'cursor_invalidation','optimizer_mode',
    'sql_trace','sort_area_size','hash_area_size','nls_date_format',
    'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
  )
  and value is not null;

--Parámetros modificados en la instancia
create table karla0204.t04_update_param_instance as
  select name,value
  from v$system_parameter
  where name in (
    'cursor_invalidation','optimizer_mode',
    'sql_trace','sort_area_size','hash_area_size','nls_date_format',
    'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
  )
  and value is not null;

--Parámetros modificados en el pfile
create table karla0204.t05_update_param_spfile as
  select name,value
  from v$spparameter
  where name in (
    'cursor_invalidation','optimizer_mode',
    'sql_trace','sort_area_size','hash_area_size','nls_date_format',
    'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
  )
  and value is not null;

--Creando pfile
create pfile='/unam-bda/ejercicios-practicos/t0204/e-03-spparameter-pfile.txt' from spfile;

Prompt Mostrando tablas generadas
select * from karla0204.t03_update_param_session;
select * from karla0204.t04_update_param_instance;
select * from karla0204.t05_update_param_spfile;

whenever sqlerror continue none;