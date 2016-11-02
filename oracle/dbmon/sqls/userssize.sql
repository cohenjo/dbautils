REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show users sizes
REM ------------------------------------------------------------------------

set linesize    80
set pagesize	9999
set feedback    off

col username	for a20		head "User Name"
col MB   	for 999,999.99	head "Tot Used|(MB)"

column name new_value dbname noprint
SELECT name FROM v$database
;
ttitle dbname ' USERS :' skip -
       '============'
btitle off

set termout off
spool &1

SELECT count(*) FROM dba_users
;
ttitle off

SELECT us.name Username, ts.name Tablespace, sum(seg.blocks*ts.blocksize)/1024/1024 MB
FROM sys.ts$ ts,
     sys.user$ us,
     sys.seg$ seg 
WHERE seg.user# = us.user#
  AND ts.ts# = seg.ts#
GROUP BY us.name,ts.name
ORDER BY 3 desc
;
prompt
spool off

exit

