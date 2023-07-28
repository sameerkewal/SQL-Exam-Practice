create table date_table(
    date_1 date,
    date_2 timestamp,
    date_3 timestamp with TIME ZONE
);

/* sysdate returns the current date and time for the server
current_timestamp returns the current date and time for user session(timestamp with timezone)
  The session for the user could be different from the server. The dba can change the user session
  according to location */

--So timestamp is gewoon date maar met fractional seconds
--Als je datatype timestamp with timezone is dan stored het also die region
  insert into date_table values(sysdate, current_timestamp, current_timestamp);
rollback;
  select * from date_table;


-- The difference between this function and LOCALTIMESTAMP is that CURRENT_TIMESTAMP 
-- returns a TIMESTAMP WITH TIME ZONE value while LOCALTIMESTAMP returns a TIMESTAMP value.

--So deze returned alleen een timestamp
select LOCALTIMESTAMP from dual;

--deze returned timestamp inclusief time zone value
select CURRENT_TIMESTAMP from dual;


-----------Data Dictonary Views having to do with TZ's-----------------
--All time zone names are stored in this view


select * from v$timezone_names;


--Timezone can be set to absolute offset or to a named region

--DBTIMEZONE displays the database time zone
select DBTIMEZONE from dual;

--SESSIONTIMEZONE returns the sessions timezone
--You can set the default client session time zone using the ORA_STDZ environmental variable
select SESSIONTIMEZONE from dual;


--returns the current date for the current session(user)
select to_char(current_date, 'dd-mm-yyyy hh24:mi:ss') from dual;



--De reden dat deze 2 hetzelfde zijn is dat die database locally runned op je machine en so 
--je current session is the same as the database session thing
select to_char(current_date, 'dd-mm-yyyy hh24:mi:ss'), to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss')
from dual;

--as we already seen this returns the current date timestamp w fractional seconds 
--and also the current timezone
select current_timestamp from dual;

--Deze bevat alleen the timestamp with fractional secs but with no timezone or anything
select localtimestamp from dual;


----------ALTERING USER SESSION TIMEZONE------------------
alter session set TIME_ZONE='Asia/Karachi';

select * from v$timezone_names
where tzname like 'Asia%';



--En nu zie je het verschil
select to_char(CURRENT_DATE, 'dd-mm-yyyy hh24:mi:ss')as session_time
, to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss') as server_time
from dual;

--Wijst je timezone
select CURRENT_TIMEstamp from dual;

select localtimestamp from dual;


alter session set time_zone = 'America/Argentina/Buenos_Aires';


-- The TIMESTAMP WITH LOCAL TIME ZONE data type is a variant of TIMESTAMP that includes a time zone offset in its value. 
-- Data stored in the database is normalized to the database time zone, and time zone displacement is not stored as part of the column data. 
-- When the data is retrieved, it is returned in the user’s local session time zone
create table web_order(
  cust_id number,
  name varchar2(100),
  item varchar2(100),
  delivery_location varchar2(100),
  order_date timestamp with time zone,
  delivery_period number,
  delivery_date timestamp with local time zone
);

 insert into web_order
 values(1, 'Sameer', 'Toyota Nissan', 'Suriname', current_timestamp, 3, current_timestamp+3);

insert into web_order
values(2, 'Jasmine', 'Nissan Toyota', 'Suriname', current_timestamp, 3, current_timestamp+3);


alter session set time_zone='Asia/Karachi';
 select * from web_order;


 
-- CURRENT_TIMESTAMP returns the current date and time in the session time zone in a value of data type TIMESTAMP WITH TIME ZONE, 
-- while CURRENT_DATE returns the current date in the session time zone in a value of data type DATE
select current_timestamp
from dual;


select current_date
from dual;