--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  03/12/2021
--@Descripción:     Procedimiento para programar vuelos con aeronaves de carga.

conn tg_proy_admin/system
set serveroutput on

create or replace procedure p_crea_vuelo_carga(
  --Tripulación de un vuelo comercial formada por 1 piloto, 2 copilotos,
  --1 ingeniero y hasta 10 técnicos.
  p_num_vuelo in number, p_fecha_hora_salida in date,
  p_fecha_hora_llegada in date, p_aeropuerto_id in number,
  p_aeropuerto_destino_id in number, p_aeronave_id in number,
  p_piloto_id in number,   p_copiloto1_id in number, p_copiloto2_id in number, 
  p_ingeniero_id in number,p_tecnico1_id in number, p_tecnico2_id in number, 
  p_tecnico3_id in number, p_tecnico4_id in number, p_tecnico5_id in number, 
  p_tecnico6_id in number, p_tecnico7_id in number, p_tecnico8_id in number, 
  p_tecnico9_id in number, p_tecnico10_id in number,p_vuelo_id out number
) is
  v_fecha_status_actual vuelo.fecha_status_actual%type;
  v_vuelo_id vuelo.vuelo_id%type;
  v_es_carga aeronave.es_carga%type;
  v_es_piloto number(1,0);
  v_es_copiloto number(1,0);
  v_es_ingeniero number(1,0);
  v_es_tecnico number(1,0);

