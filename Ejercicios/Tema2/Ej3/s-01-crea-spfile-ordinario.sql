-- @Autor Najera Noyola Karla Andrea
-- @Fecha 31 de agosto de 2022
-- @Descripción Creación de un spfile a partir de un pfile.

-- Notas para ejecutarlo (Configuración solo dura mientras terminal esta abierta:
-- export ORACLE_SID=knnbda2 
-- sqlplus /nolog
-- start s-01-crea-spfile-ordinario.sql

Prompt Accediendo como usuario sys
connect sys/hola1234* as sysdba

create spfile from pfile;
-- También puede ser al revés xD
-- Por defecto toma la misma convención de donde se encuentra el pfile
-- No obstante, se pueden utilizar rutas diferentes. 

Prompt Verificando la existencia del nuevo spfile. 
!ls ${ORACLE_HOME}/dbs/spfileknnbda2.ora

-- Tras esto, se puede crear la base de datos DDDDDD:

-- Sección de comentarios de Froylan xD
-- Quitar antes de entregar
-- aiudaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- tengo sueñio :'varcharPd: Bonito día :31Jeje'