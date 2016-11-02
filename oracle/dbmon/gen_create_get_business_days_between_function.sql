CREATE OR REPLACE FUNCTION sys.get_business_days_between (start_date DATE, end_date DATE) RETURN number 
AS
        rtn_result    number;
BEGIN
      
      IF trunc(end_date) <= trunc(start_date) THEN
         SELECT 0 into rtn_result FROM dual;
      ELSE
          SELECT CASE WHEN (count(1) -1) < 0 THEN 0 ELSE count(1) -1 END
            INTO rtn_result
            FROM refread.ref_calendar bd
            WHERE bd.calendar_day BETWEEN trunc(start_date) AND trunc(end_date)
            and bd.work_day_ind = 'Y';
      END IF; 
      
      RETURN rtn_result;
end;
/
show err

grant execute on sys.get_business_days_between to public;
create or replace public synonym get_business_days_between  for sys.get_business_days_between ;

select get_business_days_between(sysdate,sysdate-10) from dual;
select get_business_days_between(sysdate-10,sysdate) from dual;
