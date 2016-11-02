#!/bin/bash

############################################################
# File: killIdle.sh
# Author: Anna Aronova
#
# Change list:
# ============
# 0.1   22/10/2013      Anna Aronova      Initial version
#
# Description: Kill idle connections of ci older than 1 hour
##############################################################

currentdt=`date +'%m%d%Y_%H%M'`
AGE="1 hour"
PREFIX="ci%"
#PGDATA=/DATA/pgsql

/usr/pgsql-9.2/bin/psql -U maas_admin -d template1 <<EOF
        select datname, state_change, pg_terminate_backend(pid)
        from pg_stat_activity
        where state_change< current_timestamp - interval '${AGE}'
        and state='idle'
        and datname like '${PREFIX}%';
EOF
RET=$?

if [[ ${RET} != 0 ]]; then
    echo "psql failed - please check logs"
	exit 1
fi

exit 0