--@Autor(es):       González Rosas Berenise
--                  Telléz González Jorge Luis
--@Fecha creación:  08/01/2022
--@Descripción:     Definición de la función para la lectura de un archivo 
--                  binario y retornar el archivo tipo blob a insertar en la base.

connect sys/system as sysdba

prompt Cofigurando el directorio en donde se encuentran las fotos de los empleados
create or replace directory tmp_fotos as '/tmp/proyecto/Fotos';
grant read, write on directory tmp_fotos to tg_proy_admin;

prompt Creando procedimiento con el usuario tg_proy_admin
connect tg_proy_admin/system

create or replace function actualiza_foto_empleado_1(
  nombre_foto varchar2
) return blob is
  v_bfile bfile;
  v_src_offset number;
  v_dest_offset number;
  v_blob blob;
  v_src_length number;
  v_dest_length number;
begin
  dbms_output.put_line('Cargando foto...');
  DBMS_LOB.CREATETEMPORARY(v_blob,true);
  v_bfile:=bfilename('TMP_FOTOS',nombre_foto);

  if dbms_lob.fileexists(v_bfile) = 0 then
    raise_application_error(-20001,'ERROR: El archivo '||nombre_foto||' NO existe');
  end if;

  --Validar si el archivo se encuentra disponible para usar
  if dbms_lob.isopen(v_bfile) = 1 then
    raise_application_error(-20001,'ATENCION: El archivo '||nombre_foto||'se encuentra abierto. No se puede utilizar');
  end if;

  --Abriendo el archivo correspondiente a la foto a utilizar en modo lectura
  dbms_lob.open(v_bfile, dbms_lob.lob_readonly);

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
    
  dbms_lob.close(v_bfile);
  
  --Validando que la foto del empleado se cargó correctamente
  v_src_length:=dbms_lob.getlength(v_bfile);
  v_dest_length:=dbms_lob.getlength(v_blob);

  --Las variables deben ser iguales, si son diferentes se lanza error
  if v_dest_length<>v_src_length then
    raise_application_error(-20001,'El archivo '||nombre_foto||' no se cargó correctamente');
  end if;
  return v_blob;
end;
/
show errors