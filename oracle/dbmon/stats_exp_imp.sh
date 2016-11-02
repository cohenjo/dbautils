#!/bin/sh 

Usage()
{
  echo "Usage: $SCRIPT_NAME <-d Database> <-t Table> <-o Owner> <-m MODE (EXP/IMP)>"
}

Table_stats()
{
echo "Statistics Table is:: ${TABLE_NAME}_STS"
sqlplus -s / << *EOF* >>/dev/null
define TABLE_NAME1=${TABLE_NAME}
define OWNER_NAME1=${OWNER_NAME}
define STAT_TABLE=${TABLE_NAME}_STS
set feed off head off pages 3000 linesize 200 echo off verify off
spool /tmp/stats_exp.sql
select 'exec DBMS_STATS.DROP_STAT_TABLE(''OPS\$ORACLE'' ,''&STAT_TABLE'');' from dual;
select 'exec DBMS_STATS.CREATE_STAT_TABLE(''OPS\$ORACLE'' ,''&STAT_TABLE'');' from dual;
select 'exec DBMS_STATS.EXPORT_TABLE_STATS ('''||owner||''' ,'''||table_name||''',stattab =>''&STAT_TABLE'',statown=>''OPS\$ORACLE'' );' from dba_tables where table_name = '&TABLE_NAME1' and owner = '&OWNER_NAME1';
spool off
set feed on echo on
@/tmp/stats_exp.sql
*EOF*
exp / file=${EXP_DUMP_DIR}/exp-${TABLE_NAME}_STS.dmp log=${EXP_DUMP_DIR}/exp-${TABLE_NAME}_STS.log tables=OPS\$ORACLE.${TABLE_NAME}_STS
echo "STATISTICS table export kept at location:" ${EXP_DUMP_DIR}/exp-${TABLE_NAME}_STS.dmp
}

Schema_stats()
{
echo "Statistics Table is:: ${OWNER_NAME}_STS"
sqlplus -s / << *EOF* >>/dev/null
define OWNER_NAME1=${OWNER_NAME}
define STAT_TABLE=${OWNER_NAME}_STS
set feed off head off pages 3000 linesize 200 echo off verify off
spool /tmp/stats_exp.sql
select 'exec DBMS_STATS.DROP_STAT_TABLE(''OPS\$ORACLE'' ,''&STAT_TABLE'');' from dual;
select 'exec DBMS_STATS.CREATE_STAT_TABLE(''OPS\$ORACLE'' ,''&STAT_TABLE'');' from dual;
select 'exec DBMS_STATS.EXPORT_SCHEMA_STATS (''&OWNER_NAME1'' ,''&STAT_TABLE'',NULL,''OPS\$ORACLE'' );' from dual;
spool off
set feed on echo on
@/tmp/stats_exp.sql
*EOF*
exp / file=${EXP_DUMP_DIR}/exp-${OWNER_NAME}_STS.dmp log=${EXP_DUMP_DIR}/exp-${OWNER_NAME}_STS.log tables=OPS\$ORACLE.${OWNER_NAME}_STS
echo "STATISTICS table export kept at location:" ${EXP_DUMP_DIR}/exp-${OWNER_NAME}_STS.dmp
}

Imp_Table_stats()
{
TABLE_NAME2=$1
echo "Importing from Statistics Table:: ${TABLE_NAME2}_STS ........"
sqlplus -s / << *EOF* >>/dev/null
define TABLE_NAME1=${TABLE_NAME}
define OWNER_NAME1=${OWNER_NAME}
define STAT_TABLE=${TABLE_NAME2}_STS
set feed off head off pages 3000 linesize 200 echo off verify off
spool /tmp/stats_imp.sql
select 'exec DBMS_STATS.IMPORT_TABLE_STATS ('''||owner||''' ,'''||table_name||''',stattab =>''&STAT_TABLE'',statown=>''OPS\$ORACLE'' );' from dba_tables where table_name = '&TABLE_NAME1' and owner = '&OWNER_NAME1';
spool off
set feed on echo on
@/tmp/stats_imp.sql
*EOF*
echo "Imported from :: ${TABLE_NAME2}_STS"
}

Imp_Schema_stats()
{
echo "Importing from Statistics Table:: ${OWNER_NAME}_STS ........"
sqlplus -s / << *EOF* >>/dev/null
define OWNER_NAME1=${OWNER_NAME}
define STAT_TABLE=${OWNER_NAME}_STS
set feed off head off pages 3000 linesize 200 echo off verify off
spool /tmp/stats_imp.sql
select 'exec DBMS_STATS.IMPORT_TABLE_STATS ('''||owner||''' ,'''||table_name||''',stattab =>''&STAT_TABLE'',statown=>''OPS\$ORACLE'' );' from dba_tables where owner = '&OWNER_NAME1';
spool off
set feed on echo on
@/tmp/stats_imp.sql
*EOF*
echo "Imported from :: ${OWNER_NAME}_STS"
}

Check_Stats_table()
{
TABLE_NAME3=$1
echo "Checking if Statistics Table Exists:: ${TABLE_NAME3}_STS" 
sqlplus -s / << *EOF* >>/dev/null
define TABLE_NAME1=${TABLE_NAME3}_STS
set feed off head off pages 3000 linesize 200 echo off verify off
spool /tmp/check_stats_table.log
select table_name from dba_tables where table_name = '&TABLE_NAME1' and owner = 'OPS\$ORACLE';
spool off
*EOF*
}

Imp_stats ()
{
STAB_NAME=$1
IMP_TYPE=$2
if [ ${IMP_TYPE} = "SCHEMA" ]
then
 Imp_Schema_stats ${STAB_NAME}
else
 Imp_Table_stats ${STAB_NAME}  
fi
}

check_dump_file ()
{
STAB_NAME=$1
IMP_TYPE=$2
COUNTER=$3

COUNTER=$(( ${COUNTER} + 1 ))
if [ -s ${EXP_DUMP_DIR}/exp-${STAB_NAME}_STS.dmp ]
then
 echo "Would you like to Reload ${STAB_NAME}_STS table from DUMP File ${EXP_DUMP_DIR}/exp-${STAB_NAME}_STS.dmp  (Y,N) ? [N] : \c"
 read yn
 if [ -z "$yn" ]
 then
  yn=N
 fi
 yn=`echo $yn | awk '{print toupper(substr($0,1,1))}'`

 if [  $yn = "N" ]
 then
  Check_Stats_table ${STAB_NAME}
  TMP2=`cat /tmp/check_stats_table.log|tr -s " "|sed 's/ //g'`
  if [ ${STAB_NAME}"_STS#" = ${TMP2}"#" ]
  then
        Imp_stats ${STAB_NAME} ${IMP_TYPE}
  else
        echo "Statistics table ${STAB_NAME}_STS does not exists in the database"
        exit 1
  fi
 fi 
 
 if [ $yn = "Y" ]
 then
  sqlplus -s / << *EOF* >>/dev/null
  define STAT_TABLE=${STAB_NAME}_STS
  drop table ops\$oracle.&STAT_TABLE;
*EOF*
  imp / file=${EXP_DUMP_DIR}/exp-${STAB_NAME}_STS.dmp log=${EXP_DUMP_DIR}/imp-${STAB_NAME}_STS.log FULL=y

  Check_Stats_table ${STAB_NAME}
  TMP2=`cat /tmp/check_stats_table.log|tr -s " "|sed 's/ //g'`
  if [ ${STAB_NAME}"_STS#" = ${TMP2}"#" ]
  then
        Imp_stats ${STAB_NAME} ${IMP_TYPE} ${IMP_TYPE}
  fi
 fi 
else
  Check_Stats_table ${STAB_NAME}
  TMP2=`cat /tmp/check_stats_table.log|tr -s " "|sed 's/ //g'`
  if [ ${STAB_NAME}"_STS#" = ${TMP2}"#" ]
  then
   Imp_stats ${STAB_NAME} ${IMP_TYPE}
  else
  echo $COUNTER ${IMP_TYPE}
   if [ $COUNTER = 2 -a ${IMP_TYPE} = "TABLE" ]
   then
	echo  $OWNER_NAME
   	check_dump_file $OWNER_NAME TABLE 2
   else 
   echo "Statistics table ${STAB_NAME}_STS does not exists in the database"
   exit 1
	fi
  fi
fi
}

#MAIN

SCRIPT_NAME=`basename $0`

while getopts d:t:o:m: opt
do
        case $opt in
                d) DATABASE_NAME=$OPTARG ;;
                t) TABLE_NAME=`awk -v tname=$OPTARG 'BEGIN{ print toupper(tname)}'` ;;
                o) OWNER_NAME=`awk -v oname=$OPTARG 'BEGIN{ print toupper(oname)}'` ;;
                m) MODE=`awk -v mname=$OPTARG 'BEGIN{ print toupper(mname)}'` ;;
            #    h) Usage; exit 1 ;;
            #    *) Usage; exit 1 ;;
        esac
done

#check for validations
if [ $# -lt 3 -o ${DATABASE_NAME}"#" = "#" -o ${OWNER_NAME}"#" = "#" -o ${MODE}"#" = "#" ]
then
        Usage 
        exit 1
fi

echo $ORACLE_SID

if [ ${ORACLE_SID} != ${DATABASE_NAME} ]
then
        Usage
        exit 1       
fi

EXP_DUMP_DIR=/oravl09/ORACLE/${DATABASE_NAME}/export
if [ ${MODE} = "EXP" ]
then
   if [ ${TABLE_NAME}"#" = "#" ]
   then
     Schema_stats
   else
     Table_stats
   fi
elif [ ${MODE} = "IMP" ]
then
   if [ ${TABLE_NAME}"#" = "#" ]
   then
     check_dump_file $OWNER_NAME SCHEMA 1
   else
     check_dump_file $TABLE_NAME TABLE 1
   fi
else
Usage
exit 1
fi
  
