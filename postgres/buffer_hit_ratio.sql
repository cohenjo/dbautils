select case when (blks_hit+blks_read)=0 THEN 100 ELSE (blks_hit::real/(blks_hit+blks_read)) END as pct
from pg_stat_database ;