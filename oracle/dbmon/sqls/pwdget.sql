REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Create script for changing user passwords to original passwords 
REM ------------------------------------------------------------------------

set verify off
set feedback off
set echo off
set pagesize 0
set termout off

spool &2\.sql

prompt spool &2\.log
prompt

SELECT 'alter user ' || username || ' identified by values '''|| password ||''';'
FROM dba_users
WHERE username &1
;

prompt spool off
prompt exit

spool off

exit

