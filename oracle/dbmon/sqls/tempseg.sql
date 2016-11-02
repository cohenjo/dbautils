REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on sys.v_$*
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show temporary tablespace segments
REM ------------------------------------------------------------------------

set linesize    80
set pages       100
set feedback    off
set verify      off

col osuser      for a10 trunc           head "Remote|OS User"
col process     for a9 trunc            head "Remote|Process"
col username    for a20			head "User Name"
col serial#     for 99999 trunc         head SER#

SELECT s.username, u.user, u.tablespace, u.contents, u.extents, u.blocks 
FROM sys.v_$session s, sys.v_$sort_usage u 
WHERE s.saddr = u.session_addr 
; 

SELECT s.osuser, s.process, s.username, s.serial#, 
       sum(u.blocks)*vp.value/1024 "Sort Size" 
FROM sys.v_$session s, sys.v_$sort_usage u, sys.v_$parameter vp 
WHERE s.saddr = u.session_addr 
  AND vp.name = 'db_block_size' 
  AND s.osuser like '&os_user' 
GROUP by s.osuser, s.process, s.username, s.serial#, vp.value 
;

prompt

exit
