--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 12/11/2022
--@Descripción:    Script 3 del ejercicio 1 del Tema 5: Configuración en modo dedicado y compartido. 

-- Inciso A
prompt Iniciando sesion como sysdba
connect sys/system2 as sysdba

-- Inciso B
prompt Creando la tabla karla0501.t01_session_data y agregando un registro
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
create table karla0501.t01_session_data as (
  select 
  -- id
  1 as id,
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
prompt Confirmando la inserción de los datos con id=1
commit;

-- Inciso D
prompt Saliendo de sesión
disconnect
prompt Iniciando sesión en modo dedicado
connect sys@knnbda2_dedicated/system2 as sysdba

-- Inciso E
prompt Creando un nuevo registro en la tabla karla0501.t01_session_data
insert into karla0501.t01_session_data values(
  select 
  -- id
  2 as id,
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

-- Inciso F
prompt Confirmando la inserción de los datos con id=2
commit;

-- Inciso G
prompt Saliendo de sesión
disconnect
prompt Iniciando sesión en compartido
connect sys@knnbda2_shared/system2 as sysdba

-- Inciso H
prompt Creando un nuevo registro en la tabla karla0501.t01_session_data
insert into karla0501.t01_session_data values(
  select 
  -- id
  3 as id,
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

-- Inciso F
prompt Confirmando la inserción de los datos con id=3
commit;

-- Tabla karla0501.t01_session_data
set linesize window
column username format a30
column osuser format a30
select * from karla0501.t01_session_data;