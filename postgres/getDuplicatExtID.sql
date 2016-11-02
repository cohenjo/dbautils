

create type test as (ids int[],c73 int);

CREATE OR REPLACE FUNCTION getDuplicateExternalIDs() RETURNS setof test AS
$BODY$
DECLARE
    tbl_name text;

               person_entity_type_id int;
               num test;
               index int :=0;
BEGIN
    select id from entity_descriptor where name='Person' and tenant_id='v4' into person_entity_type_id;
    FOR tbl_name IN select tablename from pg_tables where tablename similar to 'entities_\d*'  LOOP
              RAISE NOTICE 'checking duplicities in table: % ',quote_ident(tbl_name);
              EXECUTE FORMAT('select array_agg(entity_id),c73 from %I where entity_type_id=%L and is_deleted = %L group by c73 having count(c73) > 1;', tbl_name,person_entity_type_id,false) INTO num;
              return next num;
    END LOOP;
    RETURN ;
END
$BODY$
LANGUAGE plpgsql;

-- this will run the main function
select getDuplicateExternalIDs();
