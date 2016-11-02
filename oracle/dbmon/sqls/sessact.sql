REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show active sessions 
REM ------------------------------------------------------------------------

set linesize    132
set pages       100
set feedback    off
set verify	off

col sid		for 999 trunc 
col serial#	for 99999 trunc	head SER#
col username	for a15 trunc	head "User Name" 
col osuser      for a15 trunc   head "OS User"
col process     for a10         head "Process"      
col program	for a25 trunc	head Program
col command	for 99 trunc	head Command

SELECT distinct sid, serial#, substr(username,1,12) username,
       substr(osuser,1,10) osuser, process, program, command
FROM v$session 
WHERE sid > 7 
  AND status = 'ACTIVE'
  AND username &1 
;

prompt

exit

