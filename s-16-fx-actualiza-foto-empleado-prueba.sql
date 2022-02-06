--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  08/01/2022
--@Descripción:     Bloque de prueba de la función fx-actualiza-foto-empleado.

Prompt =================================================
Prompt Prueba 1.
Prompt Actualización de foto al empleado con ID=1.
Prompt =================================================
declare 
  v_tamaño_foto number;
  v_codigo number;
  v_mensaje varchar2(1000);
begin 
  update empleado
    set foto=actualiza_foto_empleado_1('empleado-2.jpg')
  where empleado_id=1;
    
  select dbms_lob.getlength(foto) into v_tamaño_foto
  from empleado
  where empleado_id=1;
   
  if v_tamaño_foto = 8809 then
    dbms_output.put_line('Prueba exitosa! Tamaño de la foto: ' ||v_tamaño_foto); 
  end if;
  
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada.
        La función no está actuando correctamente.');
      raise;
end;
/
show errors