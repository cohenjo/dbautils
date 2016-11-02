SET ECHO off
REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show users connections 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col username for a&2  head    "User Name"
col sess     for 999  heading "Sessions Per User"

break on report
compute sum of sess on report

SELECT username, count(username) sess
FROM v$session
WHERE username &1
GROUP BY username
ORDER BY sess
;

prompt

exit

