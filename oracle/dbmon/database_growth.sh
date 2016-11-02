#!/bin/sh
#*****************************************************************************
#
#  This script is used to create an excel report for iGen IAM database growth
#
#  USAGE: database_growth.sh DAYS DB_NAME
#
#  Default is 31 days and current oracle_sid defined in oraenv
#
#  By Sam Yeoman - Jan 2010
#*****************************************************************************

case $1 in 
[A-Z,a-z]*)	
	typeset -u DB_NAME=$1 ;;
[0-9]*)
	typeset -u DAYS=$1 ;;
esac

case $2 in 
[A-Z,a-z]*)	
	typeset -u DB_NAME=$2 ;;
[0-9]*)
	typeset -u DAYS=$2 ;;
esac

export DATE=`date +%Y%m%d`

if [ -z "$DAYS" ] 
then
        export DAYS="31"
fi

if [ -z "$DB_NAME" ] 
then
        export DB_NAME=`echo $ORACLE_SID | cut -c 1-6`
fi

echo "Running database and tablespace growth report for:" 
echo "Database: $DB_NAME"
echo "Days: $DAYS"
echo "File located at: /oravl09/ORACLE/database_growth_"$DB_NAME"_$DATE.xls"

sqlplus -s dba_stats/TABASOLJ1249@ditoem > /oravl09/ORACLE/database_growth_"$DB_NAME"_$DATE.xls <<EOF
set pages 50000 trimsp on space 0 linesize 50 feedback off verify on heading on markup html on 

