--1. Write an query to get all employees who’s firstname is equal to the string ‘1223’.
select * from employees where FIRST_NAME='1223';



--2. Write an query to get all employees who’s firstname is equal to the string ‘1223D’.
select * from EMPLOYEES where FIRST_NAME='1223D';



--3. Write an query to get all employees who earn more then the string ‘500o’
select * from EMPLOYEES where to_char(salary)>'20000'
order by SALARY;

--4. Write an query to get all employees who were hired after 17 JUNI 2003.
select * from EMPLOYEES where HIRE_DATE>'17 JUNE 2003';


--5. For what is the NLS_DATABASE_PARAMETERS table used for?
/*Is de standaard format dat gebruikt wordt wanneer je bv to_date of to_char doet zonder een format te speciferen
Is ook de standaard format waarin date values zullen worden displayed als je ze gewoon ophaalt uit een TABLE BV*/
select HIRE_DATE from EMPLOYEES;




--6 Change NLS_DATE_FORMAT to ‘DD-MON-YYYY’ and run query of 5 again. 
--dit is alleen voor die session btw
alter session set nls_date_format="DD-MON-YYYY";
select * from EMPLOYEES where HIRE_DATE>'17 JUNE 2003';


--7 Write an query to show the hire_date of the employees as ‘Monday, April 2023 12:56 PM’
select to_char(HIRE_DATE, 'Day, Month YYYY hh12:mi PM') FROM EMPLOYEES;

--8 -Write an query to show the sysdate in string datatype, with format ’23-04-2023’
select to_char(sysdate, 'DD-MM-YYYY') from dual;


--9 Write an query to show the sysdate in string datatype, with format ’23-APRIL-2023’
select to_char(sysdate, 'DD-MONTH-YYYY') from dual;

--10 Write an query to show the sysdate in string datatype, with format ’23-APR-2023’
select to_char(sysdate, 'DD-MON-YYYY') from dual;

--11 Write an query to show the date of today as ‘23rd of APRIL 2023’.
select to_char(sysdate, 'ddth "of" MONTH yyyy') from dual;

--12 Write an query to show the month as ‘4th of Month of the year 2023’.
select to_char(sysdate, 'ddth "of" Month "of the year" yyyy') from dual;

--13 Write an query to show the date of today as ‘Twenty Third of APRIL 2023’.
select to_char(sysdate, 'ddsp "of" MONTH yyyy') from dual;


select to_char(to_date('23 04 2023', 'DD MM YYYY'), 'ddspth "of" Month yyyy') from dual;

--14 Write an query to show the month as ‘fourth Month of the year 2023’.
select to_char(sysdate, 'mmspth "Month of the year" yyyy')from dual;


--15 Write an query to show all employees who were hired in February.
select * from EMPLOYEES where to_char(HIRE_DATE, 'mm')='02';



--16 Write an query to show all employees who were hired on a Monday.
select * from EMPLOYEES where to_char(HIRE_DATE, 'Day') = 'Monday   ';
select FIRST_NAME, LAST_NAME, to_char(HIRE_DATE, 'Day'), length(to_char(HIRE_DATE, 'Day')) from EMPLOYEES;
--????????????????????????????????????????????
--???????????
select FIRST_NAME, LAST_NAME, HIRE_DATE, to_char(HIRE_DATE, 'Day Month yyyy'), to_char(HIRE_DATE, 'D')
from employees
where to_char(HIRE_DATE, 'D') = '2';





--17 Write an query to show all employees who were hired in 2002.
select * from EMPLOYEES where to_char(HIRE_DATE, 'yyyy') = '2002';



--18 Convert 1000 to an char datatype.
select to_char(1000) from dual;


--19 Convert 100.0 to an char datatype. The output should be '100.00'. Write both ways of doing this. 
select 100, to_char(100.0, '999.99') from dual;
select 100, to_char(100.0, '999D99') from dual;

--20 Convert 8777777666.999989 to an char datatype. The output should be '8,777,777,667.000'. Write both ways of doing this.
select 8777777666.999989, to_char(8777777666.999989, '9,999,999,999.999') from dual;
select 8777777666.999989, to_char(8777777666.999989, '9G999G999G999D999') from dual;





