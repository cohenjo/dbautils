--
-- file name: execution_engine_profiles.sql
-- Auther: Sharon Dashet (sharon.dashet@hp.com)
-- Date: 08/04/2014
--
select node_name, operator_name,min(start_date) as min_start_date, max(end_date) as max_end_date, datediff(second,min(start_date),max(end_date))  as operator_execution_time_sec, datediff(second,min(min(start_date)) over(),max(max(end_date)) over())  as total_execution_time_sec
from
(SELECT node_name, operator_id,operator_name,counter_name,counter_value
,case when counter_name = 'start time' then (internal_to_timestamptz(counter_value)) else null  end as start_date
,case when counter_name = 'end time' then (internal_to_timestamptz(counter_value)) else  null  end as end_date
FROM v_monitor.execution_engine_profiles
--WHERE  counter_name='execution time (us)' 
where  (transaction_id, statement_id) IN
(SELECT transaction_id, statement_id FROM query_requests 
WHERE session_id= (SELECT session_id FROM v_monitor.current_session_p)
AND is_executing=false order BY end_timestamp DESC LIMIT 1) 
order by operator_name, counter_name
) a
group by node_name, operator_name
order by  max_end_date;
