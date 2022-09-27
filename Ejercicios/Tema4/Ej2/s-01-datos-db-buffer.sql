--@Autor: 	       Najera Noyola Karla Andrea
--@Fecha creación: 27/09/2022
--@Descripción:    Script 2 del ejercicio 2 del Tema 4: Consultas de DB buffer

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba



commit;

whenever sqlerror continue none;