SELECT m1.ROLLUP_TIMESTAMP as "DATE",
round(round(m1.AVERAGE,0)/1024,2) as AAM_DATA, 
round(round(m2.AVERAGE,0)/1024,2) as ACMS_DATA,  
round(round(m3.AVERAGE,0)/1024,2) as ADS_DATA,
round(round(m4.AVERAGE,0)/1024,2) as AFL_DATA, 
round(round(m5.AVERAGE,0)/1024,2) as AUDIT_DATA,  
round(round(m6.AVERAGE,0)/1024,2) as AUTHWORK_DATA,
round(round(m7.AVERAGE,0)/1024,2) as BC_ALFRESCO_DATA, 
round(round(m8.AVERAGE,0)/1024,2) as BIL_DATA,  
round(round(m9.AVERAGE,0)/1024,2) as BIL_MASTER_DATA,
round(round(m10.AVERAGE,0)/1024,2) as CGS_DATA, 
round(round(m11.AVERAGE,0)/1024,2) as CYP_DATA,  
round(round(m12.AVERAGE,0)/1024,2) as DLV_DATA,
round(round(m13.AVERAGE,0)/1024,2) as DM_ALFRESCO_DATA,  
round(round(m14.AVERAGE,0)/1024,2) as DM_DATA,
round(round(m15.AVERAGE,0)/1024,2) as EAI_DATA, 
round(round(m16.AVERAGE,0)/1024,2) as EPR_DATA,  
round(round(m17.AVERAGE,0)/1024,2) as HM_DATA,
round(round(m18.AVERAGE,0)/1024,2) as IM_DATA, 
round(round(m19.AVERAGE,0)/1024,2) as NTF_DATA,  
round(round(m20.AVERAGE,0)/1024,2) as OP_DATA,
round(round(m21.AVERAGE,0)/1024,2) as PARAM_DATA, 
round(round(m22.AVERAGE,0)/1024,2) as PDLM_DATA,  
round(round(m23.AVERAGE,0)/1024,2) as PD_DATA,
round(round(m24.AVERAGE,0)/1024,2) as PD_MASTER_DATA,
round(round(m25.AVERAGE,0)/1024,2) as POOL_DATA, 
round(round(m26.AVERAGE,0)/1024,2) as REFCORE_DATA,  
round(round(m27.AVERAGE,0)/1024,2) as REFREAD_DATA,
round(round(m28.AVERAGE,0)/1024,2) as REFWORK_DATA,
round(round(m29.AVERAGE,0)/1024,2) as REFWORK_MASTER_DATA, 
round(round(m30.AVERAGE,0)/1024,2) as REF_APPL_DATA,  
round(round(m31.AVERAGE,0)/1024,2) as REF_APPL_MASTER_DATA,
round(round(m32.AVERAGE,0)/1024,2) as SO_DATA,  
round(round(m33.AVERAGE,0)/1024,2) as SP_DATA,
round(round(m34.AVERAGE,0)/1024,2) as "SYSAUX",
round(round(m35.AVERAGE,0)/1024,2) as "SYSTEM",
round(round(m36.AVERAGE,0)/1024,2) as UAMS_DATA,
round(round((m1.AVERAGE+
m2.AVERAGE+
m3.AVERAGE+
m4.AVERAGE+
m5.AVERAGE+
m6.AVERAGE+
m7.AVERAGE+
m8.AVERAGE+
m9.AVERAGE+
m10.AVERAGE+
m11.AVERAGE+
m12.AVERAGE+
m13.AVERAGE+
m14.AVERAGE+
m15.AVERAGE+
m16.AVERAGE+
m17.AVERAGE+
m18.AVERAGE+
m19.AVERAGE+
m20.AVERAGE+
m21.AVERAGE+
m22.AVERAGE+
m23.AVERAGE+
m24.AVERAGE+
m25.AVERAGE+
m26.AVERAGE+
m27.AVERAGE+
m28.AVERAGE+
m29.AVERAGE+
m30.AVERAGE+
m31.AVERAGE+
m32.AVERAGE+
m33.AVERAGE+
m34.AVERAGE+
m35.AVERAGE+
m36.AVERAGE),0)/1024,2) TOTAL_DB_GB
FROM 
sysman.MGMT\$METRIC_DAILY m1, 
sysman.MGMT\$METRIC_DAILY m2,
sysman.MGMT\$METRIC_DAILY m3,
sysman.MGMT\$METRIC_DAILY m4, 
sysman.MGMT\$METRIC_DAILY m5,
sysman.MGMT\$METRIC_DAILY m6,
sysman.MGMT\$METRIC_DAILY m7, 
sysman.MGMT\$METRIC_DAILY m8,
sysman.MGMT\$METRIC_DAILY m9,
sysman.MGMT\$METRIC_DAILY m10, 
sysman.MGMT\$METRIC_DAILY m11,
sysman.MGMT\$METRIC_DAILY m12,
sysman.MGMT\$METRIC_DAILY m13, 
sysman.MGMT\$METRIC_DAILY m14,
sysman.MGMT\$METRIC_DAILY m15,
sysman.MGMT\$METRIC_DAILY m16, 
sysman.MGMT\$METRIC_DAILY m17,
sysman.MGMT\$METRIC_DAILY m18,
sysman.MGMT\$METRIC_DAILY m19, 
sysman.MGMT\$METRIC_DAILY m20,
sysman.MGMT\$METRIC_DAILY m21,
sysman.MGMT\$METRIC_DAILY m22, 
sysman.MGMT\$METRIC_DAILY m23,
sysman.MGMT\$METRIC_DAILY m24,
sysman.MGMT\$METRIC_DAILY m25, 
sysman.MGMT\$METRIC_DAILY m26,
sysman.MGMT\$METRIC_DAILY m27,
sysman.MGMT\$METRIC_DAILY m28, 
sysman.MGMT\$METRIC_DAILY m29,
sysman.MGMT\$METRIC_DAILY m30,
sysman.MGMT\$METRIC_DAILY m31, 
sysman.MGMT\$METRIC_DAILY m32,
sysman.MGMT\$METRIC_DAILY m33,
sysman.MGMT\$METRIC_DAILY m34,
sysman.MGMT\$METRIC_DAILY m35,
sysman.MGMT\$METRIC_DAILY m36
WHERE
m1.metric_name='tbspAllocation' and m1.TARGET_NAME='$DB_NAME' and m1.KEY_VALUE=upper('AAM_DATA') and m1.metric_column='spaceUsed' and m1.rollup_timestamp>sysdate-('$DAYS') - 1
and m2.metric_name='tbspAllocation' and m2.TARGET_NAME='$DB_NAME' and m2.KEY_VALUE=upper('ACMS_DATA') and m2.metric_column='spaceUsed' and m2.rollup_timestamp>sysdate-('$DAYS') - 1
and m3.metric_name='tbspAllocation' and m3.TARGET_NAME='$DB_NAME' and m3.KEY_VALUE=upper('ADS_DATA') and m3.metric_column='spaceUsed' and m3.rollup_timestamp>sysdate-('$DAYS') - 1
and m4.metric_name='tbspAllocation' and m4.TARGET_NAME='$DB_NAME' and m4.KEY_VALUE=upper('AFL_DATA') and m4.metric_column='spaceUsed' and m4.rollup_timestamp>sysdate-('$DAYS') - 1
and m5.metric_name='tbspAllocation' and m5.TARGET_NAME='$DB_NAME' and m5.KEY_VALUE=upper('AUDIT_DATA') and m5.metric_column='spaceUsed' and m5.rollup_timestamp>sysdate-('$DAYS') - 1
and m6.metric_name='tbspAllocation' and m6.TARGET_NAME='$DB_NAME' and m6.KEY_VALUE=upper('AUTHWORK_DATA') and m6.metric_column='spaceUsed' and m6.rollup_timestamp>sysdate-('$DAYS') - 1
and m7.metric_name='tbspAllocation' and m7.TARGET_NAME='$DB_NAME' and m7.KEY_VALUE=upper('BC_ALFRESCO_DATA') and m7.metric_column='spaceUsed' and m7.rollup_timestamp>sysdate-('$DAYS') - 1
and m8.metric_name='tbspAllocation' and m8.TARGET_NAME='$DB_NAME' and m8.KEY_VALUE=upper('BIL_DATA') and m8.metric_column='spaceUsed' and m8.rollup_timestamp>sysdate-('$DAYS') - 1
and m9.metric_name='tbspAllocation' and m9.TARGET_NAME='$DB_NAME' and m9.KEY_VALUE=upper('BIL_MASTER_DATA') and m9.metric_column='spaceUsed' and m9.rollup_timestamp>sysdate-('$DAYS') - 1
and m10.metric_name='tbspAllocation' and m10.TARGET_NAME='$DB_NAME' and m10.KEY_VALUE=upper('CGS_DATA') and m10.metric_column='spaceUsed' and m10.rollup_timestamp>sysdate-('$DAYS') - 1
and m11.metric_name='tbspAllocation' and m11.TARGET_NAME='$DB_NAME' and m11.KEY_VALUE=upper('CYP_DATA') and m11.metric_column='spaceUsed' and m11.rollup_timestamp>sysdate-('$DAYS') - 1
and m12.metric_name='tbspAllocation' and m12.TARGET_NAME='$DB_NAME' and m12.KEY_VALUE=upper('DLV_DATA') and m12.metric_column='spaceUsed' and m12.rollup_timestamp>sysdate-('$DAYS') - 1
and m13.metric_name='tbspAllocation' and m13.TARGET_NAME='$DB_NAME' and m13.KEY_VALUE=upper('DM_ALFRESCO_DATA') and m13.metric_column='spaceUsed' and m13.rollup_timestamp>sysdate-('$DAYS') - 1
and m14.metric_name='tbspAllocation' and m14.TARGET_NAME='$DB_NAME' and m14.KEY_VALUE=upper('DM_DATA') and m14.metric_column='spaceUsed' and m14.rollup_timestamp>sysdate-('$DAYS') - 1
and m15.metric_name='tbspAllocation' and m15.TARGET_NAME='$DB_NAME' and m15.KEY_VALUE=upper('EAI_DATA') and m15.metric_column='spaceUsed' and m15.rollup_timestamp>sysdate-('$DAYS') - 1
and m16.metric_name='tbspAllocation' and m16.TARGET_NAME='$DB_NAME' and m16.KEY_VALUE=upper('EPR_DATA') and m16.metric_column='spaceUsed' and m16.rollup_timestamp>sysdate-('$DAYS') - 1
and m17.metric_name='tbspAllocation' and m17.TARGET_NAME='$DB_NAME' and m17.KEY_VALUE=upper('HM_DATA') and m17.metric_column='spaceUsed' and m17.rollup_timestamp>sysdate-('$DAYS') - 1
and m18.metric_name='tbspAllocation' and m18.TARGET_NAME='$DB_NAME' and m18.KEY_VALUE=upper('IM_DATA') and m18.metric_column='spaceUsed' and m18.rollup_timestamp>sysdate-('$DAYS') - 1
and m19.metric_name='tbspAllocation' and m19.TARGET_NAME='$DB_NAME' and m19.KEY_VALUE=upper('NTF_DATA') and m19.metric_column='spaceUsed' and m19.rollup_timestamp>sysdate-('$DAYS') - 1
and m20.metric_name='tbspAllocation' and m20.TARGET_NAME='$DB_NAME' and m20.KEY_VALUE=upper('OP_DATA') and m20.metric_column='spaceUsed' and m20.rollup_timestamp>sysdate-('$DAYS') - 1
and m21.metric_name='tbspAllocation' and m21.TARGET_NAME='$DB_NAME' and m21.KEY_VALUE=upper('PARAM_DATA') and m21.metric_column='spaceUsed' and m21.rollup_timestamp>sysdate-('$DAYS') - 1
and m22.metric_name='tbspAllocation' and m22.TARGET_NAME='$DB_NAME' and m22.KEY_VALUE=upper('PDLM_DATA') and m22.metric_column='spaceUsed' and m22.rollup_timestamp>sysdate-('$DAYS') - 1
and m23.metric_name='tbspAllocation' and m23.TARGET_NAME='$DB_NAME' and m23.KEY_VALUE=upper('PD_DATA') and m23.metric_column='spaceUsed' and m23.rollup_timestamp>sysdate-('$DAYS') - 1
and m24.metric_name='tbspAllocation' and m24.TARGET_NAME='$DB_NAME' and m24.KEY_VALUE=upper('PD_MASTER_DATA') and m24.metric_column='spaceUsed' and m24.rollup_timestamp>sysdate-('$DAYS') - 1
and m25.metric_name='tbspAllocation' and m25.TARGET_NAME='$DB_NAME' and m25.KEY_VALUE=upper('POOL_DATA') and m25.metric_column='spaceUsed' and m25.rollup_timestamp>sysdate-('$DAYS') - 1
and m26.metric_name='tbspAllocation' and m26.TARGET_NAME='$DB_NAME' and m26.KEY_VALUE=upper('REFCORE_DATA') and m26.metric_column='spaceUsed' and m26.rollup_timestamp>sysdate-('$DAYS') - 1
and m27.metric_name='tbspAllocation' and m27.TARGET_NAME='$DB_NAME' and m27.KEY_VALUE=upper('REFREAD_DATA') and m27.metric_column='spaceUsed' and m27.rollup_timestamp>sysdate-('$DAYS') - 1
and m28.metric_name='tbspAllocation' and m28.TARGET_NAME='$DB_NAME' and m28.KEY_VALUE=upper('REFWORK_DATA') and m28.metric_column='spaceUsed' and m28.rollup_timestamp>sysdate-('$DAYS') - 1
and m29.metric_name='tbspAllocation' and m29.TARGET_NAME='$DB_NAME' and m29.KEY_VALUE=upper('REFWORK_MASTER_DATA') and m29.metric_column='spaceUsed' and m29.rollup_timestamp>sysdate-('$DAYS') - 1
and m30.metric_name='tbspAllocation' and m30.TARGET_NAME='$DB_NAME' and m30.KEY_VALUE=upper('REF_APPL_DATA') and m30.metric_column='spaceUsed' and m30.rollup_timestamp>sysdate-('$DAYS') - 1
and m31.metric_name='tbspAllocation' and m31.TARGET_NAME='$DB_NAME' and m31.KEY_VALUE=upper('REF_APPL_MASTER_DATA') and m31.metric_column='spaceUsed' and m31.rollup_timestamp>sysdate-('$DAYS') - 1
and m32.metric_name='tbspAllocation' and m32.TARGET_NAME='$DB_NAME' and m32.KEY_VALUE=upper('SO_DATA') and m32.metric_column='spaceUsed' and m32.rollup_timestamp>sysdate-('$DAYS') - 1
and m33.metric_name='tbspAllocation' and m33.TARGET_NAME='$DB_NAME' and m33.KEY_VALUE=upper('SP_DATA') and m33.metric_column='spaceUsed' and m33.rollup_timestamp>sysdate-('$DAYS') - 1
and m34.metric_name='tbspAllocation' and m34.TARGET_NAME='$DB_NAME' and m34.KEY_VALUE=upper('SYSAUX') and m34.metric_column='spaceUsed' and m34.rollup_timestamp>sysdate-('$DAYS') - 1
and m35.metric_name='tbspAllocation' and m35.TARGET_NAME='$DB_NAME' and m35.KEY_VALUE=upper('SYSTEM') and m35.metric_column='spaceUsed' and m35.rollup_timestamp>sysdate-('$DAYS') - 1
and m36.metric_name='tbspAllocation' and m36.TARGET_NAME='$DB_NAME' and m36.KEY_VALUE=upper('UAMS_DATA') and m36.metric_column='spaceUsed' and m36.rollup_timestamp>sysdate-('$DAYS') - 1
and m1.metric_name=m2.metric_name  and m1.TARGET_NAME=m2.TARGET_NAME  and m1.metric_column=m2.metric_column  and m1.rollup_timestamp=m2.rollup_timestamp
and m1.metric_name=m3.metric_name  and m1.TARGET_NAME=m3.TARGET_NAME  and m1.metric_column=m3.metric_column  and m1.rollup_timestamp=m3.rollup_timestamp
and m1.metric_name=m3.metric_name  and m1.TARGET_NAME=m3.TARGET_NAME  and m1.metric_column=m3.metric_column  and m1.rollup_timestamp=m3.rollup_timestamp
and m1.metric_name=m4.metric_name  and m1.TARGET_NAME=m4.TARGET_NAME  and m1.metric_column=m4.metric_column  and m1.rollup_timestamp=m4.rollup_timestamp
and m1.metric_name=m5.metric_name  and m1.TARGET_NAME=m5.TARGET_NAME  and m1.metric_column=m5.metric_column  and m1.rollup_timestamp=m5.rollup_timestamp
and m1.metric_name=m6.metric_name  and m1.TARGET_NAME=m6.TARGET_NAME  and m1.metric_column=m6.metric_column  and m1.rollup_timestamp=m6.rollup_timestamp
and m1.metric_name=m7.metric_name  and m1.TARGET_NAME=m7.TARGET_NAME  and m1.metric_column=m7.metric_column  and m1.rollup_timestamp=m7.rollup_timestamp
and m1.metric_name=m8.metric_name  and m1.TARGET_NAME=m8.TARGET_NAME  and m1.metric_column=m8.metric_column  and m1.rollup_timestamp=m8.rollup_timestamp
and m1.metric_name=m9.metric_name  and m1.TARGET_NAME=m9.TARGET_NAME  and m1.metric_column=m9.metric_column  and m1.rollup_timestamp=m9.rollup_timestamp
and m1.metric_name=m10.metric_name and m1.TARGET_NAME=m10.TARGET_NAME and m1.metric_column=m10.metric_column and m1.rollup_timestamp=m10.rollup_timestamp
and m1.metric_name=m11.metric_name and m1.TARGET_NAME=m11.TARGET_NAME and m1.metric_column=m11.metric_column and m1.rollup_timestamp=m11.rollup_timestamp
and m1.metric_name=m12.metric_name and m1.TARGET_NAME=m12.TARGET_NAME and m1.metric_column=m12.metric_column and m1.rollup_timestamp=m12.rollup_timestamp
and m1.metric_name=m13.metric_name and m1.TARGET_NAME=m13.TARGET_NAME and m1.metric_column=m13.metric_column and m1.rollup_timestamp=m13.rollup_timestamp
and m1.metric_name=m14.metric_name and m1.TARGET_NAME=m14.TARGET_NAME and m1.metric_column=m14.metric_column and m1.rollup_timestamp=m14.rollup_timestamp
and m1.metric_name=m15.metric_name and m1.TARGET_NAME=m15.TARGET_NAME and m1.metric_column=m15.metric_column and m1.rollup_timestamp=m15.rollup_timestamp
and m1.metric_name=m16.metric_name and m1.TARGET_NAME=m16.TARGET_NAME and m1.metric_column=m16.metric_column and m1.rollup_timestamp=m16.rollup_timestamp
and m1.metric_name=m17.metric_name and m1.TARGET_NAME=m17.TARGET_NAME and m1.metric_column=m17.metric_column and m1.rollup_timestamp=m17.rollup_timestamp
and m1.metric_name=m18.metric_name and m1.TARGET_NAME=m18.TARGET_NAME and m1.metric_column=m18.metric_column and m1.rollup_timestamp=m18.rollup_timestamp
and m1.metric_name=m19.metric_name and m1.TARGET_NAME=m19.TARGET_NAME and m1.metric_column=m19.metric_column and m1.rollup_timestamp=m19.rollup_timestamp
and m1.metric_name=m20.metric_name and m1.TARGET_NAME=m20.TARGET_NAME and m1.metric_column=m20.metric_column and m1.rollup_timestamp=m20.rollup_timestamp
and m1.metric_name=m21.metric_name and m1.TARGET_NAME=m21.TARGET_NAME and m1.metric_column=m21.metric_column and m1.rollup_timestamp=m21.rollup_timestamp
and m1.metric_name=m22.metric_name and m1.TARGET_NAME=m22.TARGET_NAME and m1.metric_column=m22.metric_column and m1.rollup_timestamp=m22.rollup_timestamp
and m1.metric_name=m23.metric_name and m1.TARGET_NAME=m23.TARGET_NAME and m1.metric_column=m23.metric_column and m1.rollup_timestamp=m23.rollup_timestamp
and m1.metric_name=m24.metric_name and m1.TARGET_NAME=m24.TARGET_NAME and m1.metric_column=m24.metric_column and m1.rollup_timestamp=m24.rollup_timestamp
and m1.metric_name=m25.metric_name and m1.TARGET_NAME=m25.TARGET_NAME and m1.metric_column=m25.metric_column and m1.rollup_timestamp=m25.rollup_timestamp
and m1.metric_name=m26.metric_name and m1.TARGET_NAME=m26.TARGET_NAME and m1.metric_column=m26.metric_column and m1.rollup_timestamp=m26.rollup_timestamp
and m1.metric_name=m26.metric_name and m1.TARGET_NAME=m26.TARGET_NAME and m1.metric_column=m26.metric_column and m1.rollup_timestamp=m26.rollup_timestamp
and m1.metric_name=m27.metric_name and m1.TARGET_NAME=m27.TARGET_NAME and m1.metric_column=m27.metric_column and m1.rollup_timestamp=m27.rollup_timestamp
and m1.metric_name=m28.metric_name and m1.TARGET_NAME=m28.TARGET_NAME and m1.metric_column=m28.metric_column and m1.rollup_timestamp=m28.rollup_timestamp
and m1.metric_name=m29.metric_name and m1.TARGET_NAME=m29.TARGET_NAME and m1.metric_column=m29.metric_column and m1.rollup_timestamp=m29.rollup_timestamp
and m1.metric_name=m30.metric_name and m1.TARGET_NAME=m30.TARGET_NAME and m1.metric_column=m30.metric_column and m1.rollup_timestamp=m30.rollup_timestamp
and m1.metric_name=m31.metric_name and m1.TARGET_NAME=m31.TARGET_NAME and m1.metric_column=m31.metric_column and m1.rollup_timestamp=m31.rollup_timestamp
and m1.metric_name=m32.metric_name and m1.TARGET_NAME=m32.TARGET_NAME and m1.metric_column=m32.metric_column and m1.rollup_timestamp=m32.rollup_timestamp
and m1.metric_name=m33.metric_name and m1.TARGET_NAME=m33.TARGET_NAME and m1.metric_column=m33.metric_column and m1.rollup_timestamp=m33.rollup_timestamp
and m1.metric_name=m34.metric_name and m1.TARGET_NAME=m34.TARGET_NAME and m1.metric_column=m34.metric_column and m1.rollup_timestamp=m34.rollup_timestamp
and m1.metric_name=m35.metric_name and m1.TARGET_NAME=m35.TARGET_NAME and m1.metric_column=m35.metric_column and m1.rollup_timestamp=m35.rollup_timestamp
and m1.metric_name=m36.metric_name and m1.TARGET_NAME=m36.TARGET_NAME and m1.metric_column=m36.metric_column and m1.rollup_timestamp=m36.rollup_timestamp
ORDER BY 1 ;

