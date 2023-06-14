/* Manipulating strings with character functions in SQL SELECT and WHERE clauses 
HR Schema: Character Functions return Char*/


--1 Write an sql query to show the email adress of the employees where only the first letter is in capital.
--er is geen email hier
select INITCAP(FIRST_NAME), LAST_NAME from EMPLOYEES;


--2 Write an sql query to show the first_name and last_name is in lower case. Also show only show the column to compare results.
select FIRST_NAME, LAST_NAME, lower(FIRST_NAME), lower(LAST_NAME)
from EMPLOYEES;

--3 Write an sql query to show the first_name and last_name is in upper case. Also show only show the column to compare results.
select  FIRST_NAME, LAST_NAME, upper(FIRST_NAME), upper(LAST_NAME)
from EMPLOYEES;

--4 The first_name can have up to 20 characters. Write a sql query to show all 20 character. 
--For the positions not used by the first_name show # on the left side. Example '###############Ellen'
select lpad(FIRST_NAME, 20, '#'), length(lpad(FIRST_NAME, 20, '#'))
from EMPLOYEES;


--5 The last_name can have up to 25 characters. Write a sql query to show all 25 character. 
--For the positions not used by the last_name show # on the right side. Example 'Abel#####################'
select FIRST_NAME, rpad(FIRST_NAME, 25, '#'), length(rpad(FIRST_NAME, 25, '#'))
from EMPLOYEES;

--6 Some phone number start with 515. Remove this and only show the number after 515.
 select replace(PHONE_NUMBER, '515.', '')
from EMPLOYEES; 



--7 Some job_id in the employees table start with 'IT'. Show only this part of the string, remove the other letters.
/* select JOB_ID,
case when */

--8 Create an query to the job_id of the employees as the following: IT_PROG => IT Programmer, AC_ACCOUNT => AC Accountant, AP_VP => AP Vice President. All other job should stay the same
--9 Write a query to only show the initials of an employee like 'R.R'. Use concat function instead of ||.
select FIRST_NAME, LAST_NAME, concat(concat(substr(FIRST_NAME, 1, 1), '.'), substr(LAST_NAME, 1, 1))
from EMPLOYEES;

--10 Write a query to only show the 2 and 3 letter of an employee first_name.
select FIRST_NAME, substr(FIRST_NAME, 2, 2)
from EMPLOYEES;


--11 Write a query to only show the last 2 letters of an employee first_name.
select FIRST_NAME, substr(FIRST_NAME, -2, 2)
from EMPLOYEES;


/*HR Schema: Functions Returning Number Values*/
--12 Write a query to show how many characters a the first_name has. Do the same for last_name and email.
select FIRST_NAME, LAST_NAME, EMAIL, length(FIRST_NAME), length(LAST_NAME), length(email) from EMPLOYEES;

--13 Write a query to show the position(number) of first_name where the letters 'll' is located.
select FIRST_NAME, instr(FIRST_NAME, 'll', 1, 1)from EMPLOYEES;

--14 Write a query to show only the letters after 'll' in a first_name. If 'll' is not present in the string show the whole name.
--2e gedeelte van vraag met een 
select FIRST_NAME, 
case when instr(FIRST_NAME, 'll', 1, 1) = 0 then FIRST_NAME
else substr(FIRST_NAME, instr(FIRST_NAME, 'll', 1,1)+2)
end
from EMPLOYEES;

/* Performing arithmetic with date data
HR Schema: Arithmetic with date data */
--15 Write a query which shows the date after a employee has worked 2 years for the company.
select FIRST_NAME, LAST_NAME, HIRE_DATE, add_months(HIRE_DATE, 24)
from EMPLOYEES;

--16 Write a query to show the date 1 year before stopping working for a job_id or department_Id(Job_history).
select END_DATE, add_months(end_date, -12)
from JOB_HISTORY;

--17 Write a query to show the number of days a employee has work for a job_id/department_id.
select FIRST_NAME, LAST_NAME, HIRE_DATE, (sysdate-HIRE_DATE), round(SYSDATE-HIRE_DATE)
from EMPLOYEES;


--18 Write a query to show the number of months a employee has work for a job_id/department_id.
select months_between(SYSDATE, HIRE_DATE) as amount_of_months_worked, round(months_between(SYSDATE,HIRE_DATE), 2)
from EMPLOYEES;

--19 Write a query to show the number of years a employee has work for a job_id/department_id.
select HIRE_DATE, sysdate, months_between(sysdate, HIRE_DATE)/12
from EMPLOYEES;

