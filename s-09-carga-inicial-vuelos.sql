--@Autor(es): González Rosas Berenise & Téllez González Jorge Luis
--@Fecha de Creación: 04/12/2021
--@Descripción: Carga inicial de datos en la base: Air Flights. Inserción
--de vuelos con procedimientos.

/*NOTA: Ejecutar script s-13-p-programar-vuelo-comercial previamente.*/

Prompt Generando registros de vuelo comerciales y de carga...
--1. Vuelo con todos los asientos ocupados con un Airbus A430
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';

declare
  v_vuelo_id number(10,0);
begin
  p_crea_vuelo_comercial(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'03-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'04-01-2022 11:15:00', 
    p_aeropuerto_id         =>26,
    p_aeropuerto_destino_id =>27, 
    p_aeronave_id           =>1,
    p_piloto_id             =>1,
    p_copiloto_id           =>125,
    p_jefe_sobrecargos_id   =>400,
    p_sobrecargo1_id        =>425,
    p_sobrecargo2_id        =>430,
    p_sobrecargo3_id        =>450,
    p_ingeniero_id          =>2720,
    p_aux_seguridad1_id     =>2909,
    p_aux_seguridad2_id     =>2917,
    p_vuelo_id              =>v_vuelo_id
  );
  
  exception
    when others then
       dbms_output.put_line('Error detectado: realizando rollback...');
        rollback;
       dbms_output.put_line('A continuación se envía la excepción encontrada.');
        raise;
end;
/
show errors

insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 1, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 228);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 2, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 441);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 3, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 656);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 4, 'No requiere atención especial', 1, 'O', 1, 643);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 5, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 410);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 6, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 424);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 7, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 435);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 8, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 614);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 9, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 905);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 10, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 725);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 11, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 847);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 12, 'No requiere atención especial', 0, 'O', 1, 54);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 13, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 336);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 14, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 20);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 15, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 23);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 16, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 590);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 17, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 693);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 18, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 644);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 19, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 874);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 20, 'No requiere atención especial', 1, 'O', 1, 824);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 21, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 931);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 22, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 185);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 23, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 973);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 24, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 577);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 25, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 785);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 26, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 616);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 27, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 226);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 28, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 358);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 29, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 458);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 30, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 876);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 31, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 632);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 32, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 761);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 33, 'No requiere atención especial', 1, 'O', 1, 892);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 34, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 863);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 35, 'No requiere atención especial', 0, 'O', 1, 776);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 36, 'No requiere atención especial', 0, 'O', 1, 689);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 37, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 853);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 38, 'No requiere atención especial', 1, 'O', 1, 9);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 39, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 579);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 40, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 681);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 41, 'No requiere atención especial', 1, 'O', 1, 71);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 42, 'No requiere atención especial', 1, 'O', 1, 398);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 43, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 512);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 44, 'No requiere atención especial', 1, 'O', 1, 397);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 45, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 137);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 46, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 67);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 47, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 394);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 48, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 329);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 49, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 302);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 50, 'No requiere atención especial', 0, 'O', 1, 585);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 51, 'No requiere atención especial', 1, 'O', 1, 429);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 52, 'No requiere atención especial', 0, 'O', 1, 966);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 53, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 132);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 54, 'No requiere atención especial', 0, 'O', 1, 543);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 55, 'No requiere atención especial', 1, 'O', 1, 935);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 56, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 742);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 57, 'No requiere atención especial', 0, 'O', 1, 861);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 58, 'No requiere atención especial', 0, 'O', 1, 596);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 59, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 668);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 60, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 757);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 61, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 997);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 62, 'No requiere atención especial', 0, 'O', 1, 956);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 63, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 136);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 64, 'No requiere atención especial', 1, 'O', 1, 489);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 65, 'No requiere atención especial', 1, 'O', 1, 529);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 66, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 786);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 67, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 487);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 68, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 343);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 69, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 898);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 70, 'No requiere atención especial', 0, 'O', 1, 55);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 71, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 322);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 72, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 601);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 73, 'No requiere atención especial', 0, 'O', 1, 503);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 74, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 704);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 75, 'No requiere atención especial', 0, 'O', 1, 21);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 76, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 933);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 77, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 376);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 78, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 10);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 79, 'No requiere atención especial', 1, 'O', 1, 937);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 80, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 191);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 81, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 411);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 82, 'No requiere atención especial', 0, 'O', 1, 634);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 83, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 182);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 84, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 886);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 85, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 602);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 86, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 457);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 87, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 653);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 88, 'No requiere atención especial', 0, 'O', 1, 405);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 89, 'No requiere atención especial', 1, 'O', 1, 619);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 90, 'No requiere atención especial', 0, 'O', 1, 985);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 91, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 335);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 92, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 951);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 93, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 48);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 94, 'No requiere atención especial', 0, 'O', 1, 911);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 95, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 362);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 96, 'No requiere atención especial', 1, 'O', 1, 465);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 97, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 751);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 98, 'No requiere atención especial', 1, 'O', 1, 676);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 99, 'No requiere atención especial', 1, 'O', 1, 439);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 100, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 846);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 101, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 592);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 102, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 991);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 103, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 486);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 104, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 38);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 105, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 928);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 106, 'No requiere atención especial', 1, 'O', 1, 256);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 107, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 999);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 108, 'No requiere atención especial', 0, 'O', 1, 773);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 109, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 135);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 110, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 62);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 111, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 862);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 112, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 597);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 113, 'No requiere atención especial', 1, 'O', 1, 716);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 114, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 180);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 115, 'No requiere atención especial', 0, 'O', 1, 946);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 116, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 243);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 117, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 147);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 118, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 934);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 119, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 758);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 120, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 606);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 121, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 895);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 122, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 421);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 123, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 718);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 124, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 495);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 125, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 375);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 126, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 552);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 127, 'No requiere atención especial', 0, 'O', 1, 255);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 128, 'No requiere atención especial', 1, 'O', 1, 752);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 129, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 864);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 130, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 672);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 131, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 591);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 132, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 478);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 133, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 553);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 134, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 212);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 135, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 719);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 136, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 294);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 137, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 671);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 138, 'No requiere atención especial', 0, 'O', 1, 860);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 139, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 327);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 140, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 542);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 141, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'O', 1, 218);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 142, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'O', 1, 109);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 143, 'No requiere atención especial', 1, 'O', 1, 983);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 144, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 938);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 145, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 947);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 146, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 633);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 147, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'O', 1, 361);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 148, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'O', 1, 330);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 149, 'No requiere atención especial', 1, 'O', 1, 932);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 150, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 1, 'O', 1, 564);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 151, 'No requiere atención especial', 0, 'O', 1, 986);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 152, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'O', 1, 77);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 153, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 1, 'V', 1, 1593);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 154, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 0, 'V', 1, 1436);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 155, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'V', 1, 1491);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 156, 'No requiere atención especial', 1, 'V', 1, 1529);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 157, 'No requiere atención especial', 0, 'V', 1, 1609);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 158, 'Padece de afecciones respiratorias: vigilar su estado y tener a la mano respiradores/broncodilatadores', 0, 'V', 1, 1678);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 159, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'V', 1, 1619);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 160, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'V', 1, 1211);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 161, 'Sufre de una afección cardiaca: requiere supervisión contínua y tener preparado equipamiento RCP adecuado en caso de emergencia', 0, 'V', 1, 1561);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 162, 'No requiere atención especial', 1, 'V', 1, 1293);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 163, 'No requiere atención especial', 0, 'V', 1, 1142);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 164, 'Pasajera embarazada: mantener en constante vigilancia de su estado y sus signos vitales.', 1, 'V', 1, 1294);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 165, 'Pasajero con discapacidad física: tener personal capacitado disponible para auxiliar en su movilidad al abordar el avión', 0, 'D', 1, 1812);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 166, 'dentro del mismo', 1, 'D', 1, 2259);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 167, 'Pasajero con discapacidad mental: mantenerse pendiente de su condición y calmarlo con las medidas adecuadas y manteniendo respeto al mismo.', 0, 'D', 1, 2069);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 168, 'dentro del mismo', 1, 'D', 1, 2116);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 169, 'y durante el aterrizaje.', 0, 'D', 1, 2255);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 170, 'y durante el aterrizaje.', 0, 'D', 1, 2110);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 171, 'Pasajero con discapacidad mental: mantenerse pendiente de su condición y calmarlo con las medidas adecuadas y manteniendo respeto al mismo.', 0, 'D', 1, 2239);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 172, 'Pasajero con discapacidad mental: mantenerse pendiente de su condición y calmarlo con las medidas adecuadas y manteniendo respeto al mismo.', 0, 'D', 1, 2006);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 173, 'Pasajero con discapacidad mental: mantenerse pendiente de su condición y calmarlo con las medidas adecuadas y manteniendo respeto al mismo.', 0, 'D', 1, 1913);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 174, 'dentro del mismo', 1, 'D', 1, 2260);


