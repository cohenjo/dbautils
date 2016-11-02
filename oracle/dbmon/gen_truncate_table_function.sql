
--DROP TABLE REF_APPL.TRUNCATE_TABLE_LOG;
/*
CREATE TABLE REF_APPL.TRUNCATE_TABLE_LOG (
        CHANGE_NUMBER NUMBER,
	TRUNCATE_DATE TIMESTAMP,
	TABLE_NAME    VARCHAR2(100),
	PARTITION_NAME VARCHAR2(100),
	USERNAME      VARCHAR2(30),
	OSUSER        VARCHAR2(256),
	MACHINE       VARCHAR2(256),
	STATUS        VARCHAR2(20)
) TABLESPACE AUDIT_DATA;

create unique index REF_APPL.TRUNCATE_TABLE_LOG_UQ on REF_APPL.TRUNCATE_TABLE_LOG (CHANGE_NUMBER,TRUNCATE_DATE,TABLE_NAME,PARTITION_NAME);

CREATE OR REPLACE PUBLIC SYNONYM TRUNCATE_TABLE_LOG FOR REF_APPL.TRUNCATE_TABLE_LOG;
grant select on REF_APPL.TRUNCATE_TABLE_LOG to REF_APPL_QUERY_ROLE ;
*/

----------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SYS.TRUNCATE_TABLE (IN_TABLE_NAME   VARCHAR2) IS
      curs           integer;
      curr_user      varchar2(30);
      tb_owner       varchar2(30);
      part_name      varchar2(30);
      tab_name       varchar2(30);
      str            varchar2(200);
      allowed        varchar2(1);

	  --------------------------------------------------------------------------------------
	  -- Ver 1.02
	  --------------------------------------------------------------------------------------
	  -- 26/05/2009 - 1.01 - Modified by Adi Zohar - Add list of permitted tables
	  --                     Also added TRUNCATE_TABLE_LOG to capture the access
	  --                     Added initial tables
	  -- 27/05/2009 - 1.02 - Added OM_GENERIC_DATA_SETS_TMP, OM_GENERIC_DATA_SUBSETS_T
          --                     OM_DYN_ATTR_TMP, OM_DYN_PROPERTY_TMP
	  --------------------------------------------------------------------------------------
      NOT_ALLOWED exception;

      CURSOR find_private_table
      IS
        SELECT a.owner from dba_tables a where
               a.owner = upper(curr_user) and
               a.table_name = upper(tab_name);

      CURSOR find_private_owner
      IS
        SELECT a.table_owner from dba_synonyms a where
               a.owner = upper(curr_user) and
               a.table_name = upper(tab_name) and
               exists
				   (select b.grantee from dba_tab_privs b, dba_role_privs c where
				   b.owner = a.table_owner and
				   b.table_name = a.table_name and
				   b.privilege='DELETE' and
				   ((b.grantee= upper(curr_user)) or
					(c.granted_role = b.grantee and
					 c.grantee = upper(curr_user))));

      CURSOR find_public_owner
      IS
        SELECT a.table_owner from dba_synonyms a where
               a.owner = 'PUBLIC' and
               a.table_name = upper(tab_name) and
               (
               (exists
				   (select b.grantee from dba_tab_privs b, dba_role_privs c where
				   b.owner = a.table_owner and
				   b.table_name = a.table_name and
				   b.privilege='DELETE' and
				   ((b.grantee= 'PUBLIC') or
					(c.granted_role = b.grantee and
					 c.grantee = 'PUBLIC'))))
			    or
                (exists
                (select b.grantee from dba_tab_privs b, dba_role_privs c where
                b.owner = a.table_owner and
                b.table_name = a.table_name and
                b.privilege='DELETE' and
                ((b.grantee= upper(curr_user)) or
                 (c.granted_role = b.grantee and
                  c.grantee = upper(curr_user))))));

      CURSOR get_user
      IS
         SELECT user
         FROM dual;

      BEGIN
		  ----------------------------------
		  -- Seperate partition and table
		  ----------------------------------
          IF instr(in_table_name,':') = 0 THEN
             tab_name := in_table_name;
          ELSE
             part_name := substr(in_table_name,instr(in_table_name,':') + 1  );
             tab_name := substr(in_table_name,1,instr(in_table_name,':') - 1);
          END IF;

		  ----------------------------------
		  -- Get Current User
		  ----------------------------------
          OPEN get_user;
          FETCH get_user INTO curr_user;
          CLOSE get_user;

		  ----------------------------------
		  -- Check Permission
		  ----------------------------------
		  IF (
				 tab_name in (
						'ADS_TMP_ORDER_INPRG_WORK',
						'ADS_TMP_ORDER_WORK',
						'AUDIT_PUBLISH_MESSAGES',
						'AUDIT_SUBSCRIBE_MESSAGES',
						'BC_PROD_TEMP_RPT_FINAL',
						'BC_PROD_TEMP_RPT_STS',
						'BC_TEMP_LOST_MSG_PRODUCT',
						'CMSN_POP_PPRD_REJECT_TRANS',
						'CMSN_POP_PPRD_TRANS',
						'CP_ADV_ATTR_POP',
						'CP_ADV_HIERARCHY',
                                                'CP_ASSIGN_FROM_FILE_TEMP',
                                                'CP_ADV_ATTR_POP',
                                                'CP_TMP_DIALLER_POP',
                                                'CP_TMP_DYN_ATTR_DATA',
						'DA_USED_CMPNDS',
						'OLSM_EMP_SKILLS',
                                                'OM_DYN_ATTR_TMP',
                                                'OM_DYN_PROPERTY_TMP',
                                                'OM_GENERIC_DATA_SUBSETS_T',
                                                'OM_GENERIC_DATA_SETS_TMP',
                                                'OM_TMP_ADV_SIZE',
                                                'OM_TMP_MASS_PRODUCT',
                                                'OM_TMP_AUTO_RENEW_JOB',
                                                'OM_TMP_PRINT_PROPOSAL',
                                                'ONE_SEARCH_EXTRACT',
                                                'IF_BILLING_TN',
						'PRIVACY_MONITOR_LOG',
						'SFU_CAMP_TRANS',
						'SFU_DIR_PRDTYP_TRANS',
						'BC_BLT_MATCHED_BUSINESS',
						'BC_BLT_MATCHED_PRODUCTS',
						'BC_TMP_PCP_TO_LIVE',
						'BC_TMP_PCP_TO_ARCHIVE',
						'OM_TMP_PCP_PRODUCT_POP'
						)
		      ) THEN
			  allowed:='Y';
		  ELSE
              RAISE NOT_ALLOWED;
          END IF;

		  ----------------------------------
		  -- Check Table Permission
		  ----------------------------------
          OPEN find_private_table;
          FETCH find_private_table into tb_owner;
          IF find_private_table%NOTFOUND THEN
             CLOSE find_private_table;
             OPEN find_private_owner;
             FETCH find_private_owner into tb_owner;
             IF find_private_owner%NOTFOUND THEN
                CLOSE find_private_owner;
                OPEN find_public_owner;
                FETCH find_public_owner into tb_owner;
                IF find_public_owner%NOTFOUND THEN
                   CLOSE find_public_owner;
                   RAISE NOT_ALLOWED;
                ELSE
                   curs := DBMS_SQL.OPEN_CURSOR;
                   IF part_name is null THEN
                      str := 'truncate table '||tb_owner||'.'||tab_name;
                   ELSE
                      str := 'alter table '||tb_owner||'.'||tab_name||
                             ' truncate partition '||part_name||' update global indexes';
                   END IF;
                   DBMS_SQL.PARSE(curs,str,DBMS_SQL.NATIVE);
                   DBMS_SQL.CLOSE_CURSOR(curs);
                   CLOSE find_public_owner;
                END IF;
             ELSE
                curs := DBMS_SQL.OPEN_CURSOR;
                IF part_name is null THEN
                   str := 'truncate table '||tb_owner||'.'||tab_name;
                ELSE
                   str := 'alter table '||tb_owner||'.'||tab_name||
                          ' truncate partition '||part_name||' update global indexes';
                END IF;
                DBMS_SQL.PARSE(curs,str,DBMS_SQL.NATIVE);
                DBMS_SQL.CLOSE_CURSOR(curs);
                CLOSE find_private_owner;
             END IF;
          ELSE
             curs := DBMS_SQL.OPEN_CURSOR;
             IF part_name is null THEN
                str := 'truncate table '||tb_owner||'.'||tab_name;
             ELSE
                str := 'alter table '||tb_owner||'.'||tab_name||
                       ' truncate partition '||part_name||' update global indexes';
             END IF;
             DBMS_SQL.PARSE(curs,str,DBMS_SQL.NATIVE);
             DBMS_SQL.CLOSE_CURSOR(curs);
             CLOSE find_private_table;
          END IF;

		  ----------------------------------
		  -- Insert into log table
		  ----------------------------------
		  insert into TRUNCATE_TABLE_LOG (CHANGE_NUMBER, TRUNCATE_DATE, TABLE_NAME ,PARTITION_NAME, USERNAME ,OSUSER , MACHINE , STATUS )
		  values (
                        dbms_flashback.get_system_change_number , systimestamp, tab_name, part_name, curr_user, 
                        SYS_CONTEXT('userenv','os_user'), SYS_CONTEXT('userenv','host') ,'TRUNCATED'
                        );
		  commit;

		  ----------------------------------
		  -- Exception
		  ----------------------------------
          EXCEPTION
             WHEN NOT_ALLOWED THEN
		  insert into TRUNCATE_TABLE_LOG (CHANGE_NUMBER, TRUNCATE_DATE, TABLE_NAME ,PARTITION_NAME, USERNAME ,OSUSER , MACHINE , STATUS )
		  values (
                        dbms_flashback.get_system_change_number , systimestamp, tab_name, part_name, curr_user, 
                        SYS_CONTEXT('userenv','os_user'), SYS_CONTEXT('userenv','host') ,'NOT ALLOWED'
                        );
		  commit;
		  RAISE_APPLICATION_ERROR(-20001,'NOT ALLOWED TO TRUNCATE THIS TABLE');

             WHEN OTHERS THEN
		  insert into TRUNCATE_TABLE_LOG (CHANGE_NUMBER, TRUNCATE_DATE, TABLE_NAME ,PARTITION_NAME, USERNAME ,OSUSER , MACHINE ,STATUS)
		  values (
                        dbms_flashback.get_system_change_number , systimestamp, tab_name, part_name, curr_user, 
                        SYS_CONTEXT('userenv','os_user'), SYS_CONTEXT('userenv','host') ,'ERROR'
                        );
		  commit;
		  RAISE_APPLICATION_ERROR(SQLERRM,'COULD NOT TRUNCATE TABLE');
      END;
/
show err