--20 Write a query which show the datetime after 12u.
select to_char(sysdate, 'DD-MM-YYYY HH24:MI:SS'), to_char(SYSDATE+INTERVAL '12' hour, 'dd-mm-yyyy hh24:mi:ss')
FROM DUAL;



--21 Write a query which show the datetime after 30m.
select to_char(SYSDATE, 'dd-mm-yyyy hh24:mi:ss'), to_char(SYSDATE + INTERVAL '30' minute, 'dd-mm-yyyy hh24:mi:ss')
from dual;

--22 Write a query which show the datetime after 40s

select to_char(SYSDATE, 'hh24:mi:ss'), to_char(sysdate + interval '30' second, 'dd-mm-yyyy hh24:mi:ss')
from dual;


/* Manipulating dates with the date function
HR Schema: Datetime Functions */
--23 Write a Oracle SQL statement to get the first date of the current month.
select trunc(SYSDATE, 'Month')
from dual;


--24 Write a Oracle SQL statement to get the last date of the current month.
select LAST_DAY(SYSDATE)
from dual;

--25 Write a Oracle SQL statement to get the current date in the specified session time zone.
select tzname from V$TIMEZONE_NAMES;
select tzname from V$TIMEZONE_NAMES;
select * from V$TIMEZONE_NAMES;

select to_char(SYSTIMESTAMP at time zone 'America/Argentina/Buenos_Aires', 'dd-mm-yyyy hh24:mi:ss')from dual;
select to_char(SYSTIMESTAMP at time zone 'America/Argentina/Buenos_Aires', 'dd-mm-yyyy: hh24:mi:ss') from dual;


select to_char(sysdate,'hh24:mi:ss') from dual;


--26 Write a Oracle SQL statement to determine how many days are left in the current month.
select last_day(sysdate)-SYSDATE as days_left
from dual;

--27 Write a Oracle SQL statement to get the first and last day of the current year.
select trunc(sysdate, 'YYYY') as first_day_of_year, last_day(add_months(sysdate, 6)) as last_day_of_year
from dual;




--28 Write a Oracle SQL statement to get the number of days in current month.

select to_char(last_day(sysdate), 'DD')
from dual;




--29 Write a Oracle SQL statement to get number of days between two given dates.
select to_date('20-05-2023', 'DD-MM-yyyy'), to_date('16-05-2002', 'DD-MM-YYYY'),
to_date('20-05-2023', 'DD-MM-yyyy')-to_date('16-05-2002', 'DD-MM-yyyy') from dual;

--30 Write a Oracle SQL statement to get the start date and end date of each month in current year from current month.
select trunc(sysdate, 'MM'), last_day(sysdate) from dual
union
select trunc(add_months(sysdate, 1), 'MM'), last_day(add_months(sysdate, 1)) from dual
union
select trunc(add_months(sysdate, 2), 'MM'), last_day(add_months(sysdate, 2)) from dual
UNION
select trunc(add_months(sysdate, 3), 'MM'), last_day(add_months(sysdate, 3)) from dual
UNION
select trunc(add_months(sysdate, 4), 'MM'), last_day(add_months(sysdate, 4)) from dual
UNION
select trunc(add_months(sysdate, 5), 'MM'), last_day(add_months(sysdate, 5)) from dual
UNION
select trunc(add_months(sysdate, 6), 'MM'), last_day(add_months(sysdate, 6)) from dual;



/* HR Schema: ROUND, TRUNC AND MOD */
--31 Write a query to show the 10% of an employees salary. Salary should include 2 decimals(afgerond). Use round
select FIRST_NAME, LAST_NAME, salary, round(salary*1.10, 2)
from EMPLOYEES;


--32 Write a query to show the 10% of an employees salary. Salary should include 2 decimals. Use trunc
select FIRST_NAME, LAST_NAME, salary, trunc(salary*1.10, 2)
from EMPLOYEES;

select 10.69, trunc(10.679, 2), round(10.679, 2) from dual;

--33 Whats the differnce between trunc and round. Analse your results of 1 and 2. 

/* The difference is that with a trunc it rounds down, regardless if the number after the decimal 
is above 5. Round actually rounds if the specified decimal that rounds is above 5*/

--34 Calculte the remainder of 11 divided by 4.
select mod(10,4) from dual;

--35 Calculte the remainder of 11 divided by -4.
select mod(11, -4) from dual;


--36 Calculte the remainder of -11 divided by 4.
select mod(-11, 4) from dual;

--37 Calculte the remainder of -11 divided by -4.

select mod(-11, -4) from dual;





