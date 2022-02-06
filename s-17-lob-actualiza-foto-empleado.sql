--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  06/01/2022
--@Descripción:     Implementación de procedimiento para la actualización
--                  de datos tipo blob.

prompt Copiando la carpeta a /tmp/proyecto/fotos
!cp -r /home/jorge/SQL/AirFlights/Fotos /tmp/proyecto
prompt cambiando permisos
!chmod 777 /tmp/proyecto/Fotos

connect sys/system as sysdba

prompt Cofigurando el directorio en donde se encuentran las fotos de los empleados
create or replace directory tmp_fotos as '/tmp/proyecto/Fotos';
grant read, write on directory tmp_fotos to tg_proy_admin;

prompt Creando procedimiento con el usuario tg_proy_admin
connect tg_proy_admin/system
set serveroutput on
create or replace procedure actualiza_foto_empleado
  (p_empleado_id in number, p_num_foto in number) is

--Declaracion de variables
v_bfile bfile;
v_src_offset number;
v_dest_offset number;
v_blob blob;
v_src_length number;
v_dest_length number;
v_nombre_foto varchar2(50);

begin
  for v_index in p_empleado_id..p_empleado_id+p_num_foto loop
    v_nombre_foto:='empleado-'||v_index||'.jpg';
    dbms_output.put_line('Cargando foto para '||v_nombre_foto);
    
    --Se valida si el archivo de la fotografia existe
    v_bfile:=bfilename('TMP_FOTOS',v_nombre_foto);

    if dbms_lob.fileexists(v_bfile) = 0 then
      raise_application_error(-20001,'ERROR: El archivo '||v_nombre_foto||' NO existe');
    end if;

    --Validar si el archivo se encuentra disponible para usar
    if dbms_lob.isopen(v_bfile) = 1 then
      raise_application_error(-20001,'ATENCION: El archivo '||v_nombre_foto||'se encuentra abierto. No se puede utilizar');
    end if;

    --Abriendo el archivo correspondiente a la foto a utilizar en modo lectura
    dbms_lob.open(v_bfile,dbms_lob.lob_readonly);

    --Actualizando blob en la tabla. Se debe asegurar que la tabla 'Empleado' ya tiene datos y la columna foto debe tener un blob vacío.
    --Asignar v_blob al empleado con ayuda del índice v_index
    --FOR UPDATE, establece un bloqueo hasta que se termine la transacción
    select foto into v_blob
    from empleado
    where empleado_id=v_index
    for update;

    --Escribiendo bytes
    v_src_offset:=1;
    v_dest_offset:=1;

    --Se carga una columna blob, a partir del archivo de la foto
    --src, es el archivo a cargar
    dbms_lob.loadblobfromfile(
      dest_lob      => v_blob,
      src_bfile     => v_bfile,
      amount        => dbms_lob.getlength(v_bfile),
      dest_offset   => v_dest_offset,
      src_offset    => v_src_offset
    );

    --Cerrando el archivo del que se hizo uso
    dbms_lob.close(v_bfile);

    --Validando que la foto del empleado se cargó correctamente
    v_src_length:=dbms_lob.getlength(v_bfile);
    v_dest_length:=dbms_lob.getlength(v_blob);

    --Las variables deben ser iguales, si son diferentes se lanza error
    if v_dest_length<>v_src_length then
      raise_application_error(-20001,'El archivo '||v_nombre_foto||' no se cargó correctamente');
    end if;
  end loop;
end;
/
show errors