--2. Vuelo con un asiento ocupado por cada categoría en un Boeing 747

declare
  v_vuelo_id number(10,0);
begin
  p_crea_vuelo_comercial(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'05-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'06-01-2022 11:15:00', 
    p_aeropuerto_id         =>12,
    p_aeropuerto_destino_id =>39, 
    p_aeronave_id           =>2,
    p_piloto_id             =>3,
    p_copiloto_id           =>100,
    p_jefe_sobrecargos_id   =>417,
    p_sobrecargo1_id        =>445,
    p_sobrecargo2_id        =>520,
    p_sobrecargo3_id        =>602,
    p_ingeniero_id          =>2721,
    p_aux_seguridad1_id     =>2906,
    p_aux_seguridad2_id     =>2918,
    p_vuelo_id              =>v_vuelo_id
  );
  commit;

  exception
    when others then
       dbms_output.put_line('ERROR DETECTADO: realizando rollback...');
        rollback;
       dbms_output.put_line('A continuación se envía la excepción encontrada.');
        raise;
end;
/
show errors

insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 1, 'No requiere atenciones especiales.', 1, 'O', 2, 2998); 
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 211, 'No requiere atenciones especiales.', 1, 'V', 2, 2999);
insert into vuelo_pasajero (vuelo_pasajero_id, asiento, atenciones_esp, flag_tomo_viaje, tipo_pasajero, vuelo_id, pasajero_id) values (seq_vuelo_pasajero.nextval, 245, 'Pasajero con discapacidad física: tener personal capacitado disponible para auxiliar en su movilidad al abordar el avión.', 1, 'D', 2, 3000);


--3. Vuelo programado con todos los asientos disponibles en un Embraer 170
declare
  v_vuelo_id number(10,0);
begin
  p_crea_vuelo_comercial(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'07-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'07-01-2022 09:15:00', 
    p_aeropuerto_id         =>2,
    p_aeropuerto_destino_id =>38, 
    p_aeronave_id           =>7,
    p_piloto_id             =>4,
    p_copiloto_id           =>112,
    p_jefe_sobrecargos_id   =>412,
    p_sobrecargo1_id        =>470,
    p_sobrecargo2_id        =>590,
    p_sobrecargo3_id        =>907,
    p_ingeniero_id          =>2722,
    p_aux_seguridad1_id     =>2930,
    p_aux_seguridad2_id     =>2931,
    p_vuelo_id              =>v_vuelo_id
  );
  exception
    when others then
       dbms_output.put_line('Error detectado: realizando rollback...');
        rollback;
       dbms_output.put_line('A continuación se envía la excepción encontrada.');
        raise;
end;
/
show errors


--4. Vuelo programado con 1 asiento 'O', 'V' y 'P' ocupado y en estado ABORDANDO.
declare
  v_vuelo_id number(10,0);
  v_num_vuelo number(5,0);
