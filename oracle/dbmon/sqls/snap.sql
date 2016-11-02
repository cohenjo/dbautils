REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show snapshots 
REM ------------------------------------------------------------------------

set linesize    96
set pagesize    9999
set feedback    off
set verify 	off

col owner		for a15	head Owner
col name		for a25 head Name
col master_owner        for a15 head "Master Owner"
col host		for a12
col last_refresh		head "Last Refresh"	

SELECT distinct s.owner, name, master_owner, host, last_refresh
FROM dba_snapshots s, dba_db_links
WHERE master_owner = username
  AND master_owner like upper('&1')
ORDER BY s.owner, name
;
prompt

exit

