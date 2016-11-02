-- poll on lock to avoid creating a long queue of requests...

DO $f$
    DECLARE ntries INT := 10;
        sleepytime INT := 2;
    BEGIN
    SET lock_timeout = '100ms';
    FOR get_lock IN 1 .. ntries LOOP
            BEGIN
                    LOCK TABLE mytable IN ACCESS EXCLUSIVE MODE;
                    ALTER TABLE mytable ADD COLUMN a int,
                            ADD COLUMN b INT,
                            ADD COLUMN c INT;
                    RAISE INFO 'table updated';
                    RETURN;
            EXCEPTION
                    WHEN lock_not_available THEN
                            PERFORM pg_sleep(sleepytime);
            END;
    END LOOP;

    RAISE INFO 'unable to obtain lock after % tries', ntries;

    END;$f$;

-- for pre-9.3 versions use this:
    DO $f$
     DECLARE ntries INT := 10;
         sleepytime INT := 2;
     BEGIN

     FOR get_lock IN 1 .. ntries LOOP
             BEGIN
                     LOCK TABLE mytable
                     IN ACCESS EXCLUSIVE MODE NOWAIT;
                     ALTER TABLE mytable ADD COLUMN new_col1 INT,
                             ADD COLUMN new_col2 VARCHAR;
                     RAISE INFO 'table updated';
                     RETURN;
             EXCEPTION
                     WHEN lock_not_available THEN
                             PERFORM pg_sleep(sleepytime);
             END;
     END LOOP;

     RAISE INFO 'unable to obtain lock after % tries', ntries;

     END;$f$;
