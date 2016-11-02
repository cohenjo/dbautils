REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sql cursor, for a given sid 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col sid         for 999 trunc
col serial#     for 99999 trunc 	head SER#
col user_name   for a16                 head "User Name"
col osuser      for a10 trunc		head "OS User"
col sql_text     			head "Sql Text"

SELECT distinct s.sid, serial#, o.user_name, osuser
FROM v$open_cursor o, v$session s 
WHERE o.saddr = s.saddr
AND   s.sid = &1
;

SELECT t.sql_text
FROM v$open_cursor o, v$session s, v$sqltext t
WHERE o.saddr = s.saddr
AND   o.address = t.address
AND   s.sid = &1
ORDER BY t.address, t.piece
;
prompt

exit

