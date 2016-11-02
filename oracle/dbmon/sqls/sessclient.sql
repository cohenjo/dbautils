REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show clients
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col machine	for a12 		head "Remote|Machine"
col osuser      for a10 trunc           head "Remote|OS User"
col username    for a&2 		head "User Name"
col sid         for 999 trunc
col serial#     for 99999 trunc         head SER#
col process     for a9 trunc            head "Remote|Process"
col spid        for a6 trunc            head "Local|Shadow|Process"
col mint 	for 99999.9 		head "Min.Since"

break on machine on osuser on username

SELECT decode(machine,null,'PC',machine,machine) machine, osuser, sess.username,
       sess.sid, sess.serial#, sess.process, proc.spid, last_call_et/60 mint
FROM v$session sess, v$sesstat stat, v$process proc
WHERE sess.sid = stat.sid 
AND   sess.paddr = proc.addr
AND   stat.statistic# = (SELECT statistic#
                         FROM v$statname
                         WHERE name = 'process last non-idle time')
AND   sess.username &1 
ORDER BY machine, osuser, username, sid
;

prompt

exit

