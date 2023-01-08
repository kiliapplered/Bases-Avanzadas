--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 2 del ejercicio 2 del Tema 6: Creación de tablespaces


-- Inciso 1
mkdir -p /unam-bda/archivelogs/KNNBDA2/disk_a
sudo chown -R oracle:oinstall /unam-bda/archivelogs/KNNBDA2/disk_a
sudo chmod -R 750 /unam-bda/archivelogs/KNNBDA2/disk_a
mkdir -p /unam-bda/archivelogs/KNNBDA2/disk_b
sudo chown -R oracle:oinstall /unam-bda/archivelogs/KNNBDA2/disk_b
sudo chmod -R 750 /unam-bda/archivelogs/KNNBDA2/disk_b

-- Inciso 2
Prompt Conectando como usuario sysdba
connect sys/system2 as sysdba

create pfile='/tmp/backup/pfile_b1.txt' from spfile;
alter system set log_archive_max_processes=2 scope=spfile;
alter system set log_archive_dest='/unam-bda/archivelogs/KNNBDA2/disk_a MANDATORY' scope=spfile;
alter system set log_archive_dest='/unam-bda/archivelogs/KNNBDA2/disk_b' scope=spfile;
alter system set log_archive_format='arch_knnbda2_%t_%s_%r.arc.' scope=spfile;
alter system set log_archive_min_succeed_dest=1 scope=spfile;

-- Inciso 3
shutdown immediate
startup mount
alter database archivelog;

-- Iniciso 4
alter database open;
archive log list

-- Inciso 5
create pfile='/tmp/pfile_b2.txt' from spfile;
