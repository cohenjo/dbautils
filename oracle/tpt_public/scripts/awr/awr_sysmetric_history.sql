SELECT
    CAST(begin_interval_time AS DATE) begin_time
  , metric_name
  , metric_unit
  , value
FROM
    dba_hist_snapshot
NATURAL JOIN
    dba_hist_sysmetric_history
WHERE
    metric_name IN ('Logons Per Sec')
AND begin_interval_time > SYSDATE - 30
ORDER BY
    metric_name
  , begin_time
/
