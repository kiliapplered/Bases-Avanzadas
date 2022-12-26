--@Autor: 	   Najera Noyola Karla Andrea
--@Fecha creación: 25/12/2022
--@Descripción:    Script 3 del ejercicio 2 del Tema 6: Asignación de cuotas y usuarios

whenever sqlerror exit rollback;

-- Inciso A
Prompt Conectando como usuario sysdba
connect sysdba/system2

-- Inciso B
Prompt Brindando cuota al usuario karla0602
alter user karla0602 quota unlimited on store_tbs1;
alter user karla0602 quota unlimited on store_tbs_multiple;
alter user karla0602 quota 50m on store_tbs_big;
alter user karla0602 quota unlimited on store_tbs_zip;
alter user karla0602 quota unlimited on store_tbs_temp;
alter user karla0602 quota unlimited on store_tbs_custom;

-- Inciso C
Prompt Cambiando el tablespace por default al usuario karla0602
alter user karla0602 default tablespace store_tbs1;

-- Inciso D
Prompt Cambiando el temp tablespace al creado con anterioridad. 
alter user karla0602 temporary tablespace store_tbs_temp;

-- Inciso E
create table karla0602.store_test(
  id     number(1)
);

-- Inciso F
declare
  v_extensiones number;
  v_total_espacio number;
begin
  v_extensiones := 0;
  loop
    begin
    execute immediate 'alter table test allocate extent';
    exception
    when others then
    if sqlcode = -1653 then
      exit;
    end if;
    end;
  end loop;
  --total espacio asignado
  select sum(bytes)/(1024*1024),count(*) into v_total_espacio,v_extensiones
  from user_extents
  where segment_name='TEST';
  dbms_output.put_line('Total de extensiones creadas: '||v_extensiones);
  dbms_output.put_line('Total de espacio reservado: '||v_total_espacio);
end;
/

-- Inciso G
Prompt Haciendo que crezca de tamaño el tablespace
alter tablespace store_tbs1 autoextend on next 25m;
Prompt Insertando un nuevo registro
insert into karla0602.store_test values(1);

whenever sqlerror continue none;