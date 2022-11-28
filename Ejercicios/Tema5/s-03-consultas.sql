--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 12/11/2022
--@Descripción:    Script 4 del ejercicio 1 del Tema 5: Consultas en modo compartido. 

-- Inciso A
prompt Iniciando sesion como sysdba
connect sys@knnbda2_shared/system2 as sysdba

-- Inciso B
prompt Creando tabla karla0501.t02_dispatcher_config
create table karla0501.t02_dispatcher_config as(
  select 
  --id
  1 as id,
  --dispatchers
  dispatchers,
  --connections
  connections,
  --sessions
  sessions,
  --service
  service
  from v$dispatcher_config
);

-- Inciso C
prompt Creando tabla karla0501.t03_dispatcher
create table karla0501.t03_dispatcher as(
  select
  --name
  name,
  --network
  network,
  --status
  status,
  --messages
  messages,
  --messages_mb
  trunc((bytes/1024/1024),2) messages_mb,
  --circuits_created
  created circuits_created,
  --idle_min
  trunc((idle/60),2) idle_min,
  --id
  1 id
  from v$dispatcher
);

-- Inciso D
prompt Creando tabla karla0501.t04_shared_server
create table karla0501.t04_shared_server as (
  select 
  --id
  1 id, 
  --name
  name,
  --status
  status,
  --messages
  messages,
  --messages_mb
  trunc((bytes/1024/1024),2) messages_mb,
  --requests
  requests,
  --idle_min
  trunc((idle/60),2) idle_min,
  --busy_min
  trunc((busy/60),2) busy_min
  from v$shared_server 
);

-- Inciso E
prompt Creando tabla karla0501.t05_queue
create table karla0501.t05_queue as(
  select 
  -- id
  1 as id,
  --queued
  queued,
  --wait
  trunc(wait/60, 2) wait,
  --totalq
  totalq
  from v$queue 
);

-- Inciso F
prompt Creando tabla karla0501.t06_virtual_circuit
create table karla0501.t06_virtual_circuit as(
  select
  -- id 
  1 id,
  -- circuit
  ci.circuit,
  --name
  di.name,
  --server
  ci.server,
  --status
  ci.status,
  --queue
  ci.queue
  from v$dispatcher di join v$circuit ci on di.paddr=ci.dispatcher
);

commit;