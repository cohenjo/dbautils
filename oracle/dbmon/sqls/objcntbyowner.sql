REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show count of objects' type by owner 
REM ------------------------------------------------------------------------

set linesize    96
set pages       999
set feedback    off
set verify 	off

col owner       for a&2         head Owner
col object_type for a20 trunc   head Type

break on owner on object_type

SELECT owner, object_type, count(object_type) Count
FROM dba_objects
WHERE owner &1
GROUP BY owner, object_type
;

prompt

exit

