REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show Statistics on log buffer 
REM    
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

col logon	for 99.99	head "Requests |per Logon"
col users	for 99.99	head "Requests |per Trans"
col redo	for 99,999,999	head "Redo Space Requests"

SELECT r.value redo, (r.value/u.value) users, (r.value/l.value) logon, 
       decode(sign((r.value/u.value)-1),1,'Increase log_buffer','OK') "Evaluation"
FROM v$sysstat l, v$sysstat u, v$sysstat r
WHERE l.name = 'logons cumulative'
AND u.name = 'user commits'
AND r.name='redo log space requests'
;
prompt

exit
