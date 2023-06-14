/* --WHERE: =, !=, <>, ^=  equal clause and not equal clause */


-- 1 Write an SQL query to display an employee’s firstname and lastname where the employee lastname is ‘King’.
select FIRST_NAME, LAST_NAME from EMPLOYEES where LAST_NAME ='King';

--2 Write an SQL query to display the employee’s fistname, last_name and job_id who earn a salary of 4800.
select FIRST_NAME, LAST_NAME, JOB_ID from EMPLOYEES where salary = 4000;

--3 Write an SQL query to display the employees who started working on 13-01-2001.
select * from EMPLOYEES where HIRE_DATE=to_date('13-01-2001', 'DD-MM-YYYY');

--4 Write an SQL query to display an employee’s firstname and lastname where the employee lastname is not ‘King’.
select FIRST_NAME, LAST_NAME from EMPLOYEES where LAST_NAME not like 'King';
select FIRST_NAME, LAST_NAME from EMPLOYEES where LAST_NAME != 'King';
select FIRST_NAME, LAST_NAME from EMPLOYEES where LAST_NAME <> 'King';

--5 Write an SQL query to display the employee’s fistname, last_name and job_id who earn a salary not equal to 4800.
select FIRST_NAME, LAST_NAME, JOB_ID from EMPLOYEES where salary != 4800;

--6 Write an SQL query to display the employees who started working on not equal to ‘13-01-2001’.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE from EMPLOYEES where HIRE_DATE != to_date('13-01-2001', 'DD-MM-YYYY')
order by EMPLOYEE_ID;

select employee_id, FIRST_NAME, LAST_NAME, HIRE_DATE from EMPLOYEES where HIRE_DATE = to_date('13-01-2001', 'DD-MM-YYYY');


/* 
WHERE: <, >, >=, <=equal clause and not equal clause */

--7 Write an SQL query to display employee’s first_name, last_name and salary who’s salary it greater then 10000
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES where salary > 10000;


--8 Write an SQL query to display employee’s first_name, last_name and salary who’s salary it less then 10000
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES where salary < 10000;

--9 Write an SQL query to display employee’s first_name, last_name and salary who’s salary is equal and greater then 17000
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES where salary >= 17000;


--10 Write an SQL query to display employee’s first_name, last_name and salary who’s salary is equal and less then 17000
select FIRST_NAME, LAST_NAME, SALARY from EMPLOYEES where salary <= 17000;

--11 Write an SQL query to display an employee full_name and where full_name = ‘Steven King’
select FIRST_NAME || ' ' || LAST_NAME as full_name 
from EMPLOYEES
where FIRST_NAME || ' ' || LAST_NAME = 'Steven King';


--12 Write an SQL query to display 1 columnn containing following information:
--‘Rewiesh Ramcharan has an salary of 1000’.
 --Where information is only displayed for employee who’s salary is greater and equal to 10000.
select FIRST_NAME || ' ' || LAST_NAME || ' has a salary of ' || SALARY
from EMPLOYEES where salary > 1000;


--13 Write an SQL query to display employee first_name, last_name and job_id who started working for the company prior to '24-07-2005'
select FIRST_NAME, LAST_NAME, JOB_ID, HIRE_DATE from EMPLOYEES where HIRE_DATE<to_date('24-07-2005', 'DD-MM-YYYY')
order by HIRE_DATE;


--14 Write an SQL query to display employee first_name, last_name and job_id who started working for the company after to '24-07-2005'
select FIRST_NAME, LAST_NAME, JOB_ID, HIRE_DATE from EMPLOYEES where HIRE_DATE>to_date('24-07-2005', 'DD-MM-YYYY')
ORDER BY HIRE_DATE asc;


--15 Write an SQL query to display employee first_name, last_name and job_id who started working for the company on '24-07-2005' 
--and prior.
select FIRST_NAME, LAST_NAME, JOB_ID, HIRE_DATE 
from EMPLOYEES 
where HIRE_DATE<=to_date('24-07-2005', 'dd-mm-yyyy')
order by HIRE_DATE;


--16 Write an SQL query to display employee first_name, last_name and job_id who started working for the company on '24-07-2005' 
--and after.
select FIRST_NAME, LAST_NAME, JOB_ID, HIRE_DATE 
from EMPLOYEES 
where HIRE_DATE>=to_date('24-07-2005', 'dd-mm-yyyy')
order by HIRE_DATE;


/* 
Where: AND, OR and NOT */
--17 Write an SQL query to display the employee full name where name = ‘Nandita Sarchand’ and salary = 4200
select FIRST_NAME || ' ' || LAST_NAME as full_name, salary
from EMPLOYEES
where FIRST_NAME|| ' ' ||LAST_NAME = 'Nandita Sarchand'
and salary = 4200;




