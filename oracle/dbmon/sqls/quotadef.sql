REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Give unlimited quota 
REM ------------------------------------------------------------------------

set linesize	80
set pages       0
set head 	off
set verify	off
set wrap	off
set termout	off
set echo	off
set feedback	off

spool &1 

SELECT 'alter user '||username ||' quota unlimited on '||default_tablespace||';'
FROM dba_users 
WHERE username not in ('SYSTEM', 'SYS', 'DBSNMP')
;
spool off

set heading	on
set feedback	on
REM @&1
;
prompt

exit
