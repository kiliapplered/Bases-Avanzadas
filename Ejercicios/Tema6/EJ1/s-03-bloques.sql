--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 27/11/2022
--@Descripción:    Script 4 del ejercicio 1 del Tema 6: Visualizar el uso de espacio a nivel bloque

whenever sqlerror exit rollback;

-- Inciso A
Prompt Conectando como usuario karla0601
connect karla0601/karla

-- Inciso B
Prompt Creando tabla t03_random_str
create table t03_random_str(
  str varchar2(1024)
);

-- Inciso C
Prompt Bloque anónimo para poblar la tabla llenando 5 extensiones (280 registros)
declare
begin
  for v_index in 1..280 loop
  execute immediate 'insert into t03_random_str(:val_aleatorio)'
  using dbms_random.string('a', 1024);
  end loop;
  commit;
end;
/

-- Inciso D
Prompt Creando tabla t04_space_usage
create table t04_space_usage(
  id number,
  segment_name varchar2(128),
  unformatted_blocks number, --número de bloques reservados sin formatear
  unused_blocks number, --número de bloques reservados sin uso
  total_blocks number, --total de bloques reservados para la tabla
  free_space_0_25 number, --número de bloques con espacio libre entre el 0 y 25%
  free_space_25_50 number, --número de bloques con espacio libre entre el 25 y 50%
  free_space_50_75 number, --número de bloques con espacio libre entre el 50 y 75%
  free_space_75_100 number --número de bloques con espacio libre entre el 75 y 100%
);

-- Inciso E
create or replace procedure get_space_usage_info( p_id number) is
  v_unformatted_blocks number;
  v_0_25_free number;
  v_25_50_free number;
  v_50_75_free number;
  v_75_100_free number;
  v_not_used number;
  v_total_blocks number;
  v_unused_blocks number;
begin
  --Uso del espacio a nivel de bloque.
  dbms_space.space_usage(
  segment_owner => 'JORGE0601',
  segment_name => 'T03_RANDOM_STR',
  segment_type => 'TABLE',
  unformatted_blocks => v_unformatted_blocks,
  unformatted_bytes => v_not_used,
  fs1_blocks => v_0_25_free,
  fs2_blocks => v_25_50_free,
  fs3_blocks => v_50_75_free,
  fs4_blocks => v_75_100_free,
  fs1_bytes => v_not_used,
  fs2_bytes => v_not_used,
  fs3_bytes => v_not_used,
  fs4_bytes => v_not_used,
  full_blocks => v_not_used,
  full_bytes => v_not_used
  );
  --consulta de espacio no utilizado
  dbms_space.unused_space (
  segment_owner => 'JORGE0601',
  segment_name => 'T03_RANDOM_STR',
  segment_type => 'TABLE',
  total_blocks => v_total_blocks,
  total_bytes => v_not_used,
  unused_blocks => v_unused_blocks,
  unused_bytes => v_not_used,
  last_used_extent_file_id => v_not_used,
  last_used_extent_block_id => v_not_used,
  last_used_block => v_not_used
);
-- Agregar aquí la instrucción insert a la tabla t04_space_usage
-- empleando en la cláusula values, los valores de las variables
-- de este procedimiento así como el parámetro p_id
  insert into t04_space_usage (id, segment_name, unformatted_blocks. unused_blocks, total_blocks, 
    free_space_0_25, free_space_25_50, free_space_50_75, free_space_75_100) values (p_id,'T03_RANDOM_STR', 
    v_unformatted_blocks, v_not_used, v_total_blocks, v_0_25_free, v_25_50_free, v_50_75_free, v_75_100_free);
end;
/
show errors

-- Inciso F
Prompt Obteniendo datos de uso posterior a la creación de la tabla
exec get_space_usage_info(1);

-- Inciso G
Prompt eliminado todos los datos de la tabla t03_random_str

-- Inciso H
Prompt Obteniendo datos de uso posterior a la creación de la tabla
exec get_space_usage_info(2);

whenever sqlerror continue none;