--21 Convert 8777777666.999989 to an char datatype. The output should be '$8,777,777,667.000'. Write both ways of doing this.
select to_char(8777777666.999989, '$9,999,999,999.999') from dual;
select to_char(8777777666.999989, '$9G999G999G999D999') from dual;

--22 Convert -898 to an char datatype. The output should be '898-'.
select to_char(-898, '999mi')from dual;

--23 Convert -898 to an char datatype. The output should be '<898>'.
select to_char(-898, '999PR') from dual;

--24 Convert 100.56 to an char. And this should show the database currency. The output should '$100.56'
select to_char(100.56, 'L999.99') 
from dual;

--25 Convert 10909.56 to an char. And this should show the database currency. Also use the group format. 
--The output should be '$10,909.56'


--26 Convert 10909.56 to an char. The output should be 'SRD10,909.56'.
select to_char(10909.56, 'C99,999.99', 'NLS_ISO_CURRENCY=''Suriname'' ') 
from dual;

--27 Convert 10909.56 to an char. The output should be 'SRD10.909,56'.
select to_char(10909.56, 'L99G999D99', 'NLS_NUMERIC_CHARACTERS='',.'' NLS_CURRENCY=''SRD'' ')from dual;


--28 Convert '3345' to an number.
select to_number('3345') from dual;


--29 Convert '3345.4545' to an number. The output should be 3345.4545.
select to_number('3345.4545', '9999.9999') from dual;


--30 Convert '$8777777666.999989' to an number. The output should be 8777777666.999989.
select to_number('$8777777666.999989', '$9999999999.999999') from dual;




--31 Create an query to get all employees hired before '02-05-2023'.
select FIRST_NAME, LAST_NAME, HIRE_DATE
from EMPLOYEES
where HIRE_DATE<to_date('02-05-2023', 'dd-mm-yyyy');



--32 Create an query to get all employees hired before '02-APRIL-2023'.
select FIRST_NAME, LAST_NAME, HIRE_DATE
from EMPLOYEES
where hire_date<to_date('02-April-2023', 'DD-Month-yyyy');


--33 Create an query to get all employees hired before '02-APRIL-2023 12:40:22'.
select FIRST_NAME, LAST_NAME, HIRE_DATE
from EMPLOYEES
where HIRE_DATE<to_date('02-April-2023 12:40:22', 'DD-Month-yyyy hh24:mi:ss')
order by HIRE_DATE;


--34 Create a sql query which print the following '29TH of April, 2023'.
select to_char(to_date('29-04-2023', 'dd-mm-yyyy'), 'DDth "of" Month, yyyy')from dual;

--35 Create a sql query which print the following 'Saturday's Special'.
select trim(to_char(to_date('10-06-2023', 'DD-MM-YYYY'), 'Day'))|| q'['s special]' from dual;




--36 Write an sql query to show the departments of a employee. 
--If an employee has no department then that record should contain string 'Emp has no Dept'.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, nvl(to_char(DEPARTMENT_ID), 'Emp has no Dept')
from EMPLOYEES;



--37 Write an sql query to show the departments of a employee. 
--If an employee has no department then that record should contain string 'null expr3'
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, nvl2(DEPARTMENT_ID, to_char(DEPARTMENT_ID), 'null expr3')
from EMPLOYEES;
--38 and if emp has a department show that as 'not null expr2'.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, nvl2(DEPARTMENT_ID, 'not null expr2', 'null expr3')
from EMPLOYEES;
 





--39 Write a query to calculate the total amount after a employee has recieved their commision. 
--If the employee doesn't recieve an comminision show that as 'Emp has no commision'.
select FIRST_NAME, LAST_NAME, COMMISSION_PCT, SALARY,
nvl2(COMMISSION_PCT, to_char(salary+(COMMISSION_PCT*SALARY)), 'Emp has no commission') as new_salary
from EMPLOYEES;



--40 Write a query to calculate the total amount after a employee has recieved their commision.
select FIRST_NAME, LAST_NAME, COMMISSION_PCT, SALARY, salary+(COMMISSION_PCT*salary)
from EMPLOYEES;

--41 Write a query to show all deparments. If a deparments has no manager then the manger of those deparments are 200.
select DEPARTMENT_ID, DEPARTMENT_NAME, nvl(MANAGER_ID, 200) from DEPARTMENTS;




