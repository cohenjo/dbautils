 select  relname,pg_size_pretty(pg_total_relation_size(oid)),pg_total_relation_size(oid)
from pg_class
where relkind = 'r'
AND relname in ('entity_data_1', 'long_data_1', 'relation_1','entity_name_1','arc_entity_data_1', 'arc_long_data_1', 'arc_relation_1', 'arc_entity_data_1_y2011', 'arc_long_data_1_y2011', 'arc_relation_1_y2011' , 'arc_entity_name_1_y2011', 'arc_entity_data_1_y2012', 'arc_long_data_1_y2012', 'arc_relation_1_y2012' , 'arc_entity_name_1_y2012', 'arc_entity_data_1_y2013', 'arc_long_data_1_y2013', 'arc_relation_1_y2013' , 'arc_entity_name_1_y2013');
ORDER BY 3 desc;
