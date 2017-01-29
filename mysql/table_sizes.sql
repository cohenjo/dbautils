-- file: table_sizes.sql
-- table size query
SELECT s.schema_name, CONCAT(IFNULL(ROUND((SUM(t.data_length)+ SUM(t.index_length))/1024/1024,2),0.00),'Mb') total_size, CONCAT(IFNULL(ROUND(((SUM(t.data_length)+SUM(t.index_length))- SUM(t.data_free))/1024/1024,2),0.00),'Mb') data_used,CONCAT(IFNULL(ROUND(SUM(data_free)/1024/1024,2),0.00),'Mb') data_free,
IFNULL(ROUND((((SUM(t.data_length)+SUM(t.index_length))- SUM(t.data_free))/((SUM(t.data_length)+SUM(t.index_length)))*100),2),0) pct_used, COUNT(table_name) total_tables
FROM information_schema.schemata s
LEFT JOIN information_schema.tables t ON s.schema_name = t.table_schema WHERE s.schema_name != 'information_schema'
GROUP BY s.schema_name ORDER BY pct_used DESC\G
