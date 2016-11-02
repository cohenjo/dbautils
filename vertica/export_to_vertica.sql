CONNECT TO VERTICA CIDB2 USER maas_admin PASSWORD 'maas_admin_123' ON '16.60.141.191',5433;

\o /tmp/export_script.sql
select 'EXPORT TO VERTICA ' || 'CIDB2.' || SCHEMA_NAME || '.' || TABLE_NAME || ' FROM ' || SCHEMA_NAME || '.' || TABLE_NAME || ';'
from ALL_TABLES
WHERE SCHEMA_NAME in ('dev_nightly_qa_377995173','dev_nightly_qa_733714229','dev_nightly_qa_653143188','dev_nightly_qa_231758708','dev_nightly_qa_246389889','dev_nightly_qa_farm_management','dev_nightly_qa_mockTenant');
\o
\i /tmp/export_script.sql
DISCONNECT CIDB2;


select SCHEMA_NAME
from schemata
WHERE SCHEMA_NAME like 'dev_nightly_qa%';


\t
\o /tmp/export_catalog.sql
select EXPORT_OBJECTS('','dev_nightly_qa_377995173',false);
select EXPORT_OBJECTS('','dev_nightly_qa_733714229',false);
select EXPORT_OBJECTS('','dev_nightly_qa_653143188',false);
select EXPORT_OBJECTS('','dev_nightly_qa_231758708',false);
select EXPORT_OBJECTS('','dev_nightly_qa_246389889',false);
select EXPORT_OBJECTS('','dev_nightly_qa_farm_management',false);
select EXPORT_OBJECTS('','dev_nightly_qa_mockTenant',false);
\o