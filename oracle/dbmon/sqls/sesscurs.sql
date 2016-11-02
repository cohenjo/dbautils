REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sql cursors 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col username	for a&2                 head "User Name"
col sid         for 999 trunc
col serial#     for 99999 trunc 	head SER#
col osuser      for a10 trunc		head "OS User"
col sql_text    for a60			head "Sql Text"

break on username on sid on serial# on osuser

SELECT username, s.sid, serial#, osuser, sql_text 
FROM v$open_cursor o, v$session s 
WHERE o.saddr = s.saddr
AND   username &1
ORDER BY user_name, sid, serial#, osuser 
;

prompt

exit

