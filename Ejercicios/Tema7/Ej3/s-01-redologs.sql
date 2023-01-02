--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 2 del ejercicio 2 del Tema 6: Creación de tablespaces

Prompt Conectando como usuario sysdba
connect sysdba/system2

-- Inciso A (2 posibles instrucciones)
!sudo find  /unam-bda/d0* -exec du -h {} \; | grep -i app/oracle/oradata/KNNBDA2/redo
!sudo find /unam-bda/d0* -name "*redo*.log" -type f -exec ls -l {} \;

-- Inciso B
select group#, sequence#, round(bytes/1024/1024, 2) size_mb, blocksize, members, status, 
  first_change#, to_char(first_time, 'DD/MM/YYYY HH24:MI:SS') fecha_seg, next_change#
  from v$log;

-- Inciso C
-- Grupo 3

-- Inciso D
select group#, status, type, member from v$logfile;

-- Inciso E
alter database
add logfile
group 4 ('/unam-bda/d01/app/oracle/oradata/KNNBDA2/redo04a.log','/unam-bda/d02/app/oracle/oradata/KNNBDA2/redo04b.log')
size 80m blocksize 512;

alter database
add logfile
group 5 ('/unam-bda/d01/app/oracle/oradata/KNNBDA2/redo05a.log','/unam-bda/d02/app/oracle/oradata/KNNBDA2/redo05b.log')
size 80m blocksize 512;

alter database
add logfile
group 6 ('/unam-bda/d01/app/oracle/oradata/KNNBDA2/redo06a.log','/unam-bda/d02/app/oracle/oradata/KNNBDA2/redo06b.log')
size 80m blocksize 512;

-- Inciso F
alter database
add logfile member '/unam-bda/d03/app/oracle/oradata/KNNBDA2/redo04c.log' to
('/unam-bda/d01/app/oracle/oradata/KNNBDA2/redo04a.log','/unam-bda/d02/app/oracle/oradata/KNNBDA2/redo04b.log');

alter database
add logfile member '/unam-bda/d03/app/oracle/oradata/KNNBDA2/redo05c.log' to
('/unam-bda/d01/app/oracle/oradata/KNNBDA2/redo05a.log','/unam-bda/d02/app/oracle/oradata/KNNBDA2/redo05b.log');

alter database
add logfile member '/unam-bda/d03/app/oracle/oradata/KNNBDA2/redo06c.log' to
('/unam-bda/d01/app/oracle/oradata/KNNBDA2/redo06a.log','/unam-bda/d02/app/oracle/oradata/KNNBDA2/redo06b.log');

-- Inciso G
select group#, sequence#, round(bytes/1024/1024, 2) size_mb, blocksize, members, status, 
  first_change#, to_char(first_time, 'DD/MM/YYYY HH24:MI:SS') fecha_seg, next_change#
  from v$log;

-- Inciso H
select group#, status, type, member from v$logfile;

-- Inciso I
alter system switch logfile;
select group#, sequence#, round(bytes/1024/1024, 2) size_mb, blocksize, members, status, 
  first_change#, to_char(first_time, 'DD/MM/YYYY HH24:MI:SS') fecha_seg, next_change#
  from v$log;

-- Inciso J
alter database clear unarchived logfile group 1;
alter database clear unarchived logfile group 2;
alter database clear unarchived logfile group 3;
select group#, sequence#, round(bytes/1024/1024, 2) size_mb, blocksize, members, status, 
  first_change#, to_char(first_time, 'DD/MM/YYYY HH24:MI:SS') fecha_seg, next_change#
  from v$log;

-- Inciso K
alter database drop logfile group 1;
alter database drop logfile group 2;
alter database drop logfile group 3;
select group#, sequence#, round(bytes/1024/1024, 2) size_mb, blocksize, members, status, 
  first_change#, to_char(first_time, 'DD/MM/YYYY HH24:MI:SS') fecha_seg, next_change#
  from v$log;

--Inciso L
!sudo find  /unam-bda/d0* -exec du -h {} \; | grep -i app/oracle/oradata/KNNBDA2/redo
!sudo find /unam-bda/d0* -name "*redo*.log" -type f -exec ls -l {} \;
!sudo rm /unam-bda/d01/app/oracle/oradata/KNNBDA2/redo01a.log
!sudo rm /unam-bda/d01/app/oracle/oradata/KNNBDA2/redo02a.log
!sudo rm /unam-bda/d01/app/oracle/oradata/KNNBDA2/redo03a.log
!sudo rm /unam-bda/d02/app/oracle/oradata/KNNBDA2/redo01b.log
!sudo rm /unam-bda/d02/app/oracle/oradata/KNNBDA2/redo02b.log
!sudo rm /unam-bda/d02/app/oracle/oradata/KNNBDA2/redo03b.log
!sudo rm /unam-bda/d03/app/oracle/oradata/KNNBDA2/redo01c.log
!sudo rm /unam-bda/d03/app/oracle/oradata/KNNBDA2/redo02c.log
!sudo rm /unam-bda/d03/app/oracle/oradata/KNNBDA2/redo03c.log

-- Inciso M
!sudo find  /unam-bda/d0* -exec du -h {} \; | grep -i app/oracle/oradata/KNNBDA2/redo
!sudo find /unam-bda/d0* -name "*redo*.log" -type f -exec ls -l {} \;