#!/usr/bin/ksh 

# Script run_parallel_dbi.ksh runs DBI in parallel, there are 2 types of DBI 
# NonPartitioned DBI with -t NP the ParamFile will just have dbifilenames
# Partitioned DBI with -t P
# the ParamFile will contain "dbifilename tablename" which is partitioned.
# example:
# dbi_run_parallel.txt will contain
# BC_PRODUCT_DBI1.sql BC_PRODUCT
# OM_PRCHSD_OFFER_PRICE_PRM.dbi OM_PRCHSD_OFFER_PRICE_PRM
# ........ etc
#
 

# Functions

Usage()
{
  printf "\n"
  echo "Usage:  `basename $0` -u UserName -p PassWord -d Database -t DBI_Type(P/NP) -f ParamFile(DBI_Filenames) -n Num_of_Parallel"
  printf "\n"
}

CheckUser ()
{
  UsrName=$1
  UsrPass=$2
  UsrIns=$3

  if [ "${UsrName}" = "" -o "${UsrPass}" = "" -o "${UsrIns}" = "" ]
  then
     echo "\n Invalid connection params : $UsrName $UsrPass $UsrIns\n"
     exit
  fi
  usr_str=`echo show user | sqlplus -s $UsrName/$UsrPass@$UsrIns | awk '{print  $1 }' `

  if [ "${usr_str}" != "USER" ]
  then
     echo "\n Invalid connection params : $UsrName $UsrPass $UsrIns\n"
     exit
  fi
}


#################################
# Main
#################################

# Check number of parameters

while getopts  u:p:d:t:n:f:h: opt
do
    case $opt  in
      u) uname=$OPTARG ;;
      p) pass=$OPTARG ;;
      d) db=$OPTARG ;;
      t) dbi_type=$OPTARG ;;
      n) PARALLEL_SIZE=$OPTARG ;;
      f) PARTFILE=$OPTARG ;;
      h) Usage;exit 1 ;;
      *) Usage;exit 1 ;;
    esac
done

if [ $# -lt 5 -o ${uname}"#" = "#" -o ${pass}"#" = "#"  -o ${db}"#" = "#" -o ${dbi_type}"#" = "#" -o ${PARTFILE}"#" = "#" ]
then
   Usage
   exit 1
fi

# Checking user's existance
CheckUser $uname $pass $db

# Checking paramfile existance
if [ ! -s ${PARTFILE} ]
then
   echo "${PARTFILE} does not exists."
   Usage
   exit 1
fi

if [ ${PARALLEL_SIZE}"#" = "#" ]
then
        PARALLEL_SIZE=4
fi


if [ ${dbi_type} = "NP" ]
then
cyc=0
cat ${PARTFILE} | while read pttn
do
  dbi_name=`echo $pttn | awk '{print $1}'`
  dbi_logname=`echo $dbi_name | awk -F "." '{print $1}'`
  echo "DBI - FileName: " $dbi_name
  sqlplus $uname/$pass@$db <<*EOF* 1>${dbi_logname}_name.log 2>&1 &
@$dbi_name 
*EOF*
 
  (( cyc=cyc+1 ))

        # count the parallel cycle
        if (( cyc%${PARALLEL_SIZE}==0 ))
        then
                echo "waiting..."
                
                wait
        fi

done
fi

if [ ${dbi_type} = "P" ]
then
cat ${PARTFILE} | while read i
 do
  dbi_name=`echo $i | awk '{print $1}'`
  dbi_logname=`echo $dbi_name | awk -F "." '{print $1}'`
  echo "DBI - FileName: " $dbi_name
  partitioned_table=`echo $i | awk '{print $2}'`  
  echo "TableName: " $partitioned_table
  if [ $partitioned_table"#" = "#" ]
  then
    echo "Partitioned table not provided"
    exit 1;
  fi
  sqlplus -s $uname/$pass@$db << *EOF*
  define tname=${partitioned_table}
  set pages 0 feed off linesize 140 head off verify off
  spool &tname..part
  select PARTITION_NAME from all_tab_partitions where table_name = upper('&tname');
  spool off
*EOF*

  cyc=0
  cat ${partitioned_table}.part | while read pttn
   do
    part_name=`echo $pttn | awk '{print $1}'`
    echo "PartitionName :" $part_name
    sqlplus $uname/$pass@$db <<*EOF* 1>${dbi_logname}_${part_name}.log 2>&1 &
define part=${part_name}
@$dbi_name
*EOF*

  (( cyc=cyc+1 ))

        # count the parallel cycle
        if (( cyc%${PARALLEL_SIZE}==0 ))
        then
                echo "waiting..."

                wait
        fi

  done
 
 done
fi

