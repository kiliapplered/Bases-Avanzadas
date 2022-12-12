--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 27/11/2022
--@Descripción:    Script 3 del ejercicio 1 del Tema 6: Uso de espacio a nivel extensión

whenever sqlerror exit rollback;

-- Inciso A
Prompt Conectando como usuario karla0601
connect karla0601/karla

-- Inciso B
Prompt Creando tabla de empleado
create table str_data(
  str     char(1024)
)
segment creation immediate
PCTFREE 0;

-- Inciso C
select lengthb(str), length(str) from str_data where str='a';

-- Inciso D
-- No entendi este inciso, pero si el cálculo es solo manual se necesitan 56 registros (64 contando los headers)
Prompt Dado que el campo es de tipo char, se reservarán 1024 bytes para cada registro
Prompt Considerando que el bloque es de 8192 bytes, en cada bloque caben 8 registros (7 contando el header)
Prompt Asimismo, al consultar dba_tablespaces.initial_extent el tamaño por default de una extensión es de 65536 bytes
Prompt Por lo anterior, caben 8 bloques por extensión ya que 65536/8192=8
Prompt Dado que una extensión tiene 8 blqoues, 8*7=56 registros aproximadamente cabran en cada extensión


-- Inciso E
Prompt Bloque anónimo para poblar la tabla con 56 registros
declare
  v_letter char(1);
begin
  v_letter:='a';
  for v_index in 1..56 loop
  execute immediate 'insert into str_data values(:ph1)'
    using v_letter;
  end loop;
  commit;
end;
/

--Inciso F
select * from user_extents where segment_name='STR_DATA';

-- Inciso G
Prompt Consultando los ROWIDs asignados
select rowid from str_data order by 1;

-- Inciso H
create table t02_str_data_extents as(
  select substr(rowid, 1, 15) as codigo_bloque, count(*) total_registros
  from str_data
  group by substr(rowid, 1, 15)
);

whenever sqlerror continue none;