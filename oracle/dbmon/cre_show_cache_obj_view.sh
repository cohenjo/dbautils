#!/bin/ksh 
#***********************************************************************
#
# Script Name    : cre_show_cache_obj_view.sh
#
# create the show_cache_obj_view at SYS
#
# By Adi Zohar - Feb 2003
#***********************************************************************
. ~/.profile

ORATAB=/etc/oratab
#***********************************************************************
for NEW_SID in `grep -v "^#" ${ORATAB} | awk 'BEGIN {FS=":"} {if ($3=="Y")  { print $1 }} '|grep -v "*"`
do
    export ORACLE_SID=${NEW_SID}

    echo "Running on $NEW_SID "
    echo "----------------------------------------------"
	echo "set echo off verify off pages 0
	drop view view_x\$bh;
	drop public synonym view_x\$bh;
	create or replace view show_cache_obj_view as select * from x\$bh; 
	grant select on show_cache_obj_view to public;              
	" | sqlplus -s "/ as sysdba"
done


