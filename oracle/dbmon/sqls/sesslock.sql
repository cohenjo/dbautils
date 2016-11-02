REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show locking sessions 
REM ------------------------------------------------------------------------

set linesize    80
set pages       100
set feedback    off
set verify      off

col session_id          for 999         head SID                jus c
col serial#             for 99999       head SER#
col status	 	for a3 trunc
col oracle_username     for a&2         head "Locking|User"     jus c
col os_user_name 	for a10 	head "Os user"		jus c
col process             for a8          head "Os Proc"          jus c
col name                for a25         head "Locked Object"    jus c

prompt Current Locks
prompt --------------

SELECT a.session_id, b.serial#, b.status, a.oracle_username, a.os_user_name,
       a.process, c.name
FROM sys.obj$ c, v$session b, v$locked_object a
WHERE a.session_id=b.sid 
AND   c.obj#=a.object_id
AND   a.oracle_username &1
;

set head off 
SELECT 'There are also '||count(*)||' transaction locks'
FROM v$transaction_enqueue
;

set head off
prompt
prompt Waiting Sessions
prompt -----------------

SELECT a.sid "Locking Sid",b.sid "Locked Sid"
FROM v$lock a , v$lock b
WHERE a.id1=b.id1
AND   a.id2=b.id2
AND   a.request=0
AND   b.lmode=0
;
prompt

exit

