select (sum(st.numbackends)::real)/(select (setting::int) from pg_settings where name = 'max_connections') as pct_used_connections
from pg_stat_database st ;
