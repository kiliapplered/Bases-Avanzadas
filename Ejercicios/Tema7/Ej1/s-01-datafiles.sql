--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 3 del ejercicio 2 del Tema 6: Asignación de cuotas y usuarios

whenever sqlerror exit rollback;

Prompt Conectando como usuario sysdba
connect sysdba/system2

-- Inciso A versión 1
select file#, name, con_id, round(bytes/1024/1024, 2) tam_mb from v$datafile where name like '%store_tbs_multiple%';

-- Inciso A versión 2
select file_name, file_id, relative_fno, round(bytes/1024/1024, 2) from dba_data_files where tablespace_name='store_tbs_multiple';

--- Inciso B
select 
  tablespace_name, round(sum(bytes)/1024/1024, 2) mb_free, sum(blocks)
from dba_free_space
where tablespace_name='store_tbs_multiple'
group by tablespace_name;

-- Inciso C
Prompt creando al usuario karla072 y asignando privilegios
create user karla072 identified by karla quota unlimited on store_tbs_multiple;
alter user karla072 default tablespace store_tbs_multiple;

-- Inciso D
create table karla072.karla_tbs_multiple (
  str  varchar2(1000);
)
segment creation immediate;

-- Inciso E
-- Pendiente

-- Inciso F
Prompt Bloque anónimo para poblar la tabla con 512 registros
declare
  v_str varchar2(1000);
begin
  v_str:='Llenando la tabla con cadenas random';
  for v_index in 1..512 loop
  execute immediate 'insert into karla072.karla_tbs_multiple values(:ph1)'
    using v_str;
  end loop;
  commit;
end;
/

-- Inciso G
-- Pendiente

-- Inciso H
Prompt Bloque anónimo para poblar la tabla con 2560 registros
declare
  v_str varchar2(1000);
begin
  v_str:='Llenando la tabla con cadenas random';
  for v_index in 1..2560 loop
  execute immediate 'insert into karla072.karla_tbs_multiple values(:ph1)'
    using v_str;
  end loop;
  commit;
end;
/

-- Inciso I
select 
  tablespace_name, round(sum(bytes)/1024/1024, 2) mb_free, sum(blocks)
from dba_free_space
where tablespace_name='store_tbs_multiple'
group by tablespace_name;

whenever sqlerror continue none;