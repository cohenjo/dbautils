REVOKE CONNECT ON DATABASE #{dbname} FROM public;
ALTER DATABASE #{dbname} CONNECTION LIMIT 0;
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE pid <> pg_backend_pid()
AND datname='#{dbname}';
DROP #{dbname};