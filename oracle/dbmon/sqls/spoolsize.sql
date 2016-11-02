SET ECHO off 
REM ------------------------------------------------------------------------ 
REM REQUIREMENTS: 
REM    SELECT on V$ tables 
REM ------------------------------------------------------------------------ 
REM PURPOSE: 
REM    Estimates shared pool utilization  based on current database  
REM    usage. This should be run during peak operation, after all  
REM    stored  objects i.e. packages, views have been loaded.  
REM ------------------------------------------------------------------------ 
REM EXAMPLE: 
REM    Obj mem:         2536573 bytes 
REM    Shared sql:      4101742 bytes 
REM    Cursors:         2125 bytes 
REM    Free memory: 968976 bytes (.92MB) 
REM    Shared pool utilization (total):  7968528 bytes (7.6MB) 
REM    Shared pool allocation (actual):  9000000 bytes (8.58MB) 
REM    Percentage Utilized:  89% 
REM  
REM ------------------------------------------------------------------------ 
REM    You should always run new scripts on a test instance initially. 
REM ------------------------------------------------------------------------ 
REM Main text of script follows: 
 
set echo off  
 
Rem If running MTS uncomment the mts calculation and output  
Rem commands.  
  
set serveroutput on;  
  
declare  
        object_mem number;  
        shared_sql number;  
        cursor_mem number;  
        mts_mem number;  
        used_pool_size number;  
        free_mem number;  
        pool_size varchar2(512); -- same as V$PARAMETER.VALUE  
begin  
  
-- Stored objects (packages, views)  
select sum(sharable_mem) into object_mem from v$db_object_cache;  
  
-- Shared SQL -- need to have additional memory if dynamic SQL used  
select sum(sharable_mem) into shared_sql from v$sqlarea;  
  
-- User Cursor Usage -- run this during peak usage.  
--  assumes 250 bytes per open cursor, for each concurrent user.  
select sum(250*users_opening) into cursor_mem from v$sqlarea;  
  
-- For a test system -- get usage for one user, multiply by # users  
-- select (250 * value) bytes_per_user  
-- from v$sesstat s, v$statname n  
-- where s.statistic# = n.statistic#  
-- and n.name = 'opened cursors current'  
-- and s.sid = 25;  -- where 25 is the sid of the process  
  
-- Free (unused) memory in the SGA: gives an indication of how much memory  
-- is being wasted out of the total allocated.  
select bytes into free_mem from v$sgastat  
        where name = 'free memory';  
  
-- For non-MTS add up object, shared sql, cursors and 20% overhead.  
used_pool_size := round(1.5*(object_mem+shared_sql+cursor_mem));  
  
-- For MTS mts contribution needs to be included (comment out previous line)  
-- used_pool_size := round(1.5*(object_mem+shared_sql+cursor_mem+mts_mem));  
  
select value into pool_size from v$parameter where name='shared_pool_size';  
  
-- Display results  
dbms_output.put_line ('Object mem:    '||to_char (object_mem) || ' bytes');  
dbms_output.put_line ('Shared SQL:    '||to_char (shared_sql) || ' bytes');  
dbms_output.put_line ('Cursors:       '||to_char (cursor_mem) || ' bytes');  
dbms_output.put_line ('Free memory:   '||to_char (free_mem) || ' bytes ' ||  
'('  || to_char(round(free_mem/1024/1024,2)) || 'MB)');  
dbms_output.put_line ('Shared pool utilization (total):  '||  
to_char(used_pool_size) || ' bytes ' || '(' ||  
to_char(round(used_pool_size/1024/1024,2)) || 'MB)');  
dbms_output.put_line ('Shared pool allocation (actual):  '|| pool_size ||' bytes ' || '(' || to_char(round(pool_size/1024/1024,2)) || 'MB)');  
dbms_output.put_line ('Percentage Utilized:  '||to_char  
(round(used_pool_size/pool_size*100)) || '%');  
end;  
/  
exit
/
