--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 13/11/2022
--@Descripción:    Script 7 del ejercicio 1 del Tema 5: Consultas, sesiones y procesos.

-- Inciso F
prompt Iniciando sesion como sysdba
connect sys/system2 as sysdba

prompt Reiniciando pool de conexiones
exec dbms_connection_pool.stop_pool();
exec dbms_connection_pool.restore_defaults();