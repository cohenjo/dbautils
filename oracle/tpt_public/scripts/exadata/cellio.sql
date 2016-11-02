COL cell_cell_path HEAD CELL_PATH FOR A20
COL cell_event     HEAD IO_TYPE   FOR A35
BREAK ON cell_event SKIP 1

SELECT /*+ CARDINALITY(a 100000) */ /* LEADING(c d) USE_HASH(d) USE_HASH(a) */
    a.event      cell_event
  , c.cell_path  cell_cell_path
--  , nvl(substr(d.name,1,30),'-') disk_name
  --, substr(d.path,1,30) disk_path
  , c.cell_hashval
  , COUNT(*)
FROM
    v$cell c
  , v$asm_disk d
  , v$active_session_history a
WHERE
    a.p1 = c.cell_hashval
--AND c.cell_path = replace(regexp_substr(d.path,'/(.*)/'),'/')
AND a.p2 = d.hash_value(+)
AND a.event LIKE 'cell%'
GROUP BY
    a.event
 --  , nvl(substr(d.name,1,30),'-') 
   --, substr(d.path,1,30)
   , c.cell_path
   , c.cell_hashval
ORDER BY
    a.event 
  , COUNT(*) DESC
/


