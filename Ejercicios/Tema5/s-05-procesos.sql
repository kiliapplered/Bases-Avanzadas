--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 13/11/2022
--@Descripción:    Script 6 del ejercicio 1 del Tema 5: Consultas, sesiones y procesos. 

-- Inciso A
prompt Iniciando sesion como sysdba
connect sys@knnbda2_pooled/system2 as sysdba

-- Inciso B
prompt Creando un nuevo registro en la tabla karla0501.t01_session_data
insert into karla0501.t01_session_data values(
  select 
  -- id
  4 as id,
  --sid
  sid,
  --logon_time
  logon_time,
  --username
  username,
  --status
  status,
  --server
  server,
  --osuser
  osuser,
  --machine
  machine,
  --type
  type,
  --process
  process,
  --port
  port
  from v$session where username='SYS' and type='USER'
);

-- Inciso C
prompt Creando tabla karla0501.t07_foreground_process
create table karla0501.t07_foreground_process as(
  select
  --sosid
  p.sosid,
  --pname
  p.pname,
  --os_username
  s.osuser os_username,
  --bd_username
  s.username bd_username,
  --server
  s.server,
  --pga_max_mem_mb
  trunc(pga_max_mem/1024/1024,2) pga_max_mem_mb,
  --tracefile
  p.tracefile
  from v$process p left join v$session s
  on p.addr = s.paddr
  where background is null
);

-- Inciso D
prompt creando tabla karla0501.t08_f_process_actual
create table karla0501.t08_f_process_actual as(
  select
  --sosid
  p.sosid,
  --pname
  p.pname,
  --os_username
  s.osuser os_username,
  --bd_username
  s.username bd_username,
  --server
  s.server,
  --pga_max_mem_mb
  trunc(pga_max_mem/1024/1024,2) pga_max_mem_mb,
  --tracefile
  p.tracefile
  from v$process p left join v$session s
  on p.addr = s.paddr
  where sys_context('USERENV','SID') = s.sid
);

-- Inciso E
prompt Creando tabla karla0501.t09_background_process
create table karla0501.t09_background_process as(
  select
  --sosid
  p.sosid,
  --pname
  p.pname,
  --os_username
  s.osuser os_username,
  --bd_username
  s.username bd_username,
  --server
  s.server,
  --pga_max_mem_mb
  trunc(pga_max_mem/1024/1024,2) pga_max_mem_mb,
  --tracefile
  p.tracefile
  from v$process p left join v$session s
  on p.addr = s.paddr
  where background is not null
);