-- This script is called by moveix.
-- It checks if the tablespace to move indexes into exists
-- and if the user has quota on it.
-- It creates the definitions of indexes which are not
-- constraints in the tablespace to move indexes from.

SET SERVEROUTPUT ON 
set verify off

declare	iowner varchar(20);
	towner varchar(20);
	userid varchar(20);
	iname varchar(40);
	tname varchar(40);
	tbsp varchar(40);
	colname varchar(40);
	fromtbs	varchar(40);
	totbs	varchar(40);
	totbsp	varchar(40);
	uniq varchar(10);
	numcols number;
	tscount	number;
	constraints number;
	init number;
	next number;

	CURSOR c1 IS SELECT owner,index_name,table_owner,table_name,tablespace_name,uniqueness,initial_extent,next_extent
		     FROM dba_indexes    
		     WHERE tablespace_name=upper('&&fromtbs') and owner=upper('&&userid')
		     and index_name like '%IX';
	CURSOR c2 IS SELECT column_name
		     FROM dba_ind_columns 
		     WHERE index_name=iname AND index_owner=iowner
		     ORDER BY column_position;
begin
	dbms_output.enable(1000000);
	-- first check if totbs really exists	
	totbs:=upper('&totbsp');
	userid:=upper('&userid');
	SELECT count(*)
	into tscount
	FROM dba_tablespaces
	WHERE tablespace_name = totbs;
	if tscount=0 then
	dbms_output.put_line('	');
	dbms_output.put_line('Tablespace '||totbs||' Does Not Exist');
		GOTO endsec;
	end if;
	-- check if user has quota on tablespace
	SELECT count(bytes)
	INTO tscount	
	FROM  dba_ts_quotas WHERE tablespace_name=totbs
	and username=userid;
	if tscount=0 then
	dbms_output.put_line('	');
	dbms_output.put_line(userid||' does not have quota on '||totbs);
		GOTO endsec;
	end if;
	-- begin processing
	OPEN C1;
LOOP
	dbms_output.put_line('	 ');
	FETCH c1 INTO iowner,iname,towner,tname,tbsp,uniq,init,next;
	EXIT WHEN c1%NOTFOUND;
  	-- check if index is a constraint, and exclude it from processing
      SELECT  count(*)
      INTO constraints
      FROM dba_constraints
      WHERE CONSTRAINT_NAME=iname and OWNER=iowner;
        -- proceed if the index is not a constraint
     if constraints = 0 then
	 -- now begins syntax formulation
        if uniq = 'UNIQUE' then
            dbms_output.put_line('create unique index '||iowner||'.'||iname);
        else
            dbms_output.put_line('create index '||iowner||'.'||iname);
        end if;
        dbms_output.put_line('	 on '||towner||'.'||tname);
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
	dbms_output.put_line('tablespace '||totbs);
	dbms_output.put_line('storage (initial '||init/1024||'K');
	dbms_output.put_line('	next     '||next/1024||'K ');
	dbms_output.put_line('	pctincrease     0); ');
	dbms_output.put_line('	 ');
  end if;
END LOOP;
CLOSE c1;
<<endsec>>
null;
end;
/
exit
/
