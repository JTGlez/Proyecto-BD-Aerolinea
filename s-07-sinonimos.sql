--@Autor(es): González Rosas Berenise & 
--            Téllez González Jorge Luis
--@Fecha de Creación: 26/12/2021
--@Descripción: Creación de sinónimos: Air Flights

prompt Generando sinónimos...
conn tg_proy_admin/system

--Sinónimos para acceder a las entidades AEROPUERTO, AERONAVE y TIPO_PAQUETE.
create or replace public synonym LISTA_AEROPUERTOS for aeropuerto;
create or replace public synonym LISTA_AERONAVES for aeronave;
create or replace public synonym TIPOS_PAQUETES for tipo_paquete;

--Generación de los permisos de lectura para el usuario invitado.
grant select on aeropuerto to tg_proy_invitado;
grant select on aeronave to tg_proy_invitado;
grant select on tipo_paquete to tg_proy_invitado;

--Permisos adicionales en 3 entidades
grant select on puesto to tg_proy_invitado;
grant select on rol to tg_proy_invitado;
grant select on estatus_vuelo to tg_proy_invitado;

connect tg_proy_invitado/guest

--Sinónimos privados del invitado para leer las tablas.
create or replace synonym LISTA_PUESTOS for tg_proy_admin.puesto;
create or replace synonym LISTA_ROLES for tg_proy_admin.rol;
create or replace synonym LISTA_ESTATUS for tg_proy_admin.estatus_vuelo;

conn tg_proy_admin/system

--Creación de sinónimos con prefijo usando SQL Dinámico.
set serveroutput on
declare
  v_sentencia varchar(200);
begin
  for p in (select table_name from all_tables where owner='TG_PROY_ADMIN') loop
    v_sentencia:= 'create or replace synonym '||SUBSTR(p.table_name,1,2)||'_'||
    p.table_name||' for '||'TG_PROY_ADMIN'||'.'||p.table_name;
    execute immediate v_sentencia;
  end loop;
end;
/
show errors

--select * from all_synonyms where owner!='PUBLIC';