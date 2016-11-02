#!/bin/bash
set -e
#nsenter_exec vertica-node-1
#example ./vertica_import.sh /opt/vertica/bin maas_admin maas_admin_123 5433 CIDB2 developer 100000002 /tmp vertica
VSQL_PATH=$1
VERTICA_USERNAME=$2
VERTICA_PASSWORD=$3
VERTICA_PORT=$4
VERTICA_DB=$5
ENV_PREFIX=$6
SOURCE_TENANT_ID=$7
SOURCE_DIR=$8
VERTICA_SYSTEM_USER=$9
IMPORT_TYPE=${10:-import}        # Set to "dry-run" to execute in dry run mode (just test the env but import nothing)

if [[ -z "$VERTICA_PORT" ]]; then
    echo "Vertica port must be specified"
    exit 1
elif [[ -z "$VERTICA_USERNAME" ]]; then
    echo "Vertica username must be specified"
    exit 1
elif [[ -z "$VERTICA_PASSWORD" ]]; then
    echo "Vertica password must be specified"
    exit 1
elif [[ -z "$VERTICA_DB" ]]; then
    echo "Vertica dbname must be specified"
    exit 1
elif [[ -z "$ENV_PREFIX" ]]; then
    echo "Vertica environment prefix must be specified"
    exit 1
elif [[ -z "$VERTICA_SYSTEM_USER" ]]; then
    echo "Vertica system user must be specified"
    exit 1
fi

if [[ ! -d ${SOURCE_DIR}/vertica-${SOURCE_TENANT_ID} ]]; then
    echo "No data for tenant ${SOURCE_TENANT_ID} - skipping vertica import"
    exit 4
fi

if [[ ${IMPORT_TYPE} == "dry-run" ]]; then
    # Check that we can reach vertica (The command will fail and exit the script if we cannot connect)
    ${VSQL_PATH}/vsql -U ${VERTICA_USERNAME} -w ${VERTICA_PASSWORD} -p ${VERTICA_PORT} -d ${VERTICA_DB} -At -c "SELECT 1 FROM DUAL" \
        || { echo "Cannot query Vertica DB: ${VERTICA_DB}"; exit 1; }

    # Check that VERTICA_SYSTEM_USER can read the export files dir
    sudo su - ${VERTICA_SYSTEM_USER} -c "test -r ${SOURCE_DIR}/vertica-${SOURCE_TENANT_ID}" || { echo "Source dir isn't readable by user: ${VERTICA_SYSTEM_USER}"; exit 1; }
else
    # Import tenant data

    # Clean up old import schema before the import
    ${VSQL_PATH}/vsql -U ${VERTICA_USERNAME} -w ${VERTICA_PASSWORD} -p ${VERTICA_PORT} -d ${VERTICA_DB} -c "DROP SCHEMA IF EXISTS ${ENV_PREFIX}_import_${SOURCE_TENANT_ID} CASCADE;"

    # Import data
    echo "Importing DDL script"
    sudo su - ${VERTICA_SYSTEM_USER} -c "gzip -d -c ${SOURCE_DIR}/vertica-${SOURCE_TENANT_ID}/ddl/export_${SOURCE_TENANT_ID}.ddl.gz" | \
        sed "s/export_${SOURCE_TENANT_ID}/${ENV_PREFIX}_import_${SOURCE_TENANT_ID}/g" | \
        ${VSQL_PATH}/vsql -U ${VERTICA_USERNAME} -w ${VERTICA_PASSWORD} -p ${VERTICA_PORT} -d ${VERTICA_DB} -a

    files=`sudo su - ${VERTICA_SYSTEM_USER} -c "ls -1 ${SOURCE_DIR}/vertica-${SOURCE_TENANT_ID}/dumps/*.dump.gz"`
    for x in ${files}
    do
        table=`basename "$x" .dump.gz`
        echo "Importing table: ${table}"
        sudo su - ${VERTICA_SYSTEM_USER} -c "gzip -d -c ${x}" | \
            ${VSQL_PATH}/vsql -U ${VERTICA_USERNAME} -w ${VERTICA_PASSWORD} -p ${VERTICA_PORT} -d ${VERTICA_DB} \
                -c "COPY ${ENV_PREFIX}_import_${SOURCE_TENANT_ID}.${table} FROM STDIN DELIMITER ',';"
    done

    echo "Import done"
fi
