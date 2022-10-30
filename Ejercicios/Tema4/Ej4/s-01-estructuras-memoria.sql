--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 30/10/2022
--@Descripción:    Script 2 del ejercicio 4 del Tema 4: Estructuras de memoria

-- Inciso A
connect sys/system2 as sysdba

Prompt Creando tabla t01_memory_areas
create table karla0404.t01_memory_areas as (
  select * from(
    -- id
    select 1 as id,
    -- sample_date 
    to_char(sysdate, 'DD-MON_YY HH24:MI:ss') sample_date from dual ),
    -- redo_buffer_mb
    (select trunc((bytes/1024/1024),2) redo_buffer_mb from v$sgainfo where name='Redo Buffers'),
    -- buffer_cache_mb
    (select trunc((bytes/1024/1024),2) buffer_cache_mb from v$sgainfo where name='Buffer Cache Size'),
    -- shared_pool_mb
    (select trunc((bytes/1024/1024),2) shared_pool_mb from v$sgainfo where name='Shared Pool Size'),
    -- large_pool_mb
    (select trunc((bytes/1024/1024),2) large_pool_mb from v$sgainfo where name='Large Pool Size'),
    -- java_pool_mb
    (select trunc((bytes/1024/1024),2) java_pool_mb from v$sgainfo where name='Java Pool Size'),
    -- total_sga_mb1
    (select
      trunc(
      (
        (select sum(value) from v$sga)-
        (select current_size from v$sga_dynamic_free_memory)
      )/1024/1024,2
      ) as total_sga_mb1 from dual),
    -- total_sga_mb2
    (select
      trunc(
      (
        (select sum(current_size) from v$sga_dynamic_components) +
        (select value from v$sga where name ='Fixed Size') +
        (select value from v$sga where name ='Redo Buffers')
      ) /1024/1024,2
    ) as total_sga_mb2 from dual),
    -- total_sga_mb3
    (select
      trunc(
        (
          select sum(bytes) from v$sgainfo where name not in (
          'Granule Size',
          'Maximum SGA Size',
          'Startup overhead in Shared Pool',
          'Free SGA Memory Available',
          'Shared IO Pool Size'
          )
        ) /1024/1024,2
      ) as total_sga_mb3 from dual),
    -- total_pga_mb1
    (select trunc(value/1024/1024,2) total_pga_mb1
    from v$pgastat where name ='aggregate PGA target parameter'),
    -- total_pga_mb2
    (select trunc(current_size/1024/1024,2) total_pga_mb2
    from v$sga_dynamic_free_memory),
    -- max_pga
    (select trunc((value/1024/1024),2) max_pga from v$pgastat where name='maximum PGA allocated')
);

-- Inciso C
Prompt Creando tabla t02_memory_param_values
create table karla0404.t02_memory_param_values as (
  select * from(
    -- id
    select 1 as id,
    -- sample_date 
    to_char(sysdate, 'DD-MON_YY HH24:MI:ss') sample_date from dual ),
  -- memory_target
    (select trunc((value/1024/1024),2) memory_target from v$parameter where name='memory_target'),
  -- sga_target
    (select trunc((value/1024/1024),2) sga_target from v$parameter where name='sga_target'),
  -- pga_aggregate_target
    (select trunc((value/1024/1024),2) pga_aggregate_target from v$parameter where name='pga_aggregate_target'),
  -- shared_pool_size
    (select trunc((value/1024/1024),2) shared_pool_size from v$parameter where name='shared_pool_size'),
  -- large_pool_size
    (select trunc((value/1024/1024),2) large_pool_size from v$parameter where name='large_pool_size'),
  -- java_pool_size
    (select trunc((value/1024/1024),2) java_pool_size from v$parameter where name='java_pool_size'),
  -- db_cache_size
    (select trunc((value/1024/1024),2) db_cache_size from v$parameter where name='db_cache_size')
);

