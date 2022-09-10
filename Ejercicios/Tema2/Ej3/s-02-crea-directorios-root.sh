# !/bin/bash
# @Autor Najera Noyola Karla Andrea
# @Fecha 10 de septiembre de 2022
# @Descripción Creación de directorios con el usuario root previo al create database

echo "Creando directorios para data files"
export ORACLE_SID=knnbda2
cd /u01/app/oracle/oradata
mkdir ${ORACLE_SID^^}
chown oracle:oinstall ${ORACLE_SID^^}
chmod 750 ${ORACLE_SID^^}

echo "Creando directorios para Redo Log y Control Files"
cd /unam-bda/d01
mkdir -p app/oracle/oradata/KNNBDA2
chown -R oracle:oinstall app
chmod -R 750 app
cd /unam-bda/d02
mkdir -p app/oracle/oradata/KNNBDA2
chown -R oracle:oinstall app
chmod -R 750 app
cd /unam-bda/d03
mkdir -p app/oracle/oradata/KNNBDA2
chown -R oracle:oinstall app
chmod -R 750 app

echo "Mostrando directorio de data files"
ls -l /u01/app/oracle/oradata

echo "Mostrando directorios para control files y Redo Logs"
ls -l /unam-bda/d0*/app/oracle/oradata

