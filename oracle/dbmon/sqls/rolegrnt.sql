REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show Which users are granted a given role 
REM ------------------------------------------------------------------------

set linesize    80
set pagesize    9999
set feedback    off
set verify 	off

SELECT grantee, admin_option  
FROM dba_role_privs 
WHERE granted_role like upper('&1')
;
prompt

exit

