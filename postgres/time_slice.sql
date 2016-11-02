select generate_series(ts,COALESCE(lead(ts) OVER(),ts+INTERVAL'2 second'),INTERVAL'1 second')::timestamp as ts,bid from tik;

with times as (select generate_series(timestamp'2014-04-24 10:36:00',timestamp'2014-04-24 10:36:00'+INTERVAL'10 seconds',INTERVAL'2 second')::timestamp as ts )
select *,first_value(bid) over (),lag(bid,1) over () from  times
left join tik on (tik.ts <@ tsrange(times.ts,times.ts+INTERVAL'2 second'));


with times as (select generate_series(timestamp'2014-04-24 10:36:00',timestamp'2014-04-24 10:36:00'+INTERVAL'10 seconds',INTERVAL'2 second')::timestamp as ts )
select *,first_value(bid) over (),lag(bid,1) over (),row_number() over() from  times
left join tik on (tik.ts <@ tsrange(times.ts,times.ts+INTERVAL'2 second'));



# select * from tik order by ts;
         ts          | symbol | bid
---------------------+--------+-----
 2014-04-24 10:36:03 | HPQ    |  10
 2014-04-24 10:36:08 | HPQ    |  12
 2014-04-24 10:36:11 | HPQ    |  13
 2014-04-24 10:36:13 | HPQ    |  15
 2014-04-24 10:36:15 | HPQ    |  11
(5 rows)

select gsts
,bid as static_bid
, bid*(cume_dist() OVER(inter))+ nbid*(1-cume_dist() OVER(inter)) as linear_bid
from
(
select generate_series(ts,COALESCE(nts,ts+INTERVAL'1 second')-(INTERVAL'1 s'/2),INTERVAL'1 s')::timestamp as gsts
,bid
,COALESCE(nbid,bid) as nbid
from
(select *,lead(ts) OVER(order by ts) as nts,lead(bid) OVER(order by ts) as nbid from tik order by ts) as tiks
) foo
WINDOW inter AS (partition by bid order by gsts desc)
order by gsts;


        gsts         | static_bid |    linear_bid
---------------------+------------+------------------
 2014-04-24 10:36:03 |         10 |               10
 2014-04-24 10:36:04 |         10 |             10.4
 2014-04-24 10:36:05 |         10 |             10.8
 2014-04-24 10:36:06 |         10 |             11.2
 2014-04-24 10:36:07 |         10 |             11.6
 2014-04-24 10:36:08 |         12 |               12
 2014-04-24 10:36:09 |         12 | 12.3333333333333
 2014-04-24 10:36:10 |         12 | 12.6666666666667
 2014-04-24 10:36:11 |         13 |               13
 2014-04-24 10:36:12 |         13 |               14
 2014-04-24 10:36:13 |         15 |               15
 2014-04-24 10:36:14 |         15 |               13
 2014-04-24 10:36:15 |         11 |               11
(13 rows)


CREATE OR REPLACE FUNCTION time_slice_day(ts timestamp, intr interval) RETURNS  timestamp
as $$
declare
	i real ;
	diff_l bigint;
	inter_l bigint;
	start timestamp;
	ret timestamp;
	diff interval;
begin
	start := date_trunc('day',ts) ;
	diff := ts-start ;
	SELECT into diff_l,inter_l EXTRACT(EPOCH FROM diff),EXTRACT(EPOCH FROM intr)  ;
	i:= diff_l/inter_l ;
	ret:= start + (i*intr);
	return ret;
end;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION time_slice_year(ts timestamp, intr interval) RETURNS  timestamp
as $$
declare
	i real ;
	start timestamp;
	ret timestamp;
begin
	start := date_trunc('year',ts) ;
	i:= (EXTRACT(EPOCH FROM (ts-start))::bigint)/(EXTRACT(EPOCH FROM intr)::bigint) ;
	ret:= start + (i*intr);
	return ret;
end;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION time_slice(ts timestamp, intr interval) RETURNS  timestamp
as $$
begin
	IF intr > '1 day'::interval then
		RETURN time_slice_year(ts,intr);
	ELSE
		RETURN time_slice_day(ts,intr);
	END IF;
