REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show table size 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

SELECT COUNT(DISTINCT(SUBSTR(ROWID,10,6))||SUBSTR(ROWID,7,3))* 8192 "Block Used"
FROM &2..&1
; 

prompt

exit
