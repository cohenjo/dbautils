REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ and dba_ tables 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show last DDl of users 
REM ------------------------------------------------------------------------

set linesize    80
set pagesize	9999
set feedback    off
set verify      off

col owner		for a20
col last_ddl_time		head "Last DDL"

column name new_value dbname noprint
SELECT name FROM v$database
;
ttitle dbname ' INACTIVE USERS :' skip -
       '===================='
btitle off

set termout off
spool &2 

SELECT  count(distinct owner) number_of_inactive_users
FROM dba_objects 
WHERE last_ddl_time < '&1'
  AND owner not in ('SYSTEM', 'SYS', 'OPS$ORACLE')
;
ttitle off

SELECT owner, max(last_ddl_time) last_ddl_time 
FROM dba_objects 
WHERE last_ddl_time < '&1'
  AND owner not in ('SYSTEM', 'SYS', 'OPS$ORACLE')
GROUP BY owner
ORDER BY last_ddl_time, owner desc
;
prompt
spool off

exit

