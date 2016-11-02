#!/bin/bash

MIN_TO_KEEP_CI=360
MIN_TO_KEEP_DEVLAB=43200
MIN_TO_KEEP_OTHER=720

MONGO=/usr/bin/mongo

usage ()
{
  echo "This utility is used for cleaning Mongo DB according to max unused minutes"
  echo "Usage: $(basename $0) [--min-to-keep-ci <minutes>] [--min-to-keep-devlab <minutes>] [--min-to-keep-other <minutes>]"
  echo 
  echo "--min-to-keep-ci      Minutes to keep CI Mongo DBs. Default 320 min."
  echo "--min-to-keep-devlab  Minutes to keep Dev Lab Mongo DBs. Default 43200 min."
  echo "--min-to-keep-other   Minutes to keep other Mongo DBs. Default 720 min."
  echo "--help                Print this message"
}

while test $# -gt 0
do
  case $1 in
    --min-to-keep-ci)
      MIN_TO_KEEP_CI=$2
      shift
      ;;
    --min-to-keep-devlab)
      MIN_TO_KEEP_DEVLAB=$2
      shift
      ;;
    --min-to-keep-other)
      MIN_TO_KEEP_OTHER=$2
      shift
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      echo >&2 "Invalid argument: $1"
      usage
      exit 1
      ;;
  esac
  shift
done

MONGO_REPOSITORY=`grep -e '^dbpath' /etc/mongod.conf|sed 's/.*=//'`
if [ $? -ne 0 ]; then
  exit 1
fi

IS_MASTER=`${MONGO} -u admin -p admin admin --eval "var m = rs.isMaster();m.ismaster" --quiet`
if [ $? -ne 0 ]; then
  exit 1
fi

if [ "${IS_MASTER}" = "true" ]; then
  echo "$(hostname) is MongoDB master host"
  echo "MIN_TO_KEEP_CI     = $MIN_TO_KEEP_CI"
  echo "MIN_TO_KEEP_DEVLAB = $MIN_TO_KEEP_DEVLAB"
  echo "MIN_TO_KEEP_OTHER  = $MIN_TO_KEEP_OTHER"

  cd ${MONGO_REPOSITORY}
  if [ $? -ne 0 ]; then
    exit 1
  fi

  # Clean CI
  dbs=`find ./ -name '*.ns' ! -mmin -${MIN_TO_KEEP_CI} |sed "s/\.\/\(.*\)\.ns/\1/g" |grep -e "^ci_" |grep -v -e "^admin$"`
  if [ $? -eq 0 ]; then
    for db in $dbs ; do
      echo "Removing CI DB: $db "
      ${MONGO} -u admin -p admin --eval "var d = db.getMongo().getDB('$db'); d.dropDatabase()" admin
      if [ $? -ne 0 ]; then
        exit 1
      fi
    done;
  fi

  # Clean DEV
  dbs=`find ./ -name '*.ns' ! -mmin -${MIN_TO_KEEP_DEVLAB} |sed "s/\.\/\(.*\)\.ns/\1/g" |grep -e "^dev_" |grep -v -e "^admin$"`
  if [ $? -eq 0 ]; then
    for db in $dbs ; do
      echo "Removing DEV DB: $db"
      ${MONGO} -u admin -p admin --eval "var d = db.getMongo().getDB('$db'); d.dropDatabase()" admin
      if [ $? -ne 0 ]; then
        exit 1
      fi
    done;
  fi

  # Clean OTHER
  dbs=`find ./ -name '*.ns' ! -mmin -${MIN_TO_KEEP_OTHER} |sed "s/\.\/\(.*\)\.ns/\1/g" |grep -v -e "^ci_" -e "^dev_" -e "^admin$"`
  if [ $? -eq 0 ]; then
    for db in $dbs ; do
      echo "Removing OTHER DB: $db"
      ${MONGO} -u admin -p admin --eval "var d = db.getMongo().getDB('$db'); d.dropDatabase()" admin
      if [ $? -ne 0 ]; then
        exit 1
      fi
    done;
  fi

else
  echo "$(hostname) is not MongoDB master host"
fi

echo "DONE"
exit 0