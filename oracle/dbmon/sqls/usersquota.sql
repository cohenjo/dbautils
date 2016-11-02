REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ and dba_ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show users quotas
REM ------------------------------------------------------------------------

set linesize    80
set pagesize	9999
set feedback    off

col username		for a20 head "User Name"
col tablespace_name     for a15 head "TS Name"
col MB  			head "Tot Used|(MB)"

column name new_value dbname noprint
SELECT name FROM v$database
;
ttitle dbname ' USERS :' skip -
       '============'
btitle off

set termout off
spool &1

SELECT count(*) FROM dba_users
;
ttitle off

break on username

SELECT username, tablespace_name, round(bytes/1024/1024,1) MB
FROM dba_ts_quotas 
WHERE username not in ('SYS' , 'SYSTEM') 
ORDER BY username
;
prompt
spool off

exit

