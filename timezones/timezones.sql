

--Dit betekent basically 55 years and 11 months from now
select interval '55-11' year to month from dual;



--means 1 year and 4 months from now
select interval '1-4' year to month from dual;


--Als het jaar groter dan 2 digits is moet je de scale bij je year keyword aangeven
select interval '555-11' year to month from dual;

--like so:
select interval '555-11' year(3) to month from dual;


select interval '1000-11' year(4) to month from dual;


--Als je alleen months mentioned gaat oracle het converten to years voor je
--Understands that you want to convert it from months to years
select interval '350' month from dual;

--Als je year and month keyword hebt, dan ga je beide moeten specificeren in je query
select interval '350' year to month from dual;



select interval '350-11' year(3) to month from dual;
select 350/12 from dual; 

--net als hoe je month alleen month value kon doorgeven kan dat ook bij year
select interval '10' year from dual;


--Gaat die months dan als 0 aangeven(bc you didnt specify anything for it duh)
select interval '20' year from dual;


-----------Day To Second---------------
select interval '33 20:20:02' day to second from dual;


--also supports fractional seconds!
select interval '33 20:20:20.20' day to second from dual;

--Ook als je meer dan 2 getallen voor je date hebt, dan ga je die scale/length moeten aangeven
--bij je day keyword ofc
select interval '333 23:59:59.9999' day(3) to second from dual;


--Just like before kan je ook alleen,in dit geval, uren aangeven
--En Oracle will convert it to days for you
--500 hours from now is 20 days and 20 hrs
select interval '500' hour from dual;


--Bij hour moet je vanaf 4 digits precision aangeven
select interval '5000' hour(4) from dual;

select interval '1' hour from dual;


--Je kan dus obviously ook minuten aangeven
select interval '20000' minute from dual;

--Bij minute moet je vanaf 6 digits je scale aangeven
select interval '200000' minute from dual;


--Dus obviously kan je ook seconds aangeven 
--2000 seconds is 33 minutes 
select interval '2000' second from dual;

--vanaf 8 digits bij seconds moet je je scale aangeven
select interval '20000000' second from dual;
select length('20000000') from dual;


--------------------to_yminterval and to_dsinterval------------------

--Lets say I want to get the date 1 year and 2 months from now
--To achieve that I can do something like this:
select SYSDATE, sysdate + interval '1-2' year to month from dual;

--Bovenstaande werkt obviously maar is pretty long
--Shorter way to achieve that is using the to_yminterval function

select sysdate, sysdate+to_yminterval('1-2') from dual;

select sysdate, sysdate+to_yminterval('0-2') from dual;
select interval '0-2' year to month from dual;




--Now using to_dsinterval
--If i wanna add 6 days and 2 hours I can do sth like this:
select sysdate, sysdate+interval '6 2:00:00' day to second from dual;

--And the shorter way using the to_dsinterval function
select sysdate, sysdate+to_dsinterval('6 2:00:00') from dual;

select to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss'),
to_char(sysdate+to_dsinterval('6 2:00:00'), 'dd-mm-yyyy hh24:mi:ss')
from dual;


--Kan je sth like this doen using the to_dsinterval
select sysdate, sysdate+interval '2000' hour from dual;

--Nope limitaties, omdat het het basically omzet in 'interval ..... day to second'
select sysdate, sysdate+to_dsinterval('0 2000') from dual;


----------------------Extract function-----------------
select to_char(sysdate, 'yyyy') the_year,
to_char(sysdate, 'mm') the_month,
to_char(sysdate, 'dd') the_day
from dual;

--To do that in a simpler way, one could do sth like this:

select extract(year from sysdate),
        extract(month from sysdate),
        extract(day from sysdate)
        from dual;


--More practical example is this:
select EMPLOYEE_ID, FIRST_NAME, HIRE_DATE,
extract(year from HIRE_DATE) as hire_year,
extract(month from HIRE_DATE) as hire_month,
extract(day from HIRE_DATE),
extract(hour from HIRE_DATE),
extract(minute from HIRE_DATE),
extract(second from HIRE_DATE)
from EMPLOYEES;




select interval '10-11'year to month from dual;


--if YEAR or MONTH is requested, then expr must evaluate to an expression of data type DATE, TIMESTAMP, 
--TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE, or INTERVAL YEAR TO MONTH.
select extract(month from interval '10-11' year to month) from dual;
select extract(year from interval '10-11' year to month) from dual;


--if YEAR or MONTH is requested, then expr must evaluate to an expression of data type DATE, TIMESTAMP, 
--TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE, or INTERVAL YEAR TO MONTH.

select extract(day from interval '20 10:00:00' day to second) from dual;

select extract(hour from interval '20 10:00:00' day to second) from dual;
select extract(minute from interval '20 10:20:00.9999' day to second) from dual;
select extract(second from to_dsinterval('20 23:59:59')) from dual;

-- If HOUR, MINUTE, or SECOND is requested, then expr must evaluate to an expression of data type TIMESTAMP, TIMESTAMP WITH TIME ZONE, 
-- TIMESTAMP WITH LOCAL TIME ZONE, or INTERVAL DAY TO SECOND. DATE is not valid here, 
-- because Oracle Database treats it as ANSI DATE data type, which has no time fields.

