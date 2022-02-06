--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  07/01/2022
--@Descripción:     Función que calcula los costos adiciones por exceder el
--límite de 1KG para cada maleta.

create or replace function recargo_vuelo(
  p_pase_abordar_id number,
  tipo_pasajero char
) return number is
  costo_total number;

  cursor cur_maleta is
    select peso 
    from maleta m, pase_abordar pa
    where m.pase_abordar_id=pa.pase_abordar_id
      and m.pase_abordar_id=p_pase_abordar_id;
begin
  costo_total:=0;
  for p in cur_maleta loop
    if(p.peso >1) then
      costo_total:=costo_total+(p.peso-1)*500;
    end if;
    costo_total:=costo_total;
  end loop;
  
  if(tipo_pasajero='O') then
    costo_total:=costo_total*1.25;
    return costo_total;
  elsif (tipo_pasajero='V') then
    costo_total:=costo_total*1.1;
    return costo_total;
  elsif (tipo_pasajero='D') then
    costo_total:=costo_total-(costo_total*0.2);
    return costo_total;
  else
    return null;
  end if;
end;
/
show errors 