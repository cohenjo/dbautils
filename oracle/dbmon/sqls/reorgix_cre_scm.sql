SET SERVEROUTPUT ON 
set verify off

declare	iowner varchar(20);
	towner varchar(20);
	iname varchar(40);
	tname varchar(40);
	tbsp varchar(40);
	colname varchar(40);
	oldtbsp	varchar(40);
	uniq varchar(10);
	numcols number;
	tscount	number;
	constraints number;
	used_bytes number;
	len	number;
	init_num number;
 	CURSOR c1 IS SELECT i.owner,i.index_name,i.table_owner,i.table_name,i.tablespace_name,i.uniqueness
		     FROM dba_indexes i, USPACEIDX_&1 u  
		     WHERE i.owner=u.owner and i.index_name=u.object_name;
	CURSOR c2 IS SELECT column_name
		     FROM dba_ind_columns 
		     WHERE index_name=iname AND index_owner=iowner
		     ORDER BY column_position;
begin
	OPEN C1;
	dbms_output.enable(1000000);
LOOP
	FETCH c1 INTO iowner,iname,towner,tname,tbsp,uniq;
	EXIT WHEN c1%NOTFOUND;
  	-- check if index is a constraint, and exclude it from processing
      SELECT  count(*)
      INTO constraints
      FROM DBA_CONSTRAINTS
      WHERE CONSTRAINT_NAME=iname and OWNER=iowner;
        -- proceed if the index is not a constraint
     if constraints = 0 then
	-- calculate new initial storage value
	SELECT TOTAL_BYTES-UNUSED_BYTES 
	INTO used_bytes
	FROM USPACEIDX_&1
	WHERE OBJECT_NAME=iname and OWNER=iowner; 
	if used_bytes = 0 then
		init_num := 16;
	else
		init_num := round(used_bytes*1.1);
	end if;
	-- check if index is in index tablespace, if not, place it there
	len:=length(tbsp);
	if substr(tbsp,len-4)='_DATA' then
		oldtbsp:=tbsp;
		tbsp:=concat(substr(tbsp,0,len-4),'IX');
		-- check if an index tablespace actually exists
		SELECT count(*) 
		into tscount FROM DBA_TABLESPACES
		WHERE TABLESPACE_NAME=tbsp;
		-- if index tablespace does not exist, put it in orig ts
		if tscount=0 then
			tbsp:=oldtbsp;
		end if;
	end if;
	-- begin syntax printout
 -- now begins syntax formulation
        if uniq = 'UNIQUE' then
        dbms_output.put_line('create unique index '||iowner||'.'||iname||' on '||towner||'.'||tname);
        else
        dbms_output.put_line('create index '||iowner||'.'||iname||' on '||towner||'.'||tname);
        end if;
	OPEN c2;
	numcols:=0;
	LOOP
		FETCH c2 INTO colname;
		if c2%NOTFOUND then
			dbms_output.put_line('	)');
			EXIT;
		end if;
		if numcols = 0 then
			dbms_output.put_line('	(');
			dbms_output.put_line('	'||colname);
		else
			dbms_output.put_line('	,'||colname);
		end if;
		numcols := numcols+1;
	END LOOP;
	CLOSE c2;
	dbms_output.put_line('tablespace '||tbsp);
	dbms_output.put_line('storage (initial '||init_num||'K');
	dbms_output.put_line('	next     40K ');
	dbms_output.put_line('	pctincrease     0); ');
	dbms_output.put_line('	 ');
  end if;
END LOOP;
CLOSE c1;
end;
/
exit
/
