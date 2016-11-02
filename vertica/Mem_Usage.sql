

SELECT avg(average_memory_usage_percent) FROM memory_usage where TIME_SLICE(start_time,1) = TIME_SLICE(SYSDATE(),1) ;

select count(*) from tables ;


create schema if not exists z_2;
drop schema z_2 cascade;


SELECT TIME_SLICE(ts,1,'MINUTE'),o.num_objects, avg(mu.average_memory_usage_percent)
FROM memory_usage mu ,z_1.objects_number o
WHERE TIME_SLICE(ts,1,'MINUTE') = end_time
GROUP BY o.num_objects,TIME_SLICE(ts,1,'MINUTE')
ORDER BY 1;

