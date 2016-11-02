SELECT pool_name,100*sum(memory_inuse_kb)/sum(memory_size_actual_kb) 
FROM V_MONITOR.RESOURCE_POOL_STATUS group by pool_name;
