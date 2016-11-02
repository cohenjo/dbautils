-- The script is called by cleandb and by showunused.
-- It creates table,that will contain information
-- about large objects which use less than 10% of the 
-- allocated space.

#set term off
create table uspace_&1 	(owner 		varchar2(30),
			 object_name 	varchar2(30),
			 object_type	varchar2(10),
			 ts_name	varchar2(30),
			 total_bytes 	number,
			 unused_bytes	number,
			 pct_unused	number)
/
grant all on uspace_&1 to public;
/
exit
/  
