--@Autor: 	   Najera Noyola Karla Andrea
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
  (select round(value/1024/1024), 2 as memory_target_param
    from v$parameter where name='memory_target') q0,
  (select round(value/1024/1024), 2 as fixed_size 
    from v$SGA where name='Fixed Size') q1,
  (select round(value/1024/1024), 2 as memory_target_param
    from v$parameter where name='memory_target') q0,  
);

whenever sqlerror continue none;