--42 Write a sql query to check if first_name and last_name are the same. If they are the same the print the null else first_name.
select FIRST_NAME, LAST_NAME, nullif(FIRST_NAME, LAST_NAME) from EMPLOYEES;


--43 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. 
--When an employee has no commission_pct then return 1. Use nvl and coalesce.
select FIRST_NAME, COMMISSION_PCT, MANAGER_ID, salary, nvl(COMMISSION_PCT, 1) from EMPLOYEES;
SELECT FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY, coalesce(COMMISSION_PCT, 1) from EMPLOYEES;


--44 Write a sql query to print employee first_name, commission_ptc, manager_id and salary.
-- When an employee has no commission_pct then manager_id. Use nvl and coalesce.
SELECT FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY, nvl(COMMISSION_PCT, MANAGER_ID)from EMPLOYEES;

--45 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. 
--When an employee has no commission_pct then manager_id and when manager_id is null then print the salary. Use nvl and coalesce.
select FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY,
nvl(nvl(COMMISSION_PCT, MANAGER_ID), SALARY) from EMPLOYEES;


select FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY,
coalesce(COMMISSION_PCT, MANAGER_ID, SALARY) from EMPLOYEES;


--46 For query above create a new column stating whats being printed. Use nvl2.
select FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY,
nvl2();

--47 Write a query to print the salary of an employee with commission. Use coalesce.

--final answer:
select FIRST_NAME, SALARY, COMMISSION_PCT, coalesce(nullif(COMMISSION_PCT, null), null)*0+salary as new_salary
from EMPLOYEES;
-- moeilijk as hell


--48 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. 
--When an employee has no commission_pct then return 1 else show the commission. Use case.
select FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY,
case when COMMISSION_PCT is null then 1
else COMMISSION_PCT
end as "virtual column"
from EMPLOYEES;





--49 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. 
--When an employee has no commission_pct then manager_id else show the commission. Use case.
SELECT FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY,
case when COMMISSION_PCT is null then MANAGER_ID
else COMMISSION_PCT
end "virtual column"
from EMPLOYEES;


--50 Write a sql query to print employee first_name, commission_ptc, manager_id and salary. 
--When an employee has no commission_pct then manager_id and when manager_id is null then print the salary. Use case.
select FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY,
case when MANAGER_ID is null then SALARY
     when COMMISSION_PCT is null then MANAGER_ID
end
from EMPLOYEES;

--51 For query above create a new column stating whats being printed. Use case.
select FIRST_NAME, COMMISSION_PCT, MANAGER_ID, SALARY,
case when MANAGER_ID is null then SALARY
     when COMMISSION_PCT is null then MANAGER_ID
end as printed_value
from EMPLOYEES;


--52 Write a query to print the salary of an employee with commission. Use case.
    select FIRST_NAME, LAST_NAME, COMMISSION_PCT, SALARY,
    case when COMMISSION_PCT is not null then SALARY
    else COMMISSION_PCT
    end as "printed value"
    from EMPLOYEES;


--53 Write a sql query which show the salary of IT_PROG when they are given an 10% raise. Other employees salary stay the same.
    select FIRST_NAME, LAST_NAME, SALARY, JOB_ID,
    decode(JOB_ID, 'IT_PROG', salary*1.10,
            SALARY) as new_salary
            from EMPLOYEES;


--54 Write a sql query which show the salary of IT_PROG when they are given an 10% raise. 
--Also show if 'FI_ACCOUNT' were given 12% raise. Other employees salary stay the same.
select FIRST_NAME, LAST_NAME, JOB_ID, SALARY,
decode(JOB_ID, 'IT_PROG', salary*1.10,
                'FI_ACCOUNT', salary*1.12,
                SALARY) as new_salary
                from EMPLOYEES;

--55 Write a sql query which show the salary of IT_PROG when they are given an 10% raise. 
--And show if 'FI_ACCOUNT' were given 12% raise. And if 'PU_CLERK' were given 18% raise. Other employees salary stay the same.

select FIRST_NAME, LAST_NAME, JOB_ID, SALARY,
decode(JOB_ID, 'IT_PROG', SALARY*1.10,
                'FI_ACCOUNT', salary*1.12,
                'PU_CLERK', salary*1.18)
                as new_salary
                from EMPLOYEES;






