--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  03/12/2021
--@Descripción:     Procedimiento para programar vuelos con aeronaves comerciales.

conn tg_proy_admin/system
set serveroutput on

create or replace procedure p_crea_vuelo_comercial(
  --Tripulación de un vuelo comercial formada por 1 piloto, 1 copiloto,
  --1 jefe de sobrecargos, 3 sobrecargos, 1 ingeniero y 2 auxiliares de seguridad.
  p_num_vuelo in number, p_fecha_hora_salida in date,
  p_fecha_hora_llegada in date, p_aeropuerto_id in number,
  p_aeropuerto_destino_id in number, p_aeronave_id in number,
  p_piloto_id in number, p_copiloto_id in number, 
  p_jefe_sobrecargos_id in number, p_sobrecargo1_id in number, 
  p_sobrecargo2_id in number, p_sobrecargo3_id in number, 
  p_ingeniero_id in number, p_aux_seguridad1_id in number, 
  p_aux_seguridad2_id in number,p_vuelo_id out number
) is
  v_fecha_status_actual vuelo.fecha_status_actual%type;
  v_vuelo_id vuelo.vuelo_id%type;
  v_es_comercial aeronave.es_comercial%type;
  v_es_piloto number(1,0);
  v_es_copiloto number(1,0);
  v_es_sobrecargo number(1,0);
  v_es_tecnico number(1,0);
  v_es_ingeniero number(1,0);
  v_es_seguridad number (1,0);

BEGIN
  if (p_fecha_hora_llegada<p_fecha_hora_salida) then 
    raise_application_error(-20001,'ERROR: Fecha de llegada inválida.');
  end if;
    
  if(p_aeropuerto_id=p_aeropuerto_destino_id) then
    raise_application_error(-20001,'ERROR: Destino inválido: el aeropuerto de 
      origen no puede ser el destino.');
  end if;
      
  select es_comercial into v_es_comercial
  from aeronave
  where aeronave_id=p_aeronave_id;    
      
  if (v_es_comercial=0) then
    raise_application_error(-20001,'ERROR: Aeronave inválida: esta aeronave no 
      está destinada para realizar vuelos comerciales.');
  end if;
  
  --Si llega aquí, los datos de programación del vuelo comercial son válidos,
  --se realiza la programación inicial del vuelo con estatus PROGRAMADO.
  
  v_fecha_status_actual:=sysdate;
  v_vuelo_id:=seq_vuelo.nextval;
  
  insert into vuelo (vuelo_id, num_vuelo, fecha_status_actual, 
    fecha_hora_llegada, fecha_hora_salida, sala, aeropuerto_id, 
    aeropuerto_destino_id, aeronave_id, estatus_vuelo_id)
  values (v_vuelo_id, p_num_vuelo, v_fecha_status_actual, 
    p_fecha_hora_llegada, p_fecha_hora_salida, null, p_aeropuerto_id, 
    p_aeropuerto_destino_id, p_aeronave_id, 1);
      
  --Insertando en Histórico el estado actual...
  insert into historico_estatus_vuelo (historico_estatus_vuelo_id, 
    fecha_status, estatus_vuelo_id, vuelo_id)
  values (seq_historico_status_vuelo.nextval, v_fecha_status_actual,
    1, v_vuelo_id);
    
  --Se establece la tripulación del vuelo programado en vuelo_empleado.
  --Validando los puestos...
  
  --PILOTO
  select count (*) into v_es_piloto 
  from empleado 
  where empleado_id=p_piloto_id and puesto_id=1;
  
  select count (*) into v_es_copiloto 
  from empleado 
  where empleado_id=p_piloto_id and puesto_id=2;
  
  if (v_es_piloto=0 and v_es_copiloto=0) then
    raise_application_error(-20001,'ERROR: Solamente Pilotos y Copilotos pueden
      asumir el rol de Piloto de vuelo.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_piloto_id, 1);
    
  --COPILOTO
  v_es_piloto:=0;
  v_es_copiloto:=0;
  
  select count (*) into v_es_piloto 
  from empleado 
  where empleado_id=p_copiloto_id and puesto_id=1;
  
  select count (*) into v_es_copiloto 
  from empleado 
  where empleado_id=p_copiloto_id and puesto_id=2;
  
  if (v_es_piloto=0 and v_es_copiloto=0) then
    raise_application_error(-20001,'ERROR: Solamente Pilotos y Copilotos pueden
      asumir el rol de Copiloto de vuelo.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_copiloto_id, 2);
    
  --Jefe de sobrecargos
  select count (*) into v_es_sobrecargo
  from empleado 
  where empleado_id=p_jefe_sobrecargos_id and puesto_id=3;
  
  if (v_es_sobrecargo=0) then
    raise_application_error(-20001,'ERROR: El jefe de sobrecargos debe ser 
      un sobrecargo.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_jefe_sobrecargos_id, 3);
    
  --3 sobrecargos/auxiliares de vuelo
  v_es_sobrecargo:=0;
  select count (*) into v_es_sobrecargo
  from empleado 
  where empleado_id=p_sobrecargo1_id and puesto_id=3;
  
  if (v_es_sobrecargo=0) then
    raise_application_error(-20001,'ERROR: Los auxiliares de vuelo deben 
      ser sobrecargos.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_sobrecargo1_id, 4);
    
  v_es_sobrecargo:=0;
  select count (*) into v_es_sobrecargo
  from empleado 
  where empleado_id=p_sobrecargo2_id and puesto_id=3;
  
  if (v_es_sobrecargo=0) then
    raise_application_error(-20001,'ERROR: Los auxiliares de vuelo deben 
      ser sobrecargos.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_sobrecargo2_id, 4);
  
  v_es_sobrecargo:=0;
  select count (*) into v_es_sobrecargo
  from empleado 
  where empleado_id=p_sobrecargo3_id and puesto_id=3;
  
  if (v_es_sobrecargo=0) then
    raise_application_error(-20001,'ERROR: Los auxiliares de vuelo deben 
      ser sobrecargos.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_sobrecargo3_id, 4);
    
  --1 Ingeniero
  select count (*) into v_es_ingeniero
  from empleado 
  where empleado_id=p_ingeniero_id and puesto_id=5;
  
  if (v_es_ingeniero=0) then
    raise_application_error(-20001,'ERROR: Puesto crítico que debe ser 
      ocupado por un Ingeniero de vuelo cualificado.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_ingeniero_id, 5);
    
  --2 auxiliares de seguridad
  select count (*) into v_es_seguridad
  from empleado 
  where empleado_id=p_aux_seguridad1_id and puesto_id=6;
  
  if (v_es_seguridad=0) then
    raise_application_error(-20001,'ERROR: EL personal de seguridad del vuelo
      debe estar debidamente cualificado para ocupar este rol.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_aux_seguridad1_id, 6);
    
  v_es_seguridad:=0;
  select count (*) into v_es_seguridad
  from empleado 
  where empleado_id=p_aux_seguridad2_id and puesto_id=6;
  
  if (v_es_seguridad=0) then
    raise_application_error(-20001,'ERROR: EL personal de seguridad del vuelo
      debe estar debidamente cualificado para ocupar este rol.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_aux_seguridad2_id, 6);
    
  p_vuelo_id:=v_vuelo_id;
  return;
END;
/
show errors
