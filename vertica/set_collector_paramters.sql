select GET_DATA_COLLECTOR_POLICY('RequestsIssued'), GET_DATA_COLLECTOR_POLICY('RequestsCompleted');
SELECT set_data_collector_policy('RequestsCompleted', '10000', '200000');
SELECT set_data_collector_policy('RequestsIssued', '10000', '200000');
SELECT clear_data_collector('RequestsIssued');
SELECT clear_data_collector('RequestsCompleted');


SELECT * FROM v_monitor.data_collector where component like '%Load%';
SELECT set_data_collector_policy('LoadEvents', '10000', '200000');
SELECT GET_DATA_COLLECTOR_POLICY('LoadEvents');
