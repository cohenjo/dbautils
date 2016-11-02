REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show tablespace files
REM ------------------------------------------------------------------------

set linesize	80
set pages       100
set feedback	off

col tablespace_name     for a15         head "TS Name"
col file_name		for a50		head "File Name"
col free_space   	for 9,999.99	head "Free MB"
col MB			for 9,999	head "Tot|(MB)"

break on tablespace_name skip 1
compute sum of MB on tablespace_name

SELECT ddf.tablespace_name, file_name, (sum(dfs.bytes)/1024/1024) free_space,
       (ddf.bytes/1024/1024) MB 
FROM dba_data_files ddf, dba_free_space dfs
WHERE ddf.file_id=dfs.file_id (+)
GROUP BY ddf.tablespace_name, file_name, ddf.bytes 
ORDER BY ddf.tablespace_name 
;
prompt

exit
