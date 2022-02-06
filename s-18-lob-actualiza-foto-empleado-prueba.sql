--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  07/01/2022
--@Descripción:     Prueba del procedimiento para la actualización
--                  de datos tipo blob.

set serveroutput on 
declare 
    v_numero_fotos number;
    v_codigo number;
    v_mensaje varchar2(1000);
begin 
    actualiza_foto_empleado(700,49);
    select count(*) into v_numero_fotos 
    from empleado
    where dbms_lob.getlength(foto) > 0;
   
    if v_numero_fotos = 50 then
        dbms_output.put_line('¡Prueba exitosa!'); 
    end if;
    
    exception
      when others then
        v_codigo := sqlcode;
        v_mensaje := sqlerrm;
        dbms_output.put_line('Codigo:  ' || v_codigo);
        dbms_output.put_line('Mensaje: ' || v_mensaje);
        dbms_output.put_line('ERROR, se obtuvo excepción no esperada.
          El procedimiento no está funcionando correctamente.');
          raise;
end;
/
show errors;


Prompt =================================================
Prompt Prueba.
Prompt Listado del tamaño de las fotos insertadas
Prompt =================================================

select dbms_lob.getlength(foto) from empleado
where empleado_id between 700 and 749;