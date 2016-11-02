REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show database roles 
REM ------------------------------------------------------------------------

set linesize    80
set pagesize    9999
set feedback    off
set verify 	off

col role	for a30	head Role 

SELECT role 
FROM dba_roles 
;
prompt

exit

