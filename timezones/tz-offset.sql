select tz_offset('Asia/Karachi'), tz_offset('America/Argentina/Buenos_Aires')
from dual;


------------From_TZ-----------


--Built in function that provides
--conversion of a timestamp to timestamp with timezone for a given time
--Essentially it combines the timestamp and timezone information into a single operation

select from_tz(timestamp '2000-03-6 08:00:00', 'Asia/Karachi')
from dual;


--Converts to a timestamp just like how to_date works basically
select to_timestamp('20-12-2002 08:20:59.9999', 'DD-MM-YYYY HH24:MI:SS.FF')
FROM DUAL;

select to_timestamp('20-12-2002 08:20:50.999999999', 'DD-MM-YYYY HH24:MI:SSXFF')
from dual;


select * from V$NLS_PARAMETERS;



select from_tz(to_timestamp('20-12-2002 12:24:30.9999', 'DD-MM-YYYY HH24:MI:SS.FF'), 'Asia/Karachi')
from dual;

select from_tz((select current_timestamp from dual), 'Asia/karachi')
from dual;

select to_timestamp('20-12-2002', 'dd-mm-yyyy') from dual;


