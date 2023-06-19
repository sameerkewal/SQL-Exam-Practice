/* Displaying Data from Multiple Tables
HR Schema: INNER JOIN */


--1 Write an sql query to show the following columns of employees table: first_name, last_name and job_title.
select emp.first_name, emp.last_name, j.JOB_TITLE
from EMPLOYEES emp, jobs J where j.JOB_ID=emp.JOB_ID;

--2 Write an sql query to show the following columns of employees table: first_name, last_name and department_name.
SELECT emp.FIRST_NAME, emp.LAST_NAME, dep.DEPARTMENT_NAME
from EMPLOYEES emp, DEPARTMENTS DEP
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;


--3 Write an sql query to show the following columns of employees table: first_name, last_name, department_name and job_title.
select emp.FIRST_NAME, emp.LAST_NAME, dep.DEPARTMENT_NAME, j.JOB_TITLE
from EMPLOYEES emp, DEPARTMENTS dep, jobs j
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
and emp.JOB_ID=j.JOB_ID
order by j.JOB_TITLE;

--4 Write an sql query to show the following columns of employees table: first_name, last_name department_name, street_address, 
--country_name and region_name.
select emp.FIRST_NAME, emp.LAST_NAME, dep.DEPARTMENT_NAME, loc.STREET_ADDRESS, CNTR.COUNTRY_NAME, reg.REGION_NAME
from EMPLOYEES emp, DEPARTMENTS dep, LOCATIONS loc, countries CNTR, REGIONS reg
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
and dep.LOCATION_ID=loc.LOCATION_ID
and loc.COUNTRY_ID=CNTR.COUNTRY_ID
and cntr.REGION_ID=reg.REGION_ID;



--5 Write an sql query to show all the employees working in the region 'Europe’.
select emp.FIRST_NAME, emp.LAST_NAME, dep.DEPARTMENT_NAME, cntr.COUNTRY_NAME, reg.REGION_NAME
from EMPLOYEES emp, DEPARTMENTS dep, LOCATIONS loc, countries cntr, regions REG 
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
and dep.LOCATION_ID=loc.LOCATION_ID
and loc.COUNTRY_ID=CNTR.COUNTRY_ID
and cntr.REGION_ID=reg.REGION_ID
and reg.REGION_NAME='Europe';

--6 Write an sql query to show all the different jobs an employee has/had.
select emp.FIRST_NAME, EMP.LAST_NAME, emp.JOB_ID as current_job, EMP.HIRE_DATE, j.JOB_ID as old_job, j.START_DATE, j.END_DATE
from EMPLOYEES emp, JOB_HISTORY j
where emp.EMPLOYEE_ID=j.EMPLOYEE_ID;

select *
from JOB_HISTORY
order by EMPLOYEE_ID;

select *
from EMPLOYEES
order by EMPLOYEE_ID;




--7 Write a sql queries to Join locations and countries(use natural join). 
--The select_list of the different queries should be
--a Query 1 => show all columns of both tables

    select *
    from locations loc, countries cntr
    where loc.COUNTRY_ID=cntr.COUNTRY_ID;

--b Query 2 => show all columns of locations table. What do you notice
    select LOC.LOCATION_ID, LOC.STREET_ADDRESS, LOC.POSTAL_CODE, LOC.CITY, LOC.STATE_PROVINCE, LOC.COUNTRY_ID
    from LOCATIONS loc, COUNTRIES cntr
    where loc.COUNTRY_ID=cntr.COUNTRY_ID(+);

--c Query 3 => show all columns of countries table. What do you notice
    select CNTR.COUNTRY_ID, CNTR.COUNTRY_NAME, CNTR.REGION_ID
    from locations loc, countries CNTR
    where loc.COUNTRY_ID(+)=cntr.COUNTRY_ID;

--d Query 4 => show country_name only 
    select COUNTRY_NAME
    from locations loc, countries cntr 
    where loc.COUNTRY_ID=cntr.country_id;

--e Query 5 => show street_address only
    select STREET_ADDRESS
    from locations loc, countries CNTR
    where loc.COUNTRY_ID=cntr.COUNTRY_ID;

--fQuery 6 => show column mention 1 q4 and q5
--14 Do the same as question 7 but instead of using natural join, join the tables using the keyword USING.
--a
select *
from locations loc join countries cntr using(COUNTRY_ID);

