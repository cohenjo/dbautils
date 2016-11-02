REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show which privileges are granted to a given role 
REM ------------------------------------------------------------------------

set linesize    80
set pagesize    9999
set feedback    off
set verify 	off

SELECT privilege 
FROM dba_sys_privs 
WHERE grantee like upper('&1')
;
prompt

exit

