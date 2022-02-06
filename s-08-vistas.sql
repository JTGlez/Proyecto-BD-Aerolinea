--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  27/12/2021
--@Descripción:     Creación de vistas, para la protección de datos sensibles y
--                  además para simplificar la información que se encuentra 
--                  insertada en las tablas.

conn tg_proy_admin/system
prompt Generando vistas...
  
--1.Vista para observar el nombre del pasajero, los datos de su vuelo y 
--sala de abordar
create or replace view v_pasajero_vuelo(
  nombre, apellido_paterno, apellido_materno, numero_vuelo, asiento, sala_abordar
)as select nombre, ap_pat, ap_mat, num_vuelo, asiento, sala
from pasajero p
join vuelo_pasajero vp
  on p.pasajero_id = vp.pasajero_id
join vuelo v
  on v.vuelo_id= vp.vuelo_id;
  
--select * from v_pasajero_vuelo;

--2.Vista para el número de vuelo, el aeropuerto de llegada, y la hora 
--de llegada
create or replace view v_vuelo_aeropuerto(
  numero_vuelo, aeropuerto_destino, nombre_aeropuerto, 
  fecha_aterrizaje
)as select v.num_vuelo, v.aeropuerto_destino_id, a.nombre, 
  v.fecha_hora_llegada
from vuelo v, aeropuerto a
where v.aeropuerto_destino_id = a.aeropuerto_id;


--select * from v_vuelo_aeropuerto;

--3.Vista para obtener datos del empleado, y datos referentes a su puesto 
create or replace view v_empleado_puesto(
  rfc, nombre, apellido_paterno, apellido_materno, nombre_puesto, sueldo_mensual, sueldo_quincenal
)as select e.rfc, e.nombre, ap_pat,ap_mat, p.nombre, sueldo_mensual, sueldo_quincenal
from empleado e, puesto p
where e.puesto_id = p.puesto_id;

--select * from v_empleado_puesto;

--4.Vista para el paquete, con su tipo paquete, y el vuelo en el que fue enviado
create or replace view v_paquete_vuelo(
  id_vuelo,id_paquete, folio_paquete, clave_paquete, peso,
  descripcion_paquete
)as select vp.vuelo_id, vp.paquete_id, folio_paquete, clave_paquete, peso,  
  descripcion
from vuelo_paquete vp 
join paquete p
  on vp.paquete_id = p.paquete_id
join tipo_paquete tp
  on tp.tipo_paquete_id = p.tipo_paquete_id;
  
--select * from v_paquete_vuelo;

--5.Vista para obtener datos de pase y maleta
create or replace view v_pase_maleta(
  folio_pase_abordar, numero_maleta, peso_maleta, fecha_impresion_pase
)as select folio_pase, num_maleta, peso, fecha_impresion
from maleta m, pase_abordar pa
where m.pase_abordar_id = pa.pase_abordar_id;

--select * from v_pase_maleta;

--6.Vista obtener datos del vuelo, aeronave, aeropuerto y su estatus actual
create or replace view v_vuelo_aeronave_aeropuerto_status(
  numero_vuelo, matricula_aeronave, tipo, id_status, nombre_status_vuelo, 
  id_aeropuerto_origen, nombre_aeropuerto_origen, id_aeropuerto_destino, 
  nombre_aeropuerto_destino
)as select num_vuelo, matricula, (        
  case 
    when es_carga=0 and es_comercial=1 then 'COMERCIAL'
    when es_carga=1 and es_comercial=0  then 'CARGA'
    when es_carga=1 and es_comercial=1 then 'COMERCIAL/CARGA'
  end) tipo, ev.estatus_vuelo_id, ev.nombre, a.aeropuerto_id,
  a.nombre, v.aeropuerto_destino_id, aa.nombre
from vuelo v
join aeronave ae
  on v.aeronave_id = ae.aeronave_id
join aeropuerto a
  on a.aeropuerto_id = v.aeropuerto_id
join aeropuerto aa
  on aa.aeropuerto_id=v.aeropuerto_destino_id
join estatus_vuelo ev
  on ev.estatus_vuelo_id = v.estatus_vuelo_id;

--select * from v_vuelo_aeronave_aeropuerto_status;

--7.Vista para obtener datos del empleado y vuelo 
create or replace view v_empleado_vuelo(
  id_empleado, id_vuelo, nombre, apellido_paterno, apellido_materno, puntos, 
  rol_desempeñado, nombre_puesto
)as select ve.empleado_id, ve.vuelo_id, e.nombre, e.ap_pat, ap_mat, puntos, 
  r.nombre, p.nombre
from vuelo_empleado ve
join rol r
  on ve.rol_id = r.rol_id
join empleado e
  on e.empleado_id = ve.empleado_id
join puesto p
  on p.puesto_id = e.puesto_id;
  