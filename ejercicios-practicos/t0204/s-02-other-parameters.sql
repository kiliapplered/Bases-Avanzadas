-- @Autor Najera Noyola Karla Andrea
-- @Fecha 16 de septiembre de 2022
-- @Descripción Creación de tabla con parámetros de la vista v$system_parameter

whenever sqlerror exit rollback;

Prompt Accediendo como usuario sys
connect sys/system2 as sysdba

Prompt Creando tabla de parámetros de la BD
create table karla0204.t_02_other_parameters as
  (select num, name, value, default_value, isses_modifiable as is_session_modifiable, 
  issys_modifiable as is_system_modifiable 
    from v$system_parameter);

Prompt Mostrando tabla;
set linesize window;
select * from karla0204.t_02_other_parameters;

whenever sqlerror continue none;