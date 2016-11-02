-- This script is called by cleandb and by showunused.
-- It gethers information about large tables
-- and indexes of specified user
-- at which less than 90% of space used.

SET SERVEROUTPUT ON 
set verify off

declare OP1 number;
        TOT_ALLOC number;
        OP3 number;
        UNUSED number;
        OP5 number;
        OP6 number;
        OP7 number;
	user varchar(30);
	tbl varchar(40);
	idx varchar(40);
	pct_unused number;

	CURSOR c1 IS SELECT table_name
		     FROM   dba_tables
		     WHERE  owner=upper('&2') AND initial_extent> 1048576;
	CURSOR c2 IS SELECT index_name
		     FROM   dba_indexes
		     WHERE  owner=upper('&2') AND initial_extent> 1048576;
begin
	OPEN C1;
	user:=upper('&2');
	dbms_output.enable(1000000);
LOOP
	FETCH c1 INTO tbl;
	EXIT WHEN c1%NOTFOUND;
	dbms_space.unused_space(user,tbl,'TABLE',OP1,TOT_ALLOC,OP3,UNUSED,OP5,OP6,OP7); 
	pct_unused:=((UNUSED/TOT_ALLOC)*100);	
	-- insert only those with unused > 90% and allocated > 1M
	if pct_unused>90 and TOT_ALLOC>1048576 then
	   INSERT INTO ops$oracle.uspace_&1
	   VALUES (user,tbl,'TABLE','',(TOT_ALLOC/1024),(UNUSED/1024),pct_unused);
	end if;
END LOOP;
commit;
	CLOSE c1;
--
	OPEN c2;
LOOP
	FETCH c2 INTO idx;
	EXIT WHEN c2%NOTFOUND;
	dbms_space.unused_space(user,idx,'INDEX',OP1,TOT_ALLOC,OP3,UNUSED,OP5,OP6,OP7); 
	pct_unused:=((UNUSED/TOT_ALLOC)*100);	
	-- insert only those with unused > 90% and allocated > 1M
	if pct_unused>90 and TOT_ALLOC>1048576 then
	   INSERT INTO ops$oracle.uspace_&1
	   VALUES (user,idx,'INDEX','',(TOT_ALLOC/1024),(UNUSED/1024),pct_unused);
	end if;
END LOOP;
commit;
	CLOSE c2;
end;
/
begin
        update uspace_&1 u
        set ts_name = (
                select tablespace_name
                from dba_tables
                where u.object_name=table_name
                and u.owner=owner)
        where object_type='TABLE';
        update uspace_&1 u
        set ts_name = (
                select tablespace_name
                from dba_indexes
                where u.object_name=index_name
                and u.owner=owner)
        where object_type='INDEX';
end;
/
exit
/
