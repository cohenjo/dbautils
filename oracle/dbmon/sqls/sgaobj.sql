REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sga objects
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify      off

col owner       for a15         head Owner
col object_name for a30         head Name
col object_type for a10 trunc   head Type
col bytes	for 999,999,999
col percent	for 999		head "%   "

SELECT p1.value*p2.value data_cache_size
FROM v$parameter p1, v$parameter p2
WHERE p1.name='db_block_buffers'
  AND p2.name='db_block_size'
;
prompt


break on report
compute sum of bytes on report

SELECT cache.objd, objs.owner, objs.object_name, objs.object_type,
       (count(*) * 8192) bytes, (count(*) * 819200 / &&data_cache_size) percent
FROM v$bh cache, dba_objects objs
WHERE objs.object_id = cache.objd
GROUP BY cache.objd, objs.owner, objs.object_name, objs.object_type
ORDER BY 3
;
prompt

exit

