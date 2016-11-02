REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show system status
REM ------------------------------------------------------------------------

set linesize	96
set pagesize    9999
set feedback	off

col name	for a60	head Name
col value       	head Value

SELECT name, value
FROM v$sysstat
;
prompt

SELECT name, value 
FROM v$sysstat 
WHERE name in ('opened cursors current' ,'redo writes', 'logons current', 'physical writes', 'physical reads' )
;
prompt

exit
