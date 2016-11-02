-- script
\o pg_stat_output.txt
\a
select * from pg_stat_all_tables;
select * from pg_stat_all_indexes;
-- select * from pg_stat_all_sequences;
select * from pg_statio_all_tables;
select * from pg_statio_all_indexes;
select * from pg_statio_all_sequences;

select * from pg_stats;
select pg_lock_status();

\o pg_setting.txt
\a
Select * from pg_settings;
-- pg_show_all_settings()
select datname, pg_size_pretty(pg_database_size(datname)) from pg_stat_database;
select * from pg_stat_database;
Select * from pg_stat_bgwriter;

\o pg_workload.txt
\a
select datid, pg_stat_get_db_xact_rollback(datid),
pg_stat_get_db_xact_commit(datid),
pg_stat_get_db_blocks_fetched(datid),
pg_stat_get_blocks_hit(datid) ,
pg_stat_get_numscans(datid),
pg_stat_get_tuples_hot_updated(datid),
pg_stat_get_blocks_fetched(datid),
pg_stat_get_blocks_hit(datid)
from pg_stat_database;

\o pg_maintenance.txt
\a
select datid, pg_stat_get_last_vacuum_time(datid),
pg_stat_get_last_autovacuum_time(datid),
pg_stat_get_last_analyze_time(datid),
pg_stat_get_last_autoanalyze_time(datid)
from pg_stat_database;

\o pg_users_info.txt
\a
-- users info
select * from pg_user;
select * from pg_roles;