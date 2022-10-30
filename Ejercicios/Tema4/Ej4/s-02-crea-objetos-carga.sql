--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 30/10/2022
--@Descripción:    Script 3 del ejercicio 4 del Tema 4: Simulación de carga de trabajo

-- Inciso A
Prompt Iniciando sesión con usuario karla0404
connect karla0404/karla

Prompt Creando tabla t03_random_data
create table t03_random_data(
  id number(18,0),
  r_varchar varchar2(1024),
  r_char char(18),
  r_integer number(10,0),
  r_double number(20,10),
  r_date date,
  r_timestamp timestamp
);

Prompt Creando secuencia
create sequence seq_t03_random_data;

Prompt Cargando registros aleatorios
--Observar el uso del paquete dbms_random empleado para generar valores aleatorios
set timing on
begin
  for v_index in 1..80000 loop
    insert into t03_random_data(
      id,r_varchar,r_char,r_integer,r_double,r_date,r_timestamp
    )
    values(
      seq_t03_random_data.nextval,
      sys.dbms_random.string('P',1024),
      sys.dbms_random.string('U',18),
      trunc(sys.dbms_random.value(1,9999999999)),
      trunc(sys.dbms_random.value(1,9999999999),10),
      to_date(trunc(sys.dbms_random.value(1721424,5373484)),'J') +
        sys.dbms_random.normal,
      current_timestamp
  );
  end loop;
end;
/
set timing off
--no olvidar hacer commit
commit;

--Inciso B
Prompt Creando procedimiento almacenado
create or replace procedure spv_query_random_data is
  cursor cur_consulta is
    select *
    from t03_random_data
    order by id;
  v_caracter char(1) := 'k';
  v_total number;
  v_count number;
  v_rows number;
begin
    v_total := 0;
    v_rows :=0;
    for r in cur_consulta loop
    --obtiene el número de ocurrencias en cada registro.
    select regexp_count(r.r_varchar,v_caracter) into v_count from dual;
    v_total := v_count + v_total;
    v_rows := v_rows +1;
  end loop;
  dbms_output.put_line('Carácter seleccionado: '||v_caracter);
  dbms_output.put_line('Total de ocurrencias: '||v_total);
  dbms_output.put_line('Total de registros procesados: '||v_rows);
end;
/
show errors

--Inciso C
connect sys/system2 as sysdba

Prompt Insertando nuevos registro en t01_memory_areas
insert into karla0404.t01_memory_areas values(
      -- id
    2,
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
commit;