REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Create script for user creation
REM ------------------------------------------------------------------------

set verify off
set feedback off
set echo off
set pagesize 0
set termout off

spool &2\.sql

prompt spool &2\.log
prompt
SELECT 'connect '||  u.name ||'/' || u.name || chr(10)||
       ' create database link ' || l.name || chr(10)||
       ' connect to ' || l.USERID || 
       ' identified by ' || l.PASSWORD || chr(10)||
       ' using ''' || l.HOST || ''';'
FROM sys.link$ l, sys.user$ u 
WHERE l.OWNER#=u.USER#
  AND l.OWNER# !=1
  AND u.name &1
;

SELECT 'connect / '|| chr(10)||
       ' create public database link ' || l.name || chr(10) ||
       ' connect to ' || l.USERID || ' identified by ' || chr(10) ||
       l.PASSWORD || ' using ''' || l.HOST || ''';'
FROM sys.link$ l
WHERE  l.OWNER# = 1
;
prompt spool off
prompt exit

spool off

exit
