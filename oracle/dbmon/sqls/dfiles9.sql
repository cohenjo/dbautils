REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show datafile list
REM ------------------------------------------------------------------------

set linesize	80
set pages       100
set feedback	off

col name 	for a50
col MB		for 9,999,999

break on report
compute sum of MB on report

SELECT name, bytes/1024/1024 MB
FROM v$datafile 
UNION
SELECT name, bytes/1024/1024 MB
FROM v$tempfile tf
;
prompt

exit
