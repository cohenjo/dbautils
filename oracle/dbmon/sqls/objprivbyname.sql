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

col owner		for a17 
col grantee		for a17
col privilege 		for a10	head Priv
col grantor		for a17
col grantable		for a3	head Able

break on owner on grantor on grantee 

SELECT owner, grantor, grantee, privilege, grantable 
FROM dba_tab_privs
WHERE table_name like upper('&1')
  AND owner like upper('&2')
;
prompt

exit