--b
select LOC.LOCATION_ID, LOC.STREET_ADDRESS, LOC.POSTAL_CODE, LOC.CITY, LOC.STATE_PROVINCE, COUNTRY_ID
from locations loc join countries using(COUNTRY_ID);

--c
SELECT COUNTRY_ID, CNTR.COUNTRY_NAME, CNTR.REGION_ID
from locations loc join countries cntr using(COUNTRY_ID);

--d
select cntr.country_name
from locations loc join countries cntr using(COUNTRY_ID);

--e
select loc.STREET_ADDRESS
from locations loc join countries cntr using(COUNTRY_ID);



/* HR Schema: LEFT JOIN
Make exercises 1-8 using left join.  */

--1 Write an sql query to show all locations and the employees connected to the locations. 
--All locations should be shown, regardless if they areconnected to an employees or not.
SELECT loc.CITY, dep.DEPARTMENT_NAME, EMP.FIRST_NAME
from locations loc left join DEPARTMENTS DEP on loc.LOCATION_ID=dep.LOCATION_ID
left join employees emp on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;


select * from LOCATIONS;
 
--2 Write an sql query to show all locations not connected to an employee.
select loc.LOCATION_ID, loc.CITY, dep.DEPARTMENT_NAME, emp.FIRST_NAME
from LOCATIONS loc left join DEPARTMENTS dep on loc.LOCATION_ID=dep.LOCATION_ID
left join EMPLOYEES emp on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
where emp.FIRST_NAME is null and DEP.DEPARTMENT_NAME is null;


select loc.CITY, dep.department_name
from LOCATIONS loc left join DEPARTMENTS dep on loc.LOCATION_ID=dep.LOCATION_ID;


select dep.DEPARTMENT_NAME, emp.FIRST_NAME
from DEPARTMENTS dep left join EMPLOYEES emp on dep.DEPARTMENT_ID=emp.DEPARTMENT_ID;


select *
from LOCATIONS left join DEPARTMENTS on LOCATIONS.LOCATION_ID=DEPARTMENTS.LOCATION_ID order by DEPARTMENT_ID;



--3 Write an sql to only jobs which were changes by employees.
select j.JOB_TITLE
from JOB_HISTORY jh left join jobs j on jh.JOB_ID=j.JOB_ID;

--4 Write an sql query to only show regions which are not connected to employees.
select reg.REGION_NAME, CNTR.COUNTRY_NAME, loc.CITY, dep.DEPARTMENT_NAME, EMP.FIRST_NAME
from REGIONS reg left join countries cntr on cntr.REGION_ID=reg.REGION_ID
left join LOCATIONS LOC on loc.COUNTRY_ID=cntr.COUNTRY_ID
left join DEPARTMENTS dep on loc.LOCATION_ID=dep.LOCATION_ID
left join EMPLOYEES emp on dep.DEPARTMENT_ID=emp.department_id
where EMP.FIRST_NAME is null;


select *
from LOCATIONS;
select *
from countries cntr left join LOCATIONS loc on cntr.COUNTRY_ID=loc.COUNTRY_ID;
select * from REGIONS;

--5 Write an sql query to show only show employees which are connected to a region.
select EMP.FIRST_NAME, DEP.DEPARTMENT_NAME, loc.CITY, cntr.COUNTRY_NAME, reg.REGION_NAME
from EMPLOYEES emp left join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
left join locations loc on loc.LOCATION_ID=dep.LOCATION_ID
left join countries cntr on cntr.COUNTRY_ID=loc.COUNTRY_ID
left join REGIONS reg on reg.REGION_ID=cntr.REGION_ID
where REG.REGION_NAME is not null;


--6 Write an sql query to only show emplyees who never changed a job.
select EMP.FIRST_NAME, jh.JOB_ID
from EMPLOYEES emp left join JOB_HISTORY jh on jh.EMPLOYEE_ID=emp.EMPLOYEE_ID where JH.JOB_ID is null;


select *
from JOB_HISTORY;

--7 Write an sql query to only show employees who never changed from a department.
--antwoord:
select EMP.FIRST_NAME, jh.JOB_ID as old_job, emp.JOB_ID as new_job
, emp.DEPARTMENT_ID as new_department, jh.DEPARTMENT_ID as old_department
from EMPLOYEES emp left join JOB_HISTORY jh on emp.EMPLOYEE_ID=jh.EMPLOYEE_ID
where NULLIF(emp.DEPARTMENT_ID, jh.DEPARTMENT_ID) is null or jh.department_id is null;

