CREATE OR REPLACE FORCE VIEW SYS.view_aud$ (sessionid,
                                            inst_id,
                                            userid,
                                            userhost,
                                            ouser,
                                            logon_time,
                                            logout_time,
                                            log_write,
                                            log_read,
                                            phy_read,
                                            cpu
                                           )
AS
   SELECT sessionid, instance# inst_id, userid,
          REPLACE (userhost, '.sensis.com.au', '') userhost, spare1 ouser,
          TO_CHAR (ntimestamp# + 10 / 24, 'DD/MM/YY HH24:MI:SS') logon_time,
          TO_CHAR (logoff$time, 'DD/MM/YY HH24:MI:SS') logout_time,
          logoff$lwrite log_write, logoff$lread log_read,
          logoff$pread phy_read, sessioncpu cpu
     FROM SYS.aud$;


GRANT SELECT ON SYS.VIEW_AUD$ TO PUBLIC;
create public synonym view_aud$ for sys.view_aud$;
