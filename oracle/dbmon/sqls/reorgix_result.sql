SET SERVEROUTPUT ON 
set verify off
set echo off

declare OP1 number;
        TOT_ALLOC number;
        OP3 number;
        UNUSED number;
        OP5 number;
        OP6 number;
        OP7 number;
	user varchar(20);
	obj varchar(40);
	tbsp varchar(40);
	obj_typ varchar(10);
	cntr	number;
	pct_unused number;
	CURSOR c1 IS SELECT owner,object_name,object_type,ts_name 
		     FROM USPACEIDX_&1;
begin
	OPEN C1;
	dbms_output.enable(1000000);
	cntr:=0;
LOOP
	FETCH c1 INTO user,obj,obj_typ,tbsp;
	EXIT WHEN c1%NOTFOUND;
	dbms_space.unused_space(user,obj,obj_typ,OP1,TOT_ALLOC,OP3,UNUSED,OP5,OP6,OP7); 
	pct_unused:=((UNUSED/TOT_ALLOC)*100);	
	-- print info:
	if cntr=0 then
		dbms_output.put_line('	');
		dbms_output.put_line('Altered Allocations For '||user);
		dbms_output.put_line('	');
	end if;
	cntr:=cntr+1;
	dbms_output.put_line(obj||'	 Allocated: '||round(TOT_ALLOC/1024)||' K,'||' Unused: '||round((TOT_ALLOC-UNUSED)/1024)||' K,'||' Pct_Unused: '||round(pct_unused)||' %');
END LOOP;
	CLOSE c1;
end;
/
exit
/
