REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show jobs details
REM ------------------------------------------------------------------------

set linesize    96
set pages       100
set feedback    off
set verify 	off

col job		for 99999 	head Job 
col log_user    for a&2 	head "User Name"
col last_date			head "Last Date"
col failures	for 999		head Fail 
col what	for a30		head What

SELECT job, log_user, last_date, failures, what 
FROM dba_jobs 
WHERE log_user &1
;

prompt

exit

