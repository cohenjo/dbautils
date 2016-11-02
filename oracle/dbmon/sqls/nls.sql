REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show nls parameters 
REM ------------------------------------------------------------------------

set linesize	96
set pages	100
set feedback    off
set verify 	off

col name	for a30 head Name
col value$	for a30 head Value

SELECT name, value$  
FROM sys.props$
;
prompt 

exit
