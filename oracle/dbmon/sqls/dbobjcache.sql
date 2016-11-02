REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show database objects cached
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback    off

col type 		for a10 trunc
col loads		for 999 head Loads
col sharable_mem	for 999,999,999	head "Mem Used"
col executions		for 999,999 head Execs

break on report
compute sum of sharable_mem on report

SELECT substr(owner,1,15) Owner, substr(type,1,12) Type, 
       substr(name,1,24) Name, executions, sharable_mem, loads
FROM v$db_object_cache
WHERE (sharable_mem > 999
       OR loads > 1
       OR executions > 10
       OR locks > 0
       OR pins > 0)
AND (type <> 'INVALID TYPE' 
     AND type <> 'NOT LOADED')
ORDER BY sharable_mem
;
prompt

exit
