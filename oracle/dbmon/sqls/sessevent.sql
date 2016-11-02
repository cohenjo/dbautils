REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sessions details
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col SID         	for 999 trunc
col username    	for a&2 	head "User Name"
col event       	for a27 	head Event
col total_waits 	for 99999999	head 'Total|Waits'
col total_timeouts 	for 99999999	head 'Time|Outs'
col time_waited 	for 9999999	head 'Time|Wait'

SELECT  sess.username,
        eve.sid,
        eve.event,
        eve.total_waits,
        eve.total_timeouts,
        eve.time_waited
FROM v$session sess, v$session_event eve
WHERE (eve.sid = sess.sid)
  AND sess.username &1 
ORDER BY time_waited asc
;

prompt

exit

