Rem
Rem fixtbs.sql
Rem
Rem Copyright (c), Symantec Corporation. All rights reserved.
Rem
Rem DESCRIPTION
Rem	Fix tablespaces extents to reserve precalculated data,
Rem	thus improving performance of I3 views.
Rem
Rem NOTES
Rem	The script uses the TABLESPACE_FIX_SEGMENT_EXTBLKS
Rem	in package DBMS_SPACE_ADMIN of SYS.
Rem
Rem CREATED
Rem	26/04/2006
Rem

set serveroutput on size 100000

   DECLARE
     version varchar2(20);
     validate number;
   BEGIN 

    dbms_output.put('Checking instance version ... ');

    select version, to_number(substr(version,1,instr(version, '.',1,1) - 1) ||
       substr(version,instr(version, '.',1,1) + 1,instr(version, '.',1,2) - instr(version, '.',1,1) - 1) ||
       substr(version,instr(version, '.',1,2) + 1,instr(version, '.',1,3) - instr(version, '.',1,2) - 1) ||
       substr(version,instr(version, '.',1,3) + 1,instr(version, '.',1,4) - instr(version, '.',1,3) - 1))
    into version, validate
    from v$instance;

    if validate < 9205 then
	dbms_output.put_line('Found: ' || version || ' .');
	dbms_output.put_line('===========================================');
	dbms_output.put_line('This fix is only needed for instances of version 9.2.0.5 and later.');
	goto end_proc;
    end if;

    dbms_output.put_line('OK.');

    if validate >= 10000 then

	    dbms_output.put('Checking instance compatible version ... ');

	    select value, substr(value,1,instr(value,'.') - 1)
	    into version, validate
	    from v$parameter
	    where lower(name) = 'compatible';

	    if validate < 10 then
		dbms_output.put_line('Found: ' || version || ' .');
		dbms_output.put_line('===========================================');
		dbms_output.put_line('This fix needs the instance to be at least version 10.0.0.0.0 compatible.');
		goto end_proc;
	    end if;

	    dbms_output.put_line('OK.');

    end if;

    dbms_output.put('Checking procedure TABLESPACE_FIX_SEGMENT_EXTBLKS in package DBMS_SPACE_ADMIN existance ... ');

    select count(*)
    into validate
    from dba_procedures
    where object_name = 'DBMS_SPACE_ADMIN'
    and procedure_name = 'TABLESPACE_FIX_SEGMENT_EXTBLKS';

    if validate = 0 then
	dbms_output.put_line('Procedure does not exists.');
	dbms_output.put_line('===========================================');
	dbms_output.put_line('The process requires the procedure TABLESPACE_FIX_SEGMENT_EXTBLKS in package DBMS_SPACE_ADMIN.');
	dbms_output.put_line('Please execute the script $ORACLE_HOME\rdbms\admin\dbmsspc.sql to verify that you have the mentioned procedure installed');
	goto end_proc;
    end if;

    dbms_output.put_line('OK.');
    dbms_output.put('Checking DBMS_SPACE_ADMIN package status ... ');

    select count(*)
    into validate
    from dba_objects
    where object_name = 'DBMS_SPACE_ADMIN'
    and object_type = 'PACKAGE BODY'
    and status != 'VALID';

    if validate != 0 then
	dbms_output.put_line('Not Valid.');
	dbms_output.put_line('===========================================');
	dbms_output.put_line('The current state of the package is not valid. Make sure that the package is valid and execute fixtbs.sql again.');
	goto end_proc;
    end if;

    dbms_output.put_line('OK.');

    dbms_output.put_line('===========================================');

    for i in (select tablespace_name ts
	      from dba_tablespaces
	      where tablespace_name != 'SYSTEM'
	      and extent_management='LOCAL'
	      and status='ONLINE'
	      and contents='PERMANENT') loop 
    begin 
     dbms_output.put('Fixing '||i.ts||' ... '); 
     execute immediate 'begin dbms_space_admin.TABLESPACE_FIX_SEGMENT_EXTBLKS(:1); end;'
	using i.ts;
     dbms_output.put_line('Fixed.'); 
    exception  
     when others then  
      dbms_output.put_line(dbms_utility.FORMAT_ERROR_STACK); 
    end; 
    end loop; 

    <<end_proc>>
    null;
    end;
/
