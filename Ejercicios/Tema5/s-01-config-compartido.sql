--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 12/11/2022
--@Descripción:    Script 2 del ejercicio 1 del Tema 5: Configuración y conexión en modo compartido. 

-- Inciso A
prompt Iniciando sesion como sysdba
connect sys/system2 as sysdba

-- Inciso B
prompt Configurando la instancia para habilitar de forma temporal el modo compartido. 
--configura 2 dispatchers para protocolo TCP
alter system set dispatchers='(dispatchers=2)(protocol=tcp)' scope=memory;
alter system set max_dispatchers=2 scope=memory;
--configura 4 shared servers
alter system set shared_servers=4 scope=memory;
alter system set max_shared_servers=40 scope=memory;

-- Inciso C
prompt Mostrando las configuraciones realizadas
show parameter dispatchers
show parameter shared_servers

-- Inciso D
prompt Actualizando configuración del listener
!lsnrctl stop
alter system register;
!lsnrctl start

-- Inciso E
!lsnrctl services