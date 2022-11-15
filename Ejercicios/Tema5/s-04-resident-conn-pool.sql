--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 13/11/2022
--@Descripción:    Script 5 del ejercicio 1 del Tema 5: Consultas en modo compartido. 

-- Inciso A
prompt Iniciando sesion como sysdba
connect sys/system2 as sysdba

-- Inciso B
prompt Iniciando un nuevo connection pool
exec dbms_connection_pool.start_pool();

-- Inciso C
prompt Configurando el número mínimo de conexiones
exec dbms_connection_pool.alter_param ('','MAXSIZE','50');
exec dbms_connection_pool.alter_param ('','MINSIZE','42');

-- Inciso D
prompt Configuracion de parámetros relacionados a inactividad
exec dbms_connection_pool.alter_param ('','INACTIVITY_TIMEOUT','1800');
exec dbms_connection_pool.alter_param ('','MAX_THINK_TIME','1800');

