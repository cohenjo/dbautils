select 
s.node_name
,s.user_name
,s.client_hostname
,s.transaction_start
,s.statement_start
,qp.query
,qp.query_duration_us
from sessions s join query_profiles qp on (qp.statement_id = s.statement_id)
where qp.query_duration_us > 1946533
order by qp.query_duration_us desc ;