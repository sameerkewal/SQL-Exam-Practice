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
 select reg.REGION_NAME, EMP.FIRST_NAME
 from EMPLOYEES emp
 right join DEPARTMENTS dep on dep.DEPARTMENT_ID=emp.DEPARTMENT_ID
 right join locations loc on loc.LOCATION_ID=dep.LOCATION_ID
 right join countries cntr on cntr.COUNTRY_ID=loc.COUNTRY_ID
 right join regions reg on reg.REGION_ID=cntr.REGION_ID;