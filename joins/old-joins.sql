--This is called a cartesian product
--each row in table one will be joined with each row in table 2. Dus the amount of rows is basically
--het aantal rows uit table 1*het aantal rows uit table 2
--Steven for example will be repeated for every department
select emp.employee_id, emp.FIRST_NAME,
    dep.department_id,
    dep.department_name
    from EMPLOYEES emp, DEPARTMENTS DEP
    order by EMP.EMPLOYEE_ID;


--Equijoins/simple join/inner join
--Table prefixes(dat is die volle table name, wat ik hier heb gebruikt is een table alias)
-- moeten alleen als die kolumn exist in beide tables otherwise gaat hij die ambigious error geven
--But its better to use it anw om je select statement more readable te maken
select emp.employee_id, emp.first_name, dep.department_id, dep.department_name
from EMPLOYEES emp, DEPARTMENTS dep
where emp.department_id=dep.department_id
order by emp.employee_id;


--ofc mag je ook multiple where conditions hebben in een join statement
SELECT emp.EMPLOYEE_ID, emp.FIRST_NAME, dep.DEPARTMENT_ID, dep.DEPARTMENT_NAME
from EMPLOYEES emp, DEPARTMENTS dep
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
and emp.DEPARTMENT_ID>40
order by emp.EMPLOYEE_ID;

--dit kan ook but probably not recommended to be doing this? looks whack anw
SELECT emp.EMPLOYEE_ID, emp.FIRST_NAME, dep.DEPARTMENT_ID, dep.DEPARTMENT_NAME
from EMPLOYEES emp, DEPARTMENTS dep
where emp.DEPARTMENT_ID>40
and emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
order by emp.EMPLOYEE_ID;


--table alias:
select emp.employee_id, emp.first_name, dep.department_id, dep.department_name
from EMPLOYEES emp, DEPARTMENTS dep
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
order by emp.EMPLOYEE_ID;

--table prefix
select employees.EMPLOYEE_ID, EMPLOYEES.FIRST_NAME, departments.DEPARTMENT_ID, departments.DEPARTMENT_NAME
from EMPLOYEES, DEPARTMENTS
where EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
order by EMPLOYEES.EMPLOYEE_ID;


select emp.EMPLOYEE_ID, emp.FIRST_NAME, dep.DEPARTMENT_ID, dep.DEPARTMENT_NAME, LOC.LOCATION_ID, loc.CITY
from EMPLOYEES emp, DEPARTMENTS dep, LOCATIONS loc 
where emp.DEPARTMENT_ID=DEP.DEPARTMENT_ID
and dep.LOCATION_ID=loc.LOCATION_ID
order by emp.EMPLOYEE_ID;


--met 5 tables
SELECT emp.FIRST_NAME, dep.DEPARTMENT_NAME, LOC.LOCATION_ID, CNTR.COUNTRY_NAME, reg.REGION_NAME
from EMPLOYEES emp, DEPARTMENTS dep, LOCATIONS loc, COUNTRIES CNTR, regions reg
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
and dep.LOCATION_ID=loc.LOCATION_ID
and loc.COUNTRY_ID=CNTR.COUNTRY_ID
and CNTR.REGION_ID=reg.REGION_ID;



---this doesnt do anything
select emp.first_name, dep.department_name
from EMPLOYEES emp, DEPARTMENTS dep
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
and emp.DEPARTMENT_ID=DEP.DEPARTMENT_ID;


--nonequijoins

select *
from JOB_GRADES;

select e.FIRST_NAME,e.salary, j.GRADE_LEVEL
from employees e, JOB_GRADES j
where e.salary between j.LOWEST_SAL and j.HIGHEST_SAL;

select e.first_name, e.salary, j.GRADE_LEVEL
from EMPLOYEES e, JOB_GRADES j 
where e.salary >= j.LOWEST_SAL and e.SALARY <=j.HIGHEST_SAL;

--with new 1999 syntax
select e.first_name, e.salary, j.GRADE_LEVEL
from EMPLOYEES E join JOB_GRADES j on e.salary between j.LOWEST_SAL and j.HIGHEST_SAL;

select e.first_name, e.salary, j.GRADE_LEVEL
from EMPLOYEES e join JOB_GRADES j on e.salary >= j.LOWEST_SAL and e.salary<=j.HIGHEST_SAL;

--outer joins
select emp.employee_id, emp.first_name, dep.department_id
from EMPLOYEES emp, DEPARTMENTS DEP
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;

--In de bovengenoemde query zie je 107 rows, omdat 1 employee geen department heeft en die wordt dus niet included
--Nou de missing side in dit geval is dus die dep.department_id omdat bij emp.department_id er wel een null is but a null value
--in the department table isnt matching dus om het toch te displayen maak je gebruik van je outer join operator

