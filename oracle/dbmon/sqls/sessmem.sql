REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sessions memory usage
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col username    for a17                 head "User Name"
col name	for a40			head Name
col value	for 999,999,999,999 	head Value

SELECT username FROM v$session WHERE sid='&1'
;
SELECT name, value 
FROM v$sesstat stat, v$statname name
WHERE stat.sid = '&1'
  AND stat.statistic# = name.statistic#
  AND value > 0 
;

prompt

exit

