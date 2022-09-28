--@Autor: 	       Najera Noyola Karla Andrea
--@Fecha creación: 27/09/2022
--@Descripción:    Script 2 del ejercicio 2 del Tema 4: Consultas de componentes SGA

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

Prompt Creando tabla t01_sga_components
drop table karla0402.t01_sga_components;
create table karla0402.t01_sga_components as (
  select
  --memory_target_param
  q0.memory_target_param,
  --fixed_size
  q1.fixed_size,
  --variable_size
  q2.variable_size,
  --database_buffers
  q3.database_buffers,
  --redo_buffers
  q4.redo_buffers,
  --total_sga
  q5.total_sga
  from 
  (select trunc(value/1024/1024,2) as memory_target_param
      from v$parameter where name='memory_target') q0,
  (select trunc(value/1024/1024,2) as fixed_size from v$SGA
      where name='Fixed Size') q1,
  (select trunc(value/1024/1024,2) as variable_size from v$SGA
      where name='Variable Size') q2,
  (select trunc(value/1024/1024,2) as database_buffers from v$SGA
      where name='Database Buffers') q3,
  (select trunc(value/1024/1024,2) as redo_buffers from v$SGA
      where name='Redo Buffers') q4,
  (select trunc(sum(value)/1024/1024,2) as total_sga from v$SGA) q5  
);

Prompt Creando la tabla t02_sga_dynamic_components
drop table karla0402.t02_sga_dynamic_components;
create table karla0402.t02_sga_dynamic_components as(
  select component component_name,
  trunc(current_size/1024/1024,2) current_size_mb,
  oper_count operation_count,
  last_oper_type last_operation_type,
  to_date(to_char(last_oper_time,'DD/MON/YYYY HH:MI:SS'),
    'DD/MON/YYYY HH:MI:SS') last_operation_time
  from v$sga_dynamic_components
);

Prompt creando la tabla t03_sga_max_dynamic_component
drop table karla0402.t03_sga_max_dynamic_component;
create table karla0402.t03_sga_max_dynamic_component as(
  select component component_name,
  trunc(current_size/1024/1024,2) current_size_mb
  from v$sga_dynamic_components
  where current_size=(
    select max(current_size)
      from v$sga_dynamic_components)
);

Prompt creando la tabla t04_sga_min_dynamic_component
drop table karla0402.t04_sga_min_dynamic_component;
create table karla0402.t04_sga_min_dynamic_component as(
  select component component_name,
  trunc(current_size/1024/1024,2) current_size_mb
  from v$sga_dynamic_components
  where current_size=(
    select min(current_size)
      from v$sga_dynamic_components
      where current_size > 0)
);

Prompt creando la tabla t05_sga_memory_info
drop table karla0402.t05_sga_memory_info;
create table karla0402.t05_sga_memory_info as(
  select name,trunc(bytes/1024/1024,2) current_size_mb
    from v$sgainfo
    where name='Maximum SGA Size'or
      name='Free SGA Memory Available'
);

Prompt creando la tabla t06_sga_resizeable_components
drop table karla0402.t06_sga_resizeable_components;
create table karla0402.t06_sga_resizeable_components as(
  select name
  from v$sgainfo
  where resizeable in 'Yes'
);

Prompt creando la tabla t07_sga_resize_ops
drop table karla0402.t07_sga_resize_ops;
create table karla0402.t07_sga_resize_ops as(
  select component,oper_type,parameter,
    trunc(initial_size/1024/1024,2) initial_size_mb,
    trunc(target_size/1024/1024,2) target_size_mb,
    trunc(final_size/1024/1024,2) final_size_mb,
    trunc((final_size-target_size)/1024/1024,2) increment_mb,
    status,
    to_date(to_char(start_time,'DD/MON/YYYY HH:MI:SS'),
      'DD/MON/YYYY HH:MI:SS') start_time,
    to_date(to_char(end_time,'DD/MON/YYYY HH:MI:SS'),
      'DD/MON/YYYY HH:MI:SS') end_time
  from v$sga_resize_ops
  where
    (component='DEFAULT buffer cache' 
      and (oper_type='INITIALIZING'
        or oper_type='STATIC')) or
    component='Shared IO Pool' or
    component='java pool' or
    component='large pool' or
    (component='shared pool' and
      oper_type='STATIC')
);

commit;

whenever sqlerror continue none;