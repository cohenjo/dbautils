if [ $# -lt 3 ]
   then
	echo 
	echo install_help.sh USER PASS INSTANCE
	echo Example:
	echo install_help.sh system manager ypgss1
	exit 1
   fi

cd $ORACLE_MON/help

export USERNAME=$1
export PASSWORD=$2
export INSTNAME=$3

sqlplus $USERNAME/$PASSWORD@$INSTNAME @$ORACLE_MON/help/helptbl.sql
sqlldr  userid=$USERNAME/$PASSWORD@$INSTNAME control=$ORACLE_MON/help/plshelp.ctl
sqlldr  userid=$USERNAME/$PASSWORD@$INSTNAME control=$ORACLE_MON/help/plushelp.ctl
sqlldr  userid=$USERNAME/$PASSWORD@$INSTNAME control=$ORACLE_MON/help/sqlhelp.ctl
sqlplus $USERNAME/$PASSWORD@$INSTNAME @$ORACLE_MON/help/helpindx.sql

