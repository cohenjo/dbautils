SELECT * FROM pg_settings where name like '%checkpoint%'  or name like '%wal%' or name like '%bgwriter%';


SELECT
total_checkpoints,
seconds_since_start / total_checkpoints / 60 AS minutes_between_checkpoints
FROM
(SELECT
	EXTRACT(EPOCH FROM (now() - pg_postmaster_start_time())) AS seconds_since_start,
	(checkpoints_timed+checkpoints_req) AS total_checkpoints
FROM pg_stat_bgwriter
) AS sub;

select * from pg_stat_bgwriter;