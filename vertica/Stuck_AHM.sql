

-- get current status
SELECT GET_AHM_EPOCH(), GET_AHM_TIME(), GET_CURRENT_EPOCH();

-- prevent new connections
Select set_config_parameter(‘MaxClientSessions’,0);

-- close off all sessions:
Select close_all_sessions();
-- Check the transactions that were stuck in WOS (attached the list)
select * from storage_containers where storage_type='WOS';
-- Ran moveout task
Select do_tm_task(‘moveout’);
-- Checked the transactions in WOS (it came to 0)
select * from storage_containers where storage_type='WOS'; -- this should return no rows
-- Ran mergeout task
Select do_tm_task(‘mergeout);
-- Check the ahm status and it came to current now
SELECT GET_AHM_EPOCH(), GET_AHM_TIME(), GET_CURRENT_EPOCH();

-- only superuser can run this, in theory if all the above steps completed successfully there is no need as it will happen automatically.
-- SELECT MAKE_AHM_NOW();