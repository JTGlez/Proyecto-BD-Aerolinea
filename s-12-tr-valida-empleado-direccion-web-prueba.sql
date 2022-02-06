--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  06/01/2022
--@Descripción:     Prueba del trigger que valida que un empleado 
--                  no tenga más de 5 direcciones web.

Prompt =================================================
Prompt Prueba 1.
Prompt Registro de 5 direcciones web a un empleado.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  insert into empleado_direccion_web(empleado_direccion_web_id, 
   direccion_web, empleado_id)
  values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si1.com', 1000);
  
  insert into empleado_direccion_web(empleado_direccion_web_id, 
   direccion_web, empleado_id)
  values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si2.com', 1000);
  
  insert into empleado_direccion_web(empleado_direccion_web_id, 
   direccion_web, empleado_id)
  values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si3.com', 1000);
  
  insert into empleado_direccion_web(empleado_direccion_web_id, 
   direccion_web, empleado_id)
  values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si4.com', 1000);
  
  insert into empleado_direccion_web(empleado_direccion_web_id, 
   direccion_web, empleado_id)
  values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si5.com', 1000);
  --commit;
  dbms_output.put_line('OK! Direcciones registradas exitosamente. Prueba 1 exitosa.');
  rollback;
  --commit;
  
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
show errors;
  
Prompt =================================================
Prompt Prueba 2.
Prompt Registro de 6 direcciones web a un empleado.
Prompt =================================================

Prompt Se espera un resultado negativo al impedir el trigger el registro 
prompt de direcciones adicionales.

Prompt Se añaden 5 direcciones iniciales y se espera que con la sexta
prompt el trigger se dispare e impida el nuevo registro.

insert into empleado_direccion_web(empleado_direccion_web_id, 
 direccion_web, empleado_id)
values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si1.com', 302);

insert into empleado_direccion_web(empleado_direccion_web_id, 
  direccion_web, empleado_id)
values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si2.com', 302);

insert into empleado_direccion_web(empleado_direccion_web_id, 
  direccion_web, empleado_id)
values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si3.com', 302);

insert into empleado_direccion_web(empleado_direccion_web_id, 
  direccion_web, empleado_id)
values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si4.com', 302);

insert into empleado_direccion_web(empleado_direccion_web_id, 
  direccion_web, empleado_id)
values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si5.com', 302);

declare
  v_codigo number;
	v_mensaje varchar2(1000);
begin

  insert into empleado_direccion_web(empleado_direccion_web_id, 
    direccion_web, empleado_id)
  values (SEQ_EMPLEADO_DIRECCION_WEB.nextval, 'https://si6.com', 302);
  --commit;
  rollback;
  dbms_output.put_line('OK! Direcciones registradas exitosamente. Prueba 2 exitosa.');
    
  exception
    when others then
      dbms_output.put_line('ERROR: El empleado ya cuenta con 5 direcciones web
        realizando rollback...');
      rollback;
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      if v_codigo = -20001 then
    	  dbms_output.put_line('OK, prueba 2 exitosa.');
      else
    	  dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/
show errors;