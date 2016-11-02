REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show waits statistics on buffer cache.
REM    free buffer inspected - # of buffers skipped, in order to find free
REM                            buffer, because they are dirty or pinned.
REM    buffer busy waits - waits for buffer to become available.
REM    Free buffer waits - waits after a server can't find a free buffer
REM                        or when the dirty queue is full.
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

col name	for a25 head "Name"
col event       for a25 head "Event"
col total_waits		head "Total Waits"
col time_waited		head "Time Waited"
col average_wait	head "Average Wait"

SELECT name, value 
FROM v$sysstat 
WHERE name='free buffer inspected' 
;

SELECT event, total_waits, time_waited, average_wait
FROM v$system_event 
WHERE event in ('free buffer waits', 'buffer busy waits')
;
prompt

exit
