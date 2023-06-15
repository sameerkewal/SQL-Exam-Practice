--1999 syntax: cross join
--Produces cartesian product: same AS
select emp.employee_id, emp.first_name, dep.department_name
from EMPLOYEES emp, DEPARTMENTS dep;

--cross join:
select emp.EMPLOYEE_ID, emp.LAST_NAME,dep.department_id ,dep.DEPARTMENT_NAME
from EMPLOYEES emp cross join DEPARTMENTS dep
order by emp.EMPLOYEE_ID;


select emp.EMPLOYEE_ID,EMP.FIRST_NAME, EMP.LAST_NAME, dep.DEPARTMENT_ID,DEP.DEPARTMENT_NAME
from employees emp join DEPARTMENTS DEP on emp.DEPARTMENT_ID=DEP.DEPARTMENT_ID
order by EMP.EMPLOYEE_ID;

--Natural join:
--definitely a wrong use, omdat het both department_id and manager_id pakt
--tbh i have no idea what is even happening once it does that maar is wel wrong
select employee_id, FIRST_NAME, LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
from EMPLOYEES natural join DEPARTMENTS
order by EMPLOYEE_ID;

--Hier is een betere use:
select DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID, CITY
from DEPARTMENTS NATURAL join LOCATIONS;


select dep.DEPARTMENT_ID, dep.DEPARTMENT_NAME, loc.LOCATION_ID, loc.CITY
from DEPARTMENTS dep join LOCATIONS loc
on dep.LOCATION_ID=LOC.LOCATION_ID;

--column used in NATURAL join cannot have qualifier
select departments.DEPARTMENT_ID, departments.DEPARTMENT_NAME, locations.LOCATION_ID, locations.CITY
from DEPARTMENTS natural join LOCATIONS;

--Prefixes mogen dan obviously ook niet
--although als je gewoon die table alias laat and dont use the prefix then its no problem
select dep.department_id, dep.department_name,loc.LOCATION_ID, loc.CITY
from DEPARTMENTS dep natural join locations loc;

--although als je gewoon die table alias laat and dont use the prefix then its no problem
select department_id, department_name, LOCATION_ID, CITY
from DEPARTMENTS dep natural join locations loc;


--Je mag ofc wel in je where statements je prefix/alias gebruiken
select DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID, CITY
from DEPARTMENTS dep natural join locations LOC
where dep.DEPARTMENT_ID>20;

select DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID, CITY
from DEPARTMENTS  natural join locations 
where departments.DEPARTMENT_ID>20;


--Je kan je natural join ook gebruiken met left join and right join
select DEPARTMENT_NAME, LOCATION_ID, CITY
from DEPARTMENTS natural right join LOCATIONS;

--Locations and countries worden gejoined on country_id
select COUNTRY_NAME, CITY
from COUNTRIES natural left join LOCATIONS;

--using clause
--The shared column isn't allowed to be prefixed
select EMPLOYEES.EMPLOYEE_ID,
EMPLOYEES.FIRST_NAME,
DEPARTMENT_ID,
DEPARTMENTS.DEPARTMENT_NAME
from EMPLOYEES join
DEPARTMENTS
using(DEPARTMENT_ID)
order by EMPLOYEE_ID;

select EMP.EMPLOYEE_ID, EMP.EMPLOYEE_ID, EMP.FIRST_NAME, EMP.LAST_NAME, dep.DEPARTMENT_NAME
from EMPLOYEES emp
join DEPARTMENTS DEP using(DEPARTMENT_ID)
where EMP.EMPLOYEE_ID!=100;


select *
from EMPLOYEES
join JOB_HISTORY using(EMPLOYEE_ID, DEPARTMENT_ID);

select *
from JOB_HISTORY;


