/* Creating Groups of Data
HR Schema: Creating Groups of Data */


--1 Write an sql query to show all first_names only ones and order by alphabetic. Use group by.
select FIRST_NAME
from EMPLOYEES
group by FIRST_NAME
order by FIRST_NAME;

--2 Write an sql query to show all last_names only ones order by alphabetic. Use group by.
select LAST_NAME
from EMPLOYEES
group by LAST_NAME
order by LAST_NAME;


--3 Write an sql query to show all salary only ones and show the lowest value first. Use group by.
select SALARY
from EMPLOYEES
group by SALARY
order by salary;

--4 Write an sql query to show all job_id only ones and order by alphabetic. Use group by.
select JOB_ID
from EMPLOYEES
group by JOB_ID
order by JOB_ID;

select FIRST_NAME, LAST_NAME, jobs.JOB_ID, jobs.JOB_TITLE
from jobs left join EMPLOYEES on jobs.JOB_ID=EMPLOYEES.JOB_ID;

--5 Write an sql query to show all commission_ptc only ones and order by alphabetic. Use group by.
select COMMISSION_PCT
from EMPLOYEES
group by COMMISSION_PCT
order by COMMISSION_PCT;


--6 Write an sql query to show the employees salary and commission_ptc only ones. Use group by.
select SALARY, COMMISSION_PCT
from EMPLOYEES
group by salary, COMMISSION_PCT
order by SALARY, COMMISSION_PCT;


/* Aggregate functions
HR Schema: Aggregate functions */

--7 Write a sql query to get the average salary paid to the employees.
select avg(salary)
from EMPLOYEES;


--8 Write a sql query to show only the lowest salary paided.
select min(SALARY)
from EMPLOYEES;

--9 Write a sql query to show only the highest salary paided.
select max(SALARY)
from EMPLOYEES;

--10 Write a sql query to show only the mid salary paided.
select (max(salary)+min(SALARY))/2 from EMPLOYEES;

--11 Write a sql query to show the amount of employees using the employee_id and department_id. 
--What do you notice and why do think this happens
select count(EMPLOYEE_ID), count(DEPARTMENT_ID)
from EMPLOYEES;
--bc there is one employee without a department_id
select *
from EMPLOYEES;


--12 Write a sql query to get the first employee hired.
select min(HIRE_DATE)
from EMPLOYEES;

--13 Write a sql query to get the last employee hired.
select max(HIRE_DATE)
from EMPLOYEES;

--14 Write a Oracle SQL query to get the total salary being paid to all employees.
select sum(SALARY)
from EMPLOYEES;

--15 Write a Oracle SQL query to display department id and total number of employees working in each department.
select DEPARTMENT_ID, count(*)
from EMPLOYEES
group by DEPARTMENT_ID
order by DEPARTMENT_ID;


--16 Write a Oracle SQL query to display the designation (job id) and total number of employees working in each designation.
select JOB_ID, count(*)
from EMPLOYEES
group by JOB_ID
order by JOB_ID;

--17 Write a Oracle SQL query to display the department number and total salary for each department.
select DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID
order by DEPARTMENT_ID;

--18 Write a Oracle SQL query to display the department number and maximum salary for each department.
select DEPARTMENT_ID, max(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID
order by DEPARTMENT_ID;

--19 Write a Oracle SQL query to display the designations (job id) and total salary 
--allotted for each designation from the company.
select JOB_ID, sum(SALARY)
from EMPLOYEES
group by JOB_ID
order by JOB_ID;


/* HR Schema: Restricting Group Results */
--20 Write an sql query to show all the salaries paid by the company bigger then 5000. Use having clause.
select DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID
having sum(salary) > 5000
order by DEPARTMENT_ID;

--21 Write an sql query to show amount of employees working per job_id where the salary is bigger then 5000.
select JOB_ID, count(*)
from EMPLOYEES
having sum(salary)>5000
group by JOB_ID
order by JOB_ID;


select *
from EMPLOYEES
order by JOB_ID;

--22 Write an sql query to show the amount of employees working per departments where the job_id is not 
--ST_CLERK and salary is bigger then 5000.
select DEPARTMENT_ID, count(*)
from EMPLOYEES
where JOB_ID != 'ST_CLERK'
group by DEPARTMENT_ID
having sum(salary)>5000
