--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  06/01/2022
--@Descripción:     Trigger para enviar paquetes a auditoría o revisión.

create or replace trigger trg_auditoria_paquete
  after insert 
  or update
  on paquete
  for each row
  declare
    v_paquete_auditoria_aduanal_id number(10,0);
    v_razon paquete_auditoria_aduanal.razon%type;
    v_fecha_aviso paquete_auditoria_aduanal.fecha_aviso%type;
    v_paquete_id paquete_auditoria_aduanal.paquete_id%type;
  begin
    case
      when inserting then
        case   
          when :new.tipo_paquete_id=1 then
            if(:new.peso>100) then
              raise_application_error(-20001,'El paquete ingresado supera los
                100KG de límite por envío individual.');
            end if;
                    
          when :new.tipo_paquete_id=2 then
            if(:new.peso>50) then
              raise_application_error(-20002,'El paquete ingresado supera los
                50KG de límite por envío individual.');
            end if;
            
          when :new.tipo_paquete_id=3 then
            if(:new.peso>5) then
              raise_application_error(-20003,'Los paquetes categorizados como
                peligrosos no puede superar los 5KG.');
            end if;
          
            select seq_paquete_auditoria_aduanal.nextval 
            into v_paquete_auditoria_aduanal_id from dual;
           
            select to_date(sysdate, 'DD/MM/YYYY HH24:MI:SS') 
            into v_fecha_aviso from dual;
            
             v_razon:= 'El paquete con folio '
              || :new.folio_paquete
              || ' requiere una revisión adicional debido a que se trata de un paquete'
              || ' peligroso que necesita de manejo especial por parte de los técnicos.'
              || ' Su peso es de: '
              || :new.peso
              || '[Kg] y ha sido registrado el día: '
              || v_fecha_aviso;
              
            insert into paquete_auditoria_aduanal(paquete_auditoria_aduanal_id, 
              razon, fecha_aviso, paquete_id)
            values (v_paquete_auditoria_aduanal_id, v_razon, v_fecha_aviso, 
              :new.paquete_id);
           
          when :new.tipo_paquete_id=4 then
            if(:new.peso>100) then
              raise_application_error(-20004,'El paquete ingresado supera los
                100KG de límite por envío individual.');
            end if;
            
            if (:new.peso>5) then
              select seq_paquete_auditoria_aduanal.nextval 
              into v_paquete_auditoria_aduanal_id from dual;
              
              select to_date(sysdate, 'DD/MM/YYYY HH24:MI:SS') 
              into v_fecha_aviso from dual;
              
              v_razon:= 'El paquete con folio '
                || :new.folio_paquete
                || ' requiere de revisión aduanal debido a que excedió los 5KG'
                || ' y se debe verificar que no se trate de mercancía no declarada.'
                || ' Su peso es de: '
                || :new.peso
                || '[Kg] y ha sido registrado el día: '
                || v_fecha_aviso;
              
              insert into paquete_auditoria_aduanal(paquete_auditoria_aduanal_id, 
                razon, fecha_aviso, paquete_id)
              values (v_paquete_auditoria_aduanal_id, v_razon, v_fecha_aviso, 
                :new.paquete_id);
            end if;
          else
            raise_application_error(-20001,'Categoría de paquete inválida.');
        end case;
      
      when updating then
        dbms_output.put_line('ATENCIÓN: No se permiten modificaciones a 
          los paquetes una vez que estos ingresaron a la base de datos.');
          
        select seq_paquete_auditoria_aduanal.nextval 
        into v_paquete_auditoria_aduanal_id from dual;
        
        select to_date(sysdate, 'DD/MM/YYYY HH24:MI:SS') 
        into v_fecha_aviso from dual;
          
        v_razon:= 'El paquete con folio '
          || :new.folio_paquete
          || ' se trató de modificar el día '
          || v_fecha_aviso
          || ' por parte del usuario'
          || sys_context('USERENV', 'SESSION_USER')
          || '. Se sugiere realizar una inspección adicional del mismo.';
          
        insert into paquete_auditoria_aduanal(paquete_auditoria_aduanal_id, 
          razon, fecha_aviso, paquete_id)
        values (v_paquete_auditoria_aduanal_id, v_razon, v_fecha_aviso, 
          :new.paquete_id);
    end case;
  end;
  /
  show errors