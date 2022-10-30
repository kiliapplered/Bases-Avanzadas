--@Autor:           Colin Santos Luis Froylan
--@Fecha creación:  30/09/2022
--@Descripción:     Creación de tablas de pga

--A
prompt Iniciando sesion como sysdba
connect sys/system2 as sysdba

--B
create table froylan0403.t04_pga_stats as (
  select *
  from (
    --1
    select trunc(value/1024/1024,2) max_pga_mb
    from v$pgastat
    where name='maximum PGA allocated'),
    (--2
    select trunc(value/1024/1024,2) pga_target_param_calc_mb
    from v$pgastat
    where name='aggregate PGA auto target'),
    (--3
    select trunc(value/1024/1024,2) pga_target_param_actual_mb
    from v$parameter
    where name='pga_aggregate_target'),
    (--4
    select trunc(value/1024/1024,2) pga_total_actual_mb
    from v$pgastat
    where name='total PGA allocated'),
    (--5
    select trunc(value/1024/1024,2) pga_in_use_actual_mb
    from v$pgastat
    where name='total PGA inuse'),
    (--6
    select trunc(value/1024/1024,2) pga_free_memory_mb
    from v$pgastat
    where name='total freeable PGA memory'),
    (--7
    select value pga_process_count
    from v$pgastat
    where name='process count'),
    (--8
    select value pga_cache_hit_percentage
    from v$pgastat
    where name='cache hit percentage')
);

select *
from froylan0403.t04_pga_stats;