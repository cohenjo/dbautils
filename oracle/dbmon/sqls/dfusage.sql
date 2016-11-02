REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show datafile usage
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

col file#	 for 99 head "#"
col name	 for a50
col free_space	 for 9,999.99 head "Free MB"
col used_space	 for 9,999.99 head "Used MB"
col total_space	 for 9,999 head "Total MB"

SELECT df.file#, substr(df.name,1,55) name,
       (df.bytes/1024/1024) total_space,
       (sum(dfs.bytes)/1024/1024) free_space,
       ((df.bytes/1024/1024) - (sum(dfs.bytes)/1024/1024)) used_space
FROM v$datafile df , dba_free_space dfs
WHERE dfs.file_id (+) =df.file#
GROUP BY df.file# , name, (df.bytes/1024/1024)
;
prompt

exit
