--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 30/10/2022
--@Descripción:    Script 5 del ejercicio 4 del Tema 4: Automatic Shared desde Automatic

-- Inciso A
Prompt Iniciando sesión como sysdba
connect sys/system2 as sysdba

-- Inciso B
Prompt Modificando parámetros
alter system set memory_target=0 scope=memory;
alter system set sga_target=488M scope=memory;
alter system set pga_aggregate_target=280M scope=memory;

--Inciso C
exec dbms_session.sleep(5)

Prompt Insertando registro a t02_memory_param_values con id=2
  insert into karla0404.t02_memory_param_values values(
    -- id
    2,
    -- sample_date 
    to_char(sysdate, 'DD-MON_YY HH24:MI:ss'),
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
commit;