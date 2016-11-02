REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show redo log buffer cached
REM    There should be no 'log buffer space' waits.
REM    The 'redo buffer allocation retries' should be near 0. It should
REM    be less than 1% of 'redo entries'.
REM    Else consider increasing log_buffer, moving the redo logs to faster
REM    disks or improving the checkpointing or archiving process.
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off
set verify	off

col name	for a30 head Name
col value		head Value
col event       for a25 head Event

SELECT sid, event, seconds_in_wait, state
FROM v$session_wait
WHERE event = 'log buffer space%'
;

SELECT substr(name,1,30) name, value
FROM v$sysstat 
WHERE name like '%redo%' 
;

SELECT * 
FROM v$system_event 
WHERE event like '%log%' 
ORDER BY AVERAGE_WAIT desc
;

def t=sum(decode(statistic#,107,value,0))
def l=sum(decode(statistic#,97,value,0))
col title1 heading "(a) Redo Log  | Space Requests"
col title2 heading "(b) Redo Entries"
col title3 heading "Space Request    |Ratio(calculated)"
col title4 heading "Explanation"

SELECT  &t title1, &l title2, &t/&l title3, 
        decode(sign((&t*5000/&l)-1),1,'Increase log_buffer ','OK') Evaluation
FROM v$sysstat
;
prompt If a/b > 1/5000 then Increase Log_Buffer

exit
