REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sga 
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback    off

col bytes for 999,999,999

break on report
compute sum of value on report

SELECT * 
FROM v$sga
;
prompt

exit

