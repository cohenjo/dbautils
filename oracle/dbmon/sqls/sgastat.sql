REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sga status
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off

col bytes for 999,999,999

break on report
compute sum of bytes on report

SELECT * 
FROM v$sgastat
ORDER by 2
;
prompt

exit

