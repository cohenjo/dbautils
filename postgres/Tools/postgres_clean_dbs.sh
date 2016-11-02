#!/bin/bash
#
# File: postgres_clean_dbs.sh
# Description: use this script to remove DB created before a given date.
# Auther: Jony Vesterman Cohen (cohenjo@hp.com)
#
# Change list:
# ============
# 0.1   12/06/2013      Jony Cohen      Initial version
#

# Initialize our own variables:
clean_date="1 day ago"
#clean_date="1 second ago"
prefix="ci_"
verbose=0

show_help(){
  echo "usage: $0 -d <date time> -p <prefix>"
  echo "date should be in format: date +%Y-%m-%d %H:%M:%S (default: 1 day ago)"
  echo "db name prefix (default: ci_)"
  exit 1
}

while getopts "h?v:d:p:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose=1
        ;;
    p)
        echo "prefix was triggered - setting prefix"
        prefix=$OPTARG
        ;;
    d)  clean_date=$OPTARG
        ;;
    esac
done


# get the clean epoch
t2=`date --date="$clean_date" +%s`
if [[ $t2 == "" ]]; then 
  echo "got bad clean date - exiting"
  exit 1
fi

for oid in `ls -1 ${PGDATA}/base/ | grep -v pgsql_tmp`;do
  cd=`stat -c "%y" ${PGDATA}/base/$oid/PG_VERSION`;
  t1=`date --date="$cd" +%s`
  echo "db with OID: $oid was created at epoch: $t1"

  if [[ $t1 -lt $t2 ]]; then
    dbname=`psql template1 -tz0qc "select datname from pg_database where oid=$oid and datname like '${prefix}%'"`
    dbname=`echo $dbname | sed -e 's/^[ \t]*//'`
    if [[ ${dbname} != "" ]]; then
      echo "cleaning DB: $dbname"

    #cat <<EOD
     psql template1 <<EOD
        REVOKE CONNECT ON DATABASE $dbname FROM public;
        ALTER DATABASE $dbname CONNECTION LIMIT 0;
        SELECT pg_terminate_backend(pid)
        FROM pg_stat_activity
        WHERE pid <> pg_backend_pid()
        AND datname='${dbname}';
        \q
EOD
      dropdb ${dbname};
     fi
  else
    echo "DB newer than given date - do not drop."
  fi

done