--18 Write an SQL query to display all employee who have the job_id ST_CLERK and earn 3500 or more.
select * from EMPLOYEES where JOB_ID='ST_CLERK' and salary>3500;


--19 Write an SQL query to display all employees who have manager_id 100 as there manager and work in department 50
select * from EMPLOYEES where MANAGER_ID=100 and DEPARTMENT_ID=50;

--20 Write an SQL query to display all employees who have manager 100 or 101 as there manager
select * from EMPLOYEES where MANAGER_ID=100 or MANAGER_ID=101;

--21 Write an SQL query to display employee who work as ST_CLERK or SA_REP or AD_VP 
select * from EMPLOYEES where JOB_ID='ST_CLERK' or JOB_ID='SA_REP' or JOB_ID='AD_VP';

--22 Write a Oracle SQL query to get the first_name and last_name, job_id, department_id of the employees 
--who are working in the department no 10 or 20 or 40 or employees working as 'ST_CLERK', 'SA_MAN' or 'IT_PROG'.
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, JOB_ID
from EMPLOYEES
where DEPARTMENT_ID=10 or DEPARTMENT_ID=20
or JOB_ID='ST_CLERK' or JOB_ID='SA_MAN' or JOB_ID='IT_PROG';


--23 Write query to list the name (first and last name), hire date of all the employees who joined on 1-06-2006,24-03-2007,04-01-2008.
select FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
where HIRE_DATE=to_date('01-06-2006', 'DD-MM-YYYY') or HIRE_DATE=to_date('24-03-2007', 'DD-MM-YYYY') 
OR HIRE_DATE=to_date('04-01-2008', 'DD-MM-YYYY');

--24 Write a Oracle SQL query to get the employee no, first name and last name for those employees 
--who are earning commission and have a salary equal or higher then 5000
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME, COMMISSION_PCT, SALARY
from EMPLOYEES
where COMMISSION_PCT is not null and salary >=5000;

--25 Write an SQL query all display employee not working for deplarment 10 (use NOT clause).
select * from EMPLOYEES where not DEPARTMENT_ID = 20;



/* Where: BETWEEN, NOT BETWEEN */

--26 Write an SQL query to get all employees who salary are between 9000 and 24000.
    select * from EMPLOYEES where salary between 9000 and 24000
    order by salary;

--27 Write an SQL query to get all employees who salary are not between 9000 and 24000.
select *
from EMPLOYEES
where not salary between 9000 and 24000;

--28 Write an SQL query to get all employees who salary are not between ‘9000’ and ‘24000’.
-- implicit conversion hier?
select *
from EMPLOYEES
where not salary between '9000' and '24000';


--39 Write an SQL query to get all employees who salary are not between ’01-02-2021’ and ‘31-02-2021’
select *
from EMPLOYEES
where not HIRE_DATE between to_date('01-02-2021', 'DD-MM-YYYY') and to_date('31-02-2021', 'DD-MM-YYYY')
order by HIRE_DATE;




--30 Write an SQL query to get all employees who were hire between '30-01-2005' and '17-08-2002'.
select *
from EMPLOYEES
where HIRE_DATE between to_date('17-08-2002', 'DD-MM-YYYY') AND to_date('30-01-2005', 'DD-MM-YYYY');

--31 Write an SQL query to get all employees who salary are not between ’01-02-2021’ and ‘31-02-2021’ and have a commission_pct 
--between 20% and 40% and have an JOB_ID = SA_MAN or SA_REP

--als je geen parentheses gebruikt dan wordt statement gelezen als of job_id=SA_REP of anything that comes before that

select EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT, JOB_ID, HIRE_DATE
from EMPLOYEES
where not HIRE_DATE between to_date('01-02-2021', 'dd-mm-yyyy') and to_date('31-02-2021', 'dd-mm-yyyy')
and COMMISSION_PCT between 0.2 and 0.4
and (JOB_ID='SA_MAN' or JOB_ID = 'SA_REP')
order by EMPLOYEE_ID;


--32 Write an SQL query to get all jobs where the min is between 8200 and 10000 and the max salary not between 20080 and 16000.
select JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
from jobs
where MAX_SALARY not between 16000 and 20080
and MIN_SALARY between 8200 and 10000
order by JOB_ID;




--33 Write an SQL query to get all job history where job_id is AC_MGR and sysdate between start_date and end_date
--retrieves every record where the current date falls between the start_date and the end_date
select * 
from JOB_HISTORY
where JOB_ID = 'AC_MGR'
and SYSDATE between START_DATE and END_DATE;

select * 
from JOB_HISTORY
where JOB_ID = 'AC_MGR'
and to_date('31-03-2003', 'DD-MM-YYYY') between START_DATE and END_DATE;


select * from JOB_HISTORY;




/* 
Where: IN, NOT IN */

