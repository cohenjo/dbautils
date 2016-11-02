select count(*) as total_connections, count(case when statement_id is not null then 1 else null end ) as active_connections, count(case when statement_id is  null then 1 else null end ) as idle_connections, 
client_pid, substring(client_hostname,1,instr(client_hostname,':',-1,1)-1) as host_ip, user_name as user_schema
from sessions
group by client_pid, substring(client_hostname,1,instr(client_hostname,':',-1,1)-1), user_name
order by client_pid, user_name
