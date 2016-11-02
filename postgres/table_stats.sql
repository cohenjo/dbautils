select relid,s.schemaname,s.relname, s.last_vacuum,s.last_analyze,s.n_dead_tup,s.n_live_tup,s.n_dead_tup/(s.n_live_tup+s.n_dead_tup+1)::float as dead_to_live_ratio,
CASE WHEN s.last_vacuum is null  THEN 'vacuum ' || relname
     WHEN s.last_analyze is null THEN 'vacuum analyze ' || relname
     ELSE 'vacuum full ' || relname
END as recommendation
from pg_catalog.pg_stat_all_tables s
where
coalesce(s.last_vacuum,'01-01-2000') < CURRENT_DATE - 5 -- last vacuumed more than 5 days ago
or s.n_dead_tup/(s.n_live_tup+s.n_dead_tup+1)::float > 0.3






--select * from pg_stat_all_indexes i;
