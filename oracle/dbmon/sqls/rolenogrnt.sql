REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show Which users are not granted a given role 
REM ------------------------------------------------------------------------

set linesize    80
set pagesize    9999
set feedback    off
set verify 	off

SELECT username 
FROM dba_users
WHERE username not in 
   (SELECT grantee 
    FROM dba_role_privs 
    WHERE granted_role like upper('&1'))
;
prompt

exit

