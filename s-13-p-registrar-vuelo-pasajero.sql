--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  03/12/2021
--@Descripción:     Procedimiento para registrar pasajero en un vuelo.

conn tg_proy_admin/system
set serveroutput on

create or replace procedure p_registrar_vuelo_pasajero(
  p_curp in varchar2, p_num_vuelo in numeric, p_tipo_pasajero in char,
  p_asiento in numeric, p_atenciones_esp in char, p_vuelo_id out numeric
)is
  v_vuelo_pasajero_id number(10,0);
  v_asiento number(3,0);
  v_atenciones_esp varchar2 (2000);
  v_vuelo_id number(10,0);
  v_pasajero_id number(10,0);
  v_asiento_ocupado number(1,0);
  v_vuelo_existe number(1,0);
  v_max_ord number(3,0);
  v_max_vip number(3,0);
  v_max_dis number(3,0);
  v_aeronave_id number(10,0);

  cursor cur_vuelos_ord is
    select v.vuelo_id, v.num_vuelo, a.modelo, ac.capacidad_ordinarios, (
      select count(*)
      from vuelo_pasajero vp, vuelo v
      where vp.vuelo_id=v.vuelo_id
        and vp.tipo_pasajero='O'
        and v.num_vuelo=p_num_vuelo
  ) cupo_avion
    from vuelo v
    join aeronave a
      on a.aeronave_id=v.aeronave_id
    join aeronave_comercial ac
      on ac.aeronave_id=a.aeronave_id
    where (
      select count(*)
      from vuelo_pasajero vp, vuelo v
        where vp.vuelo_id=v.vuelo_id
        and vp.tipo_pasajero='O'
        and v.num_vuelo=p_num_vuelo) < ac.capacidad_ordinarios
      and v.num_vuelo=p_num_vuelo; 
    
  cursor cur_vuelos_vip is
    select v.vuelo_id, v.num_vuelo, a.modelo, ac.capacidad_vip, (
      select count(*)
        from vuelo_pasajero vp, vuelo v
      where vp.vuelo_id=v.vuelo_id
        and vp.tipo_pasajero='V'
        and v.num_vuelo=p_num_vuelo
    ) cupo_avion
    from vuelo v
    join aeronave a
      on a.aeronave_id=v.aeronave_id
    join aeronave_comercial ac
      on ac.aeronave_id=a.aeronave_id
    where (
      select count(*)
      from vuelo_pasajero vp, vuelo v
      where vp.vuelo_id=v.vuelo_id
        and vp.tipo_pasajero='V'
        and v.num_vuelo=p_num_vuelo) < ac.capacidad_vip
      and v.num_vuelo=p_num_vuelo; 
    
  cursor cur_vuelos_dis is
    select v.vuelo_id, v.num_vuelo, a.modelo, ac.capacidad_discapacitados, (
      select count(*)
      from vuelo_pasajero vp, vuelo v
      where vp.vuelo_id=v.vuelo_id
        and vp.tipo_pasajero='D'
        and v.num_vuelo=p_num_vuelo
    ) cupo_avion
    from vuelo v
    join aeronave a
      on a.aeronave_id=v.aeronave_id
    join aeronave_comercial ac
      on ac.aeronave_id=a.aeronave_id
    where (
      select count(*)
      from vuelo_pasajero vp, vuelo v
        where vp.vuelo_id=v.vuelo_id
          and vp.tipo_pasajero='D'
          and v.num_vuelo=p_num_vuelo) < ac.capacidad_discapacitados
      and v.num_vuelo=p_num_vuelo; 
