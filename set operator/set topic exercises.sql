/* Using The UNION and UNION ALL operators
HR Schema: UNION and UNION ALL */

--1 Write 2 sql queries and combine them. First query should get all employees and second should also get all employees. 
--Use the union set operator.Check the amount of row returned. Why do think that is?
select *
from EMPLOYEES
union
select *
from EMPLOYEES;

/*Is gewoon 108 rows bc union gets rid of duplicates*/


--2 Write 2 sql queries and combine them using the set operator union all. First query should get all 
--employees and second should also get all employees. Check the amount of rows returned. What’s the difference between union and union all?
select *
from EMPLOYEES
union ALL
select *
from EMPLOYEES;

/*216 rows omdat union all does not get rid of duplicates. Also union all is ook niet gesorteerd*/

--3 Write 2 sql queries and combine them using the set operator union. 
--First query should get first_name, last_name, email of employees. Second query should get last_name, first_name and email of employees.
-- What do you notice?
select FIRST_NAME, LAST_NAME, EMAIL
from EMPLOYEES
UNION
select FIRST_NAME, LAST_NAME, EMAIL
from EMPLOYEES;

/*Uh gewoon 108 rows*/

--4 Write 2 sql queries and combine them using set operator union. 
--Frist query should get first_name, last_name, phone_number of employees. 
--Second query should get first_name, last_name and email of employees. What do you notice. Try to fix it.

select FIRST_NAME, LAST_NAME, PHONE_NUMBER
from EMPLOYEES
union
select FIRST_NAME, LAST_NAME, EMAIL
from EMPLOYEES;





--5 Write 2 sql queries and combine them using set operator union. 
--First query should get first_name, job_id and salary of employees. 
--Second query should get first_name and last_name of employees. What do you notice? Fix it.
select FIRST_NAME, JOB_ID, SALARY from EMPLOYEES
union
select FIRST_NAME, LAST_NAME, null as salary
from EMPLOYEES;

--6 Write 2 sql queries and combine them using set operator union. 
--First query should get first_name and last_name of employees. 
--Second query should get first_name as 'Voornaam' and last_name as 'Achternaam' of employees. What do you notice. Fix it. 
--The column alias should be show in the result set.

--The 2nd one won't work but the first one will

select FIRST_NAME as Voornaam, LAST_NAME as Achternaam
from EMPLOYEES
union
select FIRST_NAME, LAST_NAME
from EMPLOYEES;


select FIRST_NAME, LAST_NAME
from EMPLOYEES
union
select FIRST_NAME as Voornaam, LAST_NAME as Achternaam
from EMPLOYEES;


/* HR Schema: Intersect */

--7 Write 2 queries and combine them using the intersect set operator.
-- First query should get salary of employees where job_id = 'IT_PROG'. 
--Second query should get salary of employees where job_id = 'FI_ACCOUNT'. Check the output and why do think it is like that.

--Je krijgt die 4800 in deze query niet, omdat die intersect gemeenschappelijke values **tussen** die 2 queries wilt ophalen
--Die 4800 komt gewoon 2 keer voor in die 2de query. Niet gemeenschappelijk tussen query one and query two
select salary from EMPLOYEES where JOB_ID='IT_PROG'
intersect
select SALARY from EMPLOYEES where JOB_ID='FI_ACCOUNT';


select FIRST_NAME, JOB_ID, salary from EMPLOYEES
where JOB_ID='IT_PROG' or JOB_ID='FI_ACCOUNT';

select *
from EMPLOYEES
order by JOB_ID;


--8 How many jobs have the same min_salary? Write a query to check this.
--Unanswered
SELECT min_salary
FROM jobs
GROUP BY min_salary
HAVING COUNT(*) > 1
UNION
select MIN_SALARY
from JOBS
group by MIN_SALARY
having count(*)>1;



SELECT MIN_SALARY
FROM jobs
GROUP BY MIN_SALARY
HAVING COUNT(*) > 1
INTERSECT
SELECT MIN_SALARY
FROM jobs;









--9 How many jobs have the same max_salary? Write a query to check this.

--10 How many jobs have the same min_salary and max_salary? Write a query to check this.


select count(*) from(
select MIN_SALARY as salary
from jobs
intersect
select max_salary from jobs);





/* HR Schema: Minus */
--11 Write a query to show all departments except of the one with location 1700. Use minus operator. 
select * from DEPARTMENTS
MINUS
select * from DEPARTMENTS where LOCATION_ID=1700;




--12 Write a query to show all departments with a manager. Use minus operator.
select * from DEPARTMENTS
minus
select * from DEPARTMENTS WHERE MANAGER_ID is null;

--13 Write a query to show all departments with no manager. Use minus operator.
select * from DEPARTMENTS
MINUS
select * from DEPARTMENTS where MANAGER_ID is not null;


--14 Show all employees who earn a commission_pct. Use minus operator.
select * from EMPLOYEES
MINUS
select * from EMPLOYEES where COMMISSION_PCT is null;

--15 Show all employees who dont earn a commission_pct. Use minus operator.
select * from EMPLOYEES
minus
select * from EMPLOYEES where COMMISSION_PCT is not null;

--16 Show all employees of department 80 except the employees with job_id 'SA_MAN'. Use minus.
select * from EMPLOYEES where DEPARTMENT_ID=80
minus
select * from EMPLOYEES where JOB_ID='SA_MAN';


/* HR Schema: Order by Set Operators */
--17 Write 2 sql queries and combine them. First query should get all employees and second should also get all employees. 
--Use the union set operator. Sort the data in alphabetic on first_name.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID from employees
union
select * from EMPLOYEES
order by FIRST_NAME;


