#!/bin/bash
set -e
#nsenter_exec vertica-node-1
#example ./vertica_export.sh /opt/vertica/bin maas_admin maas_admin_123 5433 CIDB2 developer 100000002 /tmp vertica
VSQL_PATH=$1
VERTICA_USERNAME=$2
VERTICA_PASSWORD=$3
VERTICA_PORT=$4
VERTICA_DB=$5
ENV_PREFIX=$6
TENANTID=$7
TARGET_DIR=$8
VERTICA_SYSTEM_USER=$9
EXPORT_TYPE=${10:-export}        # Set to "dry-run" to execute in dry run mode (just test the env but export nothing)

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

if [[ ${EXPORT_TYPE} == "dry-run" ]]; then
    # Check that we can reach vertica (The command will fail and exit the script if we cannot connect)
    ${VSQL_PATH}/vsql -U ${VERTICA_USERNAME} -w ${VERTICA_PASSWORD} -p ${VERTICA_PORT} -d ${VERTICA_DB} -At -c "SELECT 1 FROM DUAL" \
        || { echo "Cannot query Vertica DB: ${VERTICA_DB}"; exit 1; }

    # Check that the target dir exists
    [[ -d ${TARGET_DIR} ]] || { echo "Target dir doesn't exist or is not a directory"; exit 1; }
    sudo -n su - ${VERTICA_SYSTEM_USER} -c "test -w ${TARGET_DIR}" || { echo "Target dir isn't writable by user: ${VERTICA_SYSTEM_USER}"; exit 1; }
else
    # Export tenant data
    if [[ -d ${TARGET_DIR}/vertica-${TENANTID} ]]; then
        # An old export already exists in the target folder - delete it first
        echo "Target directory already exists - removing it before recreating"
        sudo su - ${VERTICA_SYSTEM_USER} -c "rm -rf ${TARGET_DIR}/vertica-${TENANTID}"
    fi

    echo "Creating the target directory for the exported data: ${TARGET_DIR}/vertica-${TENANTID}"
    sudo su - ${VERTICA_SYSTEM_USER} -c "mkdir -p ${TARGET_DIR}/vertica-${TENANTID}"
    sudo su - ${VERTICA_SYSTEM_USER} -c "chmod 770 ${TARGET_DIR}/vertica-${TENANTID}"
    sudo su - ${VERTICA_SYSTEM_USER} -c "mkdir ${TARGET_DIR}/vertica-${TENANTID}/ddl"
    sudo su - ${VERTICA_SYSTEM_USER} -c "mkdir ${TARGET_DIR}/vertica-${TENANTID}/dumps"

    echo "Dumping DDL script"
    # Export ddl script and convert the env prefix in the schema name to the constant 'export'
    ${VSQL_PATH}/vsql -U ${VERTICA_USERNAME} -w ${VERTICA_PASSWORD} -p ${VERTICA_PORT} -d ${VERTICA_DB} -At -c "SELECT EXPORT_OBJECTS('','${ENV_PREFIX}_${TENANTID}',false);" | \
        sed "s/${ENV_PREFIX}_${TENANTID}/export_${TENANTID}/g" | gzip | \
        sudo su - ${VERTICA_SYSTEM_USER} -c "dd of=${TARGET_DIR}/vertica-${TENANTID}/ddl/export_${TENANTID}.ddl.gz"

    set +e
    arr=`${VSQL_PATH}/vsql -U ${VERTICA_USERNAME} -w ${VERTICA_PASSWORD} -p ${VERTICA_PORT} -d ${VERTICA_DB} \
         -c "SELECT table_name FROM v_catalog.tables WHERE table_schema='${ENV_PREFIX}_${TENANTID}'" -At`
    if [ $? -ne 0 ]; then
        echo "Failed to get tenant table names from vertica: $arr" >&2
        sudo su - ${VERTICA_SYSTEM_USER} -c "rm -rf ${TARGET_DIR}/vertica-${TENANTID}"
        exit 1
    fi
    set -e

    if [ ${#arr[@]} -eq 0 ]; then
        echo "No data for tenant ${TENANTID} - skipping vertica export"
        sudo su - ${VERTICA_SYSTEM_USER} -c "rm -rf ${TARGET_DIR}/vertica-${TENANTID}"
        exit 4
    fi

    for x in ${arr}
    do
        echo "Dumping table: $x"
        # Dump the table and replace the temp field separator (~~|~~) with a comma (after escaping special chars). Replacement is needed since import only works with single char separators
        ${VSQL_PATH}/vsql -U ${VERTICA_USERNAME} -w ${VERTICA_PASSWORD} -p ${VERTICA_PORT} -d ${VERTICA_DB} -F "~~|~~" -At -c "SELECT * FROM ${ENV_PREFIX}_${TENANTID}.${x};" | \
            sed -e 's/\\/\\\\/g' -e 's/,/\\,/g' -e 's/~~|~~/,/g' | gzip | \
            sudo su - ${VERTICA_SYSTEM_USER} -c "dd of=${TARGET_DIR}/vertica-${TENANTID}/dumps/${x}.dump.gz"
    done

    echo "Export done"
fi