--You can also use an outer join to also see rows that do not meet the join condition.
--lees dit als include alles van emp and anything in departments that matches
--Hierbij is Kimberly wel included
SELECT emp.FIRST_NAME, emp.LAST_NAME, dep.DEPARTMENT_NAME
from EMPLOYEES emp, DEPARTMENTS dep 
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID(+);


--Hierbij zeg je first of all dat je dept table je main table is.
--Hierbij zijn alle rows van departments included die geen match hebben in die employee table. Zo met andere woorden
--alle departments die geen employees hebben
--lees dit als include alles van departments and include anything in employees that matches the department_id
select emp.first_name, emp.LAST_NAME, dep.department_name
from EMPLOYEES emp, DEPARTMENTS dep 
where emp.DEPARTMENT_ID(+)=dep.DEPARTMENT_ID;



--Hier is Kimberely included
SELECT emp.FIRST_NAME, DEP.DEPARTMENT_NAME
from EMPLOYEES emp, DEPARTMENTS dep 
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID(+)
and emp.FIRST_NAME='Kimberely';



--Hierbij is Kimberely niet included
select emp.FIRST_NAME, DEP.DEPARTMENT_NAME
from EMPLOYEES emp, DEPARTMENTS dep 
where emp.DEPARTMENT_ID(+)=dep.DEPARTMENT_ID
and EMP.FIRST_NAME='Kimberely';


--wat is je main table?
--employees. Dus je wilt alle rows displayen die matchen met jobs and also the ones that dont have a match
select emp.FIRST_NAME, j.JOB_TITLE
from EMPLOYEES emp, jobs J
where emp.JOB_ID=j.JOB_ID(+);

--en als je main table jobs is en je alle rows wilt displayen met employees die matchen and any extra jobs that aren't coupled
--with an employee en dat doe je als volgt:
--Yep hier heb je sap_cons die niet matched met any employee since no employee has that as a job
select emp.FIRST_NAME, J.JOB_TITLE
from EMPLOYEES emp, jobs J
where emp.JOB_ID(+)=j.JOB_ID;


select dep.DEPARTMENT_NAME, loc.CITY
from DEPARTMENTS dep, LOCATIONS loc
where dep.LOCATION_ID = loc.LOCATION_ID(+);

--Alle rows van location dat matchen met a department and also the ones that dont match a department!!
select dep.DEPARTMENT_NAME, loc.CITY
from DEPARTMENTS dep, LOCATIONS loc 
where dep.LOCATION_ID(+)=loc.LOCATION_ID;

select *
from LOCATIONS;

select * from EMPLOYEES order by JOB_ID asc;

--Self join: when doing a self join you should imagine splitting the one table into 2 tables
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME
from EMPLOYEES;


select worker.EMPLOYEE_ID,worker.FIRST_NAME, worker.MANAGER_ID, manager.FIRST_NAME
from EMPLOYEES worker, EMPLOYEES manager
where worker.MANAGER_ID=manager.EMPLOYEE_ID;

--alles van worker dat matched met managers and also the ones that dont match a manager
select worker.first_name, worker.manager_id, manager.employee_id, manager.first_name
from EMPLOYEES worker, EMPLOYEES MANAGER
where worker.MANAGER_ID=manager.EMPLOYEE_ID(+);


--Alles van manager dat matched met employees and even the ones that dont have employees
select worker.first_name,worker.SALARY, worker.manager_id, manager.employee_id, manager.first_name, manager.SALARY
from EMPLOYEES worker, EMPLOYEES MANAGER
where worker.MANAGER_ID(+)=manager.EMPLOYEE_ID;



/*Example: Retrieve all the employees(emp_id, first_name, dept_id) whose salary is >2500
And display their department name, department location and department city and country
All employees should appear even if they have no department*/

select count(*)
from EMPLOYEES
where salary>2500;

--Je zet die outer join operator bij departments om die ene employee ook mee te halen die geen department heeft.
--Als je het niet zet bij derest van de join statements gaat die ene employee niet meekomen
select emp.EMPLOYEE_ID, emp.FIRST_NAME, dep.DEPARTMENT_NAME, loc.CITY, countries.COUNTRY_NAME
from EMPLOYEES emp, DEPARTMENTS dep, LOCATIONS loc, COUNTRIES
where emp.department_id=dep.department_id(+)
and dep.LOCATION_ID=loc.LOCATION_ID(+)
and loc.COUNTRY_ID=countries.COUNTRY_ID(+)
and salary > 2500
order by emp.FIRST_NAME; 



