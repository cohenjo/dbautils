REM ------------------------------------------------------------------------
REM REQUIREMENTS:
REM    SELECT on V$ tables
REM ------------------------------------------------------------------------
REM PURPOSE:
REM    Show tablespace status
REM ------------------------------------------------------------------------

set linesize	96
set pages       100
set feedback	off

CREATE table dba_tsps_$$ as
       SELECT tablespace_name,sum(bytes)/1024/1024 MB,0 free,0 Largest,0 ts,0 pct,'0' contents
       FROM dba_data_files f
       GROUP BY tablespace_name;
UPDATE dba_tsps_$$
       SET free=(SELECT sum(f.bytes)/1024/1024
                 FROM dba_free_space f
                 WHERE f.tablespace_name=dba_tsps_$$.tablespace_name);
UPDATE dba_tsps_$$
       SET largest=(SELECT max(f.bytes)/1024
                    FROM dba_free_space f
                    WHERE f.tablespace_name=dba_tsps_$$.tablespace_name);
UPDATE dba_tsps_$$
       SET ts=(SELECT ts#
                FROM sys.ts$ s
                WHERE s.name=dba_tsps_$$.tablespace_name);
UPDATE dba_tsps_$$
       SET pct=(SELECT s.dflextpct
                FROM sys.ts$ s
                WHERE s.name=dba_tsps_$$.tablespace_name);
UPDATE dba_tsps_$$
       SET contents=(SELECT decode(s.contents$, 0, 'P', 1, 'T')
                FROM sys.ts$ s
                WHERE s.name=dba_tsps_$$.tablespace_name) 
;
col MB			for 99,999,999  head "Tot|(MB)"
col free		for 99,999 	head "Free|(MB)"
col Largest 		for 999,999,999 head "Largest   |Extent (K)"
col tablespace_name 	for a20 	head "Tablespace"
col percent 		for a6 		head "% Free"
col ts 			for 99		head "TS#"
col pct			for 99		head "Pct"
col contents		for a3		head "Cnt"

SELECT ts, contents, tablespace_name, MB, free, largest, 
       '  '||round(free/MB*100,0)||'%' percent, pct
FROM dba_tsps_$$
;
DROP table dba_tsps_$$
;
prompt

exit
