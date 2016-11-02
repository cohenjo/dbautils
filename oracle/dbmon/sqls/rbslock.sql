SET ECHO off
REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ and dba_* tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show rollback segments locks
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off

col sid 		for 999		head Sid
col serial#		for 99999	head Serial#
col process		for 99999	head Process
col status		for a4		head Stat
col start_time				head "Start time"
col segment_name	for a4 		head Name
col username		for a15 	head "Locking user"
col osuser		for a9 		head "Os user"

SELECT d.segment_name, s.sid, s.serial#, s.process, substr(s.status,1,3) status,
       substr(t.start_time,1,17) start_time, s.username, s.osuser
FROM dba_rollback_segs d, v$session s, v$transaction t, v$rollstat r
WHERE s.saddr = t.ses_addr
AND   t.xidusn = r.usn
AND   ((r.curext = t.start_uext-1)
       OR ((r.curext = r.extents-1)
            AND t.start_uext=0
          )
      )
AND   d.segment_id = r.usn
ORDER BY t.xidusn
;

prompt

exit

