REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show Statistics on DBWR Checkpoints 
REM    
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

col logon	for 99.99	head "Checkpoints|per Logon  "
col users	for 99.99	head "Checkpoints|per Trans  "
col chkpnt	for 99,999,999	head "DBWR Timeouts"

SELECT c.value chkpnt, (c.value/u.value) users, (c.value/l.value) logon, 
       decode(sign((c.value/u.value)-1),1,'Increase log_checkpoint_interval','OK') "Evaluation"
FROM v$sysstat l, v$sysstat u, v$sysstat c
WHERE l.name = 'logons cumulative'
AND u.name = 'user commits'
AND c.name='DBWR timeouts'
;
prompt

exit
