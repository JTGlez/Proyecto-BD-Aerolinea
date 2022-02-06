--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  06/01/2022
--@Descripción:     Bloque para validar el trigger trg_auditoria_paquete.

Prompt =================================================
Prompt Prueba 1.
Prompt Registro de un paquete 'GEN' de más de 100kg.
Prompt =================================================
set serveroutput on
declare
  v_codigo number;
	v_mensaje varchar2(1000);
begin 
  insert into paquete(paquete_id, folio_paquete, peso, tipo_paquete_id)
  values (seq_paquete.nextval, 
    dbms_random.value(100000000000000000,999999999999999999), 110, 1);
    
  raise_application_error(-20030,' ERROR: El paquete se ingresó a la tabla.'||
		' El trigger no está funcionando correctamente.');
  
  exception
	  when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK!, prueba 1 Exitosa.');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 2.
Prompt Registro de un paquete 'PER' de más de 50kg.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
begin 
  insert into paquete(paquete_id, folio_paquete, peso, tipo_paquete_id)
  values (seq_paquete.nextval, 
    dbms_random.value(100000000000000000,999999999999999999), 60, 2);
 
  raise_application_error(-20030,' ERROR: El paquete se ingresó a la tabla.'||
		' El trigger no está funcionando correctamente.');
  
  exception
	  when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20002 then
        dbms_output.put_line('OK!, prueba 2 Exitosa.');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 3.
Prompt Registro de un paquete 'PDG' de más de 5kg.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
begin 
  insert into paquete(paquete_id, folio_paquete, peso, tipo_paquete_id)
  values (seq_paquete.nextval, 
    dbms_random.value(100000000000000000,999999999999999999), 6, 3);
 
  raise_application_error(-20030,' ERROR: El paquete se ingresó a la tabla.'||
		' El trigger no está funcionando correctamente.');
  
  exception
	  when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20003 then
        dbms_output.put_line('OK!, prueba 3 Exitosa.');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 4.
Prompt Registro de un paquete 'PDG' con peso menor a 5kg.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_count number;
  v_paquete_id number(10,0);
begin 
  v_paquete_id:=seq_paquete.nextval;
  insert into paquete(paquete_id, folio_paquete, peso, tipo_paquete_id)
  values (v_paquete_id, 
    dbms_random.value(100000000000000000,999999999999999999), 1, 3);

  select count(*) into v_count
  from paquete_auditoria_aduanal
  where paquete_id = v_paquete_id;
 
  if v_count > 0 then
    dbms_output.put_line('OK!, mensaje de auditoria registrado. Prueba 4 exitosa.');
  else
    raise_application_error(-20001,'El registro no se insertó');  
  end if;

  exception
	  when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada.
        El Trigger no está funcionando correctamente.');
      raise;
end;
/
show errors

Prompt =================================================
Prompt Prueba 5.
Prompt Registro de un paquete 'PTD' con peso mayor a 5kg.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_count number;
  v_paquete_id number(10,0);
begin 
  v_paquete_id:=seq_paquete.nextval;
  insert into paquete(paquete_id, folio_paquete, peso, tipo_paquete_id)
  values (v_paquete_id, 
    dbms_random.value(100000000000000000,999999999999999999), 10, 4);
    
  select count(*) into v_count
  from paquete_auditoria_aduanal
  where paquete_id = v_paquete_id;
  
  if (v_count > 0) then
    dbms_output.put_line('OK!, mensaje de auditoria registrado. Prueba 5 exitosa.');
  else
    raise_application_error(-20001,'El registro no se insertó');  
  end if;

  exception
	  when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada.
        El Trigger no está funcionando correctamente.');
    	raise;
end;
/
show errors

Prompt =================================================
Prompt Prueba 6.
Prompt Registro de un paquete 'PTD' con peso mayor a 100kg.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);  
begin 
  insert into paquete(paquete_id, folio_paquete, peso, tipo_paquete_id)
  values (seq_paquete.nextval, 
    dbms_random.value(100000000000000000,999999999999999999), 110, 4);

  raise_application_error(-20030,' ERROR: El paquete se ingresó a la tabla.'||
		' El trigger no está funcionando correctamente.');
  
  exception
	  when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20004 then
    	dbms_output.put_line('OK!, prueba 6 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/
show errors
