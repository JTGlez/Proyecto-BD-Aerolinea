--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  04/12/2021
--@Descripción:     Bloque de prueba del procedimiento 
--                  s-13-p-abordar-vuelo-comercial.

Prompt =================================================
Prompt Prueba 1.
Prompt Generando el pase de abordar para un pasajero 'O' 
Prompt del vuelo número 91900.
Prompt =================================================
set serveroutput on
declare 
  v_existe number(1,0);
  v_codigo number;
	v_mensaje varchar2(1000);
  v_folio_pase varchar2(8);
begin
  p_abordar_vuelo_comercial(
    p_curp            =>'CMJKE673CMHMYNCYNA', 
    p_num_vuelo       =>91900,
    p_folio_pase      =>v_folio_pase
  );
  
  select count(*) into v_existe
  from pase_abordar pa, vuelo_pasajero vp, pasajero p, vuelo v
  where p.pasajero_id=vp.pasajero_id
    and vp.pase_abordar_id=pa.pase_abordar_id
    and vp.vuelo_id=v.vuelo_id
    and p.curp='CMJKE673CMHMYNCYNA'
    and v.num_vuelo=91900;
  
 
  if v_existe > 0 then
    dbms_output.put_line('OK!, registro del pase encontrado. Prueba 1 exitosa');
  else
    raise_application_error(-20001,'El registro no se insertó');  
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
Prompt Generando el pase de abordar para un pasajero 'V' 
Prompt del vuelo número 91900.
Prompt =================================================
set serveroutput on
declare 
  v_existe number(1,0);
  v_codigo number;
	v_mensaje varchar2(1000);
  v_folio_pase varchar2(8);
begin
  p_abordar_vuelo_comercial(
    p_curp            =>'TS2XWBFZCAJV2AN6OH', 
    p_num_vuelo       =>91900,
    p_folio_pase      =>v_folio_pase
  );

  select count(*) into v_existe
  from pase_abordar pa, vuelo_pasajero vp, pasajero p, vuelo v
  where p.pasajero_id=vp.pasajero_id
    and vp.pase_abordar_id=pa.pase_abordar_id
    and vp.vuelo_id=v.vuelo_id
    and p.curp='TS2XWBFZCAJV2AN6OH'
    and v.num_vuelo=91900;
  
  if v_existe > 0 then
    dbms_output.put_line('OK!, registro del pase encontrado. Prueba 2 exitosa');
  else
    raise_application_error(-20001,'El registro no se insertó');  
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
Prompt Generando el pase de abordar para un pasajero 'D' 
Prompt del vuelo número 91900.
Prompt =================================================
set serveroutput on
declare 
  v_existe number(1,0);
  v_codigo number;
	v_mensaje varchar2(1000);
  v_folio_pase varchar2(8);
begin
  p_abordar_vuelo_comercial(
    p_curp            =>'ZJKEXBOTD3GTIJUV2F', 
    p_num_vuelo       =>91900,
    p_folio_pase      =>v_folio_pase
  );
  
  select count(*) into v_existe
  from pase_abordar pa, vuelo_pasajero vp, pasajero p, vuelo v
  where p.pasajero_id=vp.pasajero_id
    and vp.pase_abordar_id=pa.pase_abordar_id
    and vp.vuelo_id=v.vuelo_id
    and p.curp='ZJKEXBOTD3GTIJUV2F'
    and v.num_vuelo=91900;
  
  if v_existe > 0 then
    dbms_output.put_line('OK!, registro del pase encontrado. Prueba 3 exitosa');
    --commit;
    --rollback;
  else
  --Si no se encuentra, lanza un error.
    raise_application_error(-20001,'El registro no se insertó');  
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
Prompt Prueba 4.
Prompt Error al generar el pase de abordar para un pasajero 
Prompt del vuelo número 91900 al no existir su registro
Prompt en el vuelo.
Prompt =================================================
set serveroutput on
declare 
  v_existe number(1,0);
  v_codigo number;
	v_mensaje varchar2(1000);
  v_folio_pase varchar2(8);

begin
  p_abordar_vuelo_comercial(
    p_curp            =>'R79VJ3RF3BTZLP081A', 
    p_num_vuelo       =>91900,
    p_folio_pase      =>v_folio_pase
  );

  select count(*) into v_existe
  from pase_abordar pa, vuelo_pasajero vp, pasajero p, vuelo v
  where p.pasajero_id=vp.pasajero_id
    and vp.pase_abordar_id=pa.pase_abordar_id
    and vp.vuelo_id=v.vuelo_id
    and p.curp='ZJKEXBOTD3GTIJUV2F'
    and v.num_vuelo=91900;
  
  if v_existe > 0 then
    dbms_output.put_line('ERROR! El pasajero no está registrado en el vuelo.');
  else
    raise_application_error(-20001,'ERROR! El registro no debe insertarse.');  
  end if;

  exception
	  when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20002 then
        dbms_output.put_line('OK! Prueba 4 exitosa. ');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 5.
Prompt Error al generar el pase de abordar para un pasajero 
Prompt del vuelo 10001 que está en estado PROGRAMADO
Prompt =================================================
set serveroutput on
declare 
  v_existe number(1,0);
  v_codigo number;
	v_mensaje varchar2(1000);
  v_folio_pase varchar2(8);
begin
  p_abordar_vuelo_comercial(
    p_curp            =>'15T7FSXZE0BO00IOP8', 
    p_num_vuelo       =>10001,
    p_folio_pase      =>v_folio_pase
  );

  select count(*) into v_existe
  from pase_abordar pa, vuelo_pasajero vp, pasajero p, vuelo v
  where p.pasajero_id=vp.pasajero_id
    and vp.pase_abordar_id=pa.pase_abordar_id
    and vp.vuelo_id=v.vuelo_id
    and p.curp='ZJKEXBOTD3GTIJUV2F'
    and v.num_vuelo=91900;
  
  if v_existe > 0 then
    dbms_output.put_line('ERROR! El pasajero no está registrado en el vuelo.');
  else
    raise_application_error(-20001,'ERROR! El registro no debe insertarse.');  
  end if;

  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20003 then
        dbms_output.put_line('OK! Prueba 5 exitosa. ');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 6.
Prompt Generando el pase de abordar para un pasajero 'O' 
Prompt del vuelo número 90700 (De forma repetida).
Prompt =================================================
set serveroutput on
declare 
  v_existe number(1,0);
  v_codigo number;
	v_mensaje varchar2(1000);
  v_folio_pase varchar2(8);
begin 
  p_abordar_vuelo_comercial(
    p_curp            =>'CMJKE673CMHMYNCYNA', 
    p_num_vuelo       =>90700,
    p_folio_pase      =>v_folio_pase
  );
  
  select count(*) into v_existe
  from pase_abordar pa, vuelo_pasajero vp, pasajero p, vuelo v
  where p.pasajero_id=vp.pasajero_id
    and vp.pase_abordar_id=pa.pase_abordar_id
    and vp.vuelo_id=v.vuelo_id
    and p.curp='CMJKE673CMHMYNCYNA'
    and v.num_vuelo=90700;
  
  if v_existe > 0 then
    dbms_output.put_line('Error! No se puede registrar 2 veces un pase para un
      mismo vuelo por parte del propio pasajero.');
  end if;

  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20009 then
        dbms_output.put_line('OK! Prueba 6 exitosa. ');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors