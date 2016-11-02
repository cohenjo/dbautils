#!/bin/bash

############################################################
# File: vertica_clean_schemas.sh
# Author: Jony Vesterman Cohen
#
# Change list:
# ============
# 0.1   22/10/2013      Jony Cohen      Initial version
#
# Description: clean CI schemas left after failuers older than 1 day
##############################################################

currentdt=`date +'%m%d%Y_%H%M'`

AGE="1 day"
#AGE="1 second"
PREFIX="ci_"
#DB="EMS"
DB="CIDB2"
#PASSWD="EMS"
USER=maas_admin
PASSWD="maas_admin_123"

usage() { echo "Usage: $0 -a <interval> -p <password> -u <username> -d <dbname> -f <prefix>" 1>&2; exit 1; }

while getopts u:p:d:f:a:h flag; do
  case $flag in
    u)
        USER=$OPTARG;
      ;;
    p)
        PASSWD=$OPTARG
        ;;
    d)
        DB=$OPTARG
      ;;
    f)
        PREFIX=$OPTARG
      ;;
    a)
        AGE=$OPTARG
      ;;
    h)
      usage;
      ;;
    ?)
        usage;
      exit;
      ;;
  esac
done

# select schema_name,create_time from schemata ;

/opt/vertica/bin/vsql -d ${DB} -U ${USER} -w ${PASSWD}   <<EOF
\timing
\echo "create cleanup script into /tmp/clean_script.sh"
\t
\o /tmp/clean_script.sh
  select 'drop schema ' || schema_name || ' cascade;'
  from v_catalog.schemata
  where create_time < current_timestamp - interval '${AGE}'
    and is_system_schema=false
    and schema_name like '${PREFIX}%';
\o
\echo "running cleanup script (/tmp/clean_script.sh)"
\i /tmp/clean_script.sh
\q
EOF
RET=$?

echo "remove cleanup script"
rm /tmp/clean_script.sh

if [[ ${RET} != 0 ]]; then
    echo "vsql failed - please check logs"
	exit 1
fi

echo "cleanup successfully finish at `date`"
exit 0

