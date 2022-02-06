--@Autor(es): González Rosas Berenise & 
--            Téllez González Jorge Luis
--@Fecha de Creación: 07/01/2022
--@Descripción: Función para generar la matrícula de un avión.

conn tg_proy_admin/system

create or replace function matricula_avion(
  modelo varchar2,
  es_carga number,
  es_comercial number
) return varchar2 is
  v_matricula varchar2(15);
begin
  v_matricula:='XA-'
             || substr(substr(modelo, 1, instr(modelo,' ')-1), 1, 2);
             if(es_comercial=1 and es_carga=1) then
               v_matricula:=v_matricula 
                          || 'C2';
             elsif (es_comercial=1) then
               v_matricula:=v_matricula
                          || 'CO';
             elsif (es_carga=1) then
               v_matricula:=v_matricula
                          || 'CA';
             else
               dbms_output.put_line('¡Datos inválidos!');
               return '';
             end if;
  v_matricula:=v_matricula
             || dbms_random.string('X', 3);   
  return v_matricula;
end;
/
show errors