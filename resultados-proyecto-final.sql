--@Autor(es):       Jorge Rodríguez
--@Fecha creación:  
--@Descripción:     Script validacion proyecto final
set serveroutput on
declare
    v_num_tablas number(10,0);
    v_num_total_tablas number(10,0);
    v_num_tablas_temp number(10,0);
    v_num_tablas_externas number(10,0);
    v_num_total_registros number(10,0):=0;
    v_num_default number(10,0);
    v_num_virtual number(10,0);
    v_num_lobs number(10,0);
    v_num_directories number(10,0);
    v_num_constraints_c number(10,0):=0;
    v_num_constraints_p number(10,0):=0;
    v_num_constraints_u number(10,0):=0;
    v_num_constraints_r number(10,0):=0;
    v_num_index_non_unique number(10,0):=0;
    v_num_index_unique_pk number(10,0):=0;
    v_num_index_unique_non_pk number(10,0):=0;
    v_num_index_function_based number(10,0):=0;
    v_num_index_lob number(10,0):=0;

    v_nombre_tabla varchar2(128);
    v_num_registros number(10,0);
    v_tipo_constraint varchar2(1);
    v_num_constraints number(10,0);

    v_num_sequences number(10,0):=0;
    v_num_private_synonyms number(10,0):=0;
    v_num_public_synonyms number(10,0):=0;
    v_num_views number(10,0):=0;
    v_num_procedures number(10,0):=0;
    v_num_triggers number(10,0):=0;
    v_num_functions number(10,0):=0;
    v_num_invalid number(10,0):=0;
    v_username varchar2(30);
    v_created date;

    cursor cur_tablas IS select table_name from user_tables;
    cursor cur_constraints is select constraint_type, 
        count(*)user_sequences from user_constraints 
        where constraint_type in('C','P','U','R') group by constraint_type;
    cursor cur_usuarios is select username,created from all_users 
        where username like '%_PROY_USER%' or username like '%_PROY_ADMIN%';
begin
	--tablas 
    select count(*) into v_num_tablas_temp from user_tables where temporary='Y';
    select count(*) into v_num_tablas_externas from user_external_tables;
   	--secuencias
   	select count(*) into v_num_sequences from user_sequences;    
    --columnas
    select count(*) into v_num_default from user_tab_cols where data_default is not null and virtual_column='NO';
    select count(*) into v_num_virtual from user_tab_cols where data_default is not null and virtual_column='YES';
    select count(*) into v_num_lobs from user_tab_cols where data_type in('BLOB','CLOB');
    --indices
    select count(*) into v_num_index_non_unique from user_indexes where index_type='NORMAL' and uniqueness='NONUNIQUE';
    select count(*) into v_num_index_lob from user_indexes where index_type='LOB';
    select count(*) into v_num_index_function_based from user_indexes where index_type='FUNCTION-BASED NORMAL';
    --indices de PKs
    select count(*) into v_num_index_unique_pk 
    from user_indexes ix, user_constraints uc
	where ix.index_name = uc.index_name 
	and uc.constraint_type='P'
	and ix.uniqueness ='UNIQUE'
	and ix.index_type='NORMAL';
	--indices unique no pks
	select count(*) into v_num_index_unique_non_pk
	from user_indexes 
	where uniqueness ='UNIQUE'
	and index_name not in(select index_name from user_constraints  where index_name is not null) 
	and index_type ='NORMAL';

    --directorios
    select count(*) into v_num_directories from all_directories;
    --sinonimos
   select count(*) into v_num_private_synonyms from user_synonyms;
   select count(*) into v_num_public_synonyms from all_synonyms where table_owner=sys_context('USERENV','SESSION_USER');
   --vistas
   select count(*) into v_num_views from user_views;
   --pl/sql objects
   select count(*) into v_num_triggers from user_procedures where object_type='TRIGGER';
   select count(*) into v_num_procedures from user_procedures where object_type='PROCEDURE';
   select count(*) into v_num_functions from user_procedures where object_type='FUNCTION';
   --invalidos
   select count(*) into v_num_invalid from user_objects where status ='INVALID';
    --registros
    open cur_tablas;
    loop 
        fetch cur_tablas into v_nombre_tabla;
        
        execute immediate 'select count(*) into :ph_num_registros '
        	||' from ' 
        	||v_nombre_tabla into v_num_registros;

        exit when cur_tablas%notfound;
        v_num_total_registros:=v_num_registros+v_num_total_registros;
    end loop;

    v_num_total_tablas:=cur_tablas%rowcount;
    close cur_tablas;
    --constraints
    open cur_constraints;
    loop
        fetch cur_constraints into v_tipo_constraint,v_num_constraints;
        exit when cur_constraints%notfound;
        case v_tipo_constraint
           when 'C' then
                v_num_constraints_c:= v_num_constraints;
            when 'P' then
                v_num_constraints_p:= v_num_constraints;
            when 'U' then
                v_num_constraints_u:= v_num_constraints;
            when 'R' then
                v_num_constraints_r:= v_num_constraints;    
           else
            dbms_output.put_line('Invalid constraint type: '||v_tipo_constraint);
        end case;
    end loop;
    close cur_constraints;
    
    dbms_output.put_line('-------USERS----');
    open cur_usuarios;
    loop
        fetch cur_usuarios into v_username,v_created;
        exit when cur_usuarios%notfound;
         dbms_output.put_line(v_username||' - '||v_created);
    end loop;
    close cur_usuarios;  
    
    dbms_output.put_line('-------RESULTADOS----');
    dbms_output.put_line('TABLES             '||v_num_total_tablas);
    dbms_output.put_line('TABLE TEMP         '||v_num_tablas_temp);
    dbms_output.put_line('TABLE EXT          '||v_num_tablas_externas);
    dbms_output.put_line('SEQUENCES          '||v_num_sequences);
    dbms_output.put_line('ROWS               '||v_num_total_registros);
    dbms_output.put_line('CONSTRAINT CHECK   '||v_num_constraints_c);
    dbms_output.put_line('CONSTRAINT PK      '||v_num_constraints_p);
    dbms_output.put_line('CONSTRAINT UNIQUE  '||v_num_constraints_u);
    dbms_output.put_line('CONSTRAINT REF     '||v_num_constraints_r);
    dbms_output.put_line('COL DEFAULT        '||v_num_default);
    dbms_output.put_line('COL VIRTUAL        '||v_num_virtual);
    dbms_output.put_line('COL LOB            '||v_num_lobs);
    dbms_output.put_line('DIRECTORIES        '||v_num_directories);
    dbms_output.put_line('INDEX UK (PK)      '||v_num_index_unique_pk);
    dbms_output.put_line('INDEX UK           '||v_num_index_unique_non_pk);
    dbms_output.put_line('INDEX NON UNIQUE   '||v_num_index_non_unique);
    dbms_output.put_line('INDEX LOB          '||v_num_index_lob);
    dbms_output.put_line('INDEX F-BASED      '||v_num_index_function_based);
    dbms_output.put_line('PUBLIC SYNONYMS    '||v_num_public_synonyms);
    dbms_output.put_line('PRIVATE SYNONYMS   '||v_num_private_synonyms);
    dbms_output.put_line('VIEWS              '||v_num_views);
    dbms_output.put_line('PROCEDURES         '||v_num_procedures);
    dbms_output.put_line('TRIGGERS           '||v_num_triggers);
    dbms_output.put_line('FUNCTIONS          '||v_num_functions);
    dbms_output.put_line('INVALID            '||v_num_invalid);   
   
end;
/
