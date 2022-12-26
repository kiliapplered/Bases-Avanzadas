--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 2 del ejercicio 2 del Tema 6: Creación de tablespaces


-- Inciso 1
mkdir -p /unam-bda/archivelogs/KNNBDA2/disk_a
chown -R oracle:oinstall app
chmod -R 750 app
mkdir -p /unam-bda/archivelogs/KNNBDA2/disk_b
chown -R oracle:oinstall app
chmod -R 750 app

-- Inciso 2
create pfile='/unam-bda/backup/pfile.txt' from spfile;
alter system set log_archive_max_processes=2 scope=both;
alter system set log_archive_dest='/unam-bda/archivelogs/KNNBDA2/disk_a MANDATORY' scope=both;
alter system set log_archive_dest='/unam-bda/archivelogs/KNNBDA2/disk_b' scope=both;
alter system set log_archive_format='arch_knnbda2_%t_%s_%r.arc.' scope=both;
alter system set log_archive_min_succeed_dest=1 scope=both;

-- Inciso 3
shutdown immediate
startup mount
alter database archivelog;

-- Iniciso 4
alter database open;
archive log list

-- Inciso 5
create spfile '/unam-bda/backup/spfile.ora' from pfile;
