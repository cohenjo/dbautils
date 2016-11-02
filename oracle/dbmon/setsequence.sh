#!/usr/bin/sh
# Set sequence to paritcular value
if [ $# != 2 ]
then
     echo "\n Usage:::  setsequence <SEQUENCE OWNER> <SEQUENCE NAME> \n"
        exit 1
fi
export SEQ_OWNER=$1
export SEQ_NAME=$2
echo "set verify off echo off concat off heading off pages 0
      select $SEQ_OWNER.$SEQ_NAME.CURRVAL from dual; " | sqlplus -s / | read CURRENT_VALUE
echo "\n ****  Current value of sequence is=====> $CURRENT_VALUE \n"
