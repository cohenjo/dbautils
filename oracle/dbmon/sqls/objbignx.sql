REM ------------------------------------------------------------------------ 
REM REQUIREMENTS: 
REM    SELECT on dba_ tables 
REM ------------------------------------------------------------------------ 
REM PURPOSE: 
REM    Show object which have next extent larger than a given # of MB
REM ------------------------------------------------------------------------ 
 
set linesize    96
set pages       100
set feedback    off
set verify      off

col owner		for a&4         head Owner
col segment_name	for a28         head Name
col tablespace_name     for a10         head "TS Name"
col segment_type	for a7		head Type
col next_extent		for 99,999,999  head Next
col extents		for 999         head Ext
col bytes               for 99,999,999  head Bytes

SELECT owner, segment_name, tablespace_name, segment_type, next_extent, 
       extents, bytes
FROM dba_segments 
WHERE next_extent/1024/1024 > &1
  AND owner &2
  AND owner not in ('SYS', 'SYSTEM')
  AND segment_type like upper('&3')
  AND tablespace_name != 'RBS'
ORDER BY next_extent
;

prompt

exit

