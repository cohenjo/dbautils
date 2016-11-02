REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show licence 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col sid         for 999 trunc

SELECT count(*) processes 
FROM v$process
;
SELECT * 
FROM v$license
;

prompt

exit

