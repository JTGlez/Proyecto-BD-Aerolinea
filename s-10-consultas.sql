--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  08/01/2022
--@Descripción:     Script con consultas hacia la base: Air Flights

--CONSULTA 1
/*Mostrar el identificador de los empleados de la aerolínea, su nombre, 
  apellidos, su rfc, el nombre de su jefe, cuántos vuelos ha realizado
  y los puntos que ha acumulado a lo largo de todos ellos. Solo considere
  a aquellos que han realizado un vuelo como mínimo.
     
  Tipo de consulta: Inner Joins, funciones de agregación, subconsultas.*/

select e.empleado_id, e.nombre, e.ap_pat, e.ap_mat, e.rfc, 
  decode(p.puesto_id, 1, 'PILOTO', 
                      2, 'COPILOTO', 
                      3, 'SOBRECARGO/AUX',
                      4, 'TECNICO', 
                      5, 'INGENIERO', 
                      6, 'SEGURIDAD', '') puesto, 
  concat(concat(ej.nombre ||' ' , ej.ap_pat || ' '), ej.ap_mat) nombre_jefe,
  np.num_vuelos, np.total_puntos
from empleado e
  join (
    select empleado_id, nombre, ap_pat, ap_mat
    from empleado
    where empleado_jefe_id is null   
  ) ej 
    on e.empleado_jefe_id=ej.empleado_id
  join puesto p
    on p.puesto_id=e.puesto_id
  join (
    select e.empleado_id, count(*) num_vuelos, sum(puntos) total_puntos
    from vuelo_empleado ve
    join vuelo v
      on v.vuelo_id=ve.vuelo_id
    join empleado e
      on e.empleado_id=ve.empleado_id
    group by e.empleado_id
  ) np
    on np.empleado_id=e.empleado_id;

--CONSULTA 2
/*Calcule la distancia existente entre el AICM y el resto de aeropuertos
  registrados en la base que tienen actualmente un convenio con la
  aerolínea considerando su latitud y longitud.
     
  Tipo de consulta: Inner Join, Consulta con tabla temporal.*/

/*Crear tabla temporal desde Developer para ver el resultado.*/     
select a.clave_aeropuerto, a.nombre, da.distancia
from aeropuerto a
join distancia_aeropuertos_cdmx_temp da
  on da.aeropuerto_id=a.aeropuerto_id
where flag_activo=1;


--CONSULTA 3
/*Suponga que se desea recuperar todos los registros de los vuelos con 
  estatus CANCELADO y que no tienen pasajeros(para los comerciales)
  ni paquetes(para los de carga) registrados para que sean eliminados
  de la base datos. Obtenga su número de vuelo, fecha de cancelación
  así como su aeropuerto de origen y destino.
    
  Tipo de consulta: Álgebra Relacional (minus), Inner Join, funciones
                    de agregación. */
     
(
  (select v.num_vuelo, v.fecha_status_actual fecha_cancelacion, 
      a1.nombre origen, a2.nombre destino
    from vuelo v
    join aeropuerto a1
      on a1.aeropuerto_id=v.aeropuerto_id
    join aeropuerto a2
      on a2.aeropuerto_id=v.aeropuerto_destino_id
    join estatus_vuelo ev
      on ev.estatus_vuelo_id=v.estatus_vuelo_id
    minus
    select v.num_vuelo, v.fecha_status_actual fecha_cancelacion, 
      a1.nombre origen, a2.nombre destino
    from vuelo_pasajero vp, vuelo v, aeropuerto a1, aeropuerto a2
    where vp.vuelo_id=v.vuelo_id
      and a1.aeropuerto_id=v.aeropuerto_id
      and a2.aeropuerto_id=v.aeropuerto_destino_id
    group by v.num_vuelo, v.fecha_status_actual, a1.nombre, a2.nombre
    having count(*)>0
  ) 
  minus
  select v.num_vuelo, v.fecha_status_actual fecha_cancelacion, 
    a1.nombre origen, a2.nombre destino
  from vuelo_paquete vpq, vuelo v, aeropuerto a1, aeropuerto a2
  where vpq.vuelo_id=v.vuelo_id
    and a1.aeropuerto_id=v.aeropuerto_id
      and a2.aeropuerto_id=v.aeropuerto_destino_id
    group by v.num_vuelo, v.fecha_status_actual, a1.nombre, a2.nombre
    having count(*)>0
)  
minus
select v.num_vuelo, v.fecha_status_actual fecha_cancelacion, 
  a1.nombre origen, a2.nombre destino
from vuelo v
join aeropuerto a1
  on a1.aeropuerto_id=v.aeropuerto_id
