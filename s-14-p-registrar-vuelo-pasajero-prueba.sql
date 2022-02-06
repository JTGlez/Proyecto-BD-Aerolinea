--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  04/12/2021
--@Descripción:     Procedimiento para validar el registro de 
--                  pasajeros en un vuelo.

set serveroutput on
Prompt =================================================
Prompt Prueba 1.
Prompt Registro en un avión sin cupo en la categoría 'O'
Prompt =================================================
declare 
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'AROL8H1PJ0RC1MSX55', 
    p_num_vuelo      =>10000,
    p_tipo_pasajero  =>'O', 
    p_asiento        =>15,
    p_atenciones_esp =>'A',
    p_vuelo_id       =>v_vuelo_id
  );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 1 exitosa. ');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 2.
Prompt Registro en un avión sin cupo en la categoría 'V'
Prompt =================================================
declare 
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'AROL8H1PJ0RC1MSX55', 
    p_num_vuelo      =>10000,
    p_tipo_pasajero  =>'V', 
    p_asiento        =>153,
    p_atenciones_esp =>'A',
    p_vuelo_id       =>v_vuelo_id
  );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 2 exitosa. ');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 3.
Prompt Registro en un avión sin cupo en la categoría 'D'
Prompt =================================================
declare 
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'AROL8H1PJ0RC1MSX55', 
    p_num_vuelo      =>10000,
    p_tipo_pasajero  =>'D', 
    p_asiento        =>170,
    p_atenciones_esp =>'D',
    p_vuelo_id       =>v_vuelo_id
  );
  
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 3 exitosa. ');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 4.
Prompt Registro en un avión en la categoría 'O' con atenciones 'D'
Prompt =================================================
declare 
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'AROL8H1PJ0RC1MSX55', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'O', 
    p_asiento        =>30,
    p_atenciones_esp =>'D',
    p_vuelo_id       =>v_vuelo_id
  );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
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
Prompt Registro en un avión en la categoría 'O' con atenciones 'F'
Prompt =================================================
declare 
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'AROL8H1PJ0RC1MSX55', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'O', 
    p_asiento        =>31,
    p_atenciones_esp =>'F',
    p_vuelo_id       =>v_vuelo_id
  );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
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
Prompt Registro en un avión en categoría 'D' con atenciones 'A'
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'AROL8H1PJ0RC1MSX55', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'D', 
    p_asiento        =>253,
    p_atenciones_esp =>'A',
    p_vuelo_id       =>v_vuelo_id
  );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 6 exitosa. ');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 7.
Prompt Registro en un avión en categoría 'D' con atenciones 'B'
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'AROL8H1PJ0RC1MSX55', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'D', 
    p_asiento        =>252,
    p_atenciones_esp =>'B',
    p_vuelo_id       =>v_vuelo_id
  );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 7 exitosa. ');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 8.
Prompt Registro en un avión en categoría 'D' con atenciones 'C'
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'AROL8H1PJ0RC1MSX55', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'D', 
    p_asiento        =>251,
    p_atenciones_esp =>'C',
    p_vuelo_id       =>v_vuelo_id
  );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 8 exitosa. ');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 9.
Prompt Registro en un avión en categoría 'D' con atenciones 'E'
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'AROL8H1PJ0RC1MSX55', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'D', 
    p_asiento        =>255,
    p_atenciones_esp =>'E',
    p_vuelo_id       =>v_vuelo_id
  );

  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 9 exitosa. ');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 10.
Prompt Registro en un vuelo inexistente.
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'AROL8H1PJ0RC1MSX55', 
    p_num_vuelo      =>99999,
    p_tipo_pasajero  =>'O', 
    p_asiento        =>15,
    p_atenciones_esp =>'A',
    p_vuelo_id       =>v_vuelo_id
  );

  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 10 exitosa.');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 11.
Prompt Registro en un vuelo con CURP inválida
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'NFPOMS835QIHMGPGY8', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'O', 
    p_asiento        =>15,
    p_atenciones_esp =>'A',
    p_vuelo_id       =>v_vuelo_id
  );
  
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = 100 then
        dbms_output.put_line('OK! Prueba 11 exitosa.');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 12.
Prompt Registro en un vuelo con asiento ya ocupado 'O'
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin  
  p_registrar_vuelo_pasajero(
    p_curp           =>'NFPOM9GDFQIHMGPGY8', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'O', 
    p_asiento        =>1,
    p_atenciones_esp =>'A',
    p_vuelo_id       =>v_vuelo_id
  );

  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 12 exitosa.');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;  
end;
/
show errors

Prompt =================================================
Prompt Prueba 13.
Prompt Registro en un vuelo con asiento ya ocupado 'V'
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'NFPOM9GDFQIHMGPGY8', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'V', 
    p_asiento        =>211,
    p_atenciones_esp =>'A',
    p_vuelo_id       =>v_vuelo_id
  );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 13 exitosa');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 14.
Prompt Registro en un vuelo con asiento ya ocupado 'D'
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'NFPOM9GDFQIHMGPGY8', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'D', 
    p_asiento        =>245,
    p_atenciones_esp =>'F',
    p_vuelo_id       =>v_vuelo_id
  );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 14 exitosa.');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 15.
Prompt Registro en un vuelo con asiento en el rango equivocado 'O'
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin 
    p_registrar_vuelo_pasajero(
      p_curp           =>'NFPOM9GDFQIHMGPGY8', 
      p_num_vuelo      =>10001,
      p_tipo_pasajero  =>'O', 
      p_asiento        =>212,
      p_atenciones_esp =>'A',
      p_vuelo_id       =>v_vuelo_id
    );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 15 exitosa.');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 16.
Prompt Registro en un vuelo con asiento en el rango equivocado 'V'
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'NFPOM9GDFQIHMGPGY8', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'V', 
    p_asiento        =>7,
    p_atenciones_esp =>'A',
    p_vuelo_id       =>v_vuelo_id
  );
    
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 16 exitosa.');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
    

end;
/
show errors

Prompt =================================================
Prompt Prueba 17.
Prompt Registro en un vuelo con asiento en el rango equivocado 'D'
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin
  p_registrar_vuelo_pasajero(
    p_curp           =>'NFPOM9GDFQIHMGPGY8', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'D', 
    p_asiento        =>2,
    p_atenciones_esp =>'D',
    p_vuelo_id       =>v_vuelo_id
  );

  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      if v_codigo = -20001 then
        dbms_output.put_line('OK! Prueba 17 exitosa.');
      else
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
        raise;
      end if;
end;
/
show errors

Prompt =================================================
Prompt Prueba 18.
Prompt Registro en un vuelo con datos correctos.
Prompt =================================================
declare 
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
begin  
  p_registrar_vuelo_pasajero(
    p_curp           =>'102KICPLRXN9R1QLJU', 
    p_num_vuelo      =>10001,
    p_tipo_pasajero  =>'O', 
    p_asiento        =>16,
    p_atenciones_esp =>'A',
    p_vuelo_id       =>v_vuelo_id
  );
  
  dbms_output.put_line('OK! Registros realizado correctamente.
    Prueba 18 exitosa');

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