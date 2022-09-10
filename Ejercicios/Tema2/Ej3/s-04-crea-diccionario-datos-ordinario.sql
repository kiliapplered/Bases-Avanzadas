-- @Autor Najera Noyola Karla Andrea
-- @Fecha 10 de septiembre de 2022
-- @Descripción Creación del diccionario de datos

Prompt Accediendo como usuario sys
connect sys/system2 as sysdba

Prompt Ejecución de scripts con sys
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

Prompt Accediendo como usuario system
connect system/system2 as sysdba

Prompt Ejecución de scripts con system
@?/sqlplus/admin/pupbld.sql