SELECT count(*), substr(query,0,100) as substr_query, avg(query_duration_us) as avg_duration
FROM query_profiles
GROUP BY substr_query
ORDER BY avg_duration desc limit 5;