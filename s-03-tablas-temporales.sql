--@Autor(es): González Rosas Berenise & 
--            Téllez González Jorge Luis
--@Fecha de Creación: 26/12/2021
--@Descripción: Implementación de tablas temporales: Air Flights

prompt Creando tablas temporales...
conn tg_proy_admin/system

--Tabla con los datos denormalizados de una aeronave.
create global temporary table aeronave_temp 
  on commit preserve rows
  as select a.aeronave_id, a.matricula, a.modelo, a.especificaciones, 
    a.es_carga, a.es_comercial, aca.capacidad_carga, aca.dim_total, 
    aca.aeropuerto_id, aco.capacidad_ordinarios, aco.capacidad_vip, 
    aco.capacidad_discapacitados 
  from aeronave a, aeronave_carga aca, aeronave_comercial aco
  where a.aeronave_id=aca.aeronave_id(+)
    and a.aeronave_id=aco.aeronave_id (+);
    
--drop table aeronave_temp;
--select * from distancia_aeropuertos_cdmx;

--Tabla con las distancia existente en [km] desde el AICM hasta el resto de 
--aeropuertos registrados en la base.
create global temporary table distancia_aeropuertos_cdmx_temp
  on commit preserve rows
  as select a2.aeropuerto_id, a2.nombre,
  trunc((acos(sin((3.14159265359/180)*a1.latitud) 
    * sin((3.14159265359/180)*a2.latitud) + cos((3.14159265359/180)*a1.latitud) 
    * cos((3.14159265359/180)*a2.latitud) * cos((3.14159265359/180)*(a1.longitud) 
    - (3.14159265359/180)*(a2.longitud))) * 6371)) distancia
  from aeropuerto a1, aeropuerto a2
  where a1.clave_aeropuerto='MEX-83N27DN28';


--drop table distancia_aeropuertos_cdmx_temp
--select * from distancia_aeropuertos_cdmx_temp;
        
