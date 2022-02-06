--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  07/01/2022
--@Descripción:     Bloques para validar el trigger trg_auditoria_vuelo.

set serveroutput on
Prompt =================================================
Prompt Prueba 1.
Prompt Programación de un nuevo vuelo.
Prompt =================================================
declare
  v_vuelo_id number(10,0);
  v_log_existe number(1,0);
  v_detalle_evento varchar2(500);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  dbms_output.put_line('Se espera un nuevo registro en auditoria_vuelo 
  indicando la programación del vuelo creado en la base.');
  p_crea_vuelo_comercial(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'07-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'07-01-2022 09:15:00', 
    p_aeropuerto_id         =>18,
    p_aeropuerto_destino_id =>42, 
    p_aeronave_id           =>5,
    p_piloto_id             =>50,
    p_copiloto_id           =>113,
    p_jefe_sobrecargos_id   =>414,
    p_sobrecargo1_id        =>497,
    p_sobrecargo2_id        =>612,
    p_sobrecargo3_id        =>1007,
    p_ingeniero_id          =>2724,
    p_aux_seguridad1_id     =>2932,
    p_aux_seguridad2_id     =>2938,
    p_vuelo_id              =>v_vuelo_id
  );
  
  select count(*) into v_log_existe
  from auditoria_vuelo av
  where vuelo_id=v_vuelo_id
    and tipo_evento='I';
  
  if(v_log_existe!=0) then
    dbms_output.put_line('OK!, log de inserción creado. Prueba 1 exitosa.');
    
    select detalle_evento into v_detalle_evento
    from auditoria_vuelo av
    where vuelo_id=v_vuelo_id
      and tipo_evento='I';
      
    dbms_output.put_line(' A continuación se muestra el log generado: '
      ||v_detalle_evento);
  else
    raise_application_error(-20001,'El registro no se insertó. El Trigger
      no funcionó correctamente.'); 
  end if;
 
  exception
    when others then
      dbms_output.put_line('Error detectado: realizando rollback...');
      rollback;
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      dbms_output.put_line('A continuación se envía la excepción encontrada.');
      raise;
end;
/
show errors

Prompt =================================================
Prompt Prueba 2.
Prompt Actualización del vuelo creado.
Prompt =================================================
declare
  v_vuelo_id number(10,0);
  v_num_vuelo number(5,0);
  v_log_existe number(1,0);
  v_detalle_evento varchar2(500);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  dbms_output.put_line('Se espera un nuevo registro en auditoria_vuelo 
  indicando que se ha realizado un cambio en los datos del vuelo.');

  v_vuelo_id:=seq_vuelo.currval;
  update vuelo
  set sala=2,
    fecha_hora_salida='07-01-2022 05:35:00',
    fecha_hora_llegada='07-01-2022 11:15:00'
  where vuelo_id=v_vuelo_id;
  
  select count(*) into v_log_existe
  from auditoria_vuelo av, vuelo v
  where av.vuelo_id=v.vuelo_id
    and av.vuelo_id=v_vuelo_id
    and tipo_evento='U';
  
  if(v_log_existe!=0) then
    dbms_output.put_line('OK!, log de inserción creado. Prueba 2 exitosa.');
    
    select detalle_evento into v_detalle_evento
      from auditoria_vuelo av
    where av.vuelo_id=v_vuelo_id
      and tipo_evento='U';
      
    dbms_output.put_line(' A continuación se muestra el log generado: '
      ||v_detalle_evento);
  else
    raise_application_error(-20001,'El registro no se insertó. El Trigger
      no funcionó correctamente.'); 
  end if;
 
  exception
    when others then
      dbms_output.put_line('Error detectado: realizando rollback...');
      rollback;
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      dbms_output.put_line('A continuación se envía la excepción encontrada.');
      raise;
end;
/
show errors

Prompt =================================================
Prompt Prueba 3.
Prompt Segunda Actualización del vuelo creado.
Prompt =================================================
declare
  v_vuelo_id number(10,0);
  v_log_existe number(1,0);
  v_num_vuelo number(5,0);
  v_detalle_evento varchar2(500);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  dbms_output.put_line('Se espera otro registro en auditoria_vuelo 
  indicando que se ha realizado nuevamente otro cambio en el vuelo creado.
  Se modifica la sala y la hora estimada de llegada.');
  v_vuelo_id:=seq_vuelo.currval;
  update vuelo
  set sala=20,
    fecha_hora_llegada='07-01-2022 12:00:00'
  where vuelo_id=v_vuelo_id;
  
  select count(*) into v_log_existe
  from auditoria_vuelo av, vuelo v
  where av.vuelo_id=v.vuelo_id
    and av.vuelo_id=v_vuelo_id
    and tipo_evento='U'
    and fecha_hora_llegada_nueva='07-01-2022 12:00:00';
  
  if(v_log_existe!=0) then
    dbms_output.put_line('OK!, log de inserción creado. Prueba 3 exitosa.');
    
    select detalle_evento into v_detalle_evento
    from auditoria_vuelo av
    where av.vuelo_id=v_vuelo_id
      and tipo_evento='U'
      and fecha_hora_llegada_nueva='07-01-2022 12:00:00';
      
    dbms_output.put_line(' A continuación se muestra el log generado: '
      ||v_detalle_evento);
  else
    raise_application_error(-20001,'El registro no se insertó. El Trigger
      no funcionó correctamente.'); 
  end if;
 
  exception
    when others then
      dbms_output.put_line('Error detectado: realizando rollback...');
      rollback;
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      dbms_output.put_line('A continuación se envía la excepción encontrada.');
      raise;
end;
/
show errors