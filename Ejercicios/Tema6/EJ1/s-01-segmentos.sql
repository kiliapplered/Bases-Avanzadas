--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 27/11/2022
--@Descripción:    Script 2 del ejercicio 1 del Tema 6: Generación de segmentos

whenever sqlerror exit rollback;

-- Inciso A
Prompt Conectando como usuario karla0601
connect karla0601/karla

-- Inciso B
Prompt Creando tabla de empleado
create table empleado(
  empleado_id     number(10, 0)   not null,
  nombre_completo varchar2(150)   not null,
  num_cuenta      varchar2(15)    not null,
  expediente      blob            not null, 
  constraint empleado_pk primary key (empleado_id)
);

--Inciso C
Prompt Creando el indice empleado_num_cuenta_uix
create unique index empleado_num_cuenta_uix
on empleado(num_cuenta);

-- Inciso D
select * from user_segments
where segment_name like '%EMPLEADO%';

--Inciso E
Prompt Insertando un registro 
insert into empleado 
values (1, 'Karla Andrea Najera Noyola', 316324951, empty_blob);

-- Inciso F
Prompt Creando nuevo segmento de forma manual
alter table empleado allocate extent;

-- Inciso G
create table t01_emp_segments as (
  select s.segment_name, s.segment_type, s.tablespace_name, (s.bytes/1024)segment_kbs, s.blocks, s.extents  
    from user_segments s
    join user_lobs l on l.tablespace_name=s.tablespace_name 
  where s.segment_name like '%EMPLEADO%' or l.table_name='EMPLEADO'
);

whenever sqlerror continue none;