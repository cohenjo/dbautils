REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tables 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show audit session
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col username    for a17 	head "User Name"
col os_username	for a10		head "Os user"
col sessionid	for 99999	head "Sess ID"
col action_name	for a20		head Action
col terminal	for a10 	head Terminal

SELECT username, os_username, sessionid, action_name, timestamp, terminal 
FROM dba_audit_session
;

prompt

exit