begin
  v_num_vuelo:=91900;

  p_crea_vuelo_comercial(
    p_num_vuelo             =>v_num_vuelo, 
    p_fecha_hora_salida     =>'07-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'07-01-2022 09:15:00', 
    p_aeropuerto_id         =>18,
    p_aeropuerto_destino_id =>24, 
    p_aeronave_id           =>5,
    p_piloto_id             =>28,
    p_copiloto_id           =>29,
    p_jefe_sobrecargos_id   =>510,
    p_sobrecargo1_id        =>570,
    p_sobrecargo2_id        =>690,
    p_sobrecargo3_id        =>1007,
    p_ingeniero_id          =>2798,
    p_aux_seguridad1_id     =>2980,
    p_aux_seguridad2_id     =>2999,
    p_vuelo_id              =>v_vuelo_id
  );
  
  update vuelo
    set estatus_vuelo_id=2
  where vuelo_id=v_vuelo_id;
  
  p_registrar_vuelo_pasajero(
      p_curp           =>'CMJKE673CMHMYNCYNA', 
      p_num_vuelo      =>v_num_vuelo,
      p_tipo_pasajero  =>'O', 
      p_asiento        =>229,
      p_atenciones_esp =>'B',
      p_vuelo_id       =>v_vuelo_id
    );
    
  p_registrar_vuelo_pasajero(
      p_curp           =>'TS2XWBFZCAJV2AN6OH', 
      p_num_vuelo      =>v_num_vuelo,
      p_tipo_pasajero  =>'V', 
      p_asiento        =>230,
      p_atenciones_esp =>'C',
      p_vuelo_id       =>v_vuelo_id
    );
    
  p_registrar_vuelo_pasajero(
      p_curp           =>'ZJKEXBOTD3GTIJUV2F', 
      p_num_vuelo      =>v_num_vuelo,
      p_tipo_pasajero  =>'D', 
      p_asiento        =>268,
      p_atenciones_esp =>'F',
      p_vuelo_id       =>v_vuelo_id
    );

  exception
    when others then
       dbms_output.put_line('Error detectado: realizando rollback...');
        rollback;
       dbms_output.put_line('A continuación se envía la excepción encontrada.');
        raise;
end;
/
show errors
 
 
--5. Vuelo comercial programado con estatus CANCELADO

declare
  v_vuelo_id number(10,0);
begin
  p_crea_vuelo_comercial(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'08-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'09-01-2022 09:15:00', 
    p_aeropuerto_id         =>30,
    p_aeropuerto_destino_id =>41, 
    p_aeronave_id           =>9,
    p_piloto_id             =>3,
    p_copiloto_id           =>113,
    p_jefe_sobrecargos_id   =>413,
    p_sobrecargo1_id        =>471,
    p_sobrecargo2_id        =>591,
    p_sobrecargo3_id        =>908,
    p_ingeniero_id          =>2723,
    p_aux_seguridad1_id     =>2931,
    p_aux_seguridad2_id     =>2932,
    p_vuelo_id              =>v_vuelo_id
  );
  
  update vuelo
    set estatus_vuelo_id=5
  where vuelo_id=v_vuelo_id;
 
  exception
    when others then
       dbms_output.put_line('Error detectado: realizando rollback...');
        rollback;
       dbms_output.put_line('A continuación se envía la excepción encontrada.');
        raise;
end;
/
show errors


--6. Vuelo de carga programado con estatus CANCELADO

declare
  v_vuelo_id number(10,0);
