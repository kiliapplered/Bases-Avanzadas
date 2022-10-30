--@Autor:           Colin Santos Luis Froylan
--@Fecha creación:  29/09/2022
--@Descripción:     Creación de tablas de redo log buffer

--A
prompt Iniciando sesion como sysdba
connect sys/system2 as sysdba

--B
prompt Creando tabla t01_redo_log_buffer
create table froylan0403.t01_redo_log_buffer as(
  select
    (select value/1024/1024
    from v$parameter
    where name='log_buffer') redo_buffer_size_param_mb,
    bytes/1024/1024 redo_buffer_sga_info_mb,
    resizeable
  from v$sgainfo
  where name='Redo Buffers'
);