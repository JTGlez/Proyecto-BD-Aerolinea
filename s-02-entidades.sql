--@Autor(es): González Rosas Berenise & 
--            Téllez González Jorge Luis
--@Fecha de Creación: 23/12/2021
--@Descripción: Creación de las tablas del proyecto final: Air Flights.

prompt Creando las tablas del caso de estudio...
conn tg_proy_admin/system

/*Entidades sin FK*/

--Catálogo de aeropuertos.
create table aeropuerto(
  aeropuerto_id         number(10,0)    
  constraint            aeropuerto_pk   primary key,
  clave_aeropuerto      varchar2(13)    not null,
  nombre                varchar2(100)   not null,
  latitud               number(9,6)     not null,
  longitud              number(9,6)     not null,
  flag_activo           number(1,0)     not null,
  constraint aeropuerto_flag_activo_chk check(
    flag_activo in (1,0)
  ),
  constraint aeropuerto_clave_aeropuerto_uk unique(clave_aeropuerto)
);

--Tabla de pasajeros de un vuelo.
create table pasajero(
  pasajero_id           number(10,0)    
  constraint            pasajero_pk       primary key,
  nombre                varchar2(60)      not null,
  ap_pat                varchar2(60)      not null,
  ap_mat                varchar2(60),
  email                 varchar2(60),
  fecha_nacimiento      date              not null,
  curp                  varchar2(18)      not null,
  constraint            pasajero_curp_uk  unique (curp)
);

--Pase generado 10 minutos antes de que el avión de un vuelo despegue.
create table pase_abordar(
  pase_abordar_id     number(10,0)    
  constraint          pase_abordar_pk             primary key,
  folio_pase          varchar2(8)                 not null,
  fecha_impresion     date                        not null,
  constraint          pase_abordar_folio_pase_uk  unique(folio_pase)
);

--Tabla de estatus por las que puede pasar un vuelo.
create table estatus_vuelo(
  estatus_vuelo_id   number(10,0)    
  constraint         estatus_vuelo_pk  primary key,
  clave_estatus      varchar2(3)       not null,
  nombre             varchar2(30)      not null,
  descripcion        varchar2(200)     not null
);

--Catálogo de puestos de un empleado.
create table puesto(
  puesto_id             number(10,0) 
  constraint            puesto_pk       primary key,
  clave_puesto          varchar2(3)     not null,
  nombre                varchar2(40)    not null,
  sueldo_mensual        number(10,0)    not null,
  sueldo_quincenal      generated always as (sueldo_mensual/2) virtual,
  descripcion           varchar2(300)   not null
);

--Catálogo de roles de un empleado. 
create table rol(
  rol_id                number(10,0)    
  constraint            rol_pk          primary key,
  clave_rol             varchar2(3)     not null,
  nombre                varchar2(40)    not null,
  descripcion           varchar2(200)   not null
);

--Catálogo de paquetes de acuerdo a su naturaleza. Pendiente preguntar al profe
create table tipo_paquete(
  tipo_paquete_id       number (10,0) 
  constraint            tipo_paquete_pk  primary key,
  clave_paquete         varchar2(3)      not null,
  descripcion           varchar2(100)    not null,
  indicaciones          varchar2(300)    not null  
);

--Tabla de aeronaves.
create table aeronave(
  aeronave_id           number(10,0) 
  constraint            aeronave_pk               primary key,
  matricula             varchar2(10)              not null,
  modelo                varchar2(50)              not null,
  especificaciones      blob                      default empty_blob() not null,
  es_carga              number(1,0)               not null,
  es_comercial          number(1,0)               not null,
  constraint            aeronave_matricula_uk     unique(matricula),
  constraint            aeronave_es_carga_chk     check(es_carga in (1,0)),
  constraint            aeronave_es_comercial_chk check(es_comercial in (1,0)),
  constraint            aeronave_es_carga_es_comercial_chk check(
    (es_carga=1 and es_comercial=1) or 
    (es_carga=1 and es_comercial=0) or 
    (es_carga=0 and es_comercial=1)
  )
);
  

/*Entidades con FK*/

create table aeronave_carga(
  aeronave_id         number(10,0) 
  constraint          aeronave_carga_pk    primary key,
  num_bodegas         number(2,0)          not null,
  capacidad_carga     number(4,0)          not null,
  alto                number(4,0)          not null,
  ancho               number(4,0)          not null,
  profundidad         number(4,0)          not null,
  dim_total           generated always as 
    (num_bodegas*(alto*ancho*profundidad)) virtual,
  aeropuerto_id       number(10,0)         not null,
  constraint          aeronave_carga_aeronave_id_fk foreign key (aeronave_id) 
  references aeronave (aeronave_id)
);

