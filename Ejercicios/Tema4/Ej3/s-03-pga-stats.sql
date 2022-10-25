--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/10/2022
--@Descripción:    Script 4 del ejercicio 3 del Tema 4: Tabla con estadísticas de la PGA

-- Inciso A
prompt Iniciando sesion como sysdba
connect sys/system2 as sysdba

-- Inciso B
create table karla0403.t04_pga_stats as(
  -- max_pga_mb
  (select trunc(value/1024/1024,2) as max_pga_mb
    from v$pgastat
    where name='maximum PGA allocated'),
  --pga_target_param_calc_mb
  (select trunc(value/1024/1024,2) as pga_target_param_calc_mb
    from v$pgastat
    where name='aggregate PGA auto target'),
  --pga_target_param_actual_mb
  (select trunc(value/1024/1024,2) pga_target_param_actual_mb
    from v$parameter
    where name='pga_aggregate_target'),
  --pga_total_actual_mb
  (select trunc(value/1024/1024,2) pga_total_actual_mb
    from v$pgastat
    where name='total PGA allocated'),
  --pga_in_use_actual_mb
  (select trunc(value/1024/1024,2) pga_in_use_actual_mb
    from v$pgastat
    where name='total PGA inuse'),
  --pga_free_memory_mb
  (select trunc(value/1024/1024,2) pga_free_memory_mb
    from v$pgastat
    where name='total freeable PGA memory'),
  --pga_process_count
  (select value pga_process_count
    from v$pgastat
    where name='process count'),
  --pga_cache_hit_percentage
  (select value pga_process_count
    from v$pgastat
    where name='process count')
);

set linesize window
select * from karla0403.t04_pga_stats;