REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show system privilege 
REM ------------------------------------------------------------------------

set linesize    80
set pagesize    9999
set feedback    off

col grantee		for a30
col granted_role	for a20
col admin_option 	for a8	head ADMIN 

break on privilege

SELECT privilege, grantee, admin_option 
FROM dba_sys_privs
ORDER BY privilege, grantee
;
prompt

exit

