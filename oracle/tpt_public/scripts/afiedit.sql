SELECT sql_id, COUNT(*) FROM v$sql GROUP BY sql_id HAVING COUNT(*) > 3
/
