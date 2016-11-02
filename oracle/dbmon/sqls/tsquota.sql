REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show users quotas by tablespace
REM ------------------------------------------------------------------------

set linesize    80
set pagesize	9999
set feedback    off

col tablespace_name     for a15		head "TS Name"
col username		for a20 	head "User Name"
col MB  				head "Tot Used|(MB)"
col max_bytes		for 999,999,990	head Quota
col PCT			for 999.9 truncate

set termout off
spool &2

break on tablespace_name

SELECT tablespace_name, username, round(bytes/1024/1024,1) MB,  
       max_bytes, ((bytes/max_bytes)*100) PCT
FROM dba_ts_quotas 
WHERE username not in ('SYS' , 'SYSTEM') 
  AND tablespace_name like upper('&1') 
ORDER BY tablespace_name, bytes desc
;
prompt
spool off

exit

