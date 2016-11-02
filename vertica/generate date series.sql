create table test (sub varchar(255), service varchar(255),start_ts timestamp,end_ts timestamp,status varchar(255));
insert into test values ('Ally','CRM','8/3/2015'::timestamp,null,'Active');
insert into test values ('Ally','Salesforce','10/10/2015'::timestamp,null,'Active');
insert into test values ('Alan','CRM','9/1/2015'::timestamp,'10/31/2015'::timestamp,'Expired');
insert into test values ('Scott','CRM','9/10/2015'::timestamp,'12/31/2015'::timestamp,'Suspended');
insert into test values ('Stanley','Salesforce','8/2/2015'::timestamp,'12/31/2015'::timestamp,'Active');

WITH months(mon) AS (
SELECT DATE_TRUNC('month',ts::DATE) as month
FROM (SELECT '01/01/2015'::TIMESTAMP as tm
      UNION
      SELECT '01/01/2016'::TIMESTAMP as tm) as t
TIMESERIES ts as '1 Month' OVER (ORDER BY tm))
select mon,count(case when service = 'CRM' then 1 else 0 end) as CRM 
FROM (select * from test JOIN months ON (months.mon between test.start_ts and COALESCE(end_ts,'01/01/2016'::DATE))) foo
group by mon;

WITH months(mon) AS (
SELECT DATE_TRUNC('month',ts::DATE) as month
FROM (SELECT '01/01/2015'::TIMESTAMP as tm
      UNION
      SELECT '01/01/2016'::TIMESTAMP as tm) as t
TIMESERIES ts as '1 Month' OVER (ORDER BY tm))
select mon,service, count(*) as CRM 
FROM (select * from test JOIN months ON (months.mon between  DATE_TRUNC('month',test.start_ts) and COALESCE(end_ts,'01/01/2016'::DATE))) foo
group by mon,service
ORDER BY service,mon;


SELECT st,service ,TS_FIRST_VALUE(start_ts),TS_LAST_VALUE(end_ts)
FROM test
TIMESERIES st AS '1 month' OVER (partition by service order by start_ts)


select TIME_SLICE(start_ts,1,'month'),service,count(*) OVER (partition by service order by month(start_ts)) from test;


select MONTH(start_ts) sm,MONTH(COALESCE(end_ts,now())) em,service from test;