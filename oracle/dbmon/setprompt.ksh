typeset -u NAME=`echo $1|cut -d. -f1`
if [ -z "$NAME" ]
then
        echo "1"
        chdir $HOME
else
        echo "**$1**"
        chdir $1
fi
echo "\033]0;${LOGNAME}@${HOST}      $ORACLE_SID     DIR=$PWD \007\c"
