--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 24/09/2022
--@Descripción:    Script 2 del ejercicio 1 del Tema 4: Creación de la tabla de componentes SGA

whenever sqlerror exit rollback;

Prompt Conectando como usuario sys
connect sys/system2 as sysdba

Prompt Creando tabla t01_sga_components
create table karla0401.t01_sga_components(
  memory_target_param number(5,2),
  fixed_size number(5,2),
  variable_size number(5,2),
  database_buffers number(5,2),
  redo_buffers number(5,2),
  total_sga number(5,2)
);

Prompt Insertando datos en la tabla t01_sga_components
insert into karla0401.t01_sga_components values 
(
  -- memory_target_param
  (select round((value/1024/1024),2) from v$system_parameter where name='memory_target'),
  -- fixed_size
  (select round((value/1024/1024),2) from v$SGA where name='Fixed Size'),
  -- variable_size
  (select round((value/1024/1024),2) from v$SGA where name='Variable Size'),
  -- database_buffers
  (select round((value/1024/1024),2) from v$SGA where name='Database Buffers'),
  -- redo_buffers
  (select round((value/1024/1024),2) from v$SGA where name='Redo Buffers'),
  -- total_sga
  (select round((sum(value)/1024/1024),2) from v$SGA)
);

Prompt Creando tabla t02_sga_dynamic_components e insertando datos
create table karla0401.t02_sga_dynamic_components as(
  select component as component_name, round((current_size/1024/1024),2) current_size_mb,
    oper_count as operation_count, last_oper_type as last_operation_type, 
    last_oper_time as last_operation_time 
  from v$sga_dynamic_components
);


Prompt Creando tabla t03_sga_max_dynamic_component
create table karla0401.t03_sga_max_dynamic_component(
  component_name varchar2(64),
  current_size_mb number(10,2)
);

Prompt Insertando datos en la tabla t03_sga_max_dynamic_component
insert into karla0401.t03_sga_max_dynamic_component values(
  -- component_name
  (select component from v$sga_dynamic_components
  where current_size=(select max(current_size) current_size_mb from v$sga_dynamic_components)),
  -- current_size_mb
  (select round((current_size/1024/1024),2) from v$sga_dynamic_components
  where current_size=(select max(current_size) current_size_mb from v$sga_dynamic_components))
);

Prompt Creando tabla t04_sga_min_dynamic_component
create table karla0401.t04_sga_min_dynamic_component as (
  select component, round((current_size/1024/1024),2) current_size_mb from v$sga_dynamic_components
  where current_size=(select min(current_size) from v$sga_dynamic_components where current_size!=0)
);

Prompt Creando tabla t05_sga_memory_info
create table karla0401.t05_sga_memory_info(
  name varchar2(64),
  current_size_mb number(10,2)
);

Prompt Insertando datos en la tabla t05_sga_memory_info
insert into karla0401.t05_sga_memory_info values (
  -- name
  (select name from v$sgainfo where name='Maximum SGA Size'),
  -- current_size_mb
  (select round(bytes/1024/1024) from v$sgainfo where name='Maximum SGA Size')
);
insert into karla0401.t05_sga_memory_info values (
  -- name
  (select name from v$sgainfo where name='Free SGA Memory Available'),
  -- current_size_mb
  (select round(bytes/1024/1024) from v$sgainfo where name='Free SGA Memory Available')
);

Prompt Creando tabla t06_sga_resizeable_components e insertando datos
create table karla0401.t06_sga_resizeable_components as (
  select name from v$sgainfo where resizeable='Yes'
);

Prompt Creando tabla t07_sga_resize_ops
create table karla0401.t07_sga_resize_ops as(
  select component, oper_type, parameter, round((initial_size/1024/1024),2) as initial_size_mb,
  round((target_size/1024/1024),2) target_size_mb, round((final_size/1024/1024),2) final_size_mb,
  round((final_size-target_size/1024/1024),2) increment_mb, status, to_date(start_time, 'DD/MON/YYYY HH:MI:SS') start_time,
  to_date(end_time, 'DD/MON/YYYY HH:MI:SS') end_time from v$sga_resize_ops 
);

commit;

whenever sqlerror continue none;
