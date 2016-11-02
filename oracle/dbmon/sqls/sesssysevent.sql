REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sessions' events
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify      off

col event		for a35
col total_waits		for 999,999,999		head Waits
col total_timeouts	for 9,999,999		head Timeouts
col time_waite	 	for 9,999,999,999	head WaitTime
col average_wait	for 999,999	 	head AvgWait


SELECT * 
FROM v$system_event
ORDER BY total_waits
;
prompt

exit