break on report

  SELECT /*+ use_nl(m1a,m2a,m3a,m4a,m5a,m6a,m7a,m8a,m9a,m10a,m11a,m12a,m13a,m14a,m15a,m16a,m17a,m18a,m19a,m20a,m21a,m22a,m23a,m24a,m25a,m26a,m27a,m28a,m29a,m30a,m31a,m32a,m33a,m34a,m35a,m36a,m1b,m2b,m3b,m4b,m5b,m6b,m7b,m8b,m9b,m10b,m11b,m12b,m13b,m14b,m15b,m16b,m17b,m18b,m19b,m20b,m21b,m22b,m23b,m24b,m25b,m26b,m27b,m28b,m29b,m30b,m31b,m32b,m33b,m34b,m35b,m36b) */
'GB GROWTH FOR $DAYS DAYS' as " ",
round(round((m1a.average-m1b.average),0)/1024,2) as AAM_DATA,
round(round((m2a.average-m2b.average),0)/1024,2) as ACMS_DATA,
round(round((m3a.AVERAGE-m3b.AVERAGE),0)/1024,2) as ADS_DATA,
round(round((m4a.AVERAGE-m4b.AVERAGE),0)/1024,2) as AFL_DATA,
round(round((m5a.AVERAGE-m5b.AVERAGE),0)/1024,2) as AUDIT_DATA,
round(round((m6a.AVERAGE-m6b.AVERAGE),0)/1024,2) as AUTHWORK_DATA,
round(round((m7a.AVERAGE-m7b.AVERAGE),0)/1024,2) as BC_ALFRESCO_DATA,
round(round((m8a.AVERAGE-m8b.AVERAGE),0)/1024,2) as BIL_DATA,
round(round((m9a.AVERAGE-m9b.AVERAGE),0)/1024,2) as BIL_MASTER_DATA,
round(round((m10a.AVERAGE-m10b.AVERAGE),0)/1024,2) as CGS_DATA,
round(round((m11a.AVERAGE-m11b.AVERAGE),0)/1024,2) as CYP_DATA,
round(round((m12a.AVERAGE-m12b.AVERAGE),0)/1024,2) as DLV_DATA,
round(round((m13a.AVERAGE-m13b.AVERAGE),0)/1024,2) as DM_ALFRESCO_DATA,
round(round((m14a.AVERAGE-m14b.AVERAGE),0)/1024,2) as DM_DATA,
round(round((m15a.AVERAGE-m15b.AVERAGE),0)/1024,2) as EAI_DATA,
round(round((m16a.AVERAGE-m16b.AVERAGE),0)/1024,2) as EPR_DATA,
round(round((m17a.AVERAGE-m17b.AVERAGE),0)/1024,2) as HM_DATA,
round(round((m18a.AVERAGE-m18b.AVERAGE),0)/1024,2) as IM_DATA,
round(round((m19a.AVERAGE-m19b.AVERAGE),0)/1024,2) as NTF_DATA,
round(round((m20a.AVERAGE-m20b.AVERAGE),0)/1024,2) as OP_DATA,
round(round((m21a.AVERAGE-m21b.AVERAGE),0)/1024,2) as PARAM_DATA,
round(round((m22a.AVERAGE-m22b.AVERAGE),0)/1024,2) as PDLM_DATA,
round(round((m23a.AVERAGE-m23b.AVERAGE),0)/1024,2) as PD_DATA,
round(round((m24a.AVERAGE-m24b.AVERAGE),0)/1024,2) as PD_MASTER_DATA,
round(round((m25a.AVERAGE-m25b.AVERAGE),0)/1024,2) as POOL_DATA,
round(round((m26a.AVERAGE-m26b.AVERAGE),0)/1024,2) as REFCORE_DATA,
round(round((m27a.AVERAGE-m27b.AVERAGE),0)/1024,2) as REFREAD_DATA,
round(round((m28a.AVERAGE-m28b.AVERAGE),0)/1024,2) as REFWORK_DATA,
round(round((m29a.AVERAGE-m29b.AVERAGE),0)/1024,2) as REFWORK_MASTER_DATA,
round(round((m30a.AVERAGE-m30b.AVERAGE),0)/1024,2) as REF_APPL_DATA,
round(round((m31a.AVERAGE-m31b.AVERAGE),0)/1024,2) as REF_APPL_MASTER_DATA,
round(round((m32a.AVERAGE-m32b.AVERAGE),0)/1024,2) as SO_DATA,
round(round((m33a.AVERAGE-m33b.AVERAGE),0)/1024,2) as SP_DATA,
round(round((m34a.AVERAGE-m34b.AVERAGE),0)/1024,2) as "SYSAUX",
round(round((m35a.AVERAGE-m35b.AVERAGE),0)/1024,2) as "SYSTEM",
round(round((m36a.AVERAGE-m36b.AVERAGE),0)/1024,2) as UAMS_DATA,
round(round(round((m1a.average-m1b.average),0) +
round((m2a.average-m2b.average),0) +
round((m3a.AVERAGE-m3b.AVERAGE),0) +
round((m4a.AVERAGE-m4b.AVERAGE),0) +
round((m5a.AVERAGE-m5b.AVERAGE),0) +
round((m6a.AVERAGE-m6b.AVERAGE),0) +
round((m7a.AVERAGE-m7b.AVERAGE),0) +
round((m8a.AVERAGE-m8b.AVERAGE),0) +
round((m9a.AVERAGE-m9b.AVERAGE),0) +
round((m10a.AVERAGE-m10b.AVERAGE),0)+
round((m11a.AVERAGE-m11b.AVERAGE),0)+
round((m12a.AVERAGE-m12b.AVERAGE),0)+
round((m13a.AVERAGE-m13b.AVERAGE),0)+
round((m14a.AVERAGE-m14b.AVERAGE),0)+
round((m15a.AVERAGE-m15b.AVERAGE),0)+
round((m16a.AVERAGE-m16b.AVERAGE),0)+
round((m17a.AVERAGE-m17b.AVERAGE),0)+
round((m18a.AVERAGE-m18b.AVERAGE),0)+
round((m19a.AVERAGE-m19b.AVERAGE),0)+
round((m20a.AVERAGE-m20b.AVERAGE),0)+
round((m21a.AVERAGE-m21b.AVERAGE),0)+
round((m22a.AVERAGE-m22b.AVERAGE),0)+
round((m23a.AVERAGE-m23b.AVERAGE),0)+
round((m24a.AVERAGE-m24b.AVERAGE),0)+
round((m25a.AVERAGE-m25b.AVERAGE),0)+
round((m26a.AVERAGE-m26b.AVERAGE),0)+
round((m27a.AVERAGE-m27b.AVERAGE),0)+
round((m28a.AVERAGE-m28b.AVERAGE),0)+
round((m29a.AVERAGE-m29b.AVERAGE),0)+
round((m30a.AVERAGE-m30b.AVERAGE),0)+
round((m31a.AVERAGE-m31b.AVERAGE),0)+
round((m32a.AVERAGE-m32b.AVERAGE),0)+
round((m33a.AVERAGE-m33b.AVERAGE),0)+
round((m34a.AVERAGE-m34b.AVERAGE),0)+
round((m35a.AVERAGE-m35b.AVERAGE),0)+
round((m36a.AVERAGE-m36b.AVERAGE),0),0)/1024,2) TOTAL_DB
    FROM    
