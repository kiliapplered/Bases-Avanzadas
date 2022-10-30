--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 30/10/2022
--@Descripción:    Script 3 del ejercicio 4 del Tema 4: Simulación de carga de trabajo

-- Inciso A
Prompt Iniciando sesión como sysdba
connect sys/system2 as sysdba

-- Inciso B
Prompt Reiniciando la instancia
shutdown immediate
startup

-- Inciso C
Prompt Iniciando sesión con usuario karla0404
connect karla0404/karla

-- Inciso D
Prompt Ejecutando procedimiento
set timing on
exec spv_query_random_data
set timing off

-- Inciso E
Prompt Iniciando sesión como sysdba
connect sys/system2 as sysdba

-- Inciso F
Prompt Insertando nuevos registros en t01_memory_areas
insert into karla0404.t01_memory_areas values(
      -- id
    3,
    -- sample_date 
    to_char(sysdate, 'DD-MON_YY HH24:MI:ss'),
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

-- Inciso G
commit;

Prompt Mostrando contenido de la tabla t01_memory_areas;
select * from karla0404.t01_memory_areas;