return ret;
end;
$$ LANGUAGE plpgsql;


select time_slice_day('2014-04-24 10:36:03'::timestamp, '00:01:00'::interval);
select time_slice_year('2014-04-24 10:36:03'::timestamp, '1 month'::interval);
select time_slice('2014-04-24 10:36:03'::timestamp, '1 month'::interval);




---------------------------------------------------------------------------------------
-- FINAL VERSION
---------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION time_slice(ts timestamp, intr interval) RETURNS  timestamp
as $$
begin	
	return date_trunc('year',ts) + intr*(EXTRACT(EPOCH FROM (ts-date_trunc('YEAR',ts)))::bigint/(EXTRACT(EPOCH FROM intr)::bigint));
end;
$$ LANGUAGE plpgsql;
select time_slice('2014-04-24 10:36:03'::timestamp, '1 month'::interval);
select time_slice('2014-04-24 10:36:03'::timestamp, '00:05:00'::interval);


CREATE OR REPLACE FUNCTION time_slice(ts bigint, intr bigint) RETURNS  timestamp
as $$
begin
	--return time_slice(to_timestamp(ts)::timestamp,(intr* INTERVAL '1 second')::interval );
	return EXTRACT(EPOCH FROM time_slice(to_timestamp(ts)::timestamp,(intr* INTERVAL '1 second')::interval ));
end;
$$ LANGUAGE plpgsql;
select time_slice(1398335763,2592000);
--select to_timestamp(time_slice(EXTRACT(EPOCH FROM '2014-04-24 10:36:03'::timestamp), EXTRACT(EPOCH FROM '1 month'::interval)));
--select to_timestamp(time_slice(EXTRACT(EPOCH FROM '2014-04-24 10:36:03'::timestamp), EXTRACT(EPOCH FROM '00:05:00'::interval)));
select time_slice(1398335763 , 300);

i = 538.5355779320987654320987654321
2451545 + (i*2592000)
1396310400
-------------------------------------------------------------------------
-- sample
-------------------------------------------------------------------------

select gsts
,bid as static_bid
, bid*(cume_dist() OVER(inter))+ nbid*(1-cume_dist() OVER(inter)) as linear_bid
from
(
select generate_series(ts,COALESCE(nts,ts+INTERVAL'3 second')-(INTERVAL'3 s'/2),INTERVAL'3 s')::timestamp as gsts
,bid
,COALESCE(nbid,bid) as nbid
from
(select time_slice(ts,'3 sec'::interval) as ts,symbol,bid,lead(time_slice(ts,'3 sec'::interval)) OVER(order by ts) as nts,lead(bid) OVER(order by ts) as nbid from tik order by ts) as tiks
) foo
WINDOW inter AS (partition by bid order by gsts desc)
























CREATE OR REPLACE FUNCTION time_slice(ts timestamp, intr double precision) RETURNS  timestamp
as $$
begin	
	return ts + '1 sec'::interval*EXTRACT(EPOCH FROM ts)*(EXTRACT(EPOCH FROM (ts-date_trunc('YEAR',ts)))::bigint/( intr));
end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION time_slice(ts timestamp, intr interval) RETURNS  timestamp
as $$
begin	
	return date_trunc('year',ts) + intr*(EXTRACT(EPOCH FROM (ts-date_trunc('YEAR',ts)))::bigint/(EXTRACT(EPOCH FROM intr)::bigint));
end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION time_slice(ts timestamp, intr interval) RETURNS  timestamp
as $$
begin	
	return '2000-01-01 00:00:00'::timestamp + intr*(EXTRACT(EPOCH FROM (ts-'2000-01-01 00:00:00'::timestamp))::bigint)/(EXTRACT(EPOCH FROM intr)::bigint);
end;
$$ LANGUAGE plpgsql;
select time_slice('2014-04-24 10:36:03'::timestamp, '1 month'::interval);
select time_slice('2014-04-24 10:36:03'::timestamp, '00:05:00'::interval);