sysman.MGMT\$METRIC_DAILY m1a, sysman.MGMT\$METRIC_DAILY m1b,
sysman.MGMT\$METRIC_DAILY m2a, sysman.MGMT\$METRIC_DAILY m2b,
sysman.MGMT\$METRIC_DAILY m3a, sysman.MGMT\$METRIC_DAILY m3b,
sysman.MGMT\$METRIC_DAILY m4a, sysman.MGMT\$METRIC_DAILY m4b, 
sysman.MGMT\$METRIC_DAILY m5a, sysman.MGMT\$METRIC_DAILY m5b,
sysman.MGMT\$METRIC_DAILY m6a, sysman.MGMT\$METRIC_DAILY m6b,
sysman.MGMT\$METRIC_DAILY m7a, sysman.MGMT\$METRIC_DAILY m7b, 
sysman.MGMT\$METRIC_DAILY m8a, sysman.MGMT\$METRIC_DAILY m8b,
sysman.MGMT\$METRIC_DAILY m9a, sysman.MGMT\$METRIC_DAILY m9b,
sysman.MGMT\$METRIC_DAILY m10a, sysman.MGMT\$METRIC_DAILY m10b, 
sysman.MGMT\$METRIC_DAILY m11a, sysman.MGMT\$METRIC_DAILY m11b,
sysman.MGMT\$METRIC_DAILY m12a, sysman.MGMT\$METRIC_DAILY m12b,
sysman.MGMT\$METRIC_DAILY m13a, sysman.MGMT\$METRIC_DAILY m13b, 
sysman.MGMT\$METRIC_DAILY m14a, sysman.MGMT\$METRIC_DAILY m14b,
sysman.MGMT\$METRIC_DAILY m15a, sysman.MGMT\$METRIC_DAILY m15b,
sysman.MGMT\$METRIC_DAILY m16a, sysman.MGMT\$METRIC_DAILY m16b, 
sysman.MGMT\$METRIC_DAILY m17a, sysman.MGMT\$METRIC_DAILY m17b,
sysman.MGMT\$METRIC_DAILY m18a, sysman.MGMT\$METRIC_DAILY m18b,
sysman.MGMT\$METRIC_DAILY m19a, sysman.MGMT\$METRIC_DAILY m19b, 
sysman.MGMT\$METRIC_DAILY m20a, sysman.MGMT\$METRIC_DAILY m20b,
sysman.MGMT\$METRIC_DAILY m21a, sysman.MGMT\$METRIC_DAILY m21b,
sysman.MGMT\$METRIC_DAILY m22a, sysman.MGMT\$METRIC_DAILY m22b, 
sysman.MGMT\$METRIC_DAILY m23a, sysman.MGMT\$METRIC_DAILY m23b,
sysman.MGMT\$METRIC_DAILY m24a, sysman.MGMT\$METRIC_DAILY m24b,
sysman.MGMT\$METRIC_DAILY m25a, sysman.MGMT\$METRIC_DAILY m25b, 
sysman.MGMT\$METRIC_DAILY m26a, sysman.MGMT\$METRIC_DAILY m26b,
sysman.MGMT\$METRIC_DAILY m27a, sysman.MGMT\$METRIC_DAILY m27b,
sysman.MGMT\$METRIC_DAILY m28a, sysman.MGMT\$METRIC_DAILY m28b, 
sysman.MGMT\$METRIC_DAILY m29a, sysman.MGMT\$METRIC_DAILY m29b,
sysman.MGMT\$METRIC_DAILY m30a, sysman.MGMT\$METRIC_DAILY m30b,
sysman.MGMT\$METRIC_DAILY m31a, sysman.MGMT\$METRIC_DAILY m31b, 
sysman.MGMT\$METRIC_DAILY m32a, sysman.MGMT\$METRIC_DAILY m32b,
sysman.MGMT\$METRIC_DAILY m33a, sysman.MGMT\$METRIC_DAILY m33b,
sysman.MGMT\$METRIC_DAILY m34a, sysman.MGMT\$METRIC_DAILY m34b,
sysman.MGMT\$METRIC_DAILY m35a, sysman.MGMT\$METRIC_DAILY m35b,
sysman.MGMT\$METRIC_DAILY m36a, sysman.MGMT\$METRIC_DAILY m36b
   WHERE     
       m1a.metric_name = 'tbspAllocation' AND m1a.TARGET_NAME = '$DB_NAME' AND m1a.metric_column = 'spaceUsed' AND m1a.rollup_timestamp = trunc(SYSDATE) - 1 AND m1b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m1a.KEY_VALUE='AAM_DATA' 
   AND m2a.metric_name = 'tbspAllocation' AND m2a.TARGET_NAME = '$DB_NAME' AND m2a.metric_column = 'spaceUsed' AND m2a.rollup_timestamp = trunc(SYSDATE) - 1 AND m2b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m2a.KEY_VALUE='ACMS_DATA'
   AND m3a.metric_name = 'tbspAllocation' AND m3a.TARGET_NAME = '$DB_NAME' AND m3a.metric_column = 'spaceUsed' AND m3a.rollup_timestamp = trunc(SYSDATE) - 1 AND m3b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m3a.KEY_VALUE='ADS_DATA' 
   AND m4a.metric_name = 'tbspAllocation' AND m4a.TARGET_NAME = '$DB_NAME' AND m4a.metric_column = 'spaceUsed' AND m4a.rollup_timestamp = trunc(SYSDATE) - 1 AND m4b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m4a.KEY_VALUE='AFL_DATA' 
   AND m5a.metric_name = 'tbspAllocation' AND m5a.TARGET_NAME = '$DB_NAME' AND m5a.metric_column = 'spaceUsed' AND m5a.rollup_timestamp = trunc(SYSDATE) - 1 AND m5b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m5a.KEY_VALUE='AUDIT_DATA' 
   AND m6a.metric_name = 'tbspAllocation' AND m6a.TARGET_NAME = '$DB_NAME' AND m6a.metric_column = 'spaceUsed' AND m6a.rollup_timestamp = trunc(SYSDATE) - 1 AND m6b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m6a.KEY_VALUE='AUTHWORK_DATA' 
   AND m7a.metric_name = 'tbspAllocation' AND m7a.TARGET_NAME = '$DB_NAME' AND m7a.metric_column = 'spaceUsed' AND m7a.rollup_timestamp = trunc(SYSDATE) - 1 AND m7b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m7a.KEY_VALUE='BC_ALFRESCO_DATA' 
   AND m8a.metric_name = 'tbspAllocation' AND m8a.TARGET_NAME = '$DB_NAME' AND m8a.metric_column = 'spaceUsed' AND m8a.rollup_timestamp = trunc(SYSDATE) - 1 AND m8b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m8a.KEY_VALUE='BIL_DATA' 
   AND m9a.metric_name = 'tbspAllocation' AND m9a.TARGET_NAME = '$DB_NAME' AND m9a.metric_column = 'spaceUsed' AND m9a.rollup_timestamp = trunc(SYSDATE) - 1 AND m9b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m9a.KEY_VALUE='BIL_MASTER_DATA' 
   AND m10a.metric_name = 'tbspAllocation' AND m10a.TARGET_NAME = '$DB_NAME' AND m10a.metric_column = 'spaceUsed' AND m10a.rollup_timestamp = trunc(SYSDATE) - 1 AND m10b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m10a.KEY_VALUE='CGS_DATA' 
   AND m11a.metric_name = 'tbspAllocation' AND m11a.TARGET_NAME = '$DB_NAME' AND m11a.metric_column = 'spaceUsed' AND m11a.rollup_timestamp = trunc(SYSDATE) - 1 AND m11b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m11a.KEY_VALUE='CYP_DATA' 
   AND m12a.metric_name = 'tbspAllocation' AND m12a.TARGET_NAME = '$DB_NAME' AND m12a.metric_column = 'spaceUsed' AND m12a.rollup_timestamp = trunc(SYSDATE) - 1 AND m12b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m12a.KEY_VALUE='DLV_DATA' 
   AND m13a.metric_name = 'tbspAllocation' AND m13a.TARGET_NAME = '$DB_NAME' AND m13a.metric_column = 'spaceUsed' AND m13a.rollup_timestamp = trunc(SYSDATE) - 1 AND m13b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m13a.KEY_VALUE='DM_ALFRESCO_DATA' 
   AND m14a.metric_name = 'tbspAllocation' AND m14a.TARGET_NAME = '$DB_NAME' AND m14a.metric_column = 'spaceUsed' AND m14a.rollup_timestamp = trunc(SYSDATE) - 1 AND m14b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m14a.KEY_VALUE='DM_DATA' 
   AND m15a.metric_name = 'tbspAllocation' AND m15a.TARGET_NAME = '$DB_NAME' AND m15a.metric_column = 'spaceUsed' AND m15a.rollup_timestamp = trunc(SYSDATE) - 1 AND m15b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m15a.KEY_VALUE='EAI_DATA'
   AND m16a.metric_name = 'tbspAllocation' AND m16a.TARGET_NAME = '$DB_NAME' AND m16a.metric_column = 'spaceUsed' AND m16a.rollup_timestamp = trunc(SYSDATE) - 1 AND m16b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m16a.KEY_VALUE='EPR_DATA'
   AND m17a.metric_name = 'tbspAllocation' AND m17a.TARGET_NAME = '$DB_NAME' AND m17a.metric_column = 'spaceUsed' AND m17a.rollup_timestamp = trunc(SYSDATE) - 1 AND m17b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m17a.KEY_VALUE='HM_DATA' 
   AND m18a.metric_name = 'tbspAllocation' AND m18a.TARGET_NAME = '$DB_NAME' AND m18a.metric_column = 'spaceUsed' AND m18a.rollup_timestamp = trunc(SYSDATE) - 1 AND m18b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m18a.KEY_VALUE='IM_DATA' 
   AND m19a.metric_name = 'tbspAllocation' AND m19a.TARGET_NAME = '$DB_NAME' AND m19a.metric_column = 'spaceUsed' AND m19a.rollup_timestamp = trunc(SYSDATE) - 1 AND m19b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m19a.KEY_VALUE='NTF_DATA'
   AND m20a.metric_name = 'tbspAllocation' AND m20a.TARGET_NAME = '$DB_NAME' AND m20a.metric_column = 'spaceUsed' AND m20a.rollup_timestamp = trunc(SYSDATE) - 1 AND m20b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m20a.KEY_VALUE='OP_DATA' 
   AND m21a.metric_name = 'tbspAllocation' AND m21a.TARGET_NAME = '$DB_NAME' AND m21a.metric_column = 'spaceUsed' AND m21a.rollup_timestamp = trunc(SYSDATE) - 1 AND m21b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m21a.KEY_VALUE='PARAM_DATA'
   AND m22a.metric_name = 'tbspAllocation' AND m22a.TARGET_NAME = '$DB_NAME' AND m22a.metric_column = 'spaceUsed' AND m22a.rollup_timestamp = trunc(SYSDATE) - 1 AND m22b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m22a.KEY_VALUE='PDLM_DATA' 
   AND m23a.metric_name = 'tbspAllocation' AND m23a.TARGET_NAME = '$DB_NAME' AND m23a.metric_column = 'spaceUsed' AND m23a.rollup_timestamp = trunc(SYSDATE) - 1 AND m23b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m23a.KEY_VALUE='PD_DATA' 
   AND m24a.metric_name = 'tbspAllocation' AND m24a.TARGET_NAME = '$DB_NAME' AND m24a.metric_column = 'spaceUsed' AND m24a.rollup_timestamp = trunc(SYSDATE) - 1 AND m24b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m24a.KEY_VALUE='PD_MASTER_DATA'
   AND m25a.metric_name = 'tbspAllocation' AND m25a.TARGET_NAME = '$DB_NAME' AND m25a.metric_column = 'spaceUsed' AND m25a.rollup_timestamp = trunc(SYSDATE) - 1 AND m25b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m25a.KEY_VALUE='POOL_DATA' 
   AND m26a.metric_name = 'tbspAllocation' AND m26a.TARGET_NAME = '$DB_NAME' AND m26a.metric_column = 'spaceUsed' AND m26a.rollup_timestamp = trunc(SYSDATE) - 1 AND m26b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m26a.KEY_VALUE='REFCORE_DATA' 
   AND m27a.metric_name = 'tbspAllocation' AND m27a.TARGET_NAME = '$DB_NAME' AND m27a.metric_column = 'spaceUsed' AND m27a.rollup_timestamp = trunc(SYSDATE) - 1 AND m27b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m27a.KEY_VALUE='REFREAD_DATA' 
   AND m28a.metric_name = 'tbspAllocation' AND m28a.TARGET_NAME = '$DB_NAME' AND m28a.metric_column = 'spaceUsed' AND m28a.rollup_timestamp = trunc(SYSDATE) - 1 AND m28b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m28a.KEY_VALUE='REFWORK_DATA' 
   AND m29a.metric_name = 'tbspAllocation' AND m29a.TARGET_NAME = '$DB_NAME' AND m29a.metric_column = 'spaceUsed' AND m29a.rollup_timestamp = trunc(SYSDATE) - 1 AND m29b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m29a.KEY_VALUE='REFWORK_MASTER_DATA'
   AND m30a.metric_name = 'tbspAllocation' AND m30a.TARGET_NAME = '$DB_NAME' AND m30a.metric_column = 'spaceUsed' AND m30a.rollup_timestamp = trunc(SYSDATE) - 1 AND m30b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m30a.KEY_VALUE='REF_APPL_DATA' 
   AND m31a.metric_name = 'tbspAllocation' AND m31a.TARGET_NAME = '$DB_NAME' AND m31a.metric_column = 'spaceUsed' AND m31a.rollup_timestamp = trunc(SYSDATE) - 1 AND m31b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m31a.KEY_VALUE='REF_APPL_MASTER_DATA' 
   AND m32a.metric_name = 'tbspAllocation' AND m32a.TARGET_NAME = '$DB_NAME' AND m32a.metric_column = 'spaceUsed' AND m32a.rollup_timestamp = trunc(SYSDATE) - 1 AND m32b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m32a.KEY_VALUE='SO_DATA' 
   AND m33a.metric_name = 'tbspAllocation' AND m33a.TARGET_NAME = '$DB_NAME' AND m33a.metric_column = 'spaceUsed' AND m33a.rollup_timestamp = trunc(SYSDATE) - 1 AND m33b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m33a.KEY_VALUE='SP_DATA' 
   AND m34a.metric_name = 'tbspAllocation' AND m34a.TARGET_NAME = '$DB_NAME' AND m34a.metric_column = 'spaceUsed' AND m34a.rollup_timestamp = trunc(SYSDATE) - 1 AND m34b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m34a.KEY_VALUE='SYSAUX' 
   AND m35a.metric_name = 'tbspAllocation' AND m35a.TARGET_NAME = '$DB_NAME' AND m35a.metric_column = 'spaceUsed' AND m35a.rollup_timestamp = trunc(SYSDATE) - 1 AND m35b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m35a.KEY_VALUE='SYSTEM' 
   AND m36a.metric_name = 'tbspAllocation' AND m36a.TARGET_NAME = '$DB_NAME' AND m36a.metric_column = 'spaceUsed' AND m36a.rollup_timestamp = trunc(SYSDATE) - 1 AND m36b.rollup_timestamp = trunc(SYSDATE) - ('$DAYS') AND m36a.KEY_VALUE='UAMS_DATA'
   AND m1a.target_name = m1b.target_name AND m1a.KEY_VALUE = m1b.KEY_VALUE AND m1a.metric_column = m1b.metric_column AND m1a.metric_name = m1b.metric_name                
   AND m2a.target_name = m2b.target_name AND m2a.KEY_VALUE = m2b.KEY_VALUE AND m2a.metric_column = m2b.metric_column AND m2a.metric_name = m2b.metric_name                 
   AND m3a.target_name = m3b.target_name AND m3a.KEY_VALUE = m3b.KEY_VALUE AND m3a.metric_column = m3b.metric_column AND m3a.metric_name = m3b.metric_name                
   AND m4a.target_name = m4b.target_name AND m4a.KEY_VALUE = m4b.KEY_VALUE AND m4a.metric_column = m4b.metric_column AND m4a.metric_name = m4b.metric_name                
   AND m5a.target_name = m5b.target_name AND m5a.KEY_VALUE = m5b.KEY_VALUE AND m5a.metric_column = m5b.metric_column AND m5a.metric_name = m5b.metric_name                
   AND m6a.target_name = m6b.target_name AND m6a.KEY_VALUE = m6b.KEY_VALUE AND m6a.metric_column = m6b.metric_column AND m6a.metric_name = m6b.metric_name                
   AND m7a.target_name = m7b.target_name AND m7a.KEY_VALUE = m7b.KEY_VALUE AND m7a.metric_column = m7b.metric_column AND m7a.metric_name = m7b.metric_name                
   AND m8a.target_name = m8b.target_name AND m8a.KEY_VALUE = m8b.KEY_VALUE AND m8a.metric_column = m8b.metric_column AND m8a.metric_name = m8b.metric_name                
   AND m9a.target_name = m9b.target_name AND m9a.KEY_VALUE = m9b.KEY_VALUE AND m9a.metric_column = m9b.metric_column AND m9a.metric_name = m9b.metric_name                
   AND m10a.target_name = m10b.target_name AND m10a.KEY_VALUE = m10b.KEY_VALUE AND m10a.metric_column = m10b.metric_column AND m10a.metric_name = m10b.metric_name        
   AND m11a.target_name = m11b.target_name AND m11a.KEY_VALUE = m11b.KEY_VALUE AND m11a.metric_column = m11b.metric_column AND m11a.metric_name = m11b.metric_name        
   AND m12a.target_name = m12b.target_name AND m12a.KEY_VALUE = m12b.KEY_VALUE AND m12a.metric_column = m12b.metric_column AND m12a.metric_name = m12b.metric_name        
   AND m13a.target_name = m13b.target_name AND m13a.KEY_VALUE = m13b.KEY_VALUE AND m13a.metric_column = m13b.metric_column AND m13a.metric_name = m13b.metric_name        
   AND m14a.target_name = m14b.target_name AND m14a.KEY_VALUE = m14b.KEY_VALUE AND m14a.metric_column = m14b.metric_column AND m14a.metric_name = m14b.metric_name        
   AND m15a.target_name = m15b.target_name AND m15a.KEY_VALUE = m15b.KEY_VALUE AND m15a.metric_column = m15b.metric_column AND m15a.metric_name = m15b.metric_name        
   AND m16a.target_name = m16b.target_name AND m16a.KEY_VALUE = m16b.KEY_VALUE AND m16a.metric_column = m16b.metric_column AND m16a.metric_name = m16b.metric_name        
   AND m17a.target_name = m17b.target_name AND m17a.KEY_VALUE = m17b.KEY_VALUE AND m17a.metric_column = m17b.metric_column AND m17a.metric_name = m17b.metric_name        
   AND m18a.target_name = m18b.target_name AND m18a.KEY_VALUE = m18b.KEY_VALUE AND m18a.metric_column = m18b.metric_column AND m18a.metric_name = m18b.metric_name        
   AND m19a.target_name = m19b.target_name AND m19a.KEY_VALUE = m19b.KEY_VALUE AND m19a.metric_column = m19b.metric_column AND m19a.metric_name = m19b.metric_name        
   AND m20a.target_name = m20b.target_name AND m20a.KEY_VALUE = m20b.KEY_VALUE AND m20a.metric_column = m20b.metric_column AND m20a.metric_name = m20b.metric_name        
   AND m21a.target_name = m21b.target_name AND m21a.KEY_VALUE = m21b.KEY_VALUE AND m21a.metric_column = m21b.metric_column AND m21a.metric_name = m21b.metric_name        
   AND m22a.target_name = m22b.target_name AND m22a.KEY_VALUE = m22b.KEY_VALUE AND m22a.metric_column = m22b.metric_column AND m22a.metric_name = m22b.metric_name        
   AND m23a.target_name = m23b.target_name AND m23a.KEY_VALUE = m23b.KEY_VALUE AND m23a.metric_column = m23b.metric_column AND m23a.metric_name = m23b.metric_name        
   AND m24a.target_name = m24b.target_name AND m24a.KEY_VALUE = m24b.KEY_VALUE AND m24a.metric_column = m24b.metric_column AND m24a.metric_name = m24b.metric_name        
   AND m25a.target_name = m25b.target_name AND m25a.KEY_VALUE = m25b.KEY_VALUE AND m25a.metric_column = m25b.metric_column AND m25a.metric_name = m25b.metric_name        
   AND m26a.target_name = m26b.target_name AND m26a.KEY_VALUE = m26b.KEY_VALUE AND m26a.metric_column = m26b.metric_column AND m26a.metric_name = m26b.metric_name        
   AND m27a.target_name = m27b.target_name AND m27a.KEY_VALUE = m27b.KEY_VALUE AND m27a.metric_column = m27b.metric_column AND m27a.metric_name = m27b.metric_name        
   AND m28a.target_name = m28b.target_name AND m28a.KEY_VALUE = m28b.KEY_VALUE AND m28a.metric_column = m28b.metric_column AND m28a.metric_name = m28b.metric_name        
   AND m29a.target_name = m29b.target_name AND m29a.KEY_VALUE = m29b.KEY_VALUE AND m29a.metric_column = m29b.metric_column AND m29a.metric_name = m29b.metric_name        
   AND m30a.target_name = m30b.target_name AND m30a.KEY_VALUE = m30b.KEY_VALUE AND m30a.metric_column = m30b.metric_column AND m30a.metric_name = m30b.metric_name        
   AND m31a.target_name = m31b.target_name AND m31a.KEY_VALUE = m31b.KEY_VALUE AND m31a.metric_column = m31b.metric_column AND m31a.metric_name = m31b.metric_name        
   AND m32a.target_name = m32b.target_name AND m32a.KEY_VALUE = m32b.KEY_VALUE AND m32a.metric_column = m32b.metric_column AND m32a.metric_name = m32b.metric_name        
   AND m33a.target_name = m33b.target_name AND m33a.KEY_VALUE = m33b.KEY_VALUE AND m33a.metric_column = m33b.metric_column AND m33a.metric_name = m33b.metric_name        
   AND m34a.target_name = m34b.target_name AND m34a.KEY_VALUE = m34b.KEY_VALUE AND m34a.metric_column = m34b.metric_column AND m34a.metric_name = m34b.metric_name        
   AND m35a.target_name = m35b.target_name AND m35a.KEY_VALUE = m35b.KEY_VALUE AND m35a.metric_column = m35b.metric_column AND m35a.metric_name = m35b.metric_name        
   AND m36a.target_name = m36b.target_name AND m36a.KEY_VALUE = m36b.KEY_VALUE AND m36a.metric_column = m36b.metric_column AND m36a.metric_name = m36b.metric_name        
ORDER BY 1;                                                                                                                                                                                                                                                     

EOF