select *
from JOB_HISTORY;


select emp.FIRST_NAME, DEP.DEPARTMENT_NAME
from JOB_HISTORY jh join DEPARTMENTS dep on dep.DEPARTMENT_ID=jh.DEPARTMENT_ID
join EMPLOYEES emp on emp.EMPLOYEE_ID=jh.EMPLOYEE_ID
order by emp.EMPLOYEE_ID ;

select FIRST_NAME, dep.DEPARTMENT_NAME
from EMPLOYEES 
join departments dep on employees.DEPARTMENT_ID=dep.department_id
order by EMPLOYEE_ID;


select *
from jobs;
--8 Write an sql query to show all the regions and the amount of employees per region. Also show the amount of employee who 
--are not connected to a region.
select reg.region_name, count(EMP.EMPLOYEE_ID)
from REGIONS reg left join countries cntr on reg.REGION_ID=cntr.REGION_ID
left join locations loc on cntr.COUNTRY_ID=loc.COUNTRY_ID
left join departments dep on loc.LOCATION_ID=dep.LOCATION_ID
left join employees emp on dep.DEPARTMENT_ID=emp.DEPARTMENT_ID
group by reg.REGION_NAME;



SELECT * from (
    select r.REGION_NAME, COUNT(e.EMPLOYEE_ID) AS EMPLOYEE_COUNT
FROM REGIONS r
left join countries cntr on cntr.REGION_ID=r.REGION_ID
LEFT JOIN LOCATIONS l ON cntr.COUNTRY_ID = l.COUNTRY_ID
LEFT JOIN DEPARTMENTS d ON l.LOCATION_ID = d.LOCATION_ID
LEFT JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY r.REGION_NAME
union 
select 'No Region', count(*)
from EMPLOYEES emp left join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
left join locations loc on loc.LOCATION_ID=dep.LOCATION_ID
left join countries cntr on cntr.COUNTRY_ID=loc.COUNTRY_ID
left join REGIONS reg on reg.REGION_ID=cntr.REGION_ID where DEP.DEPARTMENT_ID is null) result
order by result.REGION_NAME;

/* select EMP.FIRST_NAME, DEP.DEPARTMENT_NAME, loc.CITY, cntr.COUNTRY_NAME, reg.REGION_NAME
from EMPLOYEES emp left join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
left join locations loc on loc.LOCATION_ID=dep.LOCATION_ID
left join countries cntr on cntr.COUNTRY_ID=loc.COUNTRY_ID
left join REGIONS reg on reg.REGION_ID=cntr.REGION_ID where DEP.DEPARTMENT_ID is null; */

select *
from COUNTRIES;


/* Make exercises 1-8 using right join. */
--Right join:

--1 Write an sql query to show all locations and the employees connected to the locations. 
--All locations should be shown, regardless if they areconnected to an employees or not.


select EMP.FIRST_NAME, DEP.DEPARTMENT_NAME, loc.CITY
from EMPLOYEES emp 
right join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
right join locations loc on loc.LOCATION_ID=dep.LOCATION_ID;




--2 Write an sql query to show all locations not connected to an employee.
--answer: 
select distinct EMP.FIRST_NAME, loc.city, loc.STREET_ADDRESS
from EMPLOYEES emp
right join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
right join locations loc on dep.LOCATION_ID=loc.LOCATION_ID
where emp.EMPLOYEE_ID is null
order by loc.CITY;

SELECT loc.LOCATION_ID, loc.CITY, loc.STATE_PROVINCE, loc.COUNTRY_ID
FROM LOCATIONS loc
LEFT JOIN DEPARTMENTS dep ON loc.LOCATION_ID = dep.LOCATION_ID
LEFT JOIN EMPLOYEES emp ON dep.DEPARTMENT_ID = emp.DEPARTMENT_ID
WHERE loc.city = 'Seattle' and EMP.EMPLOYEE_ID is null
ORDER BY loc.LOCATION_ID;



 --3 Write an sql to only jobs which were changes by employees.
 select j.JOB_TITLE
 from jobs j  right join JOB_HISTORY jh on j.JOB_ID=jh.JOB_ID;


 --4 Write an sql query to only show regions which are not connected to employees.
 select reg.REGION_NAME
 from EMPLOYEES emp
 right join DEPARTMENTS dep on dep.DEPARTMENT_ID=emp.DEPARTMENT_ID
 right join locations loc on loc.LOCATION_ID=dep.LOCATION_ID
 right join countries cntr on cntr.COUNTRY_ID=loc.COUNTRY_ID
 right join regions reg on reg.REGION_ID=cntr.REGION_ID
 group by reg.REGION_NAME
 having count(emp.EMPLOYEE_ID)=0
 ;



--5 Write an sql query to show only show employees which are connected to a region.
SELECT EMP.FIRST_NAME, DEP.DEPARTMENT_NAME, LOC.CITY, CNTR.COUNTRY_NAME, REG.REGION_NAME
from REGIONS reg
right join countries cntr on cntr.REGION_ID=reg.REGION_ID
right join locations loc on cntr.COUNTRY_ID=loc.COUNTRY_ID
right join departments dep on loc.LOCATION_ID=dep.LOCATION_ID
right join employees emp on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
where REG.REGION_ID is not null;

--6 Write an sql query to only show emplyees who never changed a job.
select EMP.FIRST_NAME, EMP.JOB_ID as new_job, jh.JOB_ID as old_job
from JOB_HISTORY jh 
right join employees emp on jh.EMPLOYEE_ID=emp.EMPLOYEE_ID
where nullif(emp.JOB_ID, jh.JOB_ID)is null or jh.JOB_ID is null;




--7 Write an sql query to only show employees who never changed from a department.
--antwoord:

SELECT EMP.FIRST_NAME, EMP.DEPARTMENT_ID as new_department, jh.DEPARTMENT_ID as old_department
from job_history jh 
right join EMPLOYEES emp on jh.EMPLOYEE_ID=emp.EMPLOYEE_ID
where jh.DEPARTMENT_ID is null or nullif(emp.DEPARTMENT_ID, JH.DEPARTMENT_ID) is null;



--8 Write an sql query to show all the regions and the amount of employees per region. Also show the amount of employee who 
--are not connected to a region.
select * from(
select REG.REGION_NAME, count(emp.EMPLOYEE_ID)
from EMPLOYEES emp
right join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
right join locations loc on loc.LOCATION_ID=dep.LOCATION_ID
right join countries cntr on cntr.COUNTRY_ID=loc.COUNTRY_ID
right join regions reg on reg.REGION_ID=cntr.REGION_ID
group by reg.REGION_NAME
UNION
select 'no region', count(emp.EMPLOYEE_ID)
from regions REG
right join countries cntr on cntr.REGION_ID=reg.REGION_ID
right join locations loc on loc.COUNTRY_ID=cntr.COUNTRY_ID
right join DEPARTMENTS dep on dep.LOCATION_ID=loc.LOCATION_ID
right join EMPLOYEES emp on dep.DEPARTMENT_ID=emp.DEPARTMENT_ID
where reg.REGION_NAME is null) RESULT
order by result.region_name;


/* HR Schema: FULL JOIN */
--1 Write an sql query to show all employees and deparments.
select *
from EMPLOYEES emp full join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;

--2 Write an sql query to show all regions and employees.
select EMP.FIRST_NAME, DEP.DEPARTMENT_NAME, LOC.CITY, cntr.COUNTRY_NAME, reg.REGION_NAME
from EMPLOYEES emp full join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
full join locations loc on loc.LOCATION_ID=dep.LOCATION_ID
full join countries cntr on cntr.COUNTRY_ID=loc.COUNTRY_ID
full join regions reg on reg.REGION_ID=cntr.REGION_ID;



--3 Write an sql query to show all locations and deparments.
select LOC.LOCATION_ID, LOC.CITY, DEP.DEPARTMENT_NAME
from locations LOC
full join departments dep on dep.LOCATION_ID=loc.LOCATION_ID;





/* HR Schema: SELF JOIN */
--1 Write a sql query to show all employees and the names of their manager.
select WORKER.FIRST_NAME, MANAGER.FIRST_NAME, MANAGER.LAST_NAME
from EMPLOYEES WORKER
join EMPLOYEES manager on worker.MANAGER_ID=MANAGER.EMPLOYEE_ID;


