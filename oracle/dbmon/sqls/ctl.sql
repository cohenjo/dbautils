REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show control file status
REM ------------------------------------------------------------------------

set linesize    80
set pages       100
set feedback    off

col name	for a44

SELECT * 
FROM v$controlfile
;

prompt

exit

