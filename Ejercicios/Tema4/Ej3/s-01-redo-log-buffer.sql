--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/10/2022
--@Descripción:    Script 2 del ejercicio 3 del Tema 4: Tabla con valores de redo log buffer

-- Inciso A
prompt Iniciando sesion como sysdba
connect sys/system2 as sysdba

-- Inciso B
Prompt Creando tabla karla0403.t01_redo_log_buffer
create table karla0403.t01_redo_log_buffer as (
  --redo_buffer_size_param_mb 
  (select value/1024/1024 as redo_buffer_size_param_mb 
    from v$parameter where name='log_buffer'),
  --redo_buffer_sga_info_mb 
  (select bytes/1024/1024 as redo_buffer_sga_info_mb 
    from v$sgainfo where name='Redo Buffers'),
  --resizeable
  (select resizeable from v$sgainfo where name='Redo Buffers'),

);