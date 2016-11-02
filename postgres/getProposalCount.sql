CREATE OR REPLACE FUNCTION getProposalCount() RETURNS int AS
$BODY$
DECLARE
  tbl_name text;
	device_id int;
  currency_id text;
  col_id text;
	num int := 0;
	total int := 0;
  dist int := 0;
BEGIN
    select id from entity_descriptor where name='Proposal' and tenant_id='v4' into device_id;
     select physical_type_name from entitydescriptor_mapping where entity_type='Proposal' and logical_type_name='Cost' and tenant_id='v4' into col_id;
     select physical_type_name from entitydescriptor_mapping where entity_type='Proposal' and logical_type_name='Currency' and tenant_id='v4' into currency_id;
    FOR tbl_name IN select tablename from pg_tables where tablename similar to 'entities_\d*'  LOOP

              EXECUTE FORMAT('select count(*),count(distinct %I), sum(case when %I::double precision <> 0 then 1 else 0 end) from %I where entity_type_id=%L and is_deleted = %L ;',currency_id,col_id, tbl_name,device_id,false) INTO total, dist,num;
              RAISE NOTICE 'Counting table: % , total: % ,distinct currency: %, count: %',tbl_name,total,dist,num;
    END LOOP;
    RETURN 1;
END
$BODY$
LANGUAGE plpgsql;

-- this will run the main function
select getProposalCount();
--DROP FUNCTION getDevicesCount();
