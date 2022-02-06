--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  04/12/2021
--@Descripción:     Procedimiento para que un pasajero aborde un avión.

conn tg_proy_admin/system
set serveroutput on

create or replace procedure p_abordar_vuelo_comercial(
  p_curp in varchar, p_num_vuelo in number, p_folio_pase out varchar2
)is
  v_estado_abordando number(1,0);
  v_pasajero_existe number(1,0);
  v_pasajero_id number(10,0);
  v_pase_abordar_id number(10,0);
  v_maleta number(1,0);
  v_folio_pase varchar2(8);
  v_pase_existe number(1,0);
  v_vuelo_id number(10,0);
begin
  --Verifica que el pasajero exista y esté registrado en el vuelo previamente.
  select count(*) into v_pasajero_existe
  from vuelo_pasajero vp
  join vuelo v
    on vp.vuelo_id=v.vuelo_id
  join pasajero p
    on vp.pasajero_id=p.pasajero_id
  where v.num_vuelo=p_num_vuelo
    and p.curp=p_curp;
    
  if (v_pasajero_existe=0) then
    raise_application_error(-20002,'ERROR: Usted no está registrado en el vuelo 
      ingresado o ingresó un vuelo no existente.');
  end if;

  --Verifica que el vuelo esté en estado ABORDANDO
  select count(*) into v_estado_abordando
  from vuelo
  where num_vuelo=p_num_vuelo
    and estatus_vuelo_id=2;
    
  if (v_estado_abordando=0) then
    raise_application_error(-20003,'ERROR: Espere a que el vuelo esté listo 
      para abordar antes de generar su pase.');
  end if;
  
  select seq_pase_abordar.nextval 
    into v_pase_abordar_id
  from dual;
  
  v_folio_pase:=dbms_random.string('U', 8);
  
  --Verifica que no exista otro pase asignado al pasajero.
  select count(*) into v_pase_existe
  from vuelo_pasajero vp, pase_abordar pa, pasajero p, vuelo v
  where p.pasajero_id=vp.pasajero_id
    and vp.pase_abordar_id=pa.pase_abordar_id
    and vp.vuelo_id=v.vuelo_id
    and p.curp=p_curp
    and v.num_vuelo=p_num_vuelo
    and vp.pase_abordar_id is not null;
    
  if (v_pase_existe>0) then
    raise_application_error(-20009,'ERROR: Usted ya tiene un pase
      de abordaje registrado para este vuelo.');
  end if;
  
  insert into pase_abordar(pase_abordar_id, folio_pase, fecha_impresion)
    values (v_pase_abordar_id, v_folio_pase, sysdate);
  
  --Recupera el ID del Pasajero para actualizar su registro en vuelo_pasajero.
  --con el pase emitido y cambiando la flag de abordaje.
  select vp.pasajero_id, vp.vuelo_id into v_pasajero_id, v_vuelo_id
  from vuelo_pasajero vp
  join pasajero p
    on p.pasajero_id=vp.pasajero_id
  join vuelo v
    on v.vuelo_id=vp.vuelo_id
  where p.curp=p_curp
  and v.num_vuelo=p_num_vuelo;
  
  update vuelo_pasajero
    set pase_abordar_id=v_pase_abordar_id
  where pasajero_id=v_pasajero_id
    and vuelo_id=v_vuelo_id;
  
  update vuelo_pasajero
    set flag_tomo_viaje=1
  where pasajero_id=v_pasajero_id;
  
  p_folio_pase:=v_folio_pase;
  return;
end;
/ 
show errors