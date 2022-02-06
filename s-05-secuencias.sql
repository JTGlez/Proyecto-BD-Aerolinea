--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  26/12/2021
--@Descripción:     Creación de todas las secuencias necesarias para la 
--                  inserción de datos.

conn tg_proy_admin/system
prompt Generando secuencias...

--Secuencia para los pasajeros
create sequence seq_pasajero
  start with 1
  increment by 1
  nomaxvalue
  nocycle 
  cache 10;
  
--Secuencia para la maleta, iniciará en 1, como lo indica el caso de estudio
create sequence seq_maleta
  start with 1
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle;

--Secuencia para el historial de estatus vuelo
create sequence seq_historico_status_vuelo
  start with 1
  increment by 1
  nomaxvalue
  nocycle;
  
--Secuencia para el número de medición, de ubicación vuelo, de igual forma
--se indica que debe comenzar en 1
create sequence seq_ubicacion_vuelo
  start with 1
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle
  cache 20;

--Debido al manejo de PK's artificiales, se generarán secuencias para
--los id de cada una de las tablas implementadas.

--Secuencia para el id del pase de abordar
create sequence seq_pase_abordar
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 50;

--Secuencia para el id de paquete
create sequence seq_paquete
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 100;
  
--Secuencia para empleado
create sequence seq_empleado
  start with 20
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle;

--Secuencia para id de aeropuerto
create sequence seq_aeropuerto
  start with 1
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle;
  
--Secuencia status vuelo
create sequence seq_status_vuelo
  start with 1
  increment by 1
  nomaxvalue
  nocycle;
  
  
--Secuencia para aeronave (Super tipo)
create sequence seq_aeronave
  start with 1
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle;

--Secuencia para aeronave carga
create sequence seq_aeronave_carga
  start with 1
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle
  cache 30;
  
--Secuencia para aeronave comercial
create sequence seq_aeronave_comercial
  start with 1
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle;

--Secuencia para vuelo
create sequence seq_vuelo
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  cache 10;

--Secuencia para numero de vuelo
create sequence seq_num_vuelo
  start with 10000 
  increment by 1
  maxvalue 99999
  nocycle
  cache 10;
  
  

--Secuencia para vuelo pasajero
create sequence seq_vuelo_pasajero
  start with 1
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle;
  
--Secuencia para vuelo paquete
create sequence seq_vuelo_paquete
  start with 1
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle;

--Secuencia para vuelo empleado
create sequence seq_vuelo_empleado
  start with 1
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle;
  commit;
--Secuencia para las direcciones web de los empleados
create sequence seq_empleado_direccion_web
  start with 1
  increment by 1
  nomaxvalue
  minvalue 0
  nocycle
  cache 5;
  
--Secuencia para la tabla de auditoria de paquete
create sequence seq_paquete_auditoria_aduanal
  start with 1
  increment by 1 
  nomaxvalue
  minvalue 0
  nocycle
  cache 5;
  
create sequence seq_auditoria_vuelo
  start with 1
  increment by 1 
  nomaxvalue
  minvalue 0
  nocycle
  cache 5;

commit;