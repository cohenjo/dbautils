\echo make sure to set the table & col parameters
\echo table name: :table
\echo column:     :col
select anchor_table_schema,anchor_table_name,projection_name,column_name,row_count,used_bytes/1024/1024 used_MB,encodings,compressions 
from column_storage 
where anchor_table_name=':table'
  and column_name = ':col';



