--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 2 del ejercicio 2 del Tema 6: Creación de tablespaces

-- Inciso A
Prompt Conectando como usuario sysdba
connect sys/system2 as sysdba

-- Inciso B
Prompt Creando tablespace store_tbs1
create tablespace store_tbs1 
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs01.dbf' 
    size 20m
  extent management local autoallocate
  segment space management auto;

-- Inciso C
Prompt Creando tablespace store_tbs_multiple
create tablespace store_tbs_multiple
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_01.dbf' size 10m,
           '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_02.dbf' size 10m,
           '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_03.dbf' size 10m
  extent management local autoallocate
  segment space management auto;

-- Inciso D
Prompt Creando tablespace store_tbs_big
create bigfile tablespace store_tbs_big
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_big01.dbf' 
    size 100m
  autoextend off 
  segment space management auto
  extent management local autoallocate;

-- Inciso E
Prompt Creando tablespace store_tbs_zip
create smallfile tablespace store_tbs_zip
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_small01.dbf' 
    size 10m
  default index compress advanced high;

-- Inciso F
Prompt Creando tablespace store_tbs_temp
create temporary tablespace store_tbs_temp
  tempfile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_temp01.dbf'
    size 16m reuse;

-- Inciso G
Prompt Creando tablespace store_tbs_custom
create tablespace store_tbs_custom
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_custom_01.dbf' 
    size 10m
    reuse
    autoextend on next 1m maxsize 30m
  nologging
  offline
  blocksize 8k
  extent management local uniform size 64k
  segment space management auto;
