--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 3 del ejercicio 2 del Tema 6: Asignación de cuotas y usuarios

whenever sqlerror exit rollback;

set linesize window

Prompt Conectando como usuario sysdba
connect sys/system2 as sysdba

set linesize window
column nombre_df format a30

-- Inciso A
Prompt Consulta 1
col file_name format a65
select file_name, file_id, round(bytes/1024/1024, 2) tam_mb
from dba_data_files where tablespace_name='STORE_TBS_MULTIPLE';

--- Inciso B
Prompt Consulta 2
select 
  tablespace_name, round(sum(bytes)/1024/1024, 2) mb_free, sum(blocks) bloques_disponibles
from dba_free_space
where tablespace_name='STORE_TBS_MULTIPLE'
group by tablespace_name;

-- Inciso C
Prompt Creando al usuario karla072 y asignando privilegios
drop user karla072 cascade;
create user karla072 identified by karla quota unlimited on store_tbs_multiple;
alter user karla072 default tablespace store_tbs_multiple;
grant create session, create table, create procedure to karla072;

-- Inciso D
Prompt Creando tabla karla_tbs_multiple
create table karla072.karla_tbs_multiple (
  str  char(1024)
) segment creation immediate;

-- Inciso E
Prompt Consulta 3
select df.file_name nombre_df, df.file_id id_df,
  s.extents total_extents, s.bytes/1024/1024 total_mbs, s.blocks total_bloques
from dba_data_files df join dba_segments s on s.header_file=df.file_id
where s.segment_name='KARLA_TBS_MULTIPLE';

-- Inciso F
Prompt Bloque anónimo para poblar la tabla con 512 registros
declare
  v_str varchar2(1024);
begin
  v_str:='Llenando la tabla con cadenas random';
  for v_index in 1..512 loop
  execute immediate 'insert into karla072.karla_tbs_multiple values(:ph1)'
    using v_str;
  end loop;
  commit;
end;
/
show errors
commit;

-- Inciso G
Prompt Consulta del inciso E otra vez 
select df.file_name nombre_df, df.file_id id_df,
  s.extents total_extents, s.bytes/1024/1024 total_mbs, s.blocks total_bloques
from dba_data_files df join dba_segments s on s.header_file=df.file_id
where s.segment_name='KARLA_TBS_MULTIPLE';

-- Inciso H
Prompt Bloque anónimo para poblar la tabla con 2560 registros
declare
  v_str varchar2(1024);
begin
  v_str:='Llenando la tabla con cadenas random';
  for v_index in 1..2560 loop
  execute immediate 'insert into karla072.karla_tbs_multiple values(:ph1)'
    using v_str;
  end loop;
  commit;
end;
/
show errors
commit;

-- Inciso E de nuevo
Prompt Consulta del inciso E otra vez 
select df.file_name nombre_df, df.file_id id_df,
  s.extents total_extents, s.bytes/1024/1024 total_mbs, s.blocks total_bloques
from dba_data_files df join dba_segments s on s.header_file=df.file_id
where s.segment_name='KARLA_TBS_MULTIPLE';

-- Inciso I
Prompt Consulta  del inciso B otra vez
select 
  tablespace_name, round(sum(bytes)/1024/1024, 2) mb_free, sum(blocks) bloques_disponibles
from dba_free_space
where tablespace_name='STORE_TBS_MULTIPLE'
group by tablespace_name;

whenever sqlerror continue none;