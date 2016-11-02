REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show count of object by type 
REM ------------------------------------------------------------------------

set linesize    96
set pagesize    999
set feedback    off
set verify      off

col object_type for a20 trunc   head Type
col owner       for a20         head Owner

break on object_type on owner

SELECT object_type, owner, count(object_type) Count
FROM dba_objects
WHERE object_type like upper ('&1')
GROUP BY object_type, owner
;

prompt

exit

