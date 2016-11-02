REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show object with a give status
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col owner       for a&2         head Owner
col object_name for a30         head Name
col object_id   		head ID
col object_type	for a10 trunc	head Type

break on owner on report

SELECT owner, object_name,        
       decode(object_type,
                  'DATABASE LINK','DB LINK',
                  'PACKAGE BODY', 'PKG BODY',
              object_type) type, created 
FROM dba_objects
WHERE status='&1'
ORDER BY owner, object_type ,object_name
;

prompt

exit

