--@Autor(es): González Rosas Berenise & 
--            Téllez González Jorge Luis
--@Fecha de Creación: 23/12/2021
--@Descripción: Definición de usuarios: Air Flights.

Prompt Proporcione el password del usuario sys...
connect sys as sysdba

--Permite la salida de mensajes a consulta empleando dbms_output.put_line.
set serveroutput on

prompt Eliminando usuarios y roles de ejecuciones previas...

/*Bloques anómimos validadores de la existencia de los usuarios y roles, 
si existen los elimina. */

declare
  v_count number(1,0);

begin
  --El valor de count(*) se almacena en v_count.
  select count(*) into v_count
  from dba_users
  where username = 'TG_PROY_INVITADO';
  
  if v_count > 0 then
    dbms_output.put_line('Eliminando usuario tg_proy_invitado...');
    execute immediate 'drop user tg_proy_invitado cascade';
  end if;
end;
/


declare
  v_count number(1,0);

begin
  --El valor de count(*) se almacena en v_count.
  select count(*) into v_count
  from dba_users
  where username = 'TG_PROY_ADMIN';
  
  if v_count > 0 then
    dbms_output.put_line('Eliminando usuario tg_proy_admin...');
    execute immediate 'drop user tg_proy_admin cascade';
  end if;
end;
/

declare
  v_count number(1,0);

begin
  --El valor de count(*) se almacena en v_count.
  select count(*) into v_count
  from dba_roles
  where role = 'ROL_ADMIN';
  
  if v_count > 0 then
    execute immediate 'drop role rol_admin';
  end if;
end;
/

declare
  v_count number(1,0);

begin
  --El valor de count(*) se almacena en v_count.
  select count(*) into v_count
  from dba_roles
  where role = 'ROL_INVITADO';
  
  if v_count > 0 then
    execute immediate 'drop role rol_invitado';
  end if;
end;
/


prompt Creando los usuarios administrador e invitado...

create user tg_proy_admin identified by system 
  quota unlimited on users;
  
create user tg_proy_invitado identified by guest;

prompt Creando roles...

create role rol_admin;
grant create session, create table, create view, create procedure, 
  create trigger, create sequence, create synonym, create public synonym to rol_admin;
  
create role rol_invitado;
grant create session, create synonym to rol_invitado;

prompt Asignando roles...

grant rol_admin to tg_proy_admin;
grant rol_invitado to tg_proy_invitado;

Prompt ...listo! Usuarios creados.