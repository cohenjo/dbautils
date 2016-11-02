REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show queuess' average wait
REM    Average wait for queues should be near 0 
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

col "totalq"	for 999,999,999
col "# queued"	for 999,999,999


SELECT paddr, type "Queue type", queued "# queued", wait, totalq, 
       decode(totalq, 0,0,wait/totalq) "AVG WAIT" 
FROM v$queue
;

prompt

exit
