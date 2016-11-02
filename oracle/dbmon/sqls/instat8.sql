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
col tranx               for 999999
col miss                for 9.99
col startup_time	for a9 trunc

SELECT sessions_current, sessions_highwater, sga, MB,  
       tranx, miss, startup_time
FROM  v$process, v$license,  v$version, v$database, v$instance,
      (select to_char(startup_time, 'dd mon yyyy hh:mi:ss') 
       from v$instance),
      (select sum(bytes)/1024/1024 MB 
       from v$datafile),
      (select value tranx 
       from v$sysstat 
       where name = 'user commits'),
      (select sum(bytes)/1024/1024 sga 
       from v$sgastat),
      (select sum(reloads)*100/(sum(reloads)+sum(pins)) miss 
       from v$librarycache)
WHERE rownum = 1
;

col users for 99999

select count(*) users from dba_users;

exit