BEGIN
  case
    when p_tipo_pasajero='O' then
      --Se valida que el vuelo introducido exista en primer lugar
      select count(*) into v_vuelo_existe
      from vuelo 
      where num_vuelo=p_num_vuelo;
        
      if (v_vuelo_existe=0) then
        raise_application_error(-20001,'ERROR: El vuelo ingresado
          no existe en el sistema.');
      end if;
        
      --Se revisa con un cursor el cupo de asientos ordinarios 
      for p in cur_vuelos_ord loop
        dbms_output.put_line('Vuelo_ID: ' 
          || p.vuelo_id 
          || ', num_vuelo: ' 
          || p.num_vuelo 
          || ', aeronave: ' 
          || p.modelo 
          || ', capacidad_ordinarios: ' 
          || p.capacidad_ordinarios
          || ', cupo_actual: ' 
          || p.cupo_avion
        );
        
        --Se verifica que el vuelo haya aparecido disponible en el cursor.
        if p.num_vuelo=p_num_vuelo then
          p_vuelo_id := p.vuelo_id;
        end if; 
      end loop;
        
      if p_vuelo_id is null then
        raise_application_error(-20001,'ERROR: No hay cupo en el avión
          para el tipo de clase seleccionada.');
      end if;
        
      --Se valida que el asiento no esté todavía ocupado.
      select count(*) into v_asiento_ocupado
      from vuelo_pasajero
      where asiento=p_asiento
      and vuelo_id=p_vuelo_id;
        
      if(v_asiento_ocupado!=0) then
        raise_application_error(-20001,'ERROR: El asiento
          seleccionado ya se encuentra ocupado.');
      end if;
        
      --Se valida que el asiento ingresado esté dentro del rango adecuado según
      --su clase.
      v_vuelo_id:=p_vuelo_id;
        
      select v.aeronave_id into v_aeronave_id
      from vuelo v
      where v.vuelo_id=v_vuelo_id;
        
      select ac.capacidad_ordinarios, (ac.capacidad_ordinarios + ac.capacidad_vip),
        (ac.capacidad_ordinarios + ac.capacidad_vip + ac.capacidad_discapacitados) 
      into v_max_ord, v_max_vip, v_max_dis
      from aeronave a
      join aeronave_comercial ac
        on a.aeronave_id=ac.aeronave_id
      where a.aeronave_id=v_aeronave_id;
    
      v_asiento:=p_asiento;
        
      if (v_asiento<1 or v_asiento>v_max_ord) then
        raise_application_error(-20001,'ERROR: El asiento
          seleccionado no pertenece a la categoría Ordinario.');
      end if;
    
      if (p_atenciones_esp='A') then
        v_atenciones_esp:='No requiere atención especial';
      elsif (p_atenciones_esp='B') then
        v_atenciones_esp:='Padece de afecciones respiratorias: 
          vigilar su estado y tener a la mano respiradores/broncodilatadores';
      elsif (p_atenciones_esp='C') then
        v_atenciones_esp:='Sufre de una afección cardiaca: requiere supervisión 
          contínua y tener preparado equipamiento RCP adecuado en 
          caso de emergencia';
      elsif (p_atenciones_esp='D') then
        raise_application_error(-20001,'ATENCION: Se requiere que el registro
          sea de categoría D (Discapacitados).');
      elsif (p_atenciones_esp='E') then
        v_atenciones_esp:='Pasajera embarazada: mantener en constante vigilancia 
          de su estado y sus signos vitales.';
      elsif (p_atenciones_esp='F') then
        raise_application_error(-20001,'ATENCION: Se requiere que el registro
          sea de categoría D (Discapacitados).');
      end if;
        
      v_vuelo_pasajero_id:=seq_vuelo_pasajero.nextval;
        
      select p.pasajero_id into v_pasajero_id
      from pasajero p
      where p.curp=p_curp;
        
      insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, 
        tipo_pasajero, vuelo_id, pasajero_id)
      values (v_vuelo_pasajero_id, v_asiento, v_atenciones_esp, 'O', 
        v_vuelo_id , v_pasajero_id);
    
    when p_tipo_pasajero='V' then  
      --Se valida que el vuelo introducido exista en primer lugar  
      select count(*) into v_vuelo_existe
      from vuelo 
      where num_vuelo=p_num_vuelo;
        
      if (v_vuelo_existe=0) then
        raise_application_error(-20001,'ERROR: El vuelo ingresado
          no existe en el sistema.');
      end if;
      
      --Se revisa con un cursor el cupo de asientos vip 
      for p in cur_vuelos_vip loop
        dbms_output.put_line('Vuelo_ID: ' 
          || p.vuelo_id 
          || ', num_vuelo: ' 
          || p.num_vuelo 
          || ', aeronave: ' 
          || p.modelo 
          || ', capacidad_vip: ' 
          || p.capacidad_vip
          || ', cupo_actual: ' 
          || p.cupo_avion
        );
        
        --Se verifica que el vuelo haya aparecido disponible en el cursor.
        if p.num_vuelo=p_num_vuelo then
          p_vuelo_id := p.vuelo_id;
        end if; 
      end loop;
        
      if p_vuelo_id is null then
        raise_application_error(-20001,'ERROR: No hay cupo en el avión
          para el tipo de clase seleccionada.');
      end if;
        
      --Se valida que el asiento no esté todavía ocupado.
      select count(*) into v_asiento_ocupado
      from vuelo_pasajero
      where asiento=p_asiento
      and vuelo_id=p_vuelo_id;
        
      if(v_asiento_ocupado!=0) then
        raise_application_error(-20001,'ERROR: El asiento
          seleccionado ya se encuentra ocupado.');
      end if;
        
      --Se valida que el asiento ingresado esté dentro del rango adecuado según
      --su clase.
      v_vuelo_id:=p_vuelo_id;
        
      select v.aeronave_id into v_aeronave_id
      from vuelo v
      where v.vuelo_id=v_vuelo_id;
        
      select ac.capacidad_ordinarios, (ac.capacidad_ordinarios + ac.capacidad_vip),
        (ac.capacidad_ordinarios + ac.capacidad_vip + ac.capacidad_discapacitados) 
      into v_max_ord, v_max_vip, v_max_dis
      from aeronave a
      join aeronave_comercial ac
        on a.aeronave_id=ac.aeronave_id
      where a.aeronave_id=v_aeronave_id;
    
      v_asiento:=p_asiento;
        
      if (v_asiento<=v_max_ord or v_asiento>v_max_vip) then
        raise_application_error(-20001,'ERROR: El asiento
          seleccionado no pertenece a la categoría VIP.');
      end if; 
    
      if (p_atenciones_esp='A') then
        v_atenciones_esp:='No requiere atención especial';
      elsif (p_atenciones_esp='B') then
        v_atenciones_esp:='Padece de afecciones respiratorias: vigilar su estado 
          y tener a la mano respiradores/broncodilatadores';
      elsif (p_atenciones_esp='C') then
        v_atenciones_esp:='Sufre de una afección cardiaca: requiere supervisión 
          contínua y tener preparado equipamiento RCP adecuado en caso 
          de emergencia';
      elsif (p_atenciones_esp='D') then
        raise_application_error(-20001,'ATENCION: Se requiere que el registro
          sea de categoría D (Discapacitados).');
      elsif (p_atenciones_esp='E') then
        v_atenciones_esp:='Pasajera embarazada: mantener en constante vigilancia 
          de su estado y sus signos vitales.';
      elsif (p_atenciones_esp='F') then
        raise_application_error(-20001,'ATENCION: Se requiere que el registro
          sea de categoría D (Discapacitados).');
      end if;
        
      v_vuelo_pasajero_id:=seq_vuelo_pasajero.nextval;
        
      select p.pasajero_id into v_pasajero_id
      from pasajero p
      where p.curp=p_curp;
        
      insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, 
        tipo_pasajero, vuelo_id, pasajero_id)
      values (v_vuelo_pasajero_id, v_asiento, v_atenciones_esp, 'V', 
        v_vuelo_id , v_pasajero_id);
        
    when p_tipo_pasajero='D' then
      --Se valida que el vuelo introducido exista en primer lugar
      select count(*) into v_vuelo_existe
      from vuelo 
      where num_vuelo=p_num_vuelo;
        
      if (v_vuelo_existe=0) then
        raise_application_error(-20001,'ERROR: El vuelo ingresado
          no existe en el sistema.');
      end if;
      
      --Se revisa con un cursor el cupo de asientos para discapacitados 
      for p in cur_vuelos_dis loop
        dbms_output.put_line('Vuelo_ID: ' 
          || p.vuelo_id 
          || ', num_vuelo: ' 
          || p.num_vuelo 
          || ', aeronave: ' 
          || p.modelo 
          || ', capacidad_discapacitados: ' 
          || p.capacidad_discapacitados
          || ', cupo_actual: ' 
          || p.cupo_avion
        );
        
        --Se verifica que el vuelo haya aparecido disponible en el cursor.
        if p.num_vuelo=p_num_vuelo then
          p_vuelo_id := p.vuelo_id;
        end if; 
      end loop;
    
      if p_vuelo_id is null then
        raise_application_error(-20001,'ERROR: No hay cupo en el avión
          para el tipo de clase seleccionada.');
      end if;
        
      --Se valida que el asiento no esté todavía ocupado.
      select count(*) into v_asiento_ocupado
      from vuelo_pasajero
      where asiento=p_asiento
      and vuelo_id=p_vuelo_id;
        
      if(v_asiento_ocupado!=0) then
        raise_application_error(-20001,'ERROR: El asiento
          seleccionado ya se encuentra ocupado.');
      end if;
        
      --Se valida que el asiento ingresado esté dentro del rango adecuado 
      --según su clase.
      v_vuelo_id:=p_vuelo_id;
        
      select v.aeronave_id into v_aeronave_id
      from vuelo v
      where v.vuelo_id=v_vuelo_id;
        
      select ac.capacidad_ordinarios, (ac.capacidad_ordinarios + ac.capacidad_vip),
        (ac.capacidad_ordinarios + ac.capacidad_vip + ac.capacidad_discapacitados) 
      into v_max_ord, v_max_vip, v_max_dis
      from aeronave a
      join aeronave_comercial ac
        on a.aeronave_id=ac.aeronave_id
      where a.aeronave_id=v_aeronave_id;
    
      v_asiento:=p_asiento;
        
      if (v_asiento<=v_max_vip or v_asiento>v_max_dis) then
        raise_application_error(-20001,'ERROR: El asiento
          seleccionado no pertenece a la categoría discapacitados.');
      end if;
        
      if (p_atenciones_esp='A') then
        raise_application_error(-20001,'ATENCION: Se requiere que el registro
          sea en la categoría Ordinaria o VIP.');
      elsif (p_atenciones_esp='B') then
        raise_application_error(-20001,'ATENCION: Se requiere que el registro
          sea en la categoría Ordinaria o VIP.');
      elsif (p_atenciones_esp='C') then
        raise_application_error(-20001,'ATENCION: Se requiere que el registro
          sea en la categoría Ordinaria o VIP.');
      elsif (p_atenciones_esp='D') then
        v_atenciones_esp:='Pasajero con discapacidad mental: mantenerse 
          pendiente de su condición y calmarlo con las medidas adecuadas 
          y manteniendo respeto al mismo.';
      elsif (p_atenciones_esp='E') then
        raise_application_error(-20001,'ATENCION: Se requiere que el registro
          sea en la categoría Ordinaria o VIP.');
      elsif (p_atenciones_esp='F') then
        v_atenciones_esp:='Pasajero con discapacidad física: tener personal 
          capacitado disponible para auxiliar en su movilidad al abordar el 
          avión, dentro del mismo, y durante el aterrizaje.';
      end if;
        
      v_vuelo_pasajero_id:=seq_vuelo_pasajero.nextval;
        
      select p.pasajero_id into v_pasajero_id
      from pasajero p
      where p.curp=p_curp;
        
      insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, 
        tipo_pasajero, vuelo_id, pasajero_id)
      values (v_vuelo_pasajero_id, v_asiento, v_atenciones_esp, 'D', 
        v_vuelo_id , v_pasajero_id);
        
      else
        raise_application_error(-20010, 'Se ingresó una categoría de 
          vuelo inválida.');
    end case;
END;
/
show errors