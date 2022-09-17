-- @Autor Najera Noyola Karla Andrea
-- @Fecha 16 de septiembre de 2022
-- @Descripción Creación de un spfile a partir de un pfile.

whenever sqlerror exit rollback;

Prompt Accediendo como usuario sys
connect sys/system2 as sysdba

Prompt Apagando instancia
shutdown normal

Prompt Creando spfile a partir de pfile
create spfile from pfile='/unam-bda/ejercicios-practicos/t0204/e-02-spparameter-pfile.txt';
Prompt Verificando la existencia del nuevo spfile. 
!ls ${ORACLE_HOME}/dbs/spfileknnbda2.ora

Prompt Iniciando instancia
startup

whenever sqlerror continue none;