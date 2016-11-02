REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sessions cpu
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col SID         for 999 trunc
col username    for a&2 		head "User Name"
col value	for 999,999,999,999 	head Value

break on report
compute sum of value on report

SELECT username, sess.sid, value 
FROM v$sesstat stat, v$statname name, v$session sess
WHERE stat.statistic# = '12'
  AND sess.sid = stat.sid 
  AND stat.statistic# = name.statistic#
  AND sess.username &1
  AND value > 0 
ORDER BY 3,1,2
;

prompt

exit

