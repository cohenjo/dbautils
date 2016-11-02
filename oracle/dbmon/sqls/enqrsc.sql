REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show Statistics on enqueue resources 
REM    If Enqueue waits is larger than user commits, then Increase enqueue_resources
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

col logon	for 99.99	head "Enqueue per Logon"
col users	for 99.99	head "Enqueue per Trans"
col enqueue	for 999,999	head "Enqueue Waits"

SELECT e.value enqueue, (e.value/u.value) users, (e.value/l.value) logon, 
       decode(sign((e.value/u.value)-1),1,'Increase enqueue_resources','OK') "Evaluation"
FROM v$sysstat l, v$sysstat u, v$sysstat e
WHERE l.name = 'logons cumulative'
AND u.name = 'user commits'
AND e.name = 'enqueue waits'
;
prompt

exit
