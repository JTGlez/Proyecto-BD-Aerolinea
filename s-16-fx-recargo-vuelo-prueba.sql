--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  07/01/2022
--@Descripción:     Bloque de prueba para la función s-15-fx-recargo-vuelo.

set serveroutput on
Prompt =================================================
Prompt Prueba 1.
Prompt Cálculo del recargo para un pasajero 'O'.
Prompt =================================================
declare
  v_recargo_vuelo number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin 
  insert into pase_abordar(pase_abordar_id, folio_pase, fecha_impresion)
  values (990, dbms_random.string('U',8), SYSDATE);
  
  update vuelo_pasajero set pase_abordar_id=990 where pasajero_id=2998;

  insert into maleta(num_maleta, pase_abordar_id, peso)
  values (1, 990, 2);
  
  insert into maleta(num_maleta, pase_abordar_id, peso)
  values (2, 990, 1);
  
  insert into maleta(num_maleta, pase_abordar_id, peso)
  values (3, 990, 3);
    
  if (recargo_vuelo(990, 'O')=1875) then
    dbms_output.put_line('OK! Prueba 1 exitosa');
  else
    dbms_output.put_line('ERROR! Resultado incorrecto. Se esperaba 1875
      y se obtuvo: ' || recargo_vuelo(990, 'O'));
  end if;
  
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
      raise; 
  
end;
/
show errors

Prompt =================================================
Prompt Prueba 2.
Prompt Cálculo del recargo para un pasajero 'V'.
Prompt =================================================
declare
  v_recargo_vuelo number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin 
  insert into pase_abordar(pase_abordar_id, folio_pase, fecha_impresion)
  values (991, dbms_random.string('U',8), SYSDATE);
  
  update vuelo_pasajero set pase_abordar_id=991 where pasajero_id=2999;

  insert into maleta(num_maleta, pase_abordar_id, peso)
  values (1, 991, 2);
  
  insert into maleta(num_maleta, pase_abordar_id, peso)
  values (2, 991, 1);
  
  insert into maleta(num_maleta, pase_abordar_id, peso)
  values (3, 991, 3);
  
  if (recargo_vuelo(991, 'V')=1650) then
    dbms_output.put_line('OK! Prueba 2 exitosa');
  else
    dbms_output.put_line('ERROR! Resultado incorrecto. Se esperaba 1650
      y se obtuvo: ' || recargo_vuelo(991, 'V'));
  end if;
  
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
      raise; 
end;
/
show errors

Prompt =================================================
Prompt Prueba 3.
Prompt Cálculo del recargo para un pasajero 'D'.
Prompt =================================================
declare
  v_recargo_vuelo number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin 

  insert into pase_abordar(pase_abordar_id, folio_pase, fecha_impresion)
  values (992, dbms_random.string('U',8), SYSDATE);
  
  update vuelo_pasajero set pase_abordar_id=992 where pasajero_id=3000;

  insert into maleta(num_maleta, pase_abordar_id, peso)
  values (1, 992, 2);
  
  insert into maleta(num_maleta, pase_abordar_id, peso)
  values (2, 992, 1);
  
  insert into maleta(num_maleta, pase_abordar_id, peso)
  values (3, 992, 3);

  if (recargo_vuelo(992, 'D')=1200) then
    dbms_output.put_line('OK! Prueba 3 exitosa');
  else
    dbms_output.put_line('ERROR! Resultado incorrecto. Se esperaba 1200
      y se obtuvo: ' || recargo_vuelo(992, 'V'));
  end if;
  
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
      raise; 
end;
/
show errors
