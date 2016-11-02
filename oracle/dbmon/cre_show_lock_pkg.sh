#!/bin/ksh 
#***********************************************************************
#
# Script Name    : cre_show_lock_pkg.sh
#
# create the show_lock_pkg at SYS for show8locks
#
# By Adi Zohar - Feb 2003 - fixed
#***********************************************************************
cd $ORACLE_MON
sqlplus -s "/ as sysdba" @cre_show_lock_pkg.sql
