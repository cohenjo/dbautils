REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM 
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off
set head 	off

col sessions_current    for 999       
col sessions_highwater  for 999      
col sga                 for 9999.9
col MB                  for 999,999
col phyrds              for 99999   
col phywrts             for 99999  
col tranx               for 999999
col miss                for 9.99
col startup_time	for a9 trunc

SELECT count(*) 
FROM dba_tables
WHERE owner='OPS$ORACLE' 
  AND table_name='DBA_EXP'
;
SELECT count(*) 
FROM dba_tables
WHERE owner='OPS$ORACLE' 
  AND table_name='DBA_PROD'
;
SELECT count(*)
FROM  v$database
WHERE log_mode='ARCHIVELOG'
;

exit