--2 Write a sql query to show all employees and the names of their manager and the department their manager is working for. 
select worker.FIRST_NAME, manager.FIRST_NAME, manager.LAST_NAME, DEP.DEPARTMENT_NAME
from employees WORKER
join employees manager on worker.MANAGER_ID=MANAGER.EMPLOYEE_ID
join departments dep on manager.DEPARTMENT_ID=dep.DEPARTMENT_ID;

--3 Write a sql query to show all employees and the names of their manager and the region their manager lives in. 

select worker.FIRST_NAME, manager.FIRST_NAME, manager.LAST_NAME, reg.REGION_NAME
from employees WORKER
join employees manager on worker.MANAGER_ID=MANAGER.EMPLOYEE_ID
join departments dep on manager.DEPARTMENT_ID=dep.DEPARTMENT_ID
join locations loc on dep.LOCATION_ID=loc.LOCATION_ID
join countries cntr on cntr.COUNTRY_ID=loc.COUNTRY_ID
join regions reg on reg.REGION_ID=cntr.REGION_ID;




/* HR Schema: Non Equijoin  */
--1 Retrieve the employees who are not assigned to any department using a non-equijoin.
select * 
from EMPLOYEES emp join DEPARTMENTS dep on emp.DEPARTMENT_ID between 0 and 200;



--2 List all employees along with their job titles, including those who have not been assigned a job using a non-equijoin.
--3 Find the employees who have a higher salary than their managers, using a non-equijoin.
SELECT worker.FIRST_NAME, worker.SALARY, manager.FIRST_NAME, manager.SALARY
from EMPLOYEES worker join EMPLOYEES manager on worker.MANAGER_ID=manager.EMPLOYEE_ID 
and worker.SALARY>manager.SALARY;


--4 Display the employees who have a higher commission percentage than their department manager, using a non-equijoin.
select WORKER.FIRST_NAME ,WORKer.COMMISSION_PCT, MANAGER.FIRST_NAME, manager.COMMISSION_PCT
from EMPLOYEES worker join EMPLOYEES manager on worker.MANAGER_ID=manager.EMPLOYEE_ID
and worker.COMMISSION_PCT>MANAGER.COMMISSION_PCT;

--5 Retrieve the employees who were hired before their respective managers, using a non-equijoin.
select WORKER.FIRST_NAME, worker.HIRE_DATE, manager.FIRST_NAME, MANAGER.HIRE_DATE
from EMPLOYEES worker join EMPLOYEES manager on worker.MANAGER_ID=manager.EMPLOYEE_ID
and worker.HIRE_DATE<manager.HIRE_DATE;

--6 List the employees who have a higher salary than the average salary of all employees in their department, using a non-equijoin.

select emp.EMPLOYEE_ID, emp.FIRST_NAME, emp.last_name, emp.department_id, emp.SALARY, dept_avg.avg_salary
from EMPLOYEES emp join (
    select department_id, avg(salary) as avg_salary from EMPLOYEES group by DEPARTMENT_ID
)dept_avg on emp.department_id=dept_avg.department_id and emp.salary>dept_avg.avg_salary;

select *
from EMPLOYEES where DEPARTMENT_ID=90;

select dep.DEPARTMENT_NAME, avg(EMP.SALARY)
from EMPLOYEES emp join DEPARTMENTS dep on dep.DEPARTMENT_ID=emp.department_id
group by dep.DEPARTMENT_NAME;

--7 Find the employees who have a job located in a different country than their department's location, using a non-equijoin.

select dep.DEPARTMENT_NAME, loc.city
from DEPARTMENTS dep join locations loc on dep.LOCATION_ID=loc.LOCATION_ID;


select *
from jobs;

--8 Display the employees who have a job title that starts with the same letter as their manager's last name, using a non-equijoin.
select J.JOB_TITLE, manager.LAST_NAME, substr(j.JOB_TITLE, 1, 1), substr(manager.LAST_NAME, 1, 1)
from EMPLOYEES worker 
join jobs j on worker.JOB_ID=j.JOB_ID
join employees manager on worker.MANAGER_ID=manager.EMPLOYEE_ID
order by j.JOB_TITLE;


