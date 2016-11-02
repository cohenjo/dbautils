REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show datafiles status
REM ------------------------------------------------------------------------

set linesize	110
set pages       100
set feedback	off

col file#	for 99 		head "#"
col status	for a3 trunc	head "Stat"
col name	for a50		head "File Name"
col MB		for 99,999	head "Size (MB)"
col phywrts	for 99,999,999	head "Phy Writes"
col phyrds	for 99,999,999	head "Phy Reads"  
col blkwr	for 99.99 trunc	head "Block|Wr/ms"
col blkrd	for 99.99 trunc	head "Block|Rd/ms"


break on report
compute sum of MB on report
compute sum of phyrds on report
compute sum of phywrts on report

SELECT fs.file#, status, substr(name,1,55) Name, (bytes)/1024/1024 MB,
       phywrts, phyrds, decode(writetim,0,0,(phyblkwrt/writetim)/10) blkwr
FROM v$datafile df, v$filestat fs
WHERE df.file# = fs.file#
UNION
SELECT ts.file#, status, substr(name,1,55) FilePath, (bytes/1024/1024) MB,
       phywrts, phyrds, decode(writetim,0,0,(phyblkwrt/writetim)/10) blkwr
FROM v$tempfile tf, v$tempstat ts
WHERE tf.file# = ts.file#
ORDER by 1, phywrts desc
;
prompt

exit
