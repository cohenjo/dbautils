REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show datafiles status
REM ------------------------------------------------------------------------

set linesize	120
set pages       100
set feedback	off

col file#	for 99 	 		head "#"
col status	for a3 trunc		head "Stat"
col name	for a50			head "File Name"
col MB		for 999,999		head "Size (MB)"
col phywrts	for 9,999,999 trunc 	head "Phy Writes"
col phyrds	for 9,999,999 trunc	head "Phy Reads"  
col blkwr	for 999.99 trunc	head "Block|Wr/ms"
col blkrd	for 999.99 trunc	head "Block|Rd/ms"


break on report
compute sum of MB on report
compute sum of phyrds on report
compute sum of phywrts on report

SELECT fs.file#, status, substr(name,1,55) Name, (bytes)/1024/1024 MB, 
       phywrts, phyrds, decode(writetim,0,0,((phyblkwrt/writetim)/10)) blkwr,
       decode(readtim,0,0,((phyblkrd/readtim)/10)) blkrd
FROM v$datafile df, v$filestat fs
WHERE df.file# = fs.file#
ORDER BY df.file#, phywrts desc
;
prompt

exit