SELECT emp.EMPLOYEE_ID, emp.FIRST_NAME, emp.LAST_NAME, emp.JOB_ID, mgr.LAST_NAME AS MANAGER_LAST_NAME
FROM EMPLOYEES emp
JOIN EMPLOYEES mgr ON emp.MANAGER_ID = mgr.EMPLOYEE_ID
JOIN JOBS emp_job ON emp.JOB_ID = emp_job.JOB_ID;




select EMP.LAST_NAME, emp.MANAGER_ID, j.JOB_TITLE
from employees emp join jobs j on emp.JOB_ID=j.JOB_ID
where emp.LAST_NAME='Smith'
order by j.JOB_TITLE ;



--9 Retrieve the employees who do not have any subordinates, using a non-equijoin.

 --Dit haalt alle records
 select manager.EMPLOYEE_ID, worker.first_name, manager.first_name
from EMPLOYEES worker right join employees manager on worker.MANAGER_ID=manager.EMPLOYEE_ID
where worker.FIRST_NAME is null
order by manager.EMPLOYEE_ID;





--10 List the employees who have a hire date that falls on a weekend, using a non-equijoin.

select to_char(to_date('25-06-2023', 'DD-MM-yyyy'), 'D') from dual;

select FIRST_NAME, HIRE_DATE from EMPLOYEES
where to_char(HIRE_DATE, 'D')=6 or  to_char(HIRE_DATE, 'D')=7 or  to_char(HIRE_DATE, 'D')=1;


/* HR Schema: Cross Join */
--1 Retrieve the full names of all employees along with the names of their departments using a CROSS JOIN.
select  distinct emp.first_name, emp.last_name
from employees emp 
cross join departments dep;


--2 Find the combination of all employees and jobs in the HR sample database using a CROSS JOIN.
select emp.FIRST_NAME, j.JOB_ID
from employees emp cross join jobs j;

--3 List the employee ID, job ID, and department name for all possible combinations of employees, jobs, and departments.
select *
from employees emp cross join departments dep cross join jobs j;

--4 How many rows are returned when performing a CROSS JOIN between the "employees" and "departments" tables in the HR sample database?
/*2916 rows*/

--5 Display the employee ID, department ID, and location ID for all possible combinations of employees and departments 
--using a CROSS JOIN.

select EMP.EMPLOYEE_ID, dep.DEPARTMENT_ID, dep.LOCATION_ID
from EMPLOYEES emp cross join DEPARTMENTS dep;


--6 Retrieve the employee ID, job title, and manager ID for all
-- employees in the HR sample database, including those who do not have a manager, using a CROSS JOIN.
select distinct emp.EMPLOYEE_ID, j.JOB_TITLE, emp.MANAGER_ID
from employees emp cross join jobs j
where emp.JOB_ID=j.JOB_ID;


--7 Find all possible combinations of employees and departments, along with the associated location ID and country ID 
--using a CROSS JOIN.
select EMP.FIRST_NAME, dep.DEPARTMENT_ID, dep.LOCATION_ID, loc.COUNTRY_ID
from EMPLOYEES emp cross join departments dep 
cross join locations loc;


--8 List the employee ID, department name, and job title for all possible combinations of employees,
-- departments, and jobs in the HR sample database.
select emp.EMPLOYEE_ID, dep.DEPARTMENT_NAME, j.JOB_TITLE
from employees emp cross join departments dep cross join jobs j; 

--9 Retrieve the full names of all employees and the names of their managers using a CROSS JOIN.
select WORKER.FIRST_NAME||' ' ||worker.LAST_NAME as worker_full_name, manager.FIRST_NAME|| ' ' ||manager.LAST_NAME as manager_full_name
from EMPLOYEES worker cross join EMPLOYEES manager
where worker.MANAGER_ID=manager.EMPLOYEE_ID
order by worker.EMPLOYEE_ID;


select WORKER.FIRST_NAME||' ' ||worker.LAST_NAME as worker_full_name, manager.FIRST_NAME|| ' ' ||manager.LAST_NAME as manager_full_name
from EMPLOYEES worker join EMPLOYEES manager on worker.MANAGER_ID=manager.EMPLOYEE_ID
order by worker.EMPLOYEE_ID;



--10 Display the employee ID, department name, and job title for all possible combinations of employees, departments, and jobs, 
--sorted by department name.
select emp.EMPLOYEE_ID, dep.DEPARTMENT_NAME, j.JOB_TITLE
from EMPLOYEES emp cross join departments dep cross join jobs j;