join aeropuerto a2
  on a2.aeropuerto_id=v.aeropuerto_destino_id
join estatus_vuelo ev
  on ev.estatus_vuelo_id=v.estatus_vuelo_id
where v.estatus_vuelo_id!=5;
  
--CONSULTA 4
/*Se ha detectado que el pasajero con CURP '' ha presentado cierta actividad
  sospechosa que ha hecho saltar las alarmas del departamento de seguridad
  del último aeropuerto que visitó. Obtenga la información de este pasajero,
  el último aeropuerto que visitó (El aeropuerto destino de su último vuelo)
  y la fecha de llegada de su último vuelo. 

  Tipo de consulta: Inner Join, Subconsulta, funciones de agregación.*/
  
select p.curp, p.nombre, p.ap_pat, p.ap_mat, p.fecha_nacimiento, 
  ae.nombre ultimo_aeropuerto_visitado, v.fecha_hora_llegada fecha_ultimo_vuelo
from vuelo_pasajero vp
join vuelo v
  on v.vuelo_id=vp.vuelo_id
join pasajero p
  on p.pasajero_id=vp.pasajero_id
join aeropuerto ae
  on ae.aeropuerto_id=v.aeropuerto_destino_id
join (
  select max(v.fecha_hora_llegada) fecha_ultimo_vuelo
  from vuelo_pasajero vp
  join vuelo v
    on vp.vuelo_id=v.vuelo_id
  join aeropuerto ae
    on ae.aeropuerto_id=v.aeropuerto_destino_id
  join pasajero p
    on p.pasajero_id=vp.pasajero_id
  where p.curp='CMJKE673CMHMYNCYNA'
  group by p.nombre
) lv
  on v.fecha_hora_llegada=lv.fecha_ultimo_vuelo
where p.curp='CMJKE673CMHMYNCYNA';
  
--CONSULTA 5
/*La Aerolínea requiere un informe detallado que indique los siguientes 
  datos de las aeronaves y los vuelos que se han programado para ellas
  (si es que se les ha programado uno) : modelo, matrícula, número de vuelo, 
  fecha de salida, fecha de llegada, aeropuerto origen y destino. 
  Si a las aeronaves se les han asignado vuelos, solo deberán 
  considerarse aquellos vuelos con estado 'PROGRAMADO';     
    
  Tipo de consulta: Outer Join.*/  

select a.aeronave_id, a.modelo, a.matricula, (
  case 
    when es_carga=0 and es_comercial=1 then 'COMERCIAL'
    when es_carga=1 and es_comercial=0  then 'CARGA'
    when es_carga=1 and es_comercial=1 then 'COMERCIAL/CARGA'
  end) tipo_aeronave ,v.num_vuelo, v.fecha_hora_salida, 
  v.fecha_hora_llegada, ao.nombre aeropuerto_origen, 
  ad.nombre aeropuerto_destino, ev.nombre
from aeronave a
left join vuelo v
  on a.aeronave_id=v.aeronave_id
  and v.estatus_vuelo_id=1
left join estatus_vuelo ev
  on ev.estatus_vuelo_id=v.estatus_vuelo_id
left join aeropuerto ao
  on ao.aeropuerto_id=v.aeropuerto_id
left join aeropuerto ad
  on ad.aeropuerto_id=v.aeropuerto_destino_id;
    
--CONSULTA 6  
/*Recupere la información del pasajero con folio IM7JL6KG, incluyendo la
  fecha de impresión del mismo.
         
  Tipo de consulta: Tablas externas.*/
     
select pext.pasajero_id, p.nombre, p.ap_pat, p.ap_mat, pext.email, 
  pext.num_vuelo, pext.fecha_impresion 
from pasajero_pase_vuelo_ext pext
join pasajero p
  on p.pasajero_id=pext.pasajero_id
where folio_pase='IM7JL6KG';
     
--CONSULTA 7
/*Realice un reporte que incluya el número de cada vuelo registrado en la 
  base, la aeronave empleada, su matrícula, el nombre de cada tripulante,
  su rfc y el rol que desempeñan en el mismo. Ordene considerando cada vuelo
  y ordenando en forma ascendente los roles de cada empleado.
    
  Tipo de consulta: Natural join (con using).*/
   
select v.num_vuelo, a.matricula, a.modelo, empleado_id, e.nombre, e.ap_pat, 
  e.ap_mat, e.rfc, rol_id, r.nombre rol from vuelo_empleado ve
natural join vuelo v
natural join aeronave a
natural join empleado e
join rol r using (rol_id)
order by v.num_vuelo asc, rol_id asc;
  
