SET SERVEROUTPUT ON 
set verify off

declare TOT_BL number;
        TOT_ALLOC number;
        UNUSED_BL number;
        UNUSED number;
        OP5 number;
        OP6 number;
        OP7 number;
	user varchar(20);
	object varchar(40);
	obj_typ varchar(40);
	pct_unused number;
begin
 user:=upper('&2');
 object:=upper('&1');
 obj_typ:=upper('&3');
 dbms_output.enable(1000000);
 dbms_space.unused_space(user,object,obj_typ,TOT_BL,TOT_ALLOC,UNUSED_BL,UNUSED,OP5,OP6,OP7); 
 pct_unused:=round((UNUSED/TOT_ALLOC)*100);	
 dbms_output.put_line('		 ');
 dbms_output.put_line('Space Usage For: '||user||'.'||object);
 dbms_output.put_line('---------------------------------------');
 dbms_output.put_line('Bytes Allocated :	'||round(TOT_ALLOC/1024)||' K');
 dbms_output.put_line('Unused Bytes : 		'||round(UNUSED/1024)||' K');
 dbms_output.put_line('Percent Unused :	'||pct_unused||'%');
end;
/
exit;
/
