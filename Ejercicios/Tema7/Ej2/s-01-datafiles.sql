--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 3 del ejercicio 2 del Tema 6: Asignación de cuotas y usuarios

Prompt Conectando como usuario sysdba
connect sys/system2 as sysdba

-- Inciso A
alter database datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_01.dbf' offline;
alter database datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_02.dbf' offline;
alter database datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_03.dbf' offline;

-- Inciso B
alter tablespace store_tbs_multiple offline;

-- Inciso C
select count(*) from karla0701.karla_tbs_multiple;

-- Inciso D
select file_name, file_id, online_status
from dba_data_files
where tablespace_name='STORE_TBS_MULTIPLE';

-- Inciso E
alter tablespace store_tbs_multiple
  rename datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_01.dbf',
                  '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_02.dbf',
                  '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_03.dbf'
                to '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_013.dbf',
                   '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_023.dbf',
                   '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_033.dbf';
select file_name, file_id, online_status
from dba_data_files
where tablespace_name='STORE_TBS_MULTIPLE';

-- Inciso F
alter database
  move datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_013.dbf'
                to '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_01.dbf';
alter database
  move datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_023.dbf'
                to '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_02.dbf';
alter database
  move datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_033.dbf'
                to '/u01/app/oracle/oradata/KNNBDA2/store_tbs_multiple_03.dbf';
! sudo ls -l /u01/app/oracle/oradata/KNNBDA2/

-- Inciso G
alter tablespace store_tbs1 offline;
alter tablespace store_tbs1 drop datafile '/u01/app/oracle/oradata/KNNBDA2/store_tbs01.dbf';


-- Inciso H
alter tablespace store_tbs1 online;