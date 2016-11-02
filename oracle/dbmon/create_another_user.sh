#!/bin/sh
# -----------------------------------------------------------------------------
# File Name:    create_another_user.sh
#
# Function:     Creates a new user as a copy of an existing one.
#
# Remarks:
#
# Parameters:   $1      -       Oracle SID in which User to be created 
#               $2      -       The new user name
#               $3      -       The new user password
#               $4      -       The existing user name
#
# Change History;
#
# Date     Author         Change
# ======== ============   =======================================================
# 11/01/08 Yogesh Latey   Initial Version
#
# -----------------------------------------------------------------------------

if [ $# -lt 4 -o $# -gt 5 ]; then

   echo " "
   echo "Usage : `basename $0` SID NEWUSERNAME PASSWORD EXISTING_USERNAME [Y|N]"
   echo " "

   exit 1
fi

. ~/.profile
ORATAB=/etc/oratab
export ORAENV_ASK=NO

export SID_EXIST=`grep $1 $ORATAB | wc -l`

if [ $SID_EXIST = 0 ]
then
   echo "\n ORACLE SID: $1 Does not exist on `hostname`"
   exit 1
fi

export ORACLE_SID=`grep ^$1 $ORATAB| cut -d: -f1`

. oraenv

export newuser=$2
export newpassword=$3
export model=$4

sqlplus -s / > $log_file <<EOF
DEFINE newline=CHR(10)

SET ECHO OFF
SET HEAD OFF
SET FEEDBACK OFF
SET VERIFY OFF

SPOOL Create_user_$newuser.sql

SELECT  'CREATE USER $newuser IDENTIFIED BY $newpassword'||&newline||
        '  DEFAULT TABLESPACE '||default_tablespace||&newline||
        '  TEMPORARY TABLESPACE '||temporary_tablespace||&newline||
        '  PROFILE '||profile||';'
  FROM dba_users
  WHERE username = UPPER('$model')
/

SELECT  'GRANT '||privilege||' TO $newuser'||
        DECODE(admin_option,'YES',' WITH ADMIN OPTION;',';')
  FROM dba_sys_privs
  WHERE GRANTEE = UPPER('$model')
/

SELECT  'GRANT '||granted_role||' TO $newuser'||
        DECODE(admin_option,'YES',' WITH ADMIN OPTION;',';')
  FROM dba_role_privs
  WHERE GRANTEE = UPPER('$model')
/

SELECT  'ALTER USER $newuser'||&newline||
        '  QUOTA '||
        DECODE(max_bytes,-1,'UNLIMITED',TO_CHAR(max_bytes))||
        ' ON '||tablespace_name||';'
  FROM dba_ts_quotas
  WHERE username = UPPER('$model')
/

SELECT  'GRANT '||privilege||' ON '||owner||'.'||
        table_name||' TO $newuser'||
        DECODE(grantable,'YES',' WITH GRANT OPTION;',';')
  FROM dba_tab_privs
  WHERE GRANTEE = UPPER('$model')
/

 SELECT 'ALTER USER $newuser QUOTA UNLIMITED ON '||default_tablespace from dba_users where username= UPPER('$model')
 /

SPOOL OFF

SET VERIFY OFF
SET FEEDBACK ON
SET HEAD ON
SET ECHO ON

EOF

Local=$5
if [ -z "Local" ]
then
echo "Would you like to execute ? (Y/N) \c"; read Local
fi

if [ "$Local" = "Y" -o "$Local" = "y" ]
then
        echo "set echo on pages 0 lines 199 trimspo on
        spool Create_$newuser.log
        @Create_user_$newuser.sql
        spool off
        " | sqlplus "/ as sysdba"
        num_of_errors=`grep -i "ORA-" Create_$newuser.log | wc -l`
        echo "------------------------------------------------------------------------------"
        echo "User $newuser created with $num_of_errors errors "
        echo "------------------------------------------------------------------------------"

fi
rm -f Create_user_$newuser.sql
rm -f Create_$newuser.log

