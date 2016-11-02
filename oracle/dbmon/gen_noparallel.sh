#!/bin/sh

if [ $# != 1 ]; then
echo " "
      echo "Usage : `basename $0` SID"
echo " "
exit 1
fi

. ~/.profile
export ORACLE_SID=$1 
export DAY=`date +%Y%m%d`
tmp_file=/tmp/no_parallel_$$.sql

sqlplus -s / <<EOF

DEFINE newline=CHR(10)

SET ECHO OFF
SET HEAD OFF
SET FEEDBACK OFF
SET VERIFY OFF

SPOOL $tmp_file
PROMPT spool /oravl01/oracle/dba/LOGS/gen_noparallel_$DAY.log append
select 'alter table '||OWNER||'.'||TABLE_NAME||' noparallel;' from dba_tables where trim(degree) !='1';
PROMPT spool off
SPOOL OFF

SET VERIFY OFF
SET FEEDBACK ON
SET HEAD ON
SET ECHO ON
@$tmp_file
EOF

rm -f $tmp_file
