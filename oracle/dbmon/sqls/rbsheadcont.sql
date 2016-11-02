REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ and dba_* tables
REM ------------------------------------------------------------------------ 
REM PURPOSE:
REM    Show rollback segments header contantion
REM    Any nonzero value in 'Waits' or the 'undo header' indicates contention.
REM    The Ratio of the sum of waits to the sum of gets should be less than 1%,
REM    else, more rollback segments are needed.
REM ------------------------------------------------------------------------ 

set linesize    96
set pages       100
set feedback    off

col name	for a6		head Name
col waits 	for 999         head Waits
col gets        for 9,999,999   head Gets
col ratio 	for .9999	head Ratio

SELECT name, waits, gets, waits/gets ratio
FROM v$rollstat s, v$rollname n
WHERE s.usn = n.usn
;
set heading off
prompt -------------------------------
;
SELECT  'Sum:  ', sum(waits) waits, sum(gets) gets, sum(waits)/sum(gets) ratio
FROM v$rollstat s, v$rollname n
WHERE s.usn = n.usn
;
set heading on

REM SELECT class, count 
REM FROM v$waitstat
REM WHERE class in ('system undo header', 'undo header')
REM ;

prompt

exit

