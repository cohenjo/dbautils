REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show controlfile record 
REM ------------------------------------------------------------------------

set linesize    80
set pages       100
set feedback    off

col record_size		head "Record size"
col records_total	head "Total"
col records_used	head Used

SELECT type, record_size, records_total, records_used 
FROM v$controlfile_record_section
;

prompt

exit

