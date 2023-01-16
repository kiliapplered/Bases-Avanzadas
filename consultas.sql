--@Autor: 	       Najera Noyola Karla Andrea
--@Fecha creación: 14/01/2023
--@Descripción:    Algunas consultas interesantes

-- Determinar los datos del tablespace temporal que se usa en una BD
select property_name, property_value
from database_properties where
property_name='DEFAULT_TEMP_TABLESPACE';

-- Verificar el espacio empleado en un tablespace temporal
select * from dba_temp_free_space;

-- Imprimir información de los tablespaces existentes. 
select tablespace_name,
initial_extent,
next_extent,
min_extents,
max_extents,
pct_increase
from dba_tablespaces;

-- Datafiles y sus correspondientes tablespaces
select file_name, blocks, tablespace_name
from dba_data_files;