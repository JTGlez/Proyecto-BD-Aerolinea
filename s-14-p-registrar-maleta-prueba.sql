--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  04/12/2021
--@Descripción:     Bloque de prueba del procedimiento 
--                  s-13-p-registrar-maleta.

Prompt =================================================
Prompt Prueba 1.
Prompt Generando 1 maleta para un pasajero registrado
Prompt en el vuelo 90700.
Prompt =================================================
set serveroutput on
declare 
  v_existe number(1,0);
  v_codigo number;
	v_mensaje varchar2(1000);
  v_num_vuelo number(5,0);
  v_folio_pase varchar2(8);
  v_vuelo_id number(10,0);
begin
  v_num_vuelo:=90700;
  p_registrar_vuelo_pasajero(
      p_curp           =>'5TMLEBM3VNU4IZLDK5', 
      p_num_vuelo      =>v_num_vuelo,
      p_tipo_pasajero  =>'O', 
      p_asiento        =>178,
      p_atenciones_esp =>'A',
      p_vuelo_id       =>v_vuelo_id
    );
    
  p_abordar_vuelo_comercial(
    p_curp            =>'5TMLEBM3VNU4IZLDK5', 
    p_num_vuelo       =>v_num_vuelo,
    p_folio_pase      =>v_folio_pase
    );  
  
  p_registrar_maleta(
    p_folio_pase =>v_folio_pase, 
    p_peso       =>2
  );
  
  select count(*) into v_existe
  from pase_abordar pa, vuelo_pasajero vp, maleta m
  where vp.pase_abordar_id=pa.pase_abordar_id
    and m.pase_abordar_id=m.pase_abordar_id
    and num_maleta=1
    and pa.folio_pase=v_folio_pase
    and peso=2;
 
  if v_existe > 0 then
    dbms_output.put_line('OK!, registro de la maleta encontrado. Prueba 1 exitosa');
    rollback;
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
      El Procedimiento no está funcionando correctamente.');
    raise;
end;
/
show errors

Prompt =================================================
Prompt Prueba 2.
Prompt Generando 1 maleta pero con folio inexistente.
Prompt =================================================
set serveroutput on
declare 
  v_existe number(1,0);
  v_codigo number;
	v_mensaje varchar2(1000);
  v_num_vuelo number(5,0);
  v_folio_pase varchar2(8);
  v_vuelo_id number(10,0);
begin
  p_registrar_maleta(
    p_folio_pase =>'NAH29AN2', 
    p_peso       =>1
  );
  
  select count(*) into v_existe
  from pase_abordar pa, vuelo_pasajero vp, maleta m
  where vp.pase_abordar_id=pa.pase_abordar_id
    and m.pase_abordar_id=m.pase_abordar_id
    and num_maleta=1
    and pa.folio_pase=v_folio_pase
    and peso=2;
 
  if v_existe > 0 then
    dbms_output.put_line('ERROR! La maleta no puede existir.');
    rollback;
  end if;

  exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20020 then
    	dbms_output.put_line('OK! Prueba 2 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 3.
Prompt Generando 1 maleta con folio existente pero sin
Prompt pasajero asociado.
Prompt =================================================
set serveroutput on
declare 
  v_existe number(1,0);
  v_codigo number;
	v_mensaje varchar2(1000);
  v_num_vuelo number(5,0);
  v_folio_pase varchar2(8);
  v_pase_abordar_id number(10,0);
  v_vuelo_id number(10,0);
begin
  v_pase_abordar_id:=seq_pase_abordar.nextval;
  v_folio_pase:=dbms_random.string('U', 8);
  
  insert into pase_abordar(pase_abordar_id, folio_pase, fecha_impresion)
  values (v_pase_abordar_id, v_folio_pase, sysdate);
    
  p_registrar_maleta(
    p_folio_pase =>v_folio_pase, 
    p_peso       =>1
  );
  
  select count(*) into v_existe
  from pase_abordar pa, vuelo_pasajero vp, maleta m
  where vp.pase_abordar_id=pa.pase_abordar_id
    and m.pase_abordar_id=m.pase_abordar_id
    and num_maleta=1
    and pa.pase_abordar_id=v_pase_abordar_id
    and peso=1;
  
  if v_existe > 0 then
    dbms_output.put_line('ERROR! La maleta no puede existir. El pase no está
      asociado a ningún pasajero de un vuelo.');
    rollback;
  end if;

  exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20020 then
    	dbms_output.put_line('OK! Prueba 3 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/
show errors