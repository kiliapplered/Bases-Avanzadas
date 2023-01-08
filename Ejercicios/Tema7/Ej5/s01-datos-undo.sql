--@Autor:           Najera Noyola Karla Andrea
--@Fecha creación:  07/01/2023
--@Descripción:     

set linesize window
col name format a25
col value format a15

connect sys/system2 as sysdba

prompt Tablespace UNDO actualmente en uso:
select name, value from v$parameter where name='undo_tablespace';

prompt Creando tablespace undo con espacio muy limitado
create undo tablespace undotbs2
  datafile '/u01/app/oracle/oradata/KNNBDA2/undotbs_2.dbf'
  size 30m
  autoextend off
  extent management local autoallocate;

prompt Haciendo que el nuevo TS se ocupe mientras la instancia esté iniciada
alter system set undo_tablespace=undotbs2 scope=memory;
disconnect

prompt Verificando que el nuevo TS está en uso
connect sys/system2 as sysdba

select name, value
from v$parameter
where name='undo_tablespace';

prompt Generando consulta de v$undostat
select to_char(begin_time, 'DD-MON-YYYY HH24:MI:SS') begin_time, to_char(end_time, 'DD-MON-YYYY HH24:MI:SS') end_time,
  undotsn ts_id, undoblks, txncount, maxqueryid, maxquerylen, activeblks, unexpiredblks, expiredblks,
  tuned_undoretention
from v$undostat
order by begin_time desc
fetch first 20 rows only;

prompt Contestar con base en el periodo de muestre más reciente:
prompt ¿Cuántos bloques podrían ser sobrescritos sin causar mayores inconvenientes?
prompt ¿Cuántos bloques no pueden ser sobrescritos aún?

prompt Generando consulta para comprobar que hay un cambio en TS
select ts.ts#, ts.name, to_char(us.begin_time, 'DD-MON-YYYY HH24:MI:SS') begin_time,
  to_char(us.end_time, 'DD-MON-YYYY HH24:MI:SS') end_time, us.undotsn
from v$tablespace ts join v$undostat us on ts.ts# = us.undotsn
order by us.begin_time desc
fetch first 20 rows only;

prompt Generando consulta
select df.tablespace_name,
  sum(df.blocks) bloques_totales,
  (select sum(blocks)
     from dba_free_space
     where tablespace_name='UNDOTBS2'
     group by tablespace_name) bloques_disponibles,
  round((select sum(blocks)
     from dba_free_space
     where tablespace_name='UNDOTBS2'
     group by tablespace_name)/sum(df.blocks) * 100, 2) porcentaje_libres
from dba_free_space fs join dba_data_files df on fs.tablespace_name = df.tablespace_name
where df.tablespace_name='UNDOTBS2'
group by df.tablespace_name;

prompt Creando tabla para usuario karla072
--connect karla072/cn

prompt Buscando y eliminando registros anteriores...
declare
  v_count number;
  v_username varchar2(20) := 'KARLA072';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count > 0 then
    execute immediate 'drop user '||v_username||' cascade';
  end if;
end;
/

create user karla072 identified by cn quota unlimited on users;

grant create session, create table,
  create procedure to karla072;

create table karla072.knn_cadena_2 (
  id number constraint knn_cadena_2_pk primary key,
  cadena varchar2(1024)
) nologging;

prompt Creando secuencia sec_knn_cadena_2
create sequence karla072.sec_knn_cadena_2;

prompt Insertando 50,000 registros
begin
  for v_index in 1..50000
  loop
    insert into karla072.knn_cadena_2 (id, cadena) values(
      karla072.sec_knn_cadena_2.nextval,
      sys.dbms_random.string('P',1024)
    );
  end loop;
end;
/
show errors
commit;


prompt Ejecutando nuevamente consulta del inciso E
select to_char(begin_time, 'DD-MON-YYYY HH24:MI:SS') begin_time, to_char(end_time, 'DD-MON-YYYY HH24:MI:SS') end_time,
  undotsn ts_id, undoblks, txncount, maxqueryid, maxquerylen, activeblks, unexpiredblks, expiredblks,
  tuned_undoretention
from v$undostat
order by begin_time desc
fetch first 20 rows only;

prompt Borrando registros insertados
--Se espera un error
delete from karla072.knn_cadena_2;

prompt Proceder con borrado manual de 5000 registros cada vez
prompt Seguir hasta un error o hasta que termine
prompt Realizar consulta del inciso E en cada delete
/*
delete from knn_cadena_2
where id <= 5000;

delete from knn_cadena_2
where id <= 10000;

delete from knn_cadena_2
where id <= 15000;

delete from knn_cadena_2
where id <= 20000;

delete from knn_cadena_2
where id <= 25000;

delete from knn_cadena_2
where id <= 30000;

delete from knn_cadena_2
where id <= 35000;

delete from knn_cadena_2
where id <= 40000;

delete from knn_cadena_2
where id <= 45000;

delete from knn_cadena_2
where id <= 50000;
*/

prompt Realizar rollback al final
--rollback;

prompt Contestar qué acciones se pueden realizar para corregir el error adicional
prompt a aumentar el tamaño del tablespace undo
--Permitir que el TS crezca con autoextend, y garantizar las retenciones

prompt Replicación de error Snapshot too old
/* SESIÓN 1
conn karla072/cn
set transaction isolation level serializable name 'T1-LR';

--Incluir resultados de las siguientes consultas:
select count(*) from knn_cadena_2;

select count(*)
from knn_cadena_2
where cadena line 'A%'
  or cadena like 'Z%'
  or cadena like 'M%';
*/
/*
SESIÓN 2
conn karla072/cn

--Tratar de borrar los datos y luego hacer commit
delete from knn_cadena_2
where id <= 5000;
commit;

delete from knn_cadena_2
where id <= 10000;
commit;

delete from knn_cadena_2
where id <= 15000;
commit;

delete from knn_cadena_2
where id <= 20000;

delete from knn_cadena_2
where id <= 25000;

delete from knn_cadena_2
where id <= 30000;

delete from knn_cadena_2
where id <= 35000;

delete from knn_cadena_2
where id <= 40000;

delete from knn_cadena_2
where id <= 45000;

delete from knn_cadena_2
where id <= 50000;
*/

prompt 
/*
--Consulta para dar prioridad a datos undo:
alter tablespace undotbs2 retention guarantee;


*/