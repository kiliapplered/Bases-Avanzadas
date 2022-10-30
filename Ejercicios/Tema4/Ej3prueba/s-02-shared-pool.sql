--@Autor:           Colin Santos Luis Froylan
--@Fecha creación:  29/09/2022
--@Descripción:     Creación de tablas de shared pool

--A
prompt Iniciando sesion como sysdba
connect sys/system2 as sysdba

--B
prompt Creando tabla t02_shared_pool
create table froylan0403.t02_shared_pool as(
  select
    (select value/1024/1024
      from v$parameter
      where name='shared_pool_size') shared_pool_param_mb,
    (select bytes/1024/1024
      from v$sgainfo
      where name='Shared Pool Size') shared_pool_sga_info_mb,
    (select resizeable
      from v$sgainfo
      where name='Shared Pool Size') resizeable,
    (select count(*)
      from v$sgastat
      where pool='shared pool') shared_pool_component_total,
    bytes/1024/1024 shared_pool_free_memory
  from v$sgastat
  where name='free memory' and pool='shared pool'
);

--C
prompt Creando tabla t03_library_cache_hist
create table froylan0403.t03_library_cache_hist as(
  select 1 id, reloads, invalidations, pins, pinhits, pinhitratio
  from v$librarycache
  where namespace='SQL AREA'
);

--D
prompt Creando tabla test_orden_compra
create table froylan0403.test_orden_compra(id number);

--E
prompt ejecutando consultas con sentencias sql estáticas
set timing on
declare
  orden_compra froylan0403.test_orden_compra%rowtype;
begin
  for i in 1 .. 50000 loop
    begin
      execute immediate
        'select * from froylan0403.test_orden_compra where id = ' || i
      into orden_compra;
      exception
        when no_data_found then
          null;
    end;
  end loop;
end;
/
set timing off

--F
prompt capturando nuevamente estadísticas del library cache (id=2)
insert into froylan0403.t03_library_cache_hist(id,reloads,invalidations,pins,
  pinhits,pinhitratio)
  select 2 id, reloads,invalidations,pins,pinhits,pinhitratio
  from v$librarycache
  where namespace='SQL AREA';
commit;

--G
prompt Reiniciando instancia
shutdown immediate;
startup;

--H
prompt capturando nuevamente estadísticas del library cache (id=3)
insert into froylan0403.t03_library_cache_hist(id,reloads,invalidations,pins,
  pinhits,pinhitratio)
  select 3 id, reloads,invalidations,pins,pinhits,pinhitratio
  from v$librarycache
  where namespace='SQL AREA';
commit;

--I
prompt ejecutando consultas con placeholders
set timing on
declare
  v_query varchar2(1000);
  v_orden_compra froylan0403.test_orden_compra%rowtype;
begin
  for i in 1 .. 50000 loop
    begin
      v_query :=
        'select id '
        ||' into :ph_orden_compra '
        ||' from froylan0403.test_orden_compra '
        ||' where id=:ph_id';
      
      execute immediate v_query into v_orden_compra using i;
      exception
        when no_data_found then
          null;
    end;
  end loop;
end;
/
set timing off

--J
prompt capturando nuevamente estadísticas del library cache (id=4)
insert into froylan0403.t03_library_cache_hist(id,reloads,invalidations,pins,
  pinhits,pinhitratio)
  select 4 id, reloads,invalidations,pins,pinhits,pinhitratio
  from v$librarycache
  where namespace='SQL AREA';
commit;

--K
prompt mostrando datos de t03_library_cache_hist ...
set linesize window

select *
from froylan0403.t03_library_cache_hist
order by id;