--18 Write 2 sql queries and combine them using the set operator union all. 
--First query should get all employees and second should also get all employees. Sort the data in alphabetic on last_name.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME as lname, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID from EMPLOYEES
UNION
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME as llname, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID from EMPLOYEES
order by lname;


--19 Write 2 sql queries and combine them using the set operator union. 
--First query should get first_name, last_name, email of employees. 
--Second query should get last_name, first_name and email of employees. Sort on email alphabetic.
select FIRST_NAME, LAST_NAME, EMAIL from EMPLOYEES
union
select FIRST_NAME, LAST_NAME, EMAIL from EMPLOYEES
order by EMAIL;


--20 Write 2 sql queries and combine them using set operator union. 
--Frist query should get first_name, last_name, phone_number of employees. Second query should get first_name, last_name and email 
--of employees. Sort on email alphabetic.

select FIRST_NAME, LAST_NAME, PHONE_NUMBER from EMPLOYEES
union
select FIRST_NAME, LAST_NAME, EMAIL from EMPLOYEES
order by PHONE_NUMBER;


--21 Write 2 sql queries and combine them using set operator union. 
--First query should get first_name, job_id and salary of employees. 
--Second query should get first_name and last_name of employees. What do you notice? Fix it. Sort on salary.
select FIRST_NAME, JOB_ID, SALARY from EMPLOYEES
union
select FIRST_NAME, LAST_NAME, null as salary from EMPLOYEES
order by SALARY;



--22 Write 2 sql queries and combine them using set operator union. 
--First query should get first_name and last_name of employees. 
--Second query should get first_name as 'Voornaam' and last_name as 'Achternaam' of employees. What do you notice. Fix it. 
--The column alias should be show in the result set. Sort on first_name of second query
select FIRST_NAME as Voornaam, LAST_NAME as Achternaam from EMPLOYEES
UNION
select FIRST_NAME as Voornaam, LAST_NAME as from EMPLOYEES
order by Voornaam;


select FIRST_NAME as Voornaam
from EMPLOYEES
order by FIRST_NAME;





--23 Write 2 sql queries to show the first_name, last_name, job_id and total_salary(salary + commission_pct). 
--The first query should be for department 50 and the second for department 80. 
--Determine which set operator to use based on following requirements:
    --Show all employees. 
    --Show only employee with same total_salary. 
    --Show employees who have a total_salary. 
    --Show employees who dont have a total_salary.
    --Sort the result set of all queries on job_id and total_salary.


-- Query for department 50


--1 
select FIRST_NAME, LAST_NAME, JOB_ID,salary, SALARY+(nvl(COMMISSION_PCT,0)*SALARY) as new_salary
from EMPLOYEES WHEre DEPARTMENT_ID=50
UNION all
select FIRST_NAME, LAST_NAME, JOB_ID, salary,SALARY+(nvl(COMMISSION_PCT,0)*SALARY)
from EMPLOYEES where DEPARTMENT_ID=80
order by JOB_ID, new_salary;


--2
select first_name, last_name, salary+(nvl(commission_pct, 0)*salary) as new_salary from employees 
where salary+(nvl(commission_pct, 0)*salary) in (
    select new_salary from(
    select FIRST_NAME, LAST_NAME, JOB_ID,salary, SALARY+(nvl(COMMISSION_PCT,0)*SALARY) as new_salary
    from EMPLOYEES WHEre DEPARTMENT_ID=50
    UNION all
    select FIRST_NAME, LAST_NAME, JOB_ID, salary,SALARY+(nvl(COMMISSION_PCT,0)*SALARY)
    from EMPLOYEES where DEPARTMENT_ID=80
    order by JOB_ID, new_salary)
    group by new_salary
    having count(new_salary)>1
);

select new_salary, count(new_salary) from(
    select FIRST_NAME, LAST_NAME, JOB_ID,salary, SALARY+(nvl(COMMISSION_PCT,0)*SALARY) as new_salary
    from EMPLOYEES WHEre DEPARTMENT_ID=50
    UNION all
    select FIRST_NAME, LAST_NAME, JOB_ID, salary,SALARY+(nvl(COMMISSION_PCT,0)*SALARY)
    from EMPLOYEES where DEPARTMENT_ID=80
    order by JOB_ID, new_salary)
    group by new_salary
    having count(new_salary)>1;



--3: 
select FIRST_NAME, LAST_NAME, JOB_ID,salary, SALARY+(nvl(COMMISSION_PCT,0)*SALARY) as new_salary
from EMPLOYEES WHEre DEPARTMENT_ID=50 and COMMISSION_PCT is not null
UNION all
select FIRST_NAME, LAST_NAME, JOB_ID, salary,SALARY+(nvl(COMMISSION_PCT,0)*SALARY)
from EMPLOYEES where DEPARTMENT_ID=80 and COMMISSION_PCT is not null
order by JOB_ID, new_salary;


--4:
select FIRST_NAME, LAST_NAME, JOB_ID,salary, SALARY+(nvl(COMMISSION_PCT,0)*SALARY) as new_salary
from EMPLOYEES WHEre DEPARTMENT_ID=50 and COMMISSION_PCT is  null
UNION all
select FIRST_NAME, LAST_NAME, JOB_ID, salary,SALARY+(nvl(COMMISSION_PCT,0)*SALARY)
from EMPLOYEES where DEPARTMENT_ID=80 and COMMISSION_PCT is  null
order by JOB_ID, new_salary;

