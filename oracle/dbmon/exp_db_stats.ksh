#!/usr/bin/ksh 

if [ $# -lt 1 ]
then
  echo "Usage: \n      exp_db_stats.ksh <stats_table_name>"
  echo "      exp_db_stats.ksh CONV_DB_STATS"
  echo "      exp_db_stats.ksh IAMPR4_20090403"
  exit 1
fi

typeset -u NAME=`echo $1|cut -d. -f1`

stat_sqll_file=/tmp/exp_stat_$$.sql
stat_log_file=/tmp/exp_stat_$$.log

echo "Export of Stats for ${ORACLE_SID} Started at "`date`
rm -rf $stat_sqll_file
sqlplus -s / <<EOF >> $stat_sqll_file
DROP TABLE SYSTEM.${NAME};
exec dbms_stats.create_stat_table('SYSTEM','${NAME}');
exec dbms_stats.export_database_stats(statown=>'SYSTEM',stattab=>'${NAME}');
EOF

mkdir -p /oravl09/ORACLE/${ORACLE_SID}/export/STATS/

exp / file=/oravl09/ORACLE/${ORACLE_SID}/export/STATS/${NAME}.dmp log=/oravl09/ORACLE/${ORACLE_SID}/export/STATS/${NAME}.log tables=system.${NAME}  

echo "Export Dump of the statistics is kept at: /oravl09/ORACLE/${ORACLE_SID}/export/STATS/${NAME}.dmp" 

echo "Export of Stats for ${ORACLE_SID} Ended  at "`date`