begin
  dbms_output.put_line('Programando un vuelo de carga no válido.
    Se espera un error al ser el aeropuerto de origen el destino.');
  p_crea_vuelo_carga(
    p_num_vuelo             =>seq_num_vuelo.nextval, 
    p_fecha_hora_salida     =>'08-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'09-01-2022 11:15:00', 
    p_aeropuerto_id         =>8,
    p_aeropuerto_destino_id =>32, 
    p_aeronave_id           =>19,
    p_piloto_id             =>1,
    p_copiloto1_id          =>125,
    p_copiloto2_id          =>124,
    p_ingeniero_id          =>2720,
    p_tecnico1_id           =>2450,
    p_tecnico2_id           =>null,
    p_tecnico3_id           =>null,
    p_tecnico4_id           =>null,
    p_tecnico5_id           =>null,
    p_tecnico6_id           =>null,
    p_tecnico7_id           =>null,
    p_tecnico8_id           =>null,
    p_tecnico9_id           =>null,
    p_tecnico10_id          =>null,
    p_vuelo_id              =>v_vuelo_id
  );
  
  update vuelo
    set estatus_vuelo_id=5
  where vuelo_id=v_vuelo_id;
    
  exception
    when others then
      dbms_output.put_line('Error detectado: realizando rollback...');
      rollback;
      dbms_output.put_line('A continuación se envía la excepción encontrada.');
      raise;
end;
/
show errors


--7. Vuelo programado con 1 asiento 'O', 'V' y 'P' ocupado, en estado ABORDANDO
--   y con los pases de abordar generados.
declare
  v_vuelo_id number(10,0);
  v_num_vuelo number(5,0);
  v_folio_pase varchar2(8);
begin
  v_num_vuelo:=90700;

  p_crea_vuelo_comercial(
    p_num_vuelo             =>v_num_vuelo, 
    p_fecha_hora_salida     =>'09-01-2022 01:35:00',
    p_fecha_hora_llegada    =>'10-01-2022 09:15:00', 
    p_aeropuerto_id         =>25,
    p_aeropuerto_destino_id =>26, 
    p_aeronave_id           =>5,
    p_piloto_id             =>35,
    p_copiloto_id           =>40,
    p_jefe_sobrecargos_id   =>511,
    p_sobrecargo1_id        =>571,
    p_sobrecargo2_id        =>691,
    p_sobrecargo3_id        =>1008,
    p_ingeniero_id          =>2797,
    p_aux_seguridad1_id     =>2981,
    p_aux_seguridad2_id     =>3000,
    p_vuelo_id              =>v_vuelo_id
  );
  
  update vuelo
    set estatus_vuelo_id=2
  where vuelo_id=v_vuelo_id; 
  
  p_registrar_vuelo_pasajero(
      p_curp           =>'CMJKE673CMHMYNCYNA', 
      p_num_vuelo      =>v_num_vuelo,
      p_tipo_pasajero  =>'O', 
      p_asiento        =>229,
      p_atenciones_esp =>'B',
      p_vuelo_id       =>v_vuelo_id
    );
    
  p_abordar_vuelo_comercial(
    p_curp            =>'CMJKE673CMHMYNCYNA', 
    p_num_vuelo       =>v_num_vuelo,
    p_folio_pase      =>v_folio_pase
    );  
    
  p_registrar_vuelo_pasajero(
      p_curp           =>'TS2XWBFZCAJV2AN6OH', 
      p_num_vuelo      =>v_num_vuelo,
      p_tipo_pasajero  =>'V', 
      p_asiento        =>230,
      p_atenciones_esp =>'C',
      p_vuelo_id       =>v_vuelo_id
    );
    
  p_abordar_vuelo_comercial(
    p_curp            =>'TS2XWBFZCAJV2AN6OH', 
    p_num_vuelo       =>v_num_vuelo,
    p_folio_pase      =>v_folio_pase
    );
    
  p_registrar_vuelo_pasajero(
      p_curp           =>'ZJKEXBOTD3GTIJUV2F', 
      p_num_vuelo      =>v_num_vuelo,
      p_tipo_pasajero  =>'D', 
      p_asiento        =>268,
      p_atenciones_esp =>'F',
      p_vuelo_id       =>v_vuelo_id
    );
    
    p_abordar_vuelo_comercial(
    p_curp            =>'ZJKEXBOTD3GTIJUV2F', 
    p_num_vuelo       =>v_num_vuelo,
    p_folio_pase      =>v_folio_pase
    );
  
  exception
    when others then
       dbms_output.put_line('Error detectado: realizando rollback...');
        rollback;
       dbms_output.put_line('A continuación se envía la excepción encontrada.');
        raise;
end;
/
show errors