create table aeronave_comercial(
  aeronave_id               number(10,0) 
  constraint                aeronave_comercial_pk  primary key,
  capacidad_ordinarios      number(3,0)            not null,
  capacidad_vip             number(3,0)            not null,
  capacidad_discapacitados  number(3,0)            not null,
  constraint                aeronave_comercial_aeronave_id_fk 
  foreign key (aeronave_id) references aeronave (aeronave_id)  
);

--Tabla de vuelos programados. Preguntar si las fecha hora almacenadas
--solo son estimados y si es correcto almacenar fecha hora "reales"
create table vuelo(
  vuelo_id              number(10,0)    
  constraint            vuelo_pk        primary key,
  num_vuelo             number(5,0)     not null,
  sala                  number(2,0),
  fecha_hora_llegada    date            not null,
  fecha_hora_salida     date            not null,
  fecha_status_actual   date            not null,
  aeropuerto_id         number(10,0)    not null,
  aeropuerto_destino_id number(10,0)    not null,
  aeronave_id           number(10,0)    not null,
  estatus_vuelo_id      number(10,0)    not null,
  constraint            vuelo_aeropuerto_id_fk    
    foreign key (aeropuerto_id) references aeropuerto (aeropuerto_id),
  constraint            vuelo_aeropuerto_destino_id_fk 
    foreign key (aeropuerto_destino_id) references aeropuerto (aeropuerto_id),
  constraint            vuelo_aeronave_id_fk      
    foreign key (aeronave_id) references aeronave(aeronave_id),
  constraint            vuelo_estatus_vuelo_id_fk 
    foreign key (estatus_vuelo_id) references estatus_vuelo (estatus_vuelo_id),
  constraint            vuelo_num_vuelo_uk  unique (num_vuelo),
  constraint            vuelo_num_vuelo_chk check  (length(num_vuelo)=5)
);

--Lista de pasajeros de un vuelo.
create table vuelo_pasajero(
  vuelo_pasajero_id     number(10,0) 
  constraint            vuelo_pasajero_pk  primary key,
  asiento               number(4,0)        not null,
  tipo_pasajero         char,
  atenciones_esp        varchar2(2000),
  flag_tomo_viaje       number(1,0),
  vuelo_id              number(10,0)       not null,
  pasajero_id           number(10,0)       not null,
  pase_abordar_id       number(10,0),
  constraint            vuelo_pasajero_vuelo_id_fk        
    foreign key (vuelo_id) references vuelo(vuelo_id),
  constraint            vuelo_pasajero_pasajero_id_fk     
    foreign key (pasajero_id) references pasajero(pasajero_id),
  constraint            vuelo_pasajero_pase_abordar_id_fk 
    foreign key (pase_abordar_id) references pase_abordar(pase_abordar_id) 
    on delete set null,
  constraint            vuelo_pasajero_flag_tomo_viaje_chk 
    check (flag_tomo_viaje in (1,0)),
  constraint            vuelo_pasajero_tipo_pasajero_chk 
    check(tipo_pasajero in ('O', 'V', 'D')),
  constraint            vuelo_pasajero_vuelo_id_pasajero_id_uk 
    unique(vuelo_id, pasajero_id)
);

--Equipaje registrado de un pasajero de un vuelo. Pendiente preguntar
--si es correcto añadir un check para un peso maximo para las maletas.
create table maleta(
  num_maleta            number(10,0)  not null,
  pase_abordar_id       number(10,0)  not null,
  peso                  number(4,0)   not null,
  constraint            maleta_pk     primary key (num_maleta, pase_abordar_id),
  constraint            maleta_pase_abordar_id_fk         
    foreign key (pase_abordar_id) references pase_abordar(pase_abordar_id)
);

--Histórico de las ubicaciones de un vuelo actualizadas cada 1 minuto.
create table ubicacion_vuelo(
  num_medicion        number(10,0)        not null,
  vuelo_id            number(10,0)        not null,
  fecha_hora_actual   date                not null,
  latitud_actual      number(8,6)         not null,
  longitud_actual     number(8,6)         not null,
  constraint          ubicacion_vuelo_pk  primary key (num_medicion, vuelo_id),
  constraint          ubicacion_vuelo_vuelo_id_fk       
    foreign key (vuelo_id) references vuelo(vuelo_id)
);

--Histórico de los estados por los que pasa un vuelo.
create table historico_estatus_vuelo(
  historico_estatus_vuelo_id  number(10,0)    
  constraint                  historico_estatus_vuelo_pk  primary key,
  fecha_status                date            not null,
  estatus_vuelo_id            number(10,0)    not null,
  vuelo_id                    number(10,0)    not null,
  constraint                  historico_estatus_vuelo_estatus_vuelo_id_fk 
    foreign key (estatus_vuelo_id) references estatus_vuelo(estatus_vuelo_id),
  constraint                  historico_estatus_vuelo_vuelo_id_fk 
    foreign key (vuelo_id) references vuelo(vuelo_id) on delete cascade,
  constraint                  historico_estatus_vuelo_estatus_vuelo_id_vuelo_id
    unique (estatus_vuelo_id, vuelo_id)
);

