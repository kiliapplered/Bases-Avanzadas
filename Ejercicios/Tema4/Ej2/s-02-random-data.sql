--@Autor: 	       Najera Noyola Karla Andrea
--@Fecha creación: 27/09/2022
--@Descripción:    Script 3 del ejercicio 2 del Tema 4: Consultas de DB buffer

prompt Iniciando sesion con usuario karla0402
connect karla0402/karla

Prompt creando tabla t03_random_data
create table t03_random_data(
  id number,
  random_string varchar2(1024)
);

Prompt creando tabla t04_db_buffer_status
create table t04_db_buffer_status(
  id number generated always as identity,
  total_bloques number,
  status varchar2(10),
  evento varchar2(30)
);

Prompt insertando datos
declare
  v_rows number;
  v_query varchar2(100);
begin
  v_rows := 1000*10;
  v_query :=
    'insert into t03_random_data(id, random_string) values (:ph1,:ph2)';
  for v_index in 1 .. v_rows loop
    execute immediate v_query
      using v_index, dbms_random.string('P',1016);
  end loop;
end;
/
commit;

prompt Conectando como sys
connect sys/system2 as sysdba

prompt Insertando en t04_db_buffer_status
insert into karla0402.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después de carga' as evento
  from v$bh
  where objd = (
  select data_object_id
  from dba_objects
  where object_name='T03_RANDOM_DATA'
  and owner = 'KARLA0402'
)
group by status;
commit;

--F
prompt Liberando buffers de cache
alter system flush buffer_cache;

--G
prompt Mostrando datos después de limpiar cache
insert into karla0402.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después de vaciar db buffer' as evento
  from v$bh
  where objd = (
  select data_object_id
  from dba_objects
  where object_name='T03_RANDOM_DATA'
  and owner = 'KARLA0402'
)
group by status;

--H
prompt Reiniciando instancia
commit;
shutdown immediate;
startup;

--I
prompt Mostrando datos después de reiniciar
insert into karla0402.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después del reinicio' as evento
  from v$bh
  where objd = (
  select data_object_id
  from dba_objects
  where object_name='T03_RANDOM_DATA'
  and owner = 'KARLA0402'
)
group by status;
commit;

--J
prompt Modificando un registro de la tabla
update karla0402.t03_random_data set random_string= upper(random_string)
where id = 573;

--K
prompt Mostrando datos después del cambio 1
insert into karla0402.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después del cambio 1' as evento
  from v$bh
  where objd = (
  select data_object_id
  from dba_objects
  where object_name='T03_RANDOM_DATA'
  and owner = 'KARLA0402'
)
group by status;

--L
prompt En otra terminal crear una sesión con el usuario <nombre>0402
prompt consultar el registro modificado 3 veces
pause "select * from t03_random_data where id =<id>", [enter] para continuar

--M
prompt Mostrando datos después de 3 consultas
insert into karla0402.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después de 3 consultas' as evento
  from v$bh
  where objd = (
  select data_object_id
  from dba_objects
  where object_name='T03_RANDOM_DATA'
  and owner = 'KARLA0402'
)
group by status;

--N
prompt Mostrando los datos finales
select * from karla0402.t04_db_buffer_status;