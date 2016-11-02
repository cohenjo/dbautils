REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Prepare a script for killing sessions 
REM ------------------------------------------------------------------------

set linesize    80
set pages       100
set feedback    off
set verify      off

set verify off
set feedback off
set echo off
set pagesize 0
set termout off

spool &2\.sql

prompt spool &2\.log
prompt
SELECT 'ALTER SYSTEM KILL SESSION ''' || sid ||',' || serial# ||''''
FROM &1
;

prompt spool off
prompt exit

spool off

exit