--Paquetes transportados por un vuelo de carga.
create table paquete(
  paquete_id                  number(10,0) 
  constraint                  paquete_pk      primary key,
  folio_paquete               number(18,0)    not null,
  peso                        number(5,0)     not null,
  tipo_paquete_id             number(10,0)    not null,
  constraint                  paquete_tipo_paquete_id_fk  
    foreign key (tipo_paquete_id) references tipo_paquete(tipo_paquete_id),
  constraint                  paquete_folio_paquete_uk unique(folio_paquete)
);

--Lista de paquetes transportados por un vuelo con un avión de carga.
create table vuelo_paquete(
  vuelo_paquete_id    number(10,0) 
  constraint          vuelo_paquete_pk  primary key,
  vuelo_id            number(10,0)      not null,
  paquete_id          number(10,0)      not null,
  constraint          vuelo_paquete_vuelo_id_fk   
    foreign key (vuelo_id) references vuelo(vuelo_id),
  constraint          vuelo_paquete_paquete_id_fk 
    foreign key (paquete_id) references paquete(paquete_id),
  constraint          vuelo_paquete_vuelo_id_paquete_id_uk 
    unique(vuelo_id, paquete_id)
);

--Tabla de empleados de la aerolínea.
create table empleado(
  empleado_id           number(10,0)    
  constraint            empleado_pk            primary key,
  rfc                   varchar2(13)           not null,
  nombre                varchar2(60)           not null,
  ap_pat                varchar2(60)           not null,
  ap_mat                varchar2(60)           not null,
  foto                  blob                   default empty_blob() not null,
  curp                  varchar2(18)           not null,
  empleado_jefe_id      number(10,0),    
  puesto_id             number(10,0)           not null,
  constraint            empleado_rfc_uk        unique (rfc),
  constraint            empleado_curp_uk       unique (curp),
  constraint            empleado_puesto_id_fk  foreign key(puesto_id) 
    references puesto(puesto_id),
  constraint            empleado_empleado_jefe_id_fk  
    foreign key(empleado_jefe_id) references empleado(empleado_id) 
    on delete set null
);


--Tabla de empleados que participarán en un vuelo.
create table vuelo_empleado(
  vuelo_empleado_id   number(10,0)    
  constraint          vuelo_empleado_pk             primary key,
  puntos              number(3,0)                   not null,
  vuelo_id            number(10,0)                  not null,
  empleado_id         number(10,0)                  not null, 
  rol_id              number(10,0)                  not null,
  constraint          vuelo_empleado_vuelo_id_fk    foreign key(vuelo_id)
    references vuelo(vuelo_id) on delete cascade,
  constraint          vuelo_empleado_empleado_id_fk foreign key(empleado_id)
    references empleado(empleado_id),
  constraint          vuelo_empleado_rol_id_fk      foreign key(rol_id) 
    references rol(rol_id),
  constraint          vuelo_empleado_vuelo_id_empleado_id 
    unique(vuelo_id, empleado_id),
  constraint          vuelo_empleado_puntos_chk   
    check(puntos>=0 and puntos <=100)
);


--Direcciones web de un empleado para consultar su historial laboral. 
create table empleado_direccion_web(
  empleado_direccion_web_id   number(10,0) 
  constraint                  empleado_direccion_web_pk  primary key,
  direccion_web               varchar2(400)              not null,
  empleado_id                 number(10,0)               not null,
  constraint                  empleado_direccion_web_empleado_id_fk       
    foreign key (empleado_id) references empleado(empleado_id)
);

--Tabla de auditoría para los paquetes que requieran revisión aduanal.

create table paquete_auditoria_aduanal(
  paquete_auditoria_aduanal_id number(10,0) 
  constraint                   paquete_auditoria_aduanal_pk primary  key,
  razon                        varchar2(300)                not null,
  fecha_aviso                  date                         not null,
  paquete_id                   number(10,0)                 not null,
  constraint paquete_auditoria_aduanal_paquete_id_fk        
    foreign key (paquete_id) references paquete(paquete_id),
  constraint paquete_auditoria_aduanal_paquete_id_uk  
    unique (paquete_id)
);

--Tabla de auditoría para los cambios

create table auditoria_vuelo(
  auditoria_vuelo_id          number(10,0)      
  constraint                  auditoria_vuelo_pk primary key,
  fecha_evento                date               not null,
  usuario                     varchar2(40)       not null,
  tipo_evento                 char               not null,
  fecha_hora_llegada_anterior date,
  fecha_hora_llegada_nueva    date,
  fecha_hora_salida_anterior  date,
  fecha_hora_salida_nueva     date,
  detalle_evento              varchar2(500)      not null,
  vuelo_id                    number(10,0),
  constraint                  auditoria_vuelo_vuelo_id_fk   
    foreign key (vuelo_id) references vuelo(vuelo_id) on delete set null
);
