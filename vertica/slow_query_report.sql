-- File: slow_query_report.sql
-- the query extracts run time statistics of all SQL queries that took more than 2 seconds, in the last 5 hours, grouped by the user defined query labels
Select request_label ,user_name,request,pct_90, median,avg,max, number_of_runs, number_of_runs_above_sec
from
(
select
request_label ,
user_name,
request,
percentile_disc(.9) within group(order by request_duration_ms) over(partition by request_label , user_name) as "pct_90",
percentile_disc(.5) within group(order by request_duration_ms) over(partition by request_label , user_name) as "median",
avg(request_duration_ms) over(partition by request_label , user_name) as "avg",
max(request_duration_ms) over(partition by request_label , user_name) as "max",
count(*) over(partition by request_label , user_name) as "number_of_runs",
count(case when request_duration_ms>1000 then 1 else  null end) over(partition by request_label , user_name) as "number_of_runs_above_sec",
row_number   (   )   over   (      partition by request_label , user_name      order by request_duration_ms   )   as "row_num"
from query_requests
where start_timestamp>=sysdate()-5/24
and request_label<>''
and request_type='QUERY'
) inner_table
where row_num=1
and max>2000
order by max desc
