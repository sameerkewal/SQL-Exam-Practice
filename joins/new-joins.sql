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


--Het is dezelfde value in both tables so its not gonna give an ambiguity error
select DEPARTMENT_ID
from EMPLOYEES
join DEPARTMENTS
using(DEPARTMENT_ID);

--Al is het gewoon in je selecting columns, je kan toch het toch geen prefix alias thing geven
select FIRST_NAME, LAST_NAME, dep.DEPARTMENT_ID
from EMPLOYEES
join DEPARTMENTS dep
using(DEPARTMENT_ID);

select FIRST_NAME, LAST_NAME, departments.DEPARTMENT_ID
from EMPLOYEES
join DEPARTMENTS 
using(DEPARTMENT_ID);


select *
from EMPLOYEES
join JOB_HISTORY using(EMPLOYEE_ID, DEPARTMENT_ID);

select *
from JOB_HISTORY;


select *
from EMPLOYEES
join JOBS using(JOB_ID);

--Trying to get column ambiguously defined error with the using clause
create table TABLE_A(
    id number,
    name varchar2(20),
    age number
);


create table TABLE_B(
    age number,
    id number constraint table_b_table_a_fk references table_a(id)
);

insert into table_a values(1, 'Sameer', 21);
insert into table_a values(2, 'Jasmine', 22);
insert into table_a values(3, 'Gavin', 22);



insert into table_b values(21, 1);
insert into table_b values(22, 2);
insert into table_b values(23,  3);

-- in dit geval is die column wel ambiguously defined
SELECT
    ID,
    NAME,
    AGE
FROM
    TABLE_A
    JOIN TABLE_B
    USING(ID);


--zo alleen bij job_id mag je geen alias of table name zetten, bij derest van de kolumns is dat wel totally allowed
select emp.FIRST_NAME, emp.LAST_NAME, JOB_ID, j.JOB_TITLE
from EMPLOYEES emp
join jobs j using (JOB_ID);

--multiple columns allowed in using clause
select *
from EMPLOYEES
join JOB_HISTORY
using(EMPLOYEE_ID, DEPARTMENT_ID);



--long join using "using clause"
select emp.first_name, emp.last_name, dep.DEPARTMENT_NAME, loc.CITY, COUNTRY_ID, CNTR.COUNTRY_NAME, CNTR.REGION_ID
from EMPLOYEES emp
join DEPARTMENTS dep using(DEPARTMENT_ID)
join LOCATIONS loc using(LOCATION_ID)
join countries cntr using(COUNTRY_ID);

--ook in je where clause mag je geen prefix hebben voor die column
--op basis waarvan je joined
select *
from employees emp
join departments dept
using(department_id)
where dept.department_id>0;


--on clause
--dit gaat werken want die department_name is maar in 1 kolumn
select  FIRST_NAME, LAST_NAME, dep.DEPARTMENT_NAME
from EMPLOYEES emp join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;

--this wont omdat die kolumn in alle 2 tables voorkomt
select EMP.FIRST_NAME, LAST_NAME, department_id, dep.DEPARTMENT_NAME
from EMPLOYEES emp join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;

--now it works yippee
select EMP.FIRST_NAME, LAST_NAME, dep.department_id, dep.DEPARTMENT_NAME
from EMPLOYEES emp join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;

--je kan on ook gebruiken voor non equijoins
select emp.EMPLOYEE_ID , emp.FIRST_NAME, emp.SALARY, j.GRADE_LEVEL
from EMPLOYEES emp join JOB_GRADES J 
on emp.SALARY between j.LOWEST_SAL and j.HIGHEST_SAL;

--totally fine
select emp.EMPLOYEE_ID, emp.FIRST_NAME, emp.SALARY, j.GRADE_LEVEL
from EMPLOYEES emp join job_grades j
on salary between LOWEST_SAL and HIGHEST_SAL;


--ofc kan je ook self join doen using an on clause
select worker.FIRST_NAME, worker.LAST_NAME, worker.EMPLOYEE_ID, MANAGER.FIRST_NAME
from EMPLOYEES worker join EMPLOYEES MANAGER on worker.MANAGER_ID=MANAGER.EMPLOYEE_ID;



--full join:
--Hier include het die Kimberely ook en alle departments that dont have any employees under them
select emp.EMPLOYEE_ID, emp.FIRST_NAME, emp.DEPARTMENT_ID, dep.DEPARTMENT_NAME
from EMPLOYEES emp
full join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;

--left join:
--Kimberely
select emp.EMPLOYEE_ID, emp.FIRST_NAME, emp.DEPARTMENT_ID, dep.DEPARTMENT_name
from EMPLOYEES emp left join DEPARTMENTS DEP
on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;


--right join:
--alle departments that also dont have any employees under them
SELECT emp.EMPLOYEE_ID, emp.FIRST_NAME, emp.DEPARTMENT_ID, dep.DEPARTMENT_NAME
from EMPLOYEES emp right join DEPARTMENTS dep
on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
order by emp.FIRST_NAME;





