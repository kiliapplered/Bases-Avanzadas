--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 3 del ejercicio 2 del Tema 6: Asignación de cuotas y usuarios

whenever sqlerror exit rollback;

Prompt Conectando como usuario sysdba
connect sysdba/system2

-- Inciso A
select 
  tablespace_name,
  block_size,
  initial_extent,
  next_extent, 
  max_size,
  status,
  contents,
  logging
from dba_tablespaces;

-- Inciso B
select 
  tablespace_name,
  extent_management, 
  segment_space_management,
  bigfile,
  encrypted
from dba_tablespaces;

-- Inciso C
select
du.username,
du.default_tablespace,
du.temporary_tablespace,
case dtq.max_bytes
  when -1 then 'UNLIMITED'
  else round(dtq.max_bytes/1024/1024, 2),
round(bytes/1024/1024, 2) allocated_mb,
blocks
from dba_users du
left join dba_ts_quotas dtq on du.default_tablespace=dtq.tablespace_name
where du.username='KARLA0401' and dtq.username='KARLA0401';

select
du.username,
du.default_tablespace,
du.temporary_tablespace,
'UNLIMITED' quota_mb,
round(bytes/1024/1024, 2) allocated_mb,
blocks
from dba_users du
left join dba_ts_quotas dtq on du.default_tablespace=dtq.tablespace_name
where du.username='KARLA0401' and dtq.username='KARLA0401';


whenever sqlerror continue none;