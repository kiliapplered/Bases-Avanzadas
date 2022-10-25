--@Autor: 	       Najera Noyola Karla Andrea
--@Fecha creación: 27/09/2022
--@Descripción:    Script 2 del ejercicio 2 del Tema 4: Consultas de componentes SGA

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

prompt Creando tabla t01_db_buffer_cache
create table karla0402.t01_db_buffer_cache as(
  (select block_size,current_size,buffers,
    target_buffers,prev_size,prev_buffers,
    0 default_pool_size
  from v$buffer_pool)
);

prompt Creando tabla t02_db_buffer_sysstats
create table karla0402.t02_db_buffer_sysstats as(
  select q1.db_blocks_gets_from_cache,
    q2.consistent_gets_from_cache,
    q3.physical_reads_cache,
    trunc(1-(q3.physical_reads_cache/(q1.db_blocks_gets_from_cache+q2.consistent_gets_from_cache)),6)
      cache_hit_radio
  from
    (select value as db_blocks_gets_from_cache
    from v$sysstat
    where name='db block gets from cache') q1,
    (select value as consistent_gets_from_cache
    from v$sysstat
    where name='consistent gets from cache') q2,
    (select value as physical_reads_cache
    from v$sysstat
    where name='physical reads cache') q3
);

whenever sqlerror continue none;