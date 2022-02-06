--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  07/01/2022
--@Descripción:     Prueba del trigger auditoria_delete_vuelo específico
--                  para logs de eliminaciones de vuelos.

set serveroutput on
Prompt =================================================
Prompt Prueba 1.
Prompt Eliminación de un vuelo recién programado.
Prompt =================================================

/*RN: Para eliminar un vuelo, se requiere que este no tenga pasajeros 
      o paquetes asociados al mismo y, además, se encuentre con 
      status CANCELADO. Este caso se plantea principalmente para vuelos
      que fueron programados, sin embargo, no pasaron al estado ABORDANDO
      en su ciclo de vida.*/
declare
  v_vuelo_id number(10,0);
  v_detalle_evento varchar2(500);
  v_codigo number;
	v_mensaje varchar2(1000);
  v_existe number(1,0);
begin
  dbms_output.put_line('Se espera un nuevo registro en auditoria_vuelo 
  indicando la eliminación del vuelo programado a continuación.');
  p_crea_vuelo_carga(
    p_num_vuelo             =>99989, 
    p_fecha_hora_salida     =>'03-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'04-01-2022 11:15:00', 
    p_aeropuerto_id         =>10,
    p_aeropuerto_destino_id =>13, 
    p_aeronave_id           =>15,
    p_piloto_id             =>2,
    p_copiloto1_id          =>126,
    p_copiloto2_id          =>123,
    p_ingeniero_id          =>2721,
    p_tecnico1_id           =>2470,
    p_tecnico2_id           =>null,
    p_tecnico3_id           =>null,
    p_tecnico4_id           =>null,
    p_tecnico5_id           =>null,
    p_tecnico6_id           =>null,
    p_tecnico7_id           =>null,
    p_tecnico8_id           =>null,
    p_tecnico9_id           =>null,
    p_tecnico10_id          =>null,
    p_vuelo_id              =>v_vuelo_id
  ); 
  
  update vuelo 
  set estatus_vuelo_id=5 
  where vuelo_id=v_vuelo_id;
  delete from vuelo where vuelo_id=v_vuelo_id;
  
  select count(*) into v_existe
  from auditoria_vuelo av
  where detalle_evento like '%99989%'
    and tipo_evento='D';
  
  if(v_existe!=0) then
    dbms_output.put_line('OK!, log de inserción creado. Prueba exitosa.');
      
    select detalle_evento into v_detalle_evento
    from auditoria_vuelo av
    where detalle_evento like '%99989%'
      and tipo_evento='D';
          
    dbms_output.put_line(' A continuación se muestra el log generado: '
      ||v_detalle_evento);                     
    rollback;
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

