-- query_requests_retention_setting.sql
-- increase retention of Query Requests system table
SELECT set_data_collector_policy('RequestsCompleted', '10000', '200000');
SELECT set_data_collector_policy('RequestsIssued', '10000', '200000');
