--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  06/01/2022
--@Descripción:     Trigger para validar que un empleado no tenga más 
--                  de 5 direcciones web.

create or replace trigger trg_valida_empleado_direccion_web
  for insert on empleado_direccion_web
  compound trigger
    v_count_direcciones number(2,0);
    v_empleado_id number(10,0);
  before each row is
    v_count number(10,0);
  begin
    select count(*) into v_count
    from empleado_direccion_web
    where empleado_id=:new.empleado_id;
    dbms_output.put_line('Direcciones web en la tabla que pertenecen 
      al empleado actualmente: ' ||v_count);
    v_count_direcciones:=v_count;
    v_empleado_id:=:new.empleado_id;
  end before each row;
  
  after each row is
  begin
    if(v_count_direcciones >= 5) then
      raise_application_error(-20001,'El empleado ya tiene registradas 5 
        páginas web para su historial laboral.');
    else
      dbms_output.put_line('Dirección web registrada exitosamente.');
    end if;  
  end after each row;
  
  after statement is
    v_count number(10,0);
  begin
    select count(*) into v_count
    from empleado_direccion_web
    where empleado_id=v_empleado_id;
    dbms_output.put_line('Direcciones web actualizadas que pertenecen 
      al empleado: ' ||v_count);
  end after statement;
end;
/
show errors