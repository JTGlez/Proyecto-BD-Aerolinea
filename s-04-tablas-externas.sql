--@Autor(es): González Rosas Berenise & 
--            Téllez González Jorge Luis
--@Fecha de Creación: 26/12/2021
--@Descripción: Implementación de tablas externas: Air Flights

Prompt Creando ruta interna para archivos externos del proyecto...

connect sys as sysdba
create or replace directory tmp_proyecto as '/tmp/proyecto';
grant read, write on directory tmp_proyecto to tg_proy_admin;

Prompt Creando tablas externas...
conn tg_proy_admin/system

create table pasajero_pase_vuelo_ext(
  pasajero_id number(10,0),
  email varchar2(60),
  num_vuelo number(5,0),
  nombre_estatus varchar2(15),
  folio_pase varchar2(8),
  num_maleta number(10,0),
  peso number(4,0),
  fecha_impresion date
)
organization external(
  type oracle_loader
  default directory tmp_proyecto
  access parameters(
    records delimited by newline
    badfile tmp_proyecto:'pasajero_pase_vuelo_ext_bad.log'
    logfile tmp_proyecto:'pasajero_pase_vuelo_ext.log'
    fields terminated by ','
    lrtrim
    missing field values are null(
      pasajero_id, email, num_vuelo, nombre_estatus, folio_pase, num_maleta, 
      peso, fecha_impresion date mask "dd/mm/yyyy"
    )
  )
  location ('pasajero_pase_vuelo_ext.csv')
)
reject limit unlimited;

prompt Creando el directorio
!mkdir -p /tmp/proyecto

prompt Copiando el archivo csv a /tmp/proyecto
!cp pasajero_pase_vuelo_ext.csv /tmp/proyecto
prompt cambiando permisos
!chmod 777 /tmp/proyecto

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
--Cargar datos del empleado y su puesto
create table empleado_puesto_ext(
  empleado_id number(10,0),
  nombre varchar2(60),
  ap_pat varchar2(60),
  ap_mat varchar2(60),
  rfc varchar(13),
  nombre_puesto varchar2(40),
  sueldo_mensual number(10,0)
)
organization external(
  type oracle_loader
  default directory tmp_proyecto
  access parameters(
    records delimited by newline
    badfile tmp_proyecto:'empleado_puesto_ext_bad.log'
    logfile tmp_proyecto:'empleado_puesto_ext.log'
    fields terminated by '*'
    lrtrim
    missing field values are null(
      empleado_id,nombre, ap_pat, ap_mat, rfc, 
      nombre_puesto, sueldo_mensual
    )
  )
  location ('empleado_puesto_ext.csv')
)
reject limit unlimited;

prompt Creando el directorio
!mkdir -p /tmp/proyecto

prompt Copiando el archivo csv a /tmp/proyecto
!cp empleado_puesto_ext.csv /tmp/proyecto
prompt cambiando permisos 
!chmod 777 /tmp/proyecto

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

create table pasajero_vuelo_ext(
  pasajero_id number(10,0),
  nombre varchar2(60),
  ap_pat varchar2(60),
  ap_mat varchar2(60),
  email varchar2(60),
  vuelo_id number(10,0),
  sala number(2,0),
  asiento number(3,0),
  flag_tomo_asiento number(1,0),
  fecha_hora_salida date
)
organization external(
  type oracle_loader
  default directory tmp_proyecto
  access parameters(
    records delimited by newline
    badfile tmp_proyecto:'pasajero_vuelo_ext_bad.log'
    logfile tmp_proyecto:'pasajero_vuelo_ext.log'
    fields terminated by '#'
    lrtrim
    missing field values are null(
      pasajero_id, nombre, ap_pat, ap_mat, email, vuelo_id, sala, asiento,
      flag_tomo_asiento, fecha_hora_salida date mask "dd/mm/yyyy"
    )
  )
  location ('pasajero_vuelo_ext.csv')
)
reject limit unlimited;

prompt Creando el directorio
!mkdir -p /tmp/proyecto

prompt Copiando el archivo csv a /tmp/proyecto
!cp pasajero_vuelo_ext.csv /tmp/proyecto
prompt cambiando permisos
!chmod 777 /tmp/proyecto
