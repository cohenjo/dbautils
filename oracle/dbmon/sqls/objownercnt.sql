REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show count of object per owner 
REM ------------------------------------------------------------------------

set linesize    96
set pagesize    999
set feedback    off
set verify 	off

col owner       for a20         head Owner

SELECT distinct owner, count(object_id) Count
FROM dba_objects
GROUP BY owner
;

prompt

exit

