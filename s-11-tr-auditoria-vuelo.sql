--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  06/01/2022
--@Descripción:     Trigger que guarda un log de los cambios dentro de la 
--                  tabla vuelo.

create or replace trigger trg_auditoria_vuelo
  after insert
  or update of fecha_hora_llegada, fecha_hora_salida, sala, estatus_vuelo_id
  on vuelo
  for each row
  declare
    v_auditoria_vuelo_id number(10,0);
    v_fecha_evento date;
    v_fecha_hora_salida_anterior date;
    v_fecha_hora_salida_nueva date;
    v_fecha_hora_llegada_anterior date;
    v_fecha_hora_llegada_nueva date;
    v_detalle_evento varchar2(500);
    v_estatus_id number(10,0);
    v_num_vuelo number(5,0);
    v_aeropuerto_id number(10,0);
    v_aeropuerto_destino_id number(10,0);
    v_aeronave_id number(10,0);
    v_sala number(2,0);
  begin
    case
      when inserting then
        select seq_auditoria_vuelo.nextval into v_auditoria_vuelo_id from dual;
        
        select to_date(sysdate, 'DD/MM/YYYY HH24:MI:SS') 
        into v_fecha_evento from dual;
        
        v_estatus_id:=:new.estatus_vuelo_id;
        
        v_detalle_evento:= 'El usuario '
          || sys_context('USERENV', 'SESSION_USER')
          || ' ha programado un vuelo el día '
          || v_fecha_evento
          || ' con los siguientes datos: número de vuelo: '
          || :new.num_vuelo
          || ', fecha de salida: '
          || :new.fecha_hora_salida
          || ', fecha de llegada: '
          || :new.fecha_hora_llegada
          || ', ID del aeropuerto de origen: '
          || :new.aeropuerto_id
          || ', ID del aeropuerto destino: '
          || :new.aeropuerto_destino_id
          || ', ID de la aeronave empleada: '
          || :new.aeronave_id
          || ', status actual: ';
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
        
        insert into auditoria_vuelo (auditoria_vuelo_id, fecha_evento, usuario, 
          tipo_evento, fecha_hora_llegada_nueva, fecha_hora_salida_nueva, 
          detalle_evento, vuelo_id)
        values(v_auditoria_vuelo_id, v_fecha_evento, 
          sys_context('USERENV', 'SESSION_USER'), 'I', :new.fecha_hora_llegada, 
          :new.fecha_hora_salida, v_detalle_evento, :new.vuelo_id);
      
      when updating then
        select seq_auditoria_vuelo.nextval into v_auditoria_vuelo_id from dual;
        
        select to_date(sysdate, 'DD/MM/YYYY HH24:MI:SS') 
        into v_fecha_evento from dual;
        
        if(:new.estatus_vuelo_id!=:old.estatus_vuelo_id) then
          v_estatus_id:=:new.estatus_vuelo_id;
        else
          v_estatus_id:=:old.estatus_vuelo_id;
        end if;
        
        v_detalle_evento:= 'El usuario '
          || sys_context('USERENV', 'SESSION_USER')
          || ' ha modificado un vuelo el día '
          || v_fecha_evento
          || ' con los siguientes datos: número de vuelo: '
          || :new.num_vuelo;
        
        if(:old.fecha_hora_salida!=:new.fecha_hora_salida) then
          v_detalle_evento:=v_detalle_evento 
                          || ' fecha de salida anterior: '
                          || (to_char(:old.fecha_hora_salida)) 
                          || ', fecha de salida nueva: '
                          || (to_char(:new.fecha_hora_salida)); 
        end if;
        
        if(:old.fecha_hora_llegada!=:new.fecha_hora_llegada) then
          v_detalle_evento:=v_detalle_evento 
                          || ' fecha de llegada anterior: '
                          || (to_char(:old.fecha_hora_llegada)) 
                          || ', fecha de llegada nueva: '
                          || (to_char(:new.fecha_hora_llegada)); 
        end if;
        
        v_detalle_evento:=v_detalle_evento       
          || ', ID del aeropuerto de origen: '
          || :new.aeropuerto_id
          || ', ID del aeropuerto destino: '
          || :new.aeropuerto_destino_id
          || ', ID de la aeronave empleada: '
          || :new.aeronave_id
          || ', status actual: ';
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
                  
        if(:new.sala is not null) then
          v_detalle_evento:=v_detalle_evento 
                          || ', sala actualizada: '
                          || :new.sala;
        end if;
        
        insert into auditoria_vuelo (auditoria_vuelo_id, fecha_evento, 
          usuario, tipo_evento, fecha_hora_llegada_anterior, 
          fecha_hora_llegada_nueva, fecha_hora_salida_anterior, 
          fecha_hora_salida_nueva, detalle_evento, vuelo_id)
        values(v_auditoria_vuelo_id, v_fecha_evento, 
          sys_context('USERENV', 'SESSION_USER'),'U', :old.fecha_hora_llegada, 
          :new.fecha_hora_llegada,:old.fecha_hora_salida, 
          :new.fecha_hora_salida, v_detalle_evento, :old.vuelo_id);    
    end case;  
  end;
  /
  show errors