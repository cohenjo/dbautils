REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show options
REM ------------------------------------------------------------------------

set linesize	96
set pages	100
set feedback    off
set verify 	off

col parameter	for a35 trunc
col value	for a7 trunc

SELECT * 
FROM v$option
WHERE parameter like '&1'
ORDER BY parameter
;
prompt 

exit
