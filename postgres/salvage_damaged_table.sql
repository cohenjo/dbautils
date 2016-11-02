CREATE OR REPLACE FUNCTION salvage_damaged_table(bad_table name) 
returns void 
language plpgsql 
AS $$ 
DECLARE
	bad_table ALIAS FOR $1;
	totpages int;
	tottuples bigint;
	pageno int; 
	tupno int; 
	pos tid; 
BEGIN 
	SELECT relpages, LEAST(reltuples,65535) INTO totpages, tottuples -- tuple number can not be bigger than 65536
	FROM pg_class 
	WHERE relname = quote_ident(bad_table)
	AND relkind = 'r';

	RAISE NOTICE 'totpages %, tottuples %', totpages::text, tottuples::text;

	<<pageloop>> 
	for pageno in 0..totpages loop 
		for tupno in 1..tottuples loop 
			pos = ('(' || pageno || ',' || tupno || ')')::tid; 
			begin 
				insert into salvaged 
				select * 
				from my_bad_table -- <-- Replace with actual table name here.
				where ctid = pos; 
				exception 
				when sqlstate 'XX001' then 
					raise warning 'skipping page %', pageno; 
				continue pageloop; 
				when others then 
					raise warning 'skipping row %, SQLSTATE %', pos, SQLSTATE::text; 
			end; 
		end loop; 
	end loop; 
	RETURN;
end; 
$$; 