--34 Write an SQL query to get employees who have the job_id of AD_PRES, AD_VD and IT_PROG.
select * from EMPLOYEES where JOB_ID in ('AD_PRES', 'AD_VD', 'IT_PROG');

--35 Write an SQL query to get employees who have don’t the job_id of AD_PRES, AD_VD and IT_PROG.
select * from EMPLOYEES where JOB_ID not in('AD_PRES', 'AD_VD', 'IT_PROG');

--36 Write an SQL query to get all jobs who have an min salary of 15000, 4200, 8200 and 6000.
select * from jobs where MIN_SALARY in(15000, 4200, 8200, 6000);



/* Where: LIKE */
--37 Write a query to list the names (first and last) of those employees whose name starts with A.
select FIRST_NAME, LAST_NAME 
from EMPLOYEES
where FIRST_NAME like 'A%';


--38 Write a query to list the names (first and last) of those employees whose last name ends with a.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where LAST_NAME like '%a';

--39 Write a query to list the names (first and last) of those employees whose name have second alphabet 's' in their names.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where FIRST_NAME like '_s%';

--40 Write a query to list the names (first and last) of those employees whose first name has only five characters.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where length(FIRST_NAME)=5;

select FIRST_NAME, LAST_NAME
from EMPLOYEES
where FIRST_NAME like '_____';

--41 Write a query to list the names (first and last) of those employees whose first name has only five characters and starts with 'A'.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where FIRST_NAME like 'A____';


--42 Write a query to list the names (first and last) of those employees whose first name has only five characters and 
--last name have third alphabet ends with 's'.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where FIRST_NAME = '_____'
and LAST_NAME like '__s%';


--43 `Write a query to list the names (first and last) of the employees whose first name has only five characters and starting with 'S' 
--and ending with 'n'.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where FIRST_NAME like 'S___n';

--44 Write a query to list the names (first and last), hire date of those employees who joined in the month of which second character 
--is 'u'.
select FIRST_NAME, LAST_NAME, HIRE_DATE
from EMPLOYEES where to_char(HIRE_DATE, 'month')like '_u%';


--45 Write a query to list the names (first and last), salary of those employees whose salary is four digit number ending with Zero.

--this works, maar is er sprake van implicit conversion?
select FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where salary like '___0';

--46 Write a query to list the names (first and last), salary of those employees whose names having a character set 'll' together.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where FIRST_NAME like '%ll%';

--47 Write a query to list first_name, last_name of employees with the pattern 'l_x' in their first name.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where FIRST_NAME like 'L_x';

/* Where: Is null , is not null */
--48 Write an query of all employees who earn an commission
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where COMMISSION_PCT is not null;


--49 Write an query to get the employee who has no manager
select *
from EMPLOYEES
where MANAGER_ID is null;

--50 Write an query to gel all departments who don’t have an manager
select *
from DEPARTMENTS
where MANAGER_ID is null;

--51 Write an query to get all departments who have an manager
select *
from DEPARTMENTS
where MANAGER_ID is not null;

--52 Write an query to get all location who are not assigned to an state_province and in the Roma, Venice and London.
select *
from LOCATIONS
where STATE_PROVINCE is NULL
and CITY in('Roma', 'Venice', 'London');



/* Where: &, && */
--53 Write a query to get employees who’s first_name are Neena, Valli, John and Luis. Use 1 query for this and use the &.
select FIRST_NAME, LAST_NAME
from EMPLOYEES
where FIRST_NAME in('&name1', '&name2', '&name3', '&name4');

--54 Write an query to get all employees who were hired after 16-08-2002. Use & to prompt for the date.
accept dateP prompt 'enter date as 16-08-2002'
select FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE
from EMPLOYEES
where HIRE_DATE>to_date('&dateP', 'DD-MM-YY')
undefine dateP;


--55 Write 2 queries were you use the substitution variable of the first query in the second query. 
     -- The first query should get all employees who’s name are Steven
     -- The second query should get all employee who’s name are Steven and salary are higher then 5000.

/* 
Substitution: Define */

--56 Create a substitution variable which you can use in multiple queries. The query should do the following
    -- Get all employees where job_id = ST_CLERK
    -- Get all description of that job and the min and max_salary   
    --And the history
--57 Change job_id of 56 to SA_REP and rerun the queries of 56 again.

/* Order by */

--58 Write a query to get all employees sorted in alphabetic order.
--59 Write a query to get all employee who earn a commission first and the those who done. 
--60 Write a query to get all employees sorted based on the salary the earn. Highest first.
--61 Write a query to get all employees based in the date the were hired. Oldest employee first. 
--62 Write a query to get all jobs the employee have sorted in alphabetic order. Use distinct in employee table


/* Fetch: */
--64 Write a query to get the top 10 earning employees
--65 Write a query to get the 10 lowest earning employees
--66 Write a query to get the top 10 paying jobs starting from the 3 paying job

