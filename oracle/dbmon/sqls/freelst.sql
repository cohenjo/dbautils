REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ and dba_* tables
REM ------------------------------------------------------------------------ 
REM PURPOSE:
REM    Show free list 
REM ------------------------------------------------------------------------ 

set linesize    96
set pages       100
set feedback    off

SELECT sum(value)/100 "1% of total # of requests"
FROM v$sysstat
WHERE name in ('db block gets', 'consistent gets')
;

prompt

exit

