REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sql area main executions 
REM ------------------------------------------------------------------------

set linesize	96
set pages	100
set feedback    off
set verify 	off

col text            for	a20	   head Text
col loads           for 9,999      head Loads
col executions      for 999,999    head Exec
col disk_reads      for 9,999,999  head Disk
col buffer_gets     for 9,999,999  head "Buff Gets"
col rows_processed  for	999,999    head Rows
col address 	    for	99999999   head Address

col "Tot SQL run since startup" for 999,999,999
col "SQL executing now"  	for 999,999,999

SELECT sum(executions) "Tot SQL run since startup", 
       sum(users_executing) "SQL executing now"
FROM v$sqlarea
;

SELECT substr(SQL_TEXT,1,20) text, loads, executions, disk_reads, 
       buffer_gets ,rows_processed, address
FROM v$sqlarea
WHERE executions > 1000
AND   rownum < 10
ORDER by executions 
;
prompt 

exit
