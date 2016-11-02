REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show parameters
REM ------------------------------------------------------------------------

set linesize	96
set pages	999
set feedback    off
set verify 	off

col name	for a35 trunc
col value	for a20 trunc
col sess 	for a6		head "Sess|Modif"
col syst	for a10		head "Sys|Modif"

SELECT name, value, isses_modifiable sess, 
       decode(issys_modifiable,'IMMEDIATE','TRUE','FALSE') syst
FROM v$parameter
WHERE name like '&1'
ORDER BY name
;
prompt 

exit
