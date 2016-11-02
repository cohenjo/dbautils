#!/bin/ksh 
#==========================================================================================================
# Script Name : expdp_schema_backup.sh <SID>
#
# Purpose     : This script goes to <> and backups all schemas that exist in the table EXPDP_INCL;
#
#===========================================================================================================
# Written by  : Anna Aronova 
# Date        : 11/3/2013
#===========================================================================================================


##################################################################
# Check DB Up
##################################################################
CheckDBUP()
{
	#==============================================================================
	#check if database is up
	#==============================================================================
	echo "set pages 0
	set lines 99 
	set feedback off echo off
	select 'DATABASE_UP' DATABASE_UP from dual;
	exit
/
" | sqlplus  / | grep 'DATABASE_UP'| wc -l | {  
while read out; do
if (( $out == 0 ))
then
                echo ERROR: Database $ORACLE_SID is down  | tee -a  $log_file
                exit 1
        fi
        echo SUCCESS: Database $ORACLE_SID is Alive | tee -a  $log_file
done }
}

##################################################################
# Check Table Exists
##################################################################
CheckTableExist()
{
	#==============================================
	#check if the table exists in the database 
	#==============================================
	echo "set pages 0 lines 99 feedback off echo off
	select table_name from user_tables where table_name = '${EXP_TABLE}';
" | sqlplus -s / | grep ${EXP_TABLE} | wc -l | { 
while read TABLE_NAME; do
	if (( $TABLE_NAME == 0 ))
	then
		echo ERROR: ${EXP_TABLE} Entered does not exists in the Database $ORACLE_SID | tee -a  $log_file
		exit 1
	fi
	echo SUCCESS: ${EXP_TABLE} exists in  $ORACLE_SID| tee -a  $log_file
done }
}
##################################################################
# Check Export Directory Exists
##################################################################
CheckExpDir()
{
	#==============================================
	#check if the directory exists in the database 
	#==============================================
	echo "set pages 0 lines 99 feedback off echo off
	select directory_name from dba_directories where directory_name = upper('${DIR}');
" | sqlplus -s / | grep -i ${DIR} | wc -l | { 
while read CHECK_DIR; do
	if (( $CHECK_DIR == 0 ))
	then
		echo ERROR: ${DIR} directory is not defined in the Database $ORACLE_SID | tee -a  $log_file
		exit 1
	fi
	echo SUCCESS: ${DIR} exists in  $ORACLE_SID| tee -a  $log_file
done }
}

##################################################################
# ExpDpSchema
##################################################################
ExpDPSchema()
{
	SCHEMA=$1
	DEGREE=$2
	
	if [ $DEGREE -lt 2 ]
	then
		echo "Running export of ${SCHEMA} with 1 thread "| tee -a  $log_file
		expdp / dumpfile=${SCHEMA}_${DAY}.dp logfile=${SID}_${SCHEMA}_${DAY}.log directory=${DIR} COMPRESSION=ALL SCHEMAS=${SCHEMA}
	else
		echo "Running export of ${SCHEMA} with ${DEGREE} threads "| tee -a  $log_file
		expdp / dumpfile=${SCHEMA}_${DAY}%U.dp logfile=${SID}_${SCHEMA}_${DAY}.log parallel=${DEGREE} directory=${DIR} COMPRESSION=ALL SCHEMAS=${SCHEMA}
	fi

	/bin/gzip ${BCK_DIR}/${SCHEMA}_${DAY}*.dp
	RemoveOldBackup ${SCHEMA}
}
################################################################################
# Remove backup and log files whose modification time is x days age or older 
################################################################################
RemoveOldBackup()
{
 	SCHEMA=$1	

	find ${BCK_DIR} -type f -name "${SCHEMA}*.dp.gz" -mtime +${OLD_AGE} -exec rm {} ';'
	find ${BCK_DIR} -type f -name "${SCHEMA}*.log" -mtime +${OLD_AGE} -exec rm {} ';'
	#find ${BCK_DIR} -type f -name "*.dp.gz" -mtime ${OLD_AGE} -exec echo {} ';'
	#find ${BCK_DIR} -type f -name "*.log" -mtime ${OLD_AGE} -exec echo {} ';'

}
#####################################################################
# Main 
####################################################################
#----------------------------------------------------------------------#
# Check parameters	                                                   #
#----------------------------------------------------------------------#
if [ $# -lt 1 ]
then
   echo "\n Usage: $0 <ORACLE_SID> \n"
   exit 1
fi

#----------------------------------------------------------------------#
# Initializing Variables                                               #
#----------------------------------------------------------------------#
export SID=`echo $1|tr [[:lower:]] [[:upper:]]`
export ORACLE_SID=$SID
#export SID=`echo $1|tr [[:lower:]] [[:upper:]]`
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1
export PATH=${ORACLE_HOME}/bin:${PATH}
export DAY=`date +%Y%m%d_%H%M`
export START_TIME=`date`
export EXP_TABLE=EXPDP_INCL
export ROOT_DIR=/DATA/oradata/EXPDP
export DIR=expdp_backup
export BCK_DIR=${ROOT_DIR}/${SID}/backup
export LOG_DIR=${BCK_DIR}/LOGS
mkdir -p ${BCK_DIR}
mkdir -p ${LOG_DIR}
export log_file=$LOG_DIR/expdp_schema_backup_${SID}_${DAY}.log
rm -f $log_file
export OLD_AGE=2
#----------------------------------------------------------------------#
# Checking if the database is up
#----------------------------------------------------------------------#
echo Checking if the database is up....| tee -a  $log_file
CheckDBUP

#----------------------------------------------------------------------#
# Checking if the database is configured for backup
#----------------------------------------------------------------------#
echo Checking if the database is configured for backup....| tee -a  $log_file
CheckTableExist
CheckExpDir

#----------------------------------------------------------------------#
# echo Starting export of schemas
#----------------------------------------------------------------------#
echo "set echo on feed off pages 0 lines 250 trimsp on verify off
	col schema for a30
	select distinct schema_name schema, degree from ${EXP_TABLE} tb; 
" | sqlplus -s / | while read SCHEMA DEGREE 
	do
		echo "Starting export for $SCHEMA ($DEGREE).." | tee -a $log_file
		ExpDPSchema $SCHEMA $DEGREE
	done
#----------------------------------------------------------------------#
# Move export logs to LOG_DIR
#----------------------------------------------------------------------#
mv $BCK_DIR/*.log $LOG_DIR/ 
#----------------------------------------------------------------------#
# Clean old backups 
#----------------------------------------------------------------------#
RemoveOldBackup

echo ============================================================================================== | tee -a  $log_file
echo START Exporting schemas from $ORACLE_SID  on $START_TIME                         				| tee -a  $log_file
echo END.. Exporting schemas from $ORACLE_SID  on `date`                         					| tee -a  $log_file
echo ============================================================================================== | tee -a  $log_file
echo "LOG_FILE = $log_file "
find ${LOG_DIR} -type f -name "*${SID}*.log" -mtime ${OLD_AGE} -exec rm {} ';'
