REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show ddatabase users 
REM ------------------------------------------------------------------------

set linesize    80
set pagesize	9999
set feedback    off
set verify      off

col username		for a20 head "User Name"
col default_tablespace	for a20 head "Default|Tablespace"
col MB  			head "Tot Used|(MB)"
col QT 			for a13 head "Tot Quota|(MB)"

column name new_value dbname noprint
SELECT name FROM v$database
;
ttitle dbname ' USERS :' skip -
       '============'
btitle off

set termout off
spool &2 

SELECT count(*) FROM dba_users WHERE created > '&1'
;
ttitle off

SELECT u.username, default_tablespace, 
       decode(sign(max_bytes),-1,'Unlimited',0,0,1,round(max_bytes/1024/1024,1)) QT, round(bytes/1024/1024,1) MB, created
FROM dba_users u, dba_ts_quotas q
WHERE u.username = q.username (+) 
AND   u.default_tablespace = q.tablespace_name (+)
AND   created > '&1'
ORDER BY created desc
;
prompt
spool off

exit

