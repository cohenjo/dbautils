-- 
-- File  : first_relation.sql
-- Auther: Jony Vesterman Cohen
-- Date  : 27/06/2013
--
-- Desc  : this script updates the r1 column with entity ids of same row number belonging to the next entity type.
--
    
-- select entity_id,entity_type_id, row_number(),d.entity_id,d.entity_type_id over (PARTITION BY entity_type_id ) from z_1.ent_0 o where o.entity_type_id=d.dest_type;

-- select * from z_1.ent_0 limit 1;

set search_path=z_1

create table z_1.r as select entity_id,entity_type_id,entity_type_id+1 as dest_type, row_number() over (PARTITION BY entity_type_id ) as rn from z_1.ent_0;
-- select * from z_1.r limit 1;
create table z_1.r1 as select o.entity_id orig_id,o.entity_type_id orig_type,d.entity_id dest_id,d.entity_type_id dest_type
from z_1.r o,z_1.r d 
where 1=1
and o.entity_type_id = d.dest_type
and o.rn=d.rn;

drop table z_1.r; -- no more use for it
-- select * from z_1.r1 limit 3;

-- update the values of r1 (1st relation column)
update z_1.ent_0 as o set r1=d.dest_id 
from z_1.r1 d 
where 
  o.entity_type_id = d.orig_type
  and o.entity_id=d.orig_id;


-- just see that we did things right :)
select o.entity_id,d.entity_id,o.entity_type_id,d.entity_type_id,o.r1
from ent_0 o,ent_0 d
where d.entity_id=o.r1;

commit;
--select distinct r1 from ent_0;
select * from z_1.ent_0;

--select * from r1;


 