REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show count of object type 
REM ------------------------------------------------------------------------

set linesize    96
set pagesize    999
set feedback    off
set verify      off

col object_type	for a15	head Type

SELECT distinct object_type, count(object_type) Count
FROM dba_objects
GROUP BY object_type
;

prompt

exit

