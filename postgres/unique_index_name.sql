select ct.relname as "table name", col.attname as "column name", ci.relname as "index name"
from pg_class ct
join pg_attribute col on (ct.oid = col.attrelid)
join pg_index i on (ct.oid = i.indrelid and col.attnum = ANY( i.indkey))
join pg_class ci on (i.indexrelid = ci.oid)
where 
ct.relname = 'entity_data_20'
and col.attname='entity_id'
and i.indisunique = true;
