#!/bin/bash
#
# vertica_db_rebuild.sh
#
# This script is used to rebuild the Vertica DB on CI to clear the catalogue.
# NOTE: Use this with extreme caution - it drops the DB with no further questions.
#

DB_NAME=CIDB2
DB_PASS=CIDB2 
DB_HOSTS=16.60.133.49,16.60.133.52,16.60.133.47
#DB_HOSTS=16.60.182.187,16.60.182.192,16.60.182.185
#DB_HOSTS=16.60.154.69,16.60.154.67,16.60.154.65
#DB_HOSTS=localhost

DB_CATA=/home/vertica/verticaC/
DB_DATA=/home/vertica/verticaD/


# First stop the DB
#/opt/vertica/bin/adminTools -t stop_db -d $DB_NAME -p $DB_PASS -F
/opt/vertica/bin/adminTools -t kill_node -s $DB_HOSTS
if [ $? -ne 0 ]; then
  echo "Failed to stop the DB"
  exit 1
fi

# Verify the DB is DOWN
/opt/vertica/bin/adminTools -t db_status -s DOWN  | grep $DB_NAME
if [ $? -ne 0 ]; then
  echo "Failed to stop the DB"
  exit 1
fi

# Drop the DB
/opt/vertica/bin/adminTools -t drop_db -d $DB_NAME
if [ $? -ne 0 ]; then
  echo "Failed to drop the DB"
  exit 1
fi


# Create a new DB
/opt/vertica/bin/adminTools -t create_db --hosts=$DB_HOSTS -d $DB_NAME -p $DB_PASS -c $DB_CATA -D $DB_DATA
if [ $? -ne 0 ]; then
  echo "Failed to create the DB"
  exit 1
fi



# Create Maas_admin user
/opt/vertica/bin/vsql -d $DB_NAME -w $DB_PASS << EOF
create user maas_admin identified by 'maas_admin_123' ;
GRANT CREATE ON DATABASE CIDB2 TO maas_admin;
GRANT ALL ON DATABASE CIDB2 TO maas_admin;
GRANT USAGE ON SCHEMA public to maas_admin;
GRANT CREATE ON SCHEMA public to maas_admin;
select set_config_parameter('MaxClientSessions',2000);
select set_config_parameter('HistoryRetentionTime',-1);
select set_config_parameter('HistoryRetentionEpochs',0);
EOF

#check user can login
/opt/vertica/bin/vsql -d CIDB2 -U maas_admin -w maas_admin_123 -qtc "select 1;" | grep 1
if [ $? -ne 0 ]; then
  echo "Failed to create the User"
  exit 1
fi

echo "done"
exit 0

#EOF
 
create user maas_admin identified by 'maas_admin_123' ;
GRANT CREATE ON DATABASE EMS TO maas_admin;
GRANT ALL ON DATABASE EMS TO maas_admin;
GRANT USAGE ON SCHEMA public to maas_admin;
GRANT CREATE ON SCHEMA public to maas_admin;
select set_config_parameter('MaxClientSessions',1000);
select set_config_parameter('HistoryRetentionTime',-1);
select set_config_parameter('HistoryRetentionEpochs',0);