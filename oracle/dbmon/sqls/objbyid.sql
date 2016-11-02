REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show object for a given id 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col owner       for a&2         head Owner
col object_name for a30         head Name
col object_id   		head ID
col object_type	for a10 trunc	head Type
col status      for a7          head Status

SELECT owner, object_name, 
       decode(object_type,
                  'DATABASE LINK','DB LINK',
                  'PACKAGE BODY', 'PKG BODY',
              object_type) type, status, created 
FROM dba_objects
WHERE object_id = &1
;

prompt

exit

