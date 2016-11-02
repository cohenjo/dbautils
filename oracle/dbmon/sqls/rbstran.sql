REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show rollback segments transactions
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off

col username	for a20		head Username
col name	for a6 		head Name
col sid         for 999 trunc
col serial#     for 99999 trunc head SER#
col osuser      for a10 trunc   head "OS User"
col sql_text    for a60         head "Sql Text"
col extends     for 999         head Ext
col waits       for 999         head Waits

SELECT username, s.sid, serial#, osuser, r.name, x.extends, x.waits 
FROM v$transaction t, v$rollname r, v$session s, v$rollstat x 
WHERE t.addr=s.taddr 
  AND t.xidusn = r.usn
  AND x.usn = r.usn
;

prompt

exit

