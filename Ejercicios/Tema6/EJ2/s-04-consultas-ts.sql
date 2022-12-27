--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 3 del ejercicio 2 del Tema 6: Asignación de cuotas y usuarios

whenever sqlerror exit rollback;

Prompt Conectando como usuario sysdba
connect sys/system2 as sysdba

-- Inciso A
Prompt Consulta 1
select 
  tablespace_name,
  block_size,
  initial_extent,
  next_extent, 
  max_size,
  status,
  logging
from dba_tablespaces;

-- Inciso B
Prompt Consulta 2
select 
  tablespace_name,
  extent_management, 
  segment_space_management,
  bigfile,
  encrypted
from dba_tablespaces;

-- Inciso C
Prompt Consulta 3
select username as username,
  default_tablespace as default_tablespace,
  temporary_tablespace as temporary_tablespace,
  (select decode (max_bytes, -1 , 'UNLIMITED'
                            , max_bytes/1024/1024)
   from dba_ts_quotas
   where tablespace_name=(select default_tablespace
                          from dba_users
                          where username='KARLA0602')) as quota_mb,
  (select sum(bytes)/1024/1024
   from dba_ts_quotas
   where username='KARLA0602') as allocated_mb,
  (select sum(blocks)
   from dba_ts_quotas
   where username='KARLA0602') as blocks
from dba_users
where username='KARLA0602';

whenever sqlerror continue none;