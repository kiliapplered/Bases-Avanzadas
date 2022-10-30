--@Autor:           Colin Santos Luis Froylan
--@Fecha creación:  29/09/2022
--@Descripción:     creación de usuario0402

Prompt conectando como sysdba
connect sys/system2 as sysdba

declare
  v_count number;
  v_username varchar2(20) := 'FROYLAN0403';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count > 0 then
    execute immediate 'drop user '||v_username ||' cascade';
  end if;
end;
/

Prompt Creando usuario FROYLAN0403
create user froylan0403 identified by cn quota unlimited on users;
Prompt asignando permisos
grant create session, create table, create sequence to froylan0403;