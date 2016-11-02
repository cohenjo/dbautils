SELECT
    *
FROM
    v$system_fix_control
WHERE
    LOWER(description) LIKE LOWER('%&1%')
OR  LOWER(sql_feature) LIKE LOWER('%&1%')
OR  TO_CHAR(bugno)     LIKE LOWER('%&1%')
/

