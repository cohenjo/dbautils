SELECT /*+ MONITOR */
    MIN(t1.created), MAX(t1.created)
FROM
    t1
  , t2
  , t3
WHERE
    t1.object_id = t2.object_id
AND t2.object_id = t3.object_id
AND t1.owner = :v1
AND t2.owner = :v2
AND t3.owner = :v3
/
