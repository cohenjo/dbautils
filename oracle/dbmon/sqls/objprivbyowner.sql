REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show table's privileges
REM ------------------------------------------------------------------------

set linesize    80
set pagesize    9999
set feedback    off
set verify  off

col grantee		for a17
col privilege 		for a10	head Priv
col grantor		for a17
col table_name		for a20
col grantable		for a3	head Able

break on table_name on grantor on grantee 

SELECT table_name, grantor, grantee, privilege, grantable 
FROM dba_tab_privs
WHERE table_name like upper('&1')
  AND owner like upper('&2')
;
prompt

exit

