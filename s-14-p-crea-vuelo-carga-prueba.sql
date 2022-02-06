--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  03/12/2021
--@Descripción:     Bloque anónimo de prueba para verificar la inserción
--                  de un vuelo de tipo carga.

Prompt =================================================
Prompt Prueba 1.
Prompt Vuelo de carga con el mismo origen y destino
Prompt =================================================
set serveroutput on
declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0); 
begin
  dbms_output.put_line('Programando un vuelo de carga no válido.
    Se espera un error al ser el aeropuerto de origen el destino.');
  p_crea_vuelo_carga(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'03-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'04-01-2022 11:15:00', 
    p_aeropuerto_id         =>8,
    p_aeropuerto_destino_id =>8, 
    p_aeronave_id           =>13,
    p_piloto_id             =>1,
    p_copiloto1_id          =>125,
    p_copiloto2_id          =>124,
    p_ingeniero_id          =>2720,
    p_tecnico1_id           =>2449,
    p_tecnico2_id           =>2450,
    p_tecnico3_id           =>2451,
    p_tecnico4_id           =>2452,
    p_tecnico5_id           =>2453,
    p_tecnico6_id           =>2454,
    p_tecnico7_id           =>2455,
    p_tecnico8_id           =>2456,
    p_tecnico9_id           =>2456,
    p_tecnico10_id          =>2457,
    p_vuelo_id              =>v_vuelo_id
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
END;
/
show errors

Prompt =================================================
Prompt Prueba 2.
Prompt Vuelo de carga con una fecha de llegada inválida.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
begin
  dbms_output.put_line('Programando un vuelo de carga no válido.
    Se espera un error al ser la fecha de llegada menor a la de salida.');
  p_crea_vuelo_carga(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'03-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'02-01-2022 11:15:00', 
    p_aeropuerto_id         =>10,
    p_aeropuerto_destino_id =>8, 
    p_aeronave_id           =>13,
    p_piloto_id             =>1,
    p_copiloto1_id          =>125,
    p_copiloto2_id          =>124,
    p_ingeniero_id          =>2720,
    p_tecnico1_id           =>2449,
    p_tecnico2_id           =>2450,
    p_tecnico3_id           =>2451,
    p_tecnico4_id           =>2452,
    p_tecnico5_id           =>2453,
    p_tecnico6_id           =>2454,
    p_tecnico7_id           =>2455,
    p_tecnico8_id           =>2456,
    p_tecnico9_id           =>2456,
    p_tecnico10_id          =>2457,
    p_vuelo_id              =>v_vuelo_id
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
END;
/
show errors

Prompt =================================================
Prompt Prueba 3.
Prompt Vuelo de carga con una aeronave inválida.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
begin
  dbms_output.put_line('Programando un vuelo de carga no válido.
    Se espera un error al no ser la aeronave de tipo carga.');
  p_crea_vuelo_carga(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'03-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'04-01-2022 11:15:00', 
    p_aeropuerto_id         =>10,
    p_aeropuerto_destino_id =>8, 
    p_aeronave_id           =>7,
    p_piloto_id             =>1,
    p_copiloto1_id          =>125,
    p_copiloto2_id          =>124,
    p_ingeniero_id          =>2720,
    p_tecnico1_id           =>2449,
    p_tecnico2_id           =>2450,
    p_tecnico3_id           =>2451,
    p_tecnico4_id           =>2452,
    p_tecnico5_id           =>2453,
    p_tecnico6_id           =>2454,
    p_tecnico7_id           =>2455,
    p_tecnico8_id           =>2456,
    p_tecnico9_id           =>2456,
    p_tecnico10_id          =>2457,
    p_vuelo_id              =>v_vuelo_id
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
END;
/
show errors

Prompt =================================================
Prompt Prueba 4.
Prompt Vuelo de carga válido con piloto incorrecto.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
  
  cursor cur_tripulacion is 
    select rownum, e.nombre as nombre_empleado, e.ap_pat as apellido_paterno, 
      e.ap_mat as apellido_materno, ve.puntos, r.nombre as nombre_rol, 
      p.nombre as nombre_puesto
    from empleado e, vuelo_empleado ve, vuelo v, rol r, puesto p
    where e.empleado_id=ve.empleado_id
      and ve.vuelo_id=v.vuelo_id
      and ve.rol_id=r.rol_id
      and ve.vuelo_id=v_vuelo_id
      and p.puesto_id=e.puesto_id;
begin
  dbms_output.put_line('Programando un vuelo de carga válido pero .
    con tripulación erronea. Se espera un mensaje de error.');
  p_crea_vuelo_carga(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'03-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'04-01-2022 11:15:00', 
    p_aeropuerto_id         =>15,
    p_aeropuerto_destino_id =>25, 
    p_aeronave_id           =>14,
    p_piloto_id             =>1000,
    p_copiloto1_id          =>125,
    p_copiloto2_id          =>124,
    p_ingeniero_id          =>2720,
    p_tecnico1_id           =>2449,
    p_tecnico2_id           =>2450,
    p_tecnico3_id           =>2451,
    p_tecnico4_id           =>2452,
    p_tecnico5_id           =>2453,
    p_tecnico6_id           =>2454,
    p_tecnico7_id           =>2455,
    p_tecnico8_id           =>2456,
    p_tecnico9_id           =>2456,
    p_tecnico10_id          =>2457,
    p_vuelo_id              =>v_vuelo_id
  );
  
  dbms_output.put_line('OK! Vuelo registrado exitosamente con la 
    siguiente tripulación:');
    
  for r in cur_tripulacion loop
    dbms_output.put_line(r.rownum
      ||' Nombre: '
      ||r.nombre_empleado
      ||' '
      ||r.apellido_paterno
      ||' '
      ||r.apellido_materno
      ||' - Puntos: '
      ||r.puntos
      ||' - Rol: '
      ||r.nombre_rol
      ||' - Puesto: '
      ||r.nombre_puesto
    );
  end loop;
      
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
END;
/
show errors

Prompt =================================================
Prompt Prueba 5.
Prompt Vuelo de carga válido con técnicos incorrectos.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
  
  cursor cur_tripulacion is 
    select rownum, e.nombre as nombre_empleado, e.ap_pat as apellido_paterno, 
      e.ap_mat as apellido_materno, ve.puntos, r.nombre as nombre_rol, 
      p.nombre as nombre_puesto
    from empleado e, vuelo_empleado ve, vuelo v, rol r, puesto p
    where e.empleado_id=ve.empleado_id
      and ve.vuelo_id=v.vuelo_id
      and ve.rol_id=r.rol_id
      and ve.vuelo_id=v_vuelo_id
      and p.puesto_id=e.puesto_id;
begin
  dbms_output.put_line('Programando un vuelo de carga válido pero .
    con tripulación (técnicos) erronea. Se espera un mensaje de error.');
  p_crea_vuelo_carga(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'03-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'04-01-2022 11:15:00', 
    p_aeropuerto_id         =>15,
    p_aeropuerto_destino_id =>25, 
    p_aeronave_id           =>9,
    p_piloto_id             =>1,
    p_copiloto1_id          =>125,
    p_copiloto2_id          =>124,
    p_ingeniero_id          =>2720,
    p_tecnico1_id           =>2449,
    p_tecnico2_id           =>2,
    p_tecnico3_id           =>2451,
    p_tecnico4_id           =>350,
    p_tecnico5_id           =>2453,
    p_tecnico6_id           =>2454,
    p_tecnico7_id           =>25,
    p_tecnico8_id           =>2456,
    p_tecnico9_id           =>2456,
    p_tecnico10_id          =>2457,
    p_vuelo_id              =>v_vuelo_id
  );
  
  dbms_output.put_line('OK! Vuelo registrado exitosamente con la 
    siguiente tripulación:');
    
  for r in cur_tripulacion loop
    dbms_output.put_line(r.rownum
      ||' Nombre: '
      ||r.nombre_empleado
      ||' '
      ||r.apellido_paterno
      ||' '
      ||r.apellido_materno
      ||' - Puntos: '
      ||r.puntos
      ||' - Rol: '
      ||r.nombre_rol
      ||' - Puesto: '
      ||r.nombre_puesto
    );
  end loop;
       
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
END;
/
show errors

Prompt =================================================
Prompt Prueba 6.
Prompt Vuelo de carga válido con ingeniero incorrecto.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
  
  cursor cur_tripulacion is 
    select rownum, e.nombre as nombre_empleado, e.ap_pat as apellido_paterno, 
      e.ap_mat as apellido_materno, ve.puntos, r.nombre as nombre_rol, 
      p.nombre as nombre_puesto
    from empleado e, vuelo_empleado ve, vuelo v, rol r, puesto p
    where e.empleado_id=ve.empleado_id
      and ve.vuelo_id=v.vuelo_id
      and ve.rol_id=r.rol_id
      and ve.vuelo_id=v_vuelo_id
      and p.puesto_id=e.puesto_id;
begin
  dbms_output.put_line('Programando un vuelo de carga válido pero .
    con tripulación (ingeniero) erronea. Se espera un mensaje de error.');
  p_crea_vuelo_carga(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'03-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'04-01-2022 11:15:00', 
    p_aeropuerto_id         =>15,
    p_aeropuerto_destino_id =>25, 
    p_aeronave_id           =>15,
    p_piloto_id             =>1,
    p_copiloto1_id          =>125,
    p_copiloto2_id          =>124,
    p_ingeniero_id          =>5,
    p_tecnico1_id           =>2449,
    p_tecnico2_id           =>2450,
    p_tecnico3_id           =>2451,
    p_tecnico4_id           =>2452,
    p_tecnico5_id           =>2453,
    p_tecnico6_id           =>2454,
    p_tecnico7_id           =>2455,
    p_tecnico8_id           =>2456,
    p_tecnico9_id           =>2456,
    p_tecnico10_id          =>2457,
    p_vuelo_id              =>v_vuelo_id
  );
  
  dbms_output.put_line('OK! Vuelo registrado exitosamente con la 
    siguiente tripulación:');
    
  for r in cur_tripulacion loop
    dbms_output.put_line(r.rownum
      ||' Nombre: '
      ||r.nombre_empleado
      ||' '
      ||r.apellido_paterno
      ||' '
      ||r.apellido_materno
      ||' - Puntos: '
      ||r.puntos
      ||' - Rol: '
      ||r.nombre_rol
      ||' - Puesto: '
      ||r.nombre_puesto
    );
  end loop;
    
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
END;
/
show errors

Prompt =================================================
Prompt Prueba 7.
Prompt Vuelo de carga válido con copiloto erroneo.
Prompt =================================================
declare
  v_codigo number;
	v_mensaje varchar2(1000);
  v_vuelo_id number(10,0);
  
  cursor cur_tripulacion is 
    select rownum, e.nombre as nombre_empleado, e.ap_pat as apellido_paterno, 
      e.ap_mat as apellido_materno, ve.puntos, r.nombre as nombre_rol, 
      p.nombre as nombre_puesto
    from empleado e, vuelo_empleado ve, vuelo v, rol r, puesto p
    where e.empleado_id=ve.empleado_id
      and ve.vuelo_id=v.vuelo_id
      and ve.rol_id=r.rol_id
      and ve.vuelo_id=v_vuelo_id
      and p.puesto_id=e.puesto_id;
begin
  dbms_output.put_line('Programando un vuelo de carga válido pero .
    con tripulación (copiloto) erronea. Se espera un mensaje de error.');
  p_crea_vuelo_carga(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'03-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'04-01-2022 11:15:00', 
    p_aeropuerto_id         =>15,
    p_aeropuerto_destino_id =>25, 
    p_aeronave_id           =>19,
    p_piloto_id             =>1,
    p_copiloto1_id          =>18,
    p_copiloto2_id          =>2900,
    p_ingeniero_id          =>2720,
    p_tecnico1_id           =>2449,
    p_tecnico2_id           =>2450,
    p_tecnico3_id           =>2451,
    p_tecnico4_id           =>2452,
    p_tecnico5_id           =>2453,
    p_tecnico6_id           =>2454,
    p_tecnico7_id           =>2455,
    p_tecnico8_id           =>2456,
    p_tecnico9_id           =>2456,
    p_tecnico10_id          =>2457,
    p_vuelo_id              =>v_vuelo_id
  );
  
  dbms_output.put_line('OK! Vuelo registrado exitosamente con la 
    siguiente tripulación:');
    
  for r in cur_tripulacion loop
    dbms_output.put_line(r.rownum
      ||' Nombre: '
      ||r.nombre_empleado
      ||' '
      ||r.apellido_paterno
      ||' '
      ||r.apellido_materno
      ||' - Puntos: '
      ||r.puntos
      ||' - Rol: '
      ||r.nombre_rol
      ||' - Puesto: '
      ||r.nombre_puesto
    );
  end loop;
    
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
END;
/
show errors

Prompt =================================================
Prompt Prueba 8.
Prompt Vuelo de carga válido y con tripulación correcta.
Prompt =================================================
declare
  v_vuelo_id number(10,0);
  v_codigo number;
	v_mensaje varchar2(1000);
  
  cursor cur_tripulacion is 
    select rownum, e.nombre as nombre_empleado, e.ap_pat as apellido_paterno, 
      e.ap_mat as apellido_materno, ve.puntos, r.nombre as nombre_rol, 
      p.nombre as nombre_puesto
    from empleado e, vuelo_empleado ve, vuelo v, rol r, puesto p
    where e.empleado_id=ve.empleado_id
      and ve.vuelo_id=v.vuelo_id
      and ve.rol_id=r.rol_id
      and ve.vuelo_id=v_vuelo_id
      and p.puesto_id=e.puesto_id;
begin
  dbms_output.put_line('Programando un vuelo de carga válido.
    Se espera un mensaje de confirmación y un commit.');
  p_crea_vuelo_carga(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'03-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'04-01-2022 11:15:00', 
    p_aeropuerto_id         =>15,
    p_aeropuerto_destino_id =>25, 
    p_aeronave_id           =>10,
    p_piloto_id             =>1,
    p_copiloto1_id          =>125,
    p_copiloto2_id          =>124,
    p_ingeniero_id          =>2720,
    p_tecnico1_id           =>2449,
    p_tecnico2_id           =>2450,
    p_tecnico3_id           =>2451,
    p_tecnico4_id           =>2452,
    p_tecnico5_id           =>2453,
    p_tecnico6_id           =>2454,
    p_tecnico7_id           =>2455,
    p_tecnico8_id           =>2456,
    p_tecnico9_id           =>2457,
    p_tecnico10_id          =>2458,
    p_vuelo_id              =>v_vuelo_id
  );
  
  dbms_output.put_line('OK! Vuelo registrado exitosamente con la 
    siguiente tripulación:');
    
  for r in cur_tripulacion loop
    dbms_output.put_line(r.rownum
      ||' Nombre: '
      ||r.nombre_empleado
      ||' '
      ||r.apellido_paterno
      ||' '
      ||r.apellido_materno
      ||' - Puntos: '
      ||r.puntos
      ||' - Rol: '
      ||r.nombre_rol
      ||' - Puesto: '
      ||r.nombre_puesto
    );
  end loop;
  dbms_output.put_line('OK! Prueba 8 exitosa.');
  
  exception
    when others then
      v_codigo := sqlcode;
      v_mensaje := sqlerrm;
      dbms_output.put_line('Codigo:  ' || v_codigo);
      dbms_output.put_line('Mensaje: ' || v_mensaje);
      dbms_output.put_line('ERROR, se obtuvo excepción no esperada.');
      raise;

END;
/
show errors