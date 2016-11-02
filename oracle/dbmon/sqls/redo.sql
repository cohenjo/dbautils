REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show redo logs status
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off

col bytes 	for 99,999,999
col member 	for a50

SELECT group#, thread#, sequence#, members, bytes, archived, status 
FROM v$log order by 1,2
;

break on group# skip 1

SELECT * 
FROM v$logfile 
ORDER BY group#,member
;

prompt

exit

