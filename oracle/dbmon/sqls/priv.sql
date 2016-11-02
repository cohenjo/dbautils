REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show privileges
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off
set verify	off

col given_priv   for a50 head "Granted ..."
col grantee      for a20 head "User/Role Name"

break on grantee

SELECT grantee, privilege || ' on ' || owner  || '.' || table_name 
       AS given_priv
FROM dba_tab_privs
WHERE grantee like upper('&1')
UNION ALL
SELECT grantee, privilege || ' (Sys Priv)' AS given_priv
FROM dba_sys_privs
WHERE grantee like upper('&1')
UNION ALL
SELECT grantee, granted_role || ' (Role)' AS given_priv
FROM dba_role_privs
WHERE grantee like upper('&1')
;
prompt

exit
