REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show objects for a given name  / owner / type
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col owner	for a&4		head Owner
col object_name	for a30		head Name
col object_id			head ID
col type	for a9 trunc	head Type
col status	for a7		head Status

SELECT owner, object_name, 
       decode(object_type,
                  'DATABASE LINK','DB LINK',
                  'PACKAGE BODY', 'PKG BODY',
              object_type) type, status, created
FROM dba_objects
WHERE object_name like upper('&1')
  AND owner &2
  AND object_type like upper('&3')
ORDER BY owner, object_name, object_id 
;

prompt

exit
