#!/usr/bin/ksh 

if [ $# -lt 3 ]
then
  echo "Usage: "
  echo "       imp_db_stats.ksh <stats_table_name> <owner_name/ALL> <stats_source (T/F)>"
  echo "       imp_db_stats.ksh CONV_DB_STATS ALL T "
  echo "       imp_db_stats.ksh IAMPR4_20080403 ALL T"
  exit 1
fi

typeset -u NAME=`echo $1|cut -d. -f1`
typeset -u OWNER=`echo $2|cut -d. -f1`
typeset -u LTYPE=`echo $3|cut -d. -f1`

if [ ${LTYPE} = "T" ]
then
 echo "Checking if Statistics Table Exists:: ${NAME}"
 sqlplus -s / << *EOF* >>/dev/null
 define TABLE_NAME=${NAME}
 set feed off head off pages 3000 linesize 200 echo off verify off
 spool /tmp/check_stats_table.log
 select table_name from dba_tables where table_name = '&TABLE_NAME' and owner = 'SYSTEM';
 spool off
*EOF*
 TMP=`cat /tmp/check_stats_table.log|tr -s " "|sed 's/ //g'`
 if [ ${NAME}"#" != ${TMP}"#" ]
 then
  echo "Statistics Table ${NAME} does not exists "
  exit 1
 fi
elif [ ${LTYPE} = "F" ]
then
 echo "Checking if Filedump of the Statistics Table Exists:: /oravl09/ORACLE/${ORACLE_SID}/export/STATS/${NAME}.dmp" 
 if [ -s /oravl09/ORACLE/${ORACLE_SID}/export/STATS/${NAME}.dmp ]
 then
  sqlplus -s / << *EOF* >>/dev/null
  define STAT_TABLE=${NAME}
  drop table SYSTEM.&STAT_TABLE;
*EOF*
  imp / file=/oravl09/ORACLE/${ORACLE_SID}/export/STATS/${NAME}.dmp log=/oravl09/ORACLE/${ORACLE_SID}/export/STATS/imp_${NAME}.log FULL=y
  else
    echo "Filedump of the Statistics Table /oravl09/ORACLE/${ORACLE_SID}/export/STATS/${NAME}.dmp does not exists "
    exit 1
  fi
else
 echo "Incorrect value in type of import mode"
 exit 1 
fi


stat_sqll_file=/tmp/imp_stat_$$.sql
stat_log_file=/tmp/imp_stat_$$.log

echo "Import of Stats for ${ORACLE_SID} Started at "`date`
rm -rf $stat_sqll_file $stat_log_file

if  [ ${OWNER} = "ALL" ]
then
 sqlplus -s / <<EOF >> $stat_log_file
 set feed off head off pages 3000 linesize 200 echo off verify off
 define STAT_TABLE=${NAME}
 define OWNER=${OWNER}
 spool ${stat_sqll_file}
 PROMPT spool /tmp/imp_stat_owner.log
 select 'exec DBMS_STATS.IMPORT_TABLE_STATS ('''||owner||''' ,'''||table_name||''',stattab =>''&STAT_TABLE'',statown=>''SYSTEM'' );' 
 from dba_tables where owner   like '%WORK' or owner in 'REF_APPL';
 PROMPT spool off
 spool off
 set feed on echo on
 start ${stat_sqll_file} 
EOF
else
 sqlplus -s / <<EOF >> $stat_log_file
 set feed off head off pages 3000 linesize 200 echo off verify off
 define STAT_TABLE=${NAME}
 define OWNER=${OWNER}
 spool ${stat_sqll_file} 
 PROMPT spool /tmp/imp_stat_owner.log
 select 'exec DBMS_STATS.IMPORT_TABLE_STATS ('''||owner||''' ,'''||table_name||''',stattab =>''&STAT_TABLE'',statown=>''SYSTEM'' );' 
 from dba_tables where owner  = '&OWNER';
 PROMPT spool off
 spool off
 set feed on echo on
 start ${stat_sqll_file} 
EOF
fi

counter=`grep ORA- $stat_log_file /tmp/imp_stat_owner.log| wc -l`

if [ ${counter} -gt 0 ]
then
echo "Import of Stats for ${ORACLE_SID} Ended with ${counter} ERRORS at "`date`
else
echo "Import of Stats for ${ORACLE_SID} Ended successfully at "`date`
fi
