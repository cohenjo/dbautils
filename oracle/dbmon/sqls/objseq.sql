REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on dba_* 
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show sequences' info
REM ------------------------------------------------------------------------

set linesize    80
set pagesize    9999
set feedback    off
set verify  off

col sequence_owner	for a&3 	head Owner
col sequence_name	for a25 	head Name
col min_value 		for 9999	head Min
col max_value				head Max
col increment_by 	for 999999	head Incr	
col last_number		for 9999999999	head Last

break on sequence_owner on sequence_name

SELECT sequence_owner, sequence_name, min_value, max_value, increment_by, 
       last_number 
FROM dba_sequences
WHERE sequence_name like upper('&1')
  AND sequence_owner &2
;
prompt

exit

