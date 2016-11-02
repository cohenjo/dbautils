REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show database links 
REM ------------------------------------------------------------------------

set linesize    96
set pagesize    9999
set feedback    off
set verify 	off

col db_link	for a24	head "DB Link" 
col owner	for a15 head Owner
col username	for a15 head "User Name"
col host	for a12

SELECT db_link, owner, username, host, created 
FROM dba_db_links
WHERE owner like upper('&1')
ORDER by 5
;
prompt

exit

