#!/bin/ksh 
#***********************************************************************
#
# Script Name    : show_users_view.sh
#
# create the show_user_view and show_users_view at SYS
#
# By Adi Zohar - Feb 2003
#***********************************************************************
. ~/.profile

ORATAB=/etc/oratab
#***********************************************************************
for NEW_SID in `grep -v "^#" ${ORATAB} | awk 'BEGIN {FS=":"} {if ($3=="Y")  { print $1 }} '|grep -v "*"`
do
    export ORACLE_SID=${NEW_SID}

    echo "set echo off verify off pages 0
create user ops\$azohar   identified externally temporary tablespace temp;
create user ops\$hpham    identified externally temporary tablespace temp;
create user ops\$syeoman  identified externally temporary tablespace temp;

alter user ops\$azohar   default tablespace pool_data ;
alter user ops\$hpham    default tablespace pool_data ;
alter user ops\$syeoman  default tablespace pool_data ;

grant dba to ops\$azohar;
grant dba to ops\$hpham;
grant dba to ops\$syeoman;
    " | sqlplus / 

done
