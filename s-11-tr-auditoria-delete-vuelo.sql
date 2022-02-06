--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  06/01/2022
--@Descripción:     Trigger que guarda un log de los cambios dentro de la 
--tabla vuelo: específico para eliminaciones.

create or replace trigger trg_auditoria_delete_vuelo
  for delete on vuelo
  compound trigger
    v_auditoria_vuelo_id number(10,0);
    v_fecha_evento date;
    v_fecha_hora_salida_anterior date;
    v_fecha_hora_salida_nueva date;
    v_fecha_hora_llegada_anterior date;
    v_fecha_hora_llegada_nueva date;
    v_detalle_evento varchar2(500);
    v_estatus_id number(10,0);
    v_num_vuelo number(5,0);
    v_aeropuerto_id number (10,0);
    v_aeropuerto_destino_id number (10,0);
    v_aeronave_id number (10,0);
    v_sala number(2,0);
  before each row is
  begin 
    if(:old.estatus_vuelo_id!=5) then
      raise_application_error(-20020, 'El vuelo no puede ser eliminado.
        Para que este pueda eliminarse de la base, 
        primero tiene que ser CANCELADO.');
    end if;
      
    v_fecha_hora_llegada_anterior:=:old.fecha_hora_llegada;
    v_fecha_hora_salida_anterior:=:old.fecha_hora_salida;
    v_num_vuelo:=:old.num_vuelo;
    v_aeropuerto_id:=:old.aeropuerto_id;
    v_aeropuerto_destino_id:=:old.aeropuerto_destino_id;
    v_aeronave_id:=:old.aeronave_id;
    v_estatus_id:=5;
    v_sala:=:old.sala;
  end before each row;
  
  after statement is
    v_auditoria_vuelo_id number(10,0);
    v_fecha_evento date;
    v_detalle_evento varchar2(500);
  begin
    select seq_auditoria_vuelo.nextval into v_auditoria_vuelo_id from dual;
    
    select to_date(sysdate, 'DD/MM/YYYY HH24:MI:SS') 
    into v_fecha_evento from dual;
    
      v_detalle_evento:= 'El usuario '
      || sys_context('USERENV', 'SESSION_USER')
      || ' ha eliminado un vuelo el día '
      || v_fecha_evento
      || ' con los siguientes datos: número de vuelo: '
      || v_num_vuelo
      || ', fecha de salida: '
      || v_fecha_hora_llegada_anterior
      || ', fecha de llegada: '
      || v_fecha_hora_salida_anterior  
      || ', ID del aeropuerto de origen: '
      || v_aeropuerto_id
      || ', ID del aeropuerto destino: '
      || v_aeropuerto_destino_id
      || ', ID de la aeronave empleada: '
      || v_aeronave_id
      || ', último status: ';
    case 
      when v_estatus_id=1 then
        v_detalle_evento:=v_detalle_evento
                        || 'PROGRAMADO';
      when v_estatus_id=2 then
        v_detalle_evento:=v_detalle_evento
                        || 'ABORDANDO';
      when v_estatus_id=3 then
        v_detalle_evento:=v_detalle_evento
                        || 'A TIEMPO';
      when v_estatus_id=4 then
        v_detalle_evento:=v_detalle_evento
                        || 'DEMORADO';
      when v_estatus_id=5 then
        v_detalle_evento:=v_detalle_evento
                        || 'CANCELADO';
      else null;
    end case;
                  
    if(v_sala is not null) then
      v_detalle_evento:=v_detalle_evento 
                      || ', sala: '
                      || v_sala;
    end if;
        
    insert into auditoria_vuelo (auditoria_vuelo_id, fecha_evento, usuario, 
      tipo_evento, fecha_hora_llegada_anterior, fecha_hora_salida_anterior, 
      detalle_evento, vuelo_id)
    values(v_auditoria_vuelo_id, v_fecha_evento, 
      sys_context('USERENV', 'SESSION_USER'),'D', v_fecha_hora_llegada_anterior, 
      v_fecha_hora_salida_anterior, v_detalle_evento, null);
  end after statement;
end;
/
show errors