REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show processes details
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col PID         for 999 trun
col username    for a17 	head "User Name"
col program     for a38 trunc 	head Program
col terminal	for a10 	head Terminal

SELECT pid, username, program, terminal 
FROM v$process
;

prompt

exit

