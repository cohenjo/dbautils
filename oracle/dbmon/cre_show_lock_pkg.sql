conn / as sysdba
CREATE OR REPLACE PACKAGE SHOW_LOCK_PKG
IS
--
-- This package contains routines to support the I/watch instance monitor
--
    -- Global indicating that the debug is off/on 0/1
    g_debug                        NUMBER:=0;
    g_tree_align		   NUMBER:=3;
    g_header_display		   NUMBER:=0;

    g_const_col_username	   NUMBER:=26;
    g_const_col_pid		   NUMBER:=41;
    g_const_col_locked_obj	   NUMBER:=48;

    g_spaces			   varchar2(100):='                                                  ';

    -- Print the current lock-tree
    PROCEDURE showlock;
END; 
/

CREATE OR REPLACE Package Body SHOW_LOCK_PKG
IS
    --
    -- This package contains routines used my the show locked 
    --
    --

    /* -------------------------------------------------------------------
    || All the declarations below relate to the showlock functionality
    */ --------------------------------------------------------------------
    -- This cursor gets the data from v$lock
    CURSOR C_LOCK IS
           select 	rownum,	sid ,    type ltype,    request,    lmode,
	               decode(type,
                             'BL','Buffer table',
                             'CF','Control file',
                             'CI','Cross-instance',
                             'CS','Control file',
                             'CU','Cursor bind',
                             'DF','Data file instance',
                             'DL','Direct loader',
                             'DM','Mount/startup instance',
                             'DR','Distributed recovery process',
                             'DX','Distributed transaction entry',
                             'FI','SGA open-file information',
                             'FS','File set',
                             'HW','Space management',
                             'IN','Instance number',
                             'IR','Instance recovery',
                             'IS','Instance state',
                             'IV','Library cache',
                             'JQ','Job queue',
                             'KK','Thread kick',
                             'MB','Master buffer',
                             'MM','Mount gloabal',
                             'MR','Media recovery',
                             'PF','Password file',
                             'PI','Parallel operation',
                             'PR','Process startup',
                             'PS','Parallel operation',
                             'RE','USE_ROW_ENQUEUE enforcement',
                             'RT','Redo thread global enqueue',
                             'RW','Row wait enqueue',
                             'SC','System commit instance',
                             'SH','System commit enqueue',
                             'SM','SMON',
                             'SN','Seq num instance',
                             'SQ','Seq num enqueue',
                             'SS','Sort segment',
                             'ST','Space transaction enqueue',
                             'SV','Sequence number value',
                             'TA','Generic enqueue',
                             'TD','DDL enqueue',
                             'TE','Extend-segment enqueue',
                             'TM','DML enqueue',
                             'TT','Temp table enqueue',
                             'TX','Tran enqueue',
                             'UL','User supplied',
                             'UN','User name',
                             'US','Undo segment DDL',
                             'WL','Written redo ',
                             'WS','Write-log-switch ',
                             'TS',decode(id2,0,'Temporary enqueue  (ID2=0)',
                                               'New alloc enqueue  (ID2=1)'),
                             'LA','Library (A=namespace)',
                             'LB','Library (B=namespace)',
                             'LC','Library (C=namespace)',
                             'LD','Library (D=namespace)',
                             'LE','Library (E=namespace)',
                             'LF','Library (F=namespace)',
                             'LG','Library (G=namespace)',
                             'LH','Library (H=namespace)',
                             'LI','Library (I=namespace)',
                             'LJ','Library (J=namespace)',
                             'LK','Library (K=namespace)',
                             'LL','Library (L=namespace)',
                             'LM','Library (M=namespace)',
                             'LN','Library (N=namespace)',
                             'LO','Library (O=namespace)',
                             'LP','Library (P=namespace)',
                             'LS','Log switch',
                             'PA','Library (A=namespace)',
                             'PB','Library (B=namespace)',
                             'PC','Library (C=namespace)',
                             'PD','Library (D=namespace)',
                             'PE','Library (E=namespace)',
                             'PF','Library (F=namespace)',
                             'PG','Library (G=namespace)',
                             'PH','Library (H=namespace)',
                             'PI','Library (I=namespace)',
                             'PJ','Library (J=namespace)',
                             'PL','Library (K=namespace)',
                             'PK','Library (L=namespace)',
                             'PM','Library (M=namespace)',
                             'PN','Library (N=namespace)',
                             'PO','Library (O=namespace)',
                             'PP','Library (P=namespace)',
                             'PQ','Library (Q=namespace)',
                             'PR','Library (R=namespace)',
                             'PS','Library (S=namespace)',
                             'PT','Library (T=namespace)',
                             'PU','Library (U=namespace)',
                             'PV','Library (V=namespace)',
                             'PW','Library (W=namespace)',
                             'PX','Library (X=namespace)',
                             'PY','Library (Y=namespace)',
                             'PZ','Library (Z=namespace)',
                              'QA','Row cache (A=cache)',
                              'QB','Row cache (B=cache)',
                              'QC','Row cache (C=cache)',
                              'QD','Row cache (D=cache)',
                              'QE','Row cache (E=cache)',
                              'QF','Row cache (F=cache)',
                              'QG','Row cache (G=cache)',
                              'QH','Row cache (H=cache)',
                              'QI','Row cache (I=cache)',
                              'QJ','Row cache (J=cache)',
                              'QL','Row cache (K=cache)',
                              'QK','Row cache (L=cache)',
                              'QM','Row cache (M=cache)',
                              'QN','Row cache (N=cache)',
                              'QO','Row cache (O=cache)',
                              'QP','Row cache (P=cache)',
                              'QQ','Row cache (Q=cache)',
                              'QR','Row cache (R=cache)',
                              'QS','Row cache (S=cache)',
                              'QT','Row cache (T=cache)',
                              'QU','Row cache (U=cache)',
                              'QV','Row cache (V=cache)',
                              'QW','Row cache (W=cache)',
                              'QX','Row cache (X=cache)',
                              'QY','Row cache (Y=cache)',
                              'QZ','Row cache (Z=cache)',
                              'unknown'
                            ) lock_type,
	               decode(lmode,
		                          0, 'None',           /* Mon Lock equivalent */
	                              1, 'Null',           /* N */
		                          2, 'Row-S (SS)',     /* L */
		                          3, 'Row-X (SX)',     /* R */
		                          4, 'Share',          /* S */
		                          5, 'S/Row-X (SSX)',  /* C */
		                          6, 'Exclusive',      /* X */
		                          to_char(lmode)) mode_held,
                decode(request,
		                          0, 'None',           /* Mon Lock equivalent */
		                          1, 'Null',           /* N */
		                          2, 'Row-S (SS)',     /* L */
		                          3, 'Row-X (SX)',     /* R */
		                          4, 'Share',          /* S */
		                          5, 'S/Row-X (SSX)',  /* C */
		                          6, 'Exclusive',      /* X */
		         to_char(request)) mode_requested,
                 id1 , id2 ,
                 block blocking,
                 decode(request,0,0,1) blocked
            from v$lock
           where request<>0 or block<>0 /* Only want blocked or blocking */
           order by sid, blocking desc,blocked desc;

    -- PL/SQL table stypes (array-types) to hold v$lock data
    TYPE      vtabtype is TABLE of varchar2(200) INDEX BY BINARY_INTEGER;
    TYPE      ntabtype IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;


    sid             ntabtype;   -- array of session identifiers.
    ltype           vtabtype;   -- array of lock type codes
    request         ntabtype;   -- array of request codes
    lock_type       vtabtype;   -- array of lock type text
    mode_held       vtabtype;   -- array of mode held text
    mode_requested  vtabtype;   -- array of mode requested text
    id1             ntabtype;   -- array of id1
    id2             ntabtype;   -- array of id2
    blocking        ntabtype;   -- array of 1= blocking 2=not blocking
    blocked         ntabtype;   -- array of 1=blocked 0= not blocked
    printed         ntabtype;   -- array of 1=entry has been printed.

    blocked_list      ntabtype;  -- List of sids which are blocked
    blocked_list_cnt  NUMBER:=0;
    blocking_list     ntabtype;  -- List of sids which are blocking
    blocking_list_cnt NUMBER:=0;

    lock_count      number:=0;   -- Limit on the above arrays.
    tree_depth      number:=0;   -- Keep track of tree depth.
    tree_sequence   NUMBER:=0;   -- Sequence to display

    /* -----------------------------------------------------------
    ** lock_hash_table implements a hash table on lock_type,id1
    ** These three values will be identical for users holding and wanting
    ** the same lock.  We hash lock_type,id1  to locate the first
    ** matching row.  The value of the row found is the index to
    ** sid, ltype, etc.    Subsequent rows will hold additional matching
    ** rows.
    ** A collision is pretty unlikely given the hashing scheme but is
    ** possible so each row returned needs to be validated - eg check
    ** lock_type, id1  to ensure they're what you think they should be.
    **
    ** f_lock_hash generates a hash value
    */ -----------------------------------------------------------
    lock_hash_table     ntabtype;

    /** -----------------------------------------------------------
    **  This table contains pointers to entries with a given sid
    **  The key is sid*10000
    */  -----------------------------------------------------------
    sid_hash_table      ntabtype;

    /*
    ** IW_showlock receives the lock tree information
    */
	TYPE typ_iw_showlock_row IS RECORD (
	  USER_AUDSID   NUMBER, 
	  SEQUENCE_ID   NUMBER, 
	  TREE_DEPTH    NUMBER, 
	  SID           NUMBER, 
	  SERIAL        NUMBER, 
	  USERNAME      VARCHAR2 (30), 
	  PID           VARCHAR2 (16), 
	  LOCK_TYPE     VARCHAR2 (30), 
	  REQUEST_MODE  VARCHAR2 (30), 
	  OBJECT_NAME   VARCHAR2 (61));

    
    iw_showlock_row    typ_iw_showlock_row;


    /* ===================================
    || Print a debug message
    =====================================*/
    PROCEDURE debug(in_string varchar2) is
    BEGIN
        IF g_debug=1 THEN
            dbms_output.put_line(in_string);
        END IF;
    END;

    /* ---------------------------------------------------------
    || Functions below here are for the showlock functionality
    */ ---------------------------------------------------------

        -- Add a sid to the blocking list
    PROCEDURE add_blocking(p_sid number) IS
        i NUMBER:=0;
    BEGIN
        FOR i IN 1..blocking_list_cnt LOOP
            IF blocking_list(i)=p_sid THEN
                RETURN;
            END IF;
        END LOOP;
        blocking_list_cnt:=blocking_list_cnt+1;
        blocking_list(blocking_list_cnt):=p_sid;
    END;

    --Add a sid to the blocked list
    PROCEDURE add_blocked(p_sid number) IS
        i NUMBER:=0;
    BEGIN
        FOR i IN 1..blocked_list_cnt LOOP
            IF blocked_list(i)=p_sid THEN
                RETURN;
            END IF;
        END LOOP;
        blocked_list_cnt:=blocked_list_cnt+1;
        blocked_list(blocked_list_cnt):=p_sid;
    END;

    --Is a sid blocking?
    FUNCTION is_blocking(p_sid NUMBER) RETURN BOOLEAN IS
        i NUMBER:=0;
    BEGIN
        FOR i IN 1..blocking_list_cnt LOOP
            IF blocking_list(i)=p_sid THEN
                RETURN(TRUE);
            END IF;
        END LOOP;
        RETURN (FALSE);
    END;

    --Is a sid blocked?
    FUNCTION is_blocked(p_sid NUMBER) RETURN BOOLEAN IS
        i NUMBER:=0;
    BEGIN
        FOR i IN 1..blocked_list_cnt LOOP
            IF blocked_list(i)=p_sid THEN
                RETURN(TRUE);
            END IF;
        END LOOP;
        RETURN (FALSE);
    END;


    -- Generate a hash value for lock_hash_table
    FUNCTION f_lock_hash(p_id1 number, p_id2 number)
        RETURN BINARY_INTEGER IS
        i NUMBER;
        l_work_string VARCHAR2(20):='000';
    BEGIN
        debug('building hash_value for '||p_id1||' '||p_id2);
        -- Build up a character string containing all the numbers
        l_work_string:=TO_CHAR(p_id1)||l_work_string;
        l_work_string:=TO_CHAR(p_id2)||l_work_string;
        -- Use mod to get a number which fits in BINARY_INTEGER
        -- Actually make the number <<2^31 to allow for overflow rows
        debug('building hash_value for '||l_work_string);
        RETURN(MOD(TO_NUMBER(l_work_string),2000000000));
    END;

    -- Add an entry to the hash tables
    PROCEDURE add_hash_table(p_lock_count NUMBER,
                             p_ltype      VARCHAR2,
                             p_id1        NUMBER,
                             p_id2        NUMBER,
                             p_sid        NUMBER) IS

        l_hash_value BINARY_INTEGER;
        l_test_value NUMBER;
        i            BINARY_INTEGER;

    BEGIN
        -- Get a hash value
        debug('getting hash_value');
        l_hash_value:=f_lock_hash(p_id1,p_id2);

        debug('hash value is '||l_hash_value);

        -- Starting with the hash value, look for an empty slot
        -- and when found, insert this value.
        i:=l_hash_value;
        <<Lock_Hash_loop>>
        LOOP
            BEGIN
                l_test_value:=lock_hash_table(i);
                --If here, a value was found, so try the next entry
                i:=i+1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                -- If here, we've found a blank slot.  So put the entry in it
                -- and exit.
                lock_hash_table(i):=p_lock_count;
                debug('Added '||p_lock_count||' to lock_hash_table '||i);
                EXIT Lock_Hash_loop;
            END;
        END LOOP;

        -- Now put an entry in the sid hash table
        i:=p_sid*10000;
        <<Sid_Hash_loop>>
        LOOP
            BEGIN
                l_test_value:=sid_hash_table(i);
                --If here, a value was found, so try the next entry
                i:=i+1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                sid_hash_table(i):=p_lock_count;
                debug('Adding sid_hash_table entry '||i||' for '||p_sid);
                EXIT Sid_Hash_loop;
            END;
        END LOOP;

    END;

    procedure load_vlock IS
        -- Load the v$lock table into arrays
    BEGIN
        lock_count:=0;
        debug('load_vlock');
        FOR r1 IN C_LOCK LOOP
            debug(lock_count||' '||r1.sid);
            lock_count:=lock_count+1;
            sid(lock_count):=r1.sid;
            ltype(lock_count):=r1.ltype;
            request(lock_count):=r1.request;
            lock_type(lock_count):=r1.lock_type;
            mode_held(lock_count):=r1.mode_held;
            mode_requested(lock_count):=r1.mode_requested;
            id1(lock_count):=r1.id1;
            id2(lock_count):=r1.id2;
            blocking(lock_count):=r1.blocking;
            blocked(lock_count):=r1.blocked;
            printed(lock_count):=0;

            -- add sid to the blocked/blocking lists
            IF r1.blocking=1 THEN
                add_blocking(r1.sid);
            END IF;
            IF r1.blocked=1 THEN
                add_blocked(r1.sid);
            END IF;

            -- Add blocked entries to the lock_hash_table
            debug('add hash_table '||lock_count||' '||r1.ltype||' '||r1.id1||' '||r1.id2);
            add_hash_table(lock_count,r1.ltype,r1.id1,r1.id2,r1.sid);

        END LOOP;
    END;

    -- Return the object name given an object id
    FUNCTION object_name(p_object_id NUMBER) RETURN VARCHAR2 IS
             CURSOR c_get_objname (cp_object_id NUMBER) IS
                    SELECT u.name||'.'||o.name name
                      FROM sys.obj$ o,
                           sys.user$ u
                     WHERE obj#=cp_object_id
                       AND u.user#=o.owner#;

             r_objname c_get_objname%ROWTYPE;

    BEGIN
        OPEN    c_get_objname(p_object_id);
        FETCH   c_get_objname INTO r_objname;
        CLOSE   c_get_objname;
        RETURN (r_objname.name);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            CLOSE c_get_objname;
            RETURN('Unknown');
    END;

    -- Report basic details of the session
    PROCEDURE sid_details(p_sid NUMBER)  IS

        CURSOR c_sid_details (cp_sid NUMBER) IS
               SELECT username, serial# serial,process pid,
                      row_wait_obj# row_wait_obj
                 FROM V$SESSION
                WHERE SID=cp_sid;

        r_sid_details    c_sid_details%ROWTYPE;

        l_session_details varchar2(90);
    BEGIN
        OPEN c_sid_details(p_sid);
        FETCH   c_sid_details INTO r_sid_details;
        CLOSE   c_sid_details;



        -- Decode the row wait object
        IF r_sid_details.row_wait_obj >0 THEN
           iw_showlock_row.object_name:=object_name(r_sid_details.row_wait_obj);
        END IF   ;

        iw_showlock_row.serial:=r_sid_details.serial;
        iw_showlock_row.username:=r_sid_details.username;
        iw_showlock_row.pid:=r_sid_details.pid;


    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            CLOSE c_sid_details;
            iw_showlock_row.username:='Unknown';
            iw_showlock_row.serial:=0;
            iw_showlock_row.pid:='Unknown';

    END;

    -- Display details for a blocking user
    PROCEDURE print_blocker(p_element NUMBER, is_blocker NUMBER) IS
        out_text VARCHAR2(200);
	curr_column number:=0;

    BEGIN

	IF is_blocker=0 THEN
		iw_showlock_row.object_name:=object_name(id1(p_element));
	        printed(p_element):=1;
	ELSE
		dbms_output.put_line(chr(13));

		-- print the header once
		IF g_header_display=0 THEN
			dbms_output.put_line('Locking/Waiting tree      Username       PID    Locked Object/Type-Request  ');
			dbms_output.put_line('------------------------- -------------- ------ ----------------------------');
			g_header_display:=1;
		END IF   ;
	END IF;

        tree_sequence:=tree_sequence+1;
	sid_details(sid(p_element));

	IF is_blocker=0 THEN

		--spaces till objects
		out_text:=substr('|'||g_spaces||g_spaces,0,g_const_col_locked_obj);
		dbms_output.put(out_text);

		--lock method
		out_text:=lock_type(p_element)||'-'||mode_requested(p_element);
		dbms_output.put(out_text);

		dbms_output.put_line('');

		-- write the tree
		out_text:='|-'||lpad('>',tree_depth*g_tree_align,'-');
	ELSE
		out_text:='+ '||lpad('>',tree_depth*g_tree_align,'-');
	END IF;

	dbms_output.put(out_text);
	curr_column:=nvl(length(out_text),0);

	-- sid and serial#
	out_text:=sid(p_element)||','||iw_showlock_row.serial;
	dbms_output.put(out_text);
	curr_column:=curr_column+nvl(length(out_text),0);

	--spaces till username column
	out_text:=substr(g_spaces,0,g_const_col_username-curr_column);
	dbms_output.put(out_text);
	curr_column:=curr_column+nvl(length(out_text),0);

	--username max 14 chars
	out_text:=substr(iw_showlock_row.username,0,14);
	dbms_output.put(out_text);
	curr_column:=curr_column+nvl(length(out_text),0);

	--spaces till pid
	out_text:=substr(g_spaces,0,g_const_col_pid-curr_column);
	dbms_output.put(out_text);
	curr_column:=curr_column+nvl(length(out_text),0);

	--pid max 6 chars
	out_text:=substr(iw_showlock_row.pid,0,6);
	dbms_output.put(out_text);
	curr_column:=curr_column+nvl(length(out_text),0);

	IF is_blocker=0 THEN
		--spaces till object
		out_text:=substr(g_spaces,0,g_const_col_locked_obj-curr_column);
		dbms_output.put(out_text);
		curr_column:=curr_column+nvl(length(out_text),0);

		--locked object
		out_text:=iw_showlock_row.object_name;
		dbms_output.put(out_text);
		curr_column:=curr_column+nvl(length(out_text),0);

	END IF;

	dbms_output.put_line('');

    END;


    -- Show users waiting on the specified entry
    -- REVISIT:  This function should really take a sid as it's
    -- argument
    PROCEDURE show_waiters_on(p_blocker NUMBER) IS
        i NUMBER;
        j NUMBER;
        next_sid NUMBER;
        l_hash_value BINARY_INTEGER;
    BEGIN
        tree_depth:=tree_depth+1;

        -- Calculate the hash value for this sessions lock
        l_hash_value:=f_lock_hash(id1(p_blocker),id2(p_blocker));

        debug('Looking for sessions waiting on '||p_blocker||' '||id1(p_blocker)||' '||id2(p_blocker));
        debug('Hash value is '||l_hash_value);
        <<blocked_loop>>
        LOOP
            BEGIN
               i:=lock_hash_table(l_hash_value);
               debug('Found '||i||' '||sid(i)||' '||blocked(i));
               IF sid(i) <> sid(p_blocker)  AND
                   id1(i)=id1(p_blocker)    AND
                   id2(i)=id2(p_blocker)    AND
                   printed(i)=0             AND -- never print a waiter twice
                   i<>p_blocker             AND
                   blocked(i)=1 THEN

                   print_blocker(i,0);

                   --Now see if this sid is blocking anybody else

                   IF is_blocking(sid(i)) THEN

                        -- Look for a sid the same as this one, which blocks someone
                        -- else
                        j:=sid(i)*10000;   -- Start point in the sid hash table

                        --
                        -- Loop through our sid lookup table
                        --
                        debug('looking for sids matching '||sid(i)||' key '||j);
                        <<sid_loop>>
                        LOOP
                            BEGIN
                                next_sid:=sid_hash_table(j);
                                debug('found '||j||' '||sid_hash_table(j));

                                IF sid(next_sid)=sid(i) and i<>next_sid
                                   AND blocking(next_sid)=1 AND printed(next_sid)<>1 THEN
                                   --
                                   -- We've found a sid the same as ours who is blocking someone
                                   --
                                   show_waiters_on(next_sid);
                                   printed(next_sid):=1;        -- Remember that we've done this sid
                                END IF;
                                j:=j+1;                        -- Go to the next matchine sid
                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                -- When we stop finding sids, then we exit
                                EXIT sid_loop;
                            END;
                        END LOOP;

                    END IF;

                 END IF;
                 -- GO the the next hash value may should contain
                 -- More blockers
                 l_hash_value:=l_hash_value+1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                -- No more entries match the lock id1
                EXIT  blocked_loop;
            END;

        END LOOP;
        tree_depth:=tree_depth-1;
    END;

        -- Clear all showlock global variables
    PROCEDURE reset_globals IS
    BEGIN
        sid.delete;
        ltype.delete;
        request.delete;
        lock_type.delete;
        mode_held.delete;
        mode_requested.delete;
        id1.delete;
        id2.delete;
        blocking.delete;
        blocked.delete;
        printed.delete;
        blocked_list.delete;
        blocked_list_cnt:=0;
        blocking_list.delete;
        blocking_list_cnt:=0;
        lock_count:=0;
        tree_depth:=0;
        tree_sequence:=0;
        lock_hash_table.delete;
        sid_hash_table.delete;

	g_header_display:=0;

    END;

    -- Mainline print a lock tree.
    PROCEDURE showlock IS
        i NUMBER;
    BEGIN
        debug('about to load_vlock');
        -- clears the contents of the lock tables
        reset_globals;

        load_vlock;                 -- Load the lock arrays
        FOR i IN 1..lock_count LOOP
            IF blocking(i)=1 AND (NOT is_blocked(sid(i)))
               /* the next line ensures that we don't print multiple lines
               ** for a single session, even if that session holds multiple
               ** Blocking locks
               */
               AND (i=1 or sid(i-1) !=  sid(i) ) /*not a repeated*/ THEN
                        print_blocker(i,1);
                        show_waiters_on(i);
            END IF;
        END LOOP;

    END;

END;
/
show err

grant execute on show_lock_pkg to public;

set lines 199
set serveroutput on
exec sys.show_lock_pkg.showlock
exit
