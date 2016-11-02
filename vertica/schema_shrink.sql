


CREATE SCHEMA yechieto_100000002_bck;
\t
\o /tmp/schema_migration.sql
select 'ALTER TABLE ' || table_schema || '.' ||table_name||' SET SCHEMA ' || table_schema || '_bck CASCADE;' from tables where table_schema='yechieto_100000002' AND table_name<>'relations' ;
\o

\o /tmp/schema_shrink.sql
select 'create table ' || table_schema || '.'||table_name|| ' AS select b.* from ' || table_schema || '_bck.'||table_name|| ' b JOIN (select Id, MAX(LastUpdateTime) AS MaxUpdateTime  FROM ' || table_schema || '_bck.'||table_name|| ' group by Id) LUT ON (b.Id = LUT.Id AND LUT.MaxUpdateTime = b.LastUpdateTime);' from tables where table_schema='yechieto_100000002' AND table_name<>'relations' ;
\o

create table yechieto_100000002_bck.relations as select * from  yechieto_100000002.relations;

\i /tmp/schema_migration.sql
\i /tmp/schema_shrink.sql