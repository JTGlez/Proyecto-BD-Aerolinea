--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  04/12/2021
--@Descripción:     Procedimiento para que un pasajero registre una maleta
--tras iniciar su proceso de abordaje de un vuelo.

conn tg_proy_admin/system

create or replace procedure p_registrar_maleta(
  p_folio_pase in varchar2, p_peso in number
)is
  v_pase_existe number(1,0);
  v_num_maletas number(2,0);
  v_pase_abordar_id number(10,0); 
begin
  --Verifica que el folio del pase introducido sea válido. 
  --(Creado y ligado a un registro de vuelo_pasajero.)
  select count(*) into v_pase_existe
  from pase_abordar pa, vuelo_pasajero vp
  where vp.pase_abordar_id=pa.pase_abordar_id
  and pa.folio_pase=p_folio_pase;
  
  if(v_pase_existe=0) then
    raise_application_error(-20020, 'El folio ingresado no existe 
      o es incorrecto.');
  end if;

  /*Con el folio existente, se registran las maletas. Verifica cuántas maletas
    tiene previamente registradas el pase de abordar del pasajero y suma un 1
    a ese valor para realizar las combinaciones adecuadas de la PK.*/
    
  select count(*) into v_num_maletas
  from maleta m
  join pase_abordar pa
    on pa.pase_abordar_id=m.pase_abordar_id
  join vuelo_pasajero vp
    on vp.pase_abordar_id=pa.pase_abordar_id
  where pa.folio_pase=p_folio_pase;
  
  --Genera el consecutivo siguiente 
  v_num_maletas:=v_num_maletas + 1;
  
  --Obtiene el pase_abordar_id
  select pa.pase_abordar_id into v_pase_abordar_id
  from pase_abordar pa
  join vuelo_pasajero vp
    on vp.pase_abordar_id=pa.pase_abordar_id
  where pa.folio_pase=p_folio_pase;
  
  --Registra la maleta
  insert into maleta(num_maleta, pase_abordar_id, peso)
  values (v_num_maletas, v_pase_abordar_id, p_peso);
end;
/ 
show errors