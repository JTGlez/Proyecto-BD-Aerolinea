--@Autor(es): González Rosas Berenise & 
--            Téllez González Jorge Luis
--@Fecha de Creación: 26/12/2021
--@Descripción: Creación de índices: Air Flights

conn tg_proy_admin/system
prompt Generando índices...
--Índices non-unique para agilizar consultas.

--Tabla Pasajero
create index pa_email_ix on pasajero(email);

--Tabla Vuelo

/*Foráneas que se utilizan frecuentemente en consultas.*/
create index vu_aeropuerto_destino_id_ix on vuelo(aeropuerto_destino_id);
create index vu_aeropuerto_id_ix on vuelo(aeropuerto_id);
create index vu_aeronave_id_ix on vuelo(aeronave_id);
create index vu_estatus_vuelo_id_ix on vuelo(estatus_vuelo_id);

--Tabla de Histórico
/*Foráneas que se utilizan frecuentemente en consultas.*/
create index hev_vuelo_id_ix on historico_estatus_vuelo(vuelo_id);

--Tabla Empleado_Direccion_Web
/*Foráneas que se utilizan frecuentemente en consultas.*/
create index edw_empleado_id_ix on empleado_direccion_web(empleado_id);

--Indices basados en funciones
create index idx_empleado_nombre on
empleado (upper(nombre));

create index idx_nombre_pasajero on
pasajero (lower(nombre));

create index idx_matricula on
aeronave (lower(matricula));

create index idx_modelo on
aeronave (upper(modelo));

