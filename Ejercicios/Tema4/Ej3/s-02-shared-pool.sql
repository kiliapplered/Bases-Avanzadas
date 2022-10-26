--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/10/2022
--@Descripción:    Script 3 del ejercicio 3 del Tema 4: Tabla con valores del shared pool

-- Inciso A
prompt Iniciando sesion como sysdba
connect sys/system2 as sysdba

-- Inciso B
Prompt Creando tabla karla0403.t02_shared_pool
create table karla0403.t02_shared_pool as (
  select 
  --shared_pool_param_mb
  (select value/1024/1024 
    from v$parameter where name='shared_pool_size') shared_pool_param_mb,
  --shared_pool_sga_info_mb
  (select bytes/1024/1024
    from v$sgainfo where name='Shared Pool Size') shared_pool_sga_info_mb,
  --resizeable
  (select resizeable
    from v$sgainfo where name='Shared Pool Size') resizeable,
  --shared_pool_component_total
  (select count(*) 
    from v$sgastat where pool='shared pool') shared_pool_component_total,
  --shared_pool_free_memory
  bytes/1024/1024 as shared_pool_free_memory
    from v$sgastat where name='free memory' and pool='shared pool' 
);

-- Inciso C
Prompt Creando tabla karla0403.t03_library_cache_hist
create table karla0403.t03_library_cache_hist as (
  select 1 as id, reloads, invalidations, pins, pinhits, pinhitratio
  from v$librarycache where namespace='SQL AREA'
);

-- Inciso D
Prompt Creando tabla karla0403.test_orden_compra
create table karla0403.test_orden_compra(id number);

-- Inciso E
prompt Ejecutando consultas con sentencias sql estáticas
set timing on
declare
  orden_compra karla0403.test_orden_compra%rowtype;
begin
  for i in 1 .. 50000 loop
    begin
      execute immediate
        'select * from karla0403.test_orden_compra where id = ' || i
      into orden_compra;
      exception
        when no_data_found then
          null;
    end;
  end loop;
end;
/
set timing off

-- Inciso F
Prompt Capturando nuevamente estadísticas del library cache (id=2)
insert into karla0403.t03_library_cache_hist(id,reloads,invalidations,pins,
  pinhits,pinhitratio)
  select 2 id, reloads,invalidations,pins,pinhits,pinhitratio
  from v$librarycache
  where namespace='SQL AREA';
commit;

-- Inciso G
Prompt Reiniciando la instancia
shutdown immediate;
startup;

-- Inciso H
Prompt Capturando nuevamente estadísticas del library cache (id=3)
insert into karla0403.t03_library_cache_hist(id,reloads,invalidations,pins,
  pinhits,pinhitratio)
  select 3 id, reloads,invalidations,pins,pinhits,pinhitratio
  from v$librarycache
  where namespace='SQL AREA';
commit;

-- Inciso I
prompt ejecutando consultas con placeholders
set timing on
declare
  v_query varchar2(1000);
  v_orden_compra karla0403.test_orden_compra%rowtype;
begin
  for i in 1 .. 50000 loop
    begin
      v_query :=
        'select id '
        ||' into :ph_orden_compra '
        ||' from karla0403.test_orden_compra '
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

-- Inciso J
Prompt Capturando nuevamente estadísticas del library cache (id=4)
insert into karla0403.t03_library_cache_hist(id,reloads,invalidations,pins,
  pinhits,pinhitratio)
  select 4 id, reloads,invalidations,pins,pinhits,pinhitratio
  from v$librarycache
  where namespace='SQL AREA';
commit;

--Inciso K
Prompt MOstrando datos de karla0403.t03_library_cache_hist
set linesize window
select * from karla0403.t03_library_cache_hist order by id;
