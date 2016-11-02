CREATE OR REPLACE FUNCTION getDevicesCount() RETURNS int AS
$BODY$
DECLARE
    tbl_name text;
      
	device_id int;
	num int := 0;
	total int := 0;
BEGIN
    select id from entity_descriptor where name='Device' and tenant_id='v4' into device_id;       
    FOR tbl_name IN select tablename from pg_tables where tablename similar to 'entities_\d*'  LOOP
              RAISE NOTICE 'Counting table: % ',quote_ident(tbl_name);              
              EXECUTE FORMAT('select count(*) from %I where entity_type_id=%L and is_deleted = %L ;', tbl_name,device_id,false) INTO num;
              total := total + num;
              
    END LOOP;
    RETURN total;
END
$BODY$
LANGUAGE plpgsql;

-- this will run the main function
select getDevicesCount();
DROP FUNCTION getDevicesCount();
