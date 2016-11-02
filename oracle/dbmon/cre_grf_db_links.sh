#!/bin/ksh 
#***********************************************************************
#
# Script Name    : grf_db_links.sh
#
#***********************************************************************
. ~/.profile

ORATAB=/etc/oratab
#***********************************************************************
for NEW_SID in `grep -v "^#" ${ORATAB} | awk 'BEGIN {FS=":"} {if ($3=="Y")  { print $1 }} '`
do
    export ORACLE_SID=${NEW_SID}
    echo Running on $NEW_SID

    $ORACLE_HOME/bin/sqlplus -s /  << %EOI%   >> $log_file 2>> $log_file
conn /
@$AUTO_CONN sys
set echo on
grant select on dba_db_links to public;
exit
%EOI%
done


