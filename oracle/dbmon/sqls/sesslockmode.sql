REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show locking sessions mode 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify      off

col name		for a21		head "Locked Object" 	jus c
col session_id		for 999 	head SID		jus c
col serial#		for 99999 	head SER#
col oracle_username	for a&2 	head "Locking|User" 	jus c
col lock_type		for a20		head "Lock Type"
col mode_held		for a12		head "Mode Held"

prompt Locks
prompt =====
prompt Current Locks
prompt --------------

SELECT a.session_id, b.serial#, a.oracle_username, c.name,
       decode(d.type,
                'MR', 'Media Recovery',
                'RT', 'Redo Thread',
                'UN', 'User Name',
                'TX', 'Transaction',
                'TM', 'DML',
                'UL', 'PL/SQL User Lock',
                'DX', 'Distrib Xaction',
                'CF', 'Control File',
                'IS', 'Instance State',
                'FS', 'File Set',
                'IR', 'Instance Recovery',
                'ST', 'Disk Space Transaction',
                'TS', 'Temp Segment',
                'IV', 'Library Cache Invalidation',
                'LS', 'Log Start or Switch',
                'RW', 'Row Wait',
                'SQ', 'Sequence Number',
                'TE', 'Extend Table',
                'TT', 'Temp Table',
                d.type) lock_type,
         decode(d.lmode,
                0, 'None',           /* Mon Lock equivalent */
                1, 'Null',           /* N */
                2, 'Row-S (SS)',     /* L */
                3, 'Row-X (SX)',     /* R */
                4, 'Share',          /* S */
                5, 'S/Row-X (SSX)',  /* C */
                6, 'Exclusive',      /* X */
                to_char(d.lmode)) mode_held
FROM sys.obj$ c, v$session b, v$locked_object a, sys.v_$lock d
WHERE a.session_id=b.sid 
AND   c.obj#=a.object_id
AND   a.object_id=d.id1
AND   b.sid=d.sid
AND   a.oracle_username &1
AND   a.oracle_username not in ('SYS','SYSTEM')
;
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

