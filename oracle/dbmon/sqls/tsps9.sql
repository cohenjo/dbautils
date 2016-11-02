------------------------------------------------------------------------------
-- show9tsps.sql
--
-- This SQL Plus script lists freespace by tablespace
------------------------------------------------------------------------------

set verify off
set feedback off

column  Name 			format a15
column  "Extent Management"			heading "Extent|Management"
column  "Used (M)"   		format 9,999    heading "Used|(MB)"
column  "Free %"    		format 999   	heading "%|Free"

break   on report
compute sum of "Size (M)" on report
compute sum of "Used (M)" on report

SELECT d.tablespace_name "Name", d.contents "Type", d.status "Status",
       d.extent_management "Extent Management",
       NVL (a.bytes / 1024 / 1024, 0) "Size (M)",
       NVL (  a.bytes - NVL (f.bytes, 0), 0) / 1024 / 1024 "Used (M)",
       100 - (NVL ((  a.bytes - NVL (f.bytes, 0)) / a.bytes * 100,0)) "Free %"
  FROM sys.dba_tablespaces d,
       (SELECT   tablespace_name, SUM (bytes) bytes
            FROM dba_data_files
        GROUP BY tablespace_name) a,
       (SELECT   tablespace_name, SUM (bytes) bytes
            FROM dba_free_space
        GROUP BY tablespace_name) f
 WHERE d.tablespace_name = a.tablespace_name(+)
   AND d.tablespace_name = f.tablespace_name(+)
   AND NOT (    d.extent_management LIKE 'LOCAL'
            AND d.contents LIKE 'TEMPORARY'
           )
UNION ALL
SELECT d.tablespace_name "Name", d.contents "Type", d.status "Status",
       d.extent_management "Extent Management",
       NVL (a.bytes / 1024 / 1024, 0) "Size (M)",
       NVL (t.bytes, 0) / 1024 / 1024  "Used (M)",
       100 - (NVL (t.bytes / a.bytes * 100, 0)) "Free %"
  FROM sys.dba_tablespaces d,
       (SELECT   tablespace_name, SUM (bytes) bytes
            FROM dba_temp_files
        GROUP BY tablespace_name) a,
       (SELECT   tablespace_name, SUM (bytes_cached) bytes
            FROM v$temp_extent_pool
        GROUP BY tablespace_name) t
 WHERE d.tablespace_name = a.tablespace_name(+)
   AND d.tablespace_name = t.tablespace_name(+)
   AND d.extent_management LIKE 'LOCAL'
   AND d.contents LIKE 'TEMPORARY'
/
exit
/