BEGIN
  if (p_fecha_hora_llegada<p_fecha_hora_salida) then 
    raise_application_error(-20001,'ERROR: Fecha de llegada inválida.');
  end if;
    
  if(p_aeropuerto_id=p_aeropuerto_destino_id) then
    raise_application_error(-20001,'ERROR: Destino inválido: el aeropuerto de 
      origen no puede ser el destino.');
  end if;
      
  select es_carga into v_es_carga
  from aeronave
  where aeronave_id=p_aeronave_id;    
      
  if (v_es_carga=0) then
    raise_application_error(-20001,'ERROR: Aeronave inválida: esta aeronave no 
      está destinada para realizar vuelos de carga.');
  end if;
  
  --Si llega aquí, los datos de programación del vuelo de carga son válidos,
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
    
  --COPILOTO 1
  v_es_piloto:=0;
  v_es_copiloto:=0;
  
  select count (*) into v_es_piloto 
  from empleado 
  where empleado_id=p_copiloto1_id and puesto_id=1;
  
  select count (*) into v_es_copiloto 
  from empleado 
  where empleado_id=p_copiloto1_id and puesto_id=2;
  
  if (v_es_piloto=0 and v_es_copiloto=0) then
    raise_application_error(-20001,'ERROR: Solamente Pilotos y Copilotos pueden
      asumir el rol de Copiloto de vuelo.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_copiloto1_id, 2);
    
  --COPILOTO2
  v_es_piloto:=0;
  v_es_copiloto:=0;
  
  select count (*) into v_es_piloto 
  from empleado 
  where empleado_id=p_copiloto2_id and puesto_id=1;
  
  select count (*) into v_es_copiloto 
  from empleado 
  where empleado_id=p_copiloto2_id and puesto_id=2;
  
  if (v_es_piloto=0 and v_es_copiloto=0) then
    raise_application_error(-20001,'ERROR: Solamente Pilotos y Copilotos pueden
      asumir el rol de Copiloto de vuelo.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_copiloto2_id, 2);
    
  --INGENIERO
  select count (*) into v_es_ingeniero
  from empleado 
  where empleado_id=p_ingeniero_id and puesto_id=5;
  
  if (v_es_ingeniero=0) then
    raise_application_error(-20001,'ERROR: Puesto crítico que debe ser ocupado 
      por un Ingeniero de vuelo cualificado.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_ingeniero_id, 5);
    
  --TECNICO 1
  if(p_tecnico1_id is null) then
    raise_application_error(-20001,'ERROR: El vuelo requiere tener como mínimo 
      un técnico de carga registrado en el mismo.');
  end if;
  
  select count (*) into v_es_tecnico
  from empleado 
  where empleado_id=p_tecnico1_id and puesto_id=4;
  
  if (v_es_tecnico=0) then
    raise_application_error(-20001,'ERROR: Personal inválido. Se requieren
      exclusivamente técnicos de vuelo para este rol.');
  end if;
  
  insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
    empleado_id, rol_id)
  values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
    v_vuelo_id, p_tecnico1_id, 7);
  
  --TECNICO 2
  if(p_tecnico2_id is null) then
    dbms_output.put_line('No se ingresó un 2do técnico.');
  else
    v_es_tecnico:=0;
    select count (*) into v_es_tecnico
    from empleado 
    where empleado_id=p_tecnico2_id and puesto_id=4;
    
    if (v_es_tecnico=0) then
      raise_application_error(-20001,'ERROR: Personal inválido. Se requieren
        exclusivamente técnicos de vuelo para este rol.');
    end if;
    
    insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
      empleado_id, rol_id)
    values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
      v_vuelo_id, p_tecnico2_id, 7);
  end if;
  
  --TECNICO 3
  if(p_tecnico3_id is null) then
    dbms_output.put_line('No se ingresó un 3er técnico.');
  else
    v_es_tecnico:=0;
    select count (*) into v_es_tecnico
    from empleado 
    where empleado_id=p_tecnico3_id and puesto_id=4;
    
    if (v_es_tecnico=0) then
      raise_application_error(-20001,'ERROR: Personal inválido. Se requieren
        exclusivamente técnicos de vuelo para este rol.');
    end if;
    
    insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
      empleado_id, rol_id)
    values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
      v_vuelo_id, p_tecnico3_id, 7);
  end if;
  
  --TECNICO 4
  if(p_tecnico4_id is null) then
    dbms_output.put_line('No se ingresó un 4to técnico.');
  else
    v_es_tecnico:=0;
    select count (*) into v_es_tecnico
    from empleado 
    where empleado_id=p_tecnico4_id and puesto_id=4;
    
    if (v_es_tecnico=0) then
      raise_application_error(-20001,'ERROR: Personal inválido. Se requieren
        exclusivamente técnicos de vuelo para este rol.');
    end if;
    
    insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
      empleado_id, rol_id)
    values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
      v_vuelo_id, p_tecnico4_id, 7);
  end if;
  
  --TECNICO 5
  if(p_tecnico5_id is null) then
    dbms_output.put_line('No se ingresó un 5to técnico.');
  else
    v_es_tecnico:=0;
    select count (*) into v_es_tecnico
    from empleado 
    where empleado_id=p_tecnico5_id and puesto_id=4;
    
    if (v_es_tecnico=0) then
      raise_application_error(-20001,'ERROR: Personal inválido. Se requieren
        exclusivamente técnicos de vuelo para este rol.');
    end if;
    
    insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
      empleado_id, rol_id)
    values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
      v_vuelo_id, p_tecnico5_id, 7);
  end if;
  
  --TECNICO 6  
  if(p_tecnico6_id is null) then
    dbms_output.put_line('No se ingresó un 6to técnico.');
  else
    v_es_tecnico:=0;
    select count (*) into v_es_tecnico
    from empleado 
    where empleado_id=p_tecnico6_id and puesto_id=4;
    
    if (v_es_tecnico=0) then
      raise_application_error(-20001,'ERROR: Personal inválido. Se requieren
        exclusivamente técnicos de vuelo para este rol.');
    end if;
    
    insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
      empleado_id, rol_id)
    values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
      v_vuelo_id, p_tecnico6_id, 7);
  end if;
  
  --TECNICO 7  
  if(p_tecnico7_id is null) then
    dbms_output.put_line('No se ingresó un 7mo técnico.');
  else
    v_es_tecnico:=0;
    select count (*) into v_es_tecnico
    from empleado 
    where empleado_id=p_tecnico7_id and puesto_id=4;
    
    if (v_es_tecnico=0) then
      raise_application_error(-20001,'ERROR: Personal inválido. Se requieren
        exclusivamente técnicos de vuelo para este rol.');
    end if;
    
    insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
      empleado_id, rol_id)
    values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
      v_vuelo_id, p_tecnico7_id, 7);
  end if;
  
  --TECNICO 8 
  if(p_tecnico8_id is null) then
    dbms_output.put_line('No se ingresó un 8vo técnico.');
  else
    v_es_tecnico:=0;
    select count (*) into v_es_tecnico
    from empleado 
    where empleado_id=p_tecnico8_id and puesto_id=4;
    
    if (v_es_tecnico=0) then
      raise_application_error(-20001,'ERROR: Personal inválido. Se requieren
        exclusivamente técnicos de vuelo para este rol.');
    end if;
    
    insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
      empleado_id, rol_id)
    values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
      v_vuelo_id, p_tecnico8_id, 7);
  end if;
  
  --TECNICO 9  
  if(p_tecnico9_id is null) then
    dbms_output.put_line('No se ingresó un 9no técnico.');
  else
    v_es_tecnico:=0;
    select count (*) into v_es_tecnico
    from empleado 
    where empleado_id=p_tecnico9_id and puesto_id=4;
    
    if (v_es_tecnico=0) then
      raise_application_error(-20001,'ERROR: Personal inválido. Se requieren
        exclusivamente técnicos de vuelo para este rol.');
    end if;
    
    insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
      empleado_id, rol_id)
    values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
      v_vuelo_id, p_tecnico9_id, 7);
  end if;
  
  --TECNICO 10  
  if(p_tecnico10_id is null) then
    dbms_output.put_line('No se ingresó un 10mo técnico.');
  else
    v_es_tecnico:=0;
    select count (*) into v_es_tecnico
    from empleado 
    where empleado_id=p_tecnico10_id and puesto_id=4;
    
    if (v_es_tecnico=0) then
      raise_application_error(-20001,'ERROR: Personal inválido. Se requieren
        exclusivamente técnicos de vuelo para este rol.');
    end if;
    
    insert into vuelo_empleado(vuelo_empleado_id, puntos, vuelo_id, 
      empleado_id, rol_id)
    values (seq_vuelo_empleado.nextval, dbms_random.value(1,100), 
      v_vuelo_id, p_tecnico10_id, 7);
  end if;
   
  --Retorno del vuelo id 
  p_vuelo_id:=v_vuelo_id; 
  return; 
END;
/
show errors