--CONSULTA 8
/*Realice una consulta que que muestre cada uno de los paquetes registrados
  en la base de datos, incluyendo su tipo referenciándolos con la tabla
  a la que hace referencia el sinónimo TIPOS_PAQUETES. Ordénelos por
  tipo de paquete.
         
  Tipo de consulta: Sinónimos.*/
     
select folio_paquete, peso, descripcion, indicaciones 
from paquete p
join TIPO_PAQUETE tp
  on tp.tipo_paquete_id=p.tipo_paquete_id
order by descripcion;     
      
--CONSULTA 9     
/*Obtenga el número de vuelo y la fecha de aterrizaje 
  del último vuelo registrado por la aerolínea.
             
  Tipo de consulta: Vistas.*/
     
select numero_vuelo, fecha_aterrizaje
from v_vuelo_aeropuerto
where fecha_aterrizaje =(
  select max(fecha_aterrizaje) 
  from v_vuelo_aeropuerto
);

--CONSULTA 10     
/*La aerolínea desea reconocer a aquellos empleados que tras su inaguración
  han registrado al menos 2 vuelos y hayan obtenido al menos 100 puntos con 
  un estímulo económico. Genere un reporte de todos los empleados que
  cumplan con estas condiciones.

  Tipo de consulta: Algebra relacional-Intersect*/
 
select e.rfc, e.nombre, e.ap_pat, e.ap_mat, np.num_vuelos, np.total_puntos
from empleado e
join puesto p
  on p.puesto_id=e.puesto_id
join (
  select e.empleado_id, count(*) num_vuelos, sum(puntos) total_puntos
  from vuelo_empleado ve
  join vuelo v
    on v.vuelo_id=ve.vuelo_id
  join empleado e
    on e.empleado_id=ve.empleado_id
  group by e.empleado_id
) np
  on np.empleado_id=e.empleado_id
where np.num_vuelos=2    
intersect  
select e.rfc, e.nombre, e.ap_pat, e.ap_mat, np.num_vuelos, np.total_puntos
from empleado e
join puesto p
  on p.puesto_id=e.puesto_id
join (
  select e.empleado_id, count(*) num_vuelos, sum(puntos) total_puntos
  from vuelo_empleado ve
  join vuelo v
    on v.vuelo_id=ve.vuelo_id
  join empleado e
    on e.empleado_id=ve.empleado_id
  group by e.empleado_id
) np
  on np.empleado_id=e.empleado_id
  where np.total_puntos>=100;  

--CONSULTA 11
--Hacer uso de union
/*Se desea realizar un reporte que contenga a los pasajeros que sean de tipo D y 
  de tipo V, y que hayan tomado el número de vuelo 90700. Recuperar nombre, 
  apellido paterno y materno, número de vuelo, tipo pasajero, asiento y la 
  hora de aterrizaje del vuelo.
  
  Tipo consulta: Algebra relacional - Union e intersect*/

select p.nombre, p.ap_pat, p.ap_mat, v.num_vuelo, vp.tipo_pasajero, vp.asiento, 
  v.fecha_hora_llegada hora_aterrizaje
from pasajero p
join vuelo_pasajero vp
  on vp.pasajero_id=p.pasajero_id
join vuelo v
  on v.vuelo_id=vp.vuelo_id
where tipo_pasajero='D'
union
select p.nombre, p.ap_pat, p.ap_mat, v.num_vuelo, vp.tipo_pasajero, vp.asiento, 
  v.fecha_hora_llegada hora_aterrizaje
from pasajero p
join vuelo_pasajero vp
  on vp.pasajero_id=p.pasajero_id
join vuelo v
  on v.vuelo_id=vp.vuelo_id
where tipo_pasajero='V'
intersect
select p.nombre, p.ap_pat, p.ap_mat, v.num_vuelo, vp.tipo_pasajero, vp.asiento, 
  v.fecha_hora_llegada hora_aterrizaje
from pasajero p
join vuelo_pasajero vp
  on vp.pasajero_id=p.pasajero_id
join vuelo v
  on v.vuelo_id=vp.vuelo_id
where v.num_vuelo=90700;

--CONSULTA 12
/*Haciendo uso de un indice basado en funciones, realice la búsqueda de todos
  los datos de aeronaves de carga que sean del modelo 'BOEING 747', incluyendo
  el nombre del aeropuerto en el que se resguardan.*/

select a.modelo, a.matricula, ac.aeropuerto_id, ae.clave_aeropuerto, ae.nombre
from aeronave a
join aeronave_carga ac
  on ac.aeronave_id=a.aeronave_id
join aeropuerto ae
  on ae.aeropuerto_id=ac.aeropuerto_id
where lower(modelo) = 'boeing 747';