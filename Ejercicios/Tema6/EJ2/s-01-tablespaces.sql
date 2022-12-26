--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 2 del ejercicio 2 del Tema 6: Creación de tablespaces

whenever sqlerror exit rollback;

-- Inciso A
Prompt Conectando como usuario sysdba
connect sysdba/system2

-- Inciso B
create tablespace store_tbs1 
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs01.dbf' size 20m
  extent management local autoallocate
  segment space management auto;

-- Inciso C
create tablespace store_tbs_multiple
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_01.dbf' size 10m
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_02.dbf' size 10m
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_03.dbf' size 10m
  extent management local autoallocate
  segment space management auto;

-- Iniciso D
create bigfile tablespace store_tbs_big
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_big.dbf' size 100m
  autoextend off 
  segment space management auto
  extent management local autoallocate;

-- Inciso E
create smallfile tablespace store_tbs_zip
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_small.dbf' size 10m
  default index compress advanced high;

-- Inciso F
create temporary tablespace store_tbs_temp
  tempfile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_temp.dbf'
  reuse
  extent management local uniform size 16m;

-- Inciso G
create tablespace store_tbs_custom
  datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_custom_01.dbf' size 10m
    reuse
    blocksize 8k
    autoextend on next 1m maxsize 30m
  extent management local uniform size 64k
  segment space management auto
  nologging
  offline;

whenever sqlerror continue none;