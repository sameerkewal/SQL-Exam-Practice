select salary
from EMPLOYEES
order by salary desc;



--voor max and min geen gebruik van group by 
select max(SALARY), min(SALARY)
from EMPLOYEES;

--Je kan max and and min with varchar gebruiken en dan
--returned het de laatste value alphabetically
select max(FIRST_NAME), min(FIRST_NAME) 
from EMPLOYEES;

select FIRST_NAME
from EMPLOYEES
order by FIRST_NAME;


--also works with dates
--max is latest date and min is first date
select max(HIRE_DATE), min(HIRE_DATE)
from EMPLOYEES;

select HIRE_DATE
from EMPLOYEES
order by HIRE_DATE;


--sum and avg
--dit is the sum van alle salaries as well as the averages
select sum(SALARY), avg(SALARY)
from EMPLOYEES;

--cant use sum and avg with varchar or dates
select sum(FIRST_NAME), sum(HIRE_DATE), avg(FIRST_NAME), avg(HIRE_DATE)
from EMPLOYEES;


--count function
select *
from EMPLOYEES;

--count(*) returns all the number of rows in a table including duplicate rows and null values.
select count(*)
from EMPLOYEES;

--this is the same as count(*). 
select count(1)
from EMPLOYEES;

--you can use any *number*
select count(999)
from EMPLOYEES;

--zelfs decimale values
select count(99.99)
from EMPLOYEES;

--count column name ignores null values. Null wordt dus niet gecount
select count(COMMISSION_PCT)
from EMPLOYEES;

select count(DEPARTMENT_ID)
from EMPLOYEES;


select count(distinct DEPARTMENT_ID)
from EMPLOYEES;


select count(COMMISSION_PCT)
from EMPLOYEES;

select count(distinct COMMISSION_PCT)
from EMPLOYEES;

--in plaats van null returned het 0 waardoor je wel count kan doen, since it now actually has a value
select count(nvl(COMMISSION_PCT, 0)) from EMPLOYEES;


--use where
select count(DEPARTMENT_ID)
from EMPLOYEES
where DEPARTMENT_ID=90;

select count(distinct DEPARTMENT_ID)
from EMPLOYEES
where DEPARTMENT_ID=90;

select count(DEPARTMENT_ID)
from EMPLOYEES;

--dit hoef je niet te kennen
select listagg(FIRST_NAME, ', ')
within group(order by FIRST_NAME) "Emp List"
from EMPLOYEES
where DEPARTMENT_ID=30;



--not a single-group group function
select DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES; 

--Aan de hand van die kolumn dat je doorgeeft aan je group by statement groupeert het ze 😭😭
select DEPARTMENT_ID
from EMPLOYEES
group by DEPARTMENT_ID;

--All columns that appear in the select statement should appear in the group statement
--je gaat een null value zien met salary 7000
--dat is het opgetelde van alle employees met een department_id van null
select DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID
order by 1;


--dit bewijst bovengenoemde statement
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
from EMPLOYEES where DEPARTMENT_ID is null;


select DEPARTMENT_ID, JOB_ID, sum(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID, JOB_ID
order by 1, 2;


--You can not use an alias in a group by 
select DEPARTMENT_ID dep, sum(SALARY)
from EMPLOYEES
group by dep;


--You can, however, use an alias in an order by
select DEPARTMENT_ID dep, sum(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID
order by dep;

--where gets evaluated first, followed by "group by" and then by order "order by"
select DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES
where DEPARTMENT_ID>30
group by DEPARTMENT_ID
order by DEPARTMENT_ID;


--YOU CAN NOT USE WHERE TO RESTRICT GROUPS:
--GROUP FUNCTION IS NOT ALLOWED HERE
select DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES
where sum(salary)>156400
group by DEPARTMENT_ID
order by DEPARTMENT_ID;


--use having to achieve the above mentioned statement:
--we use having to restrict the group functions
select DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID
having sum(SALARY)>150000
order by DEPARTMENT_ID;

--Je mag group by gebruiken voor having but its not recommended
select DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES
having sum(salary)>150000
group by DEPARTMENT_ID;


--You can use nested group functions
--Bij single row functions kan je unlimited single row functions hebben, maar bij group functions mag je maximaal 2 hebben
select DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID
order by 1;


select max(sum(salary))
from EMPLOYEES
group by DEPARTMENT_ID
order by 1;

--Dit telt hoeveel employees in die department elk werken en het gemiddeld salaris van elke
select DEPARTMENT_ID,
count(*) as employee_count, avg(salary)
from EMPLOYEES
group by DEPARTMENT_ID;


--Calculate the total number of employees in each country.
select cntr.COUNTRY_NAME, count(1)
from employees emp
join DEPARTMENTS dep on dep.DEPARTMENT_ID = emp.DEPARTMENT_ID
join locations loc on dep.LOCATION_ID=loc.LOCATION_ID
join countries cntr on cntr.COUNTRY_ID = loc.COUNTRY_ID
group by cntr.COUNTRY_NAME
order by cntr.COUNTRY_NAME;


--Find the minimum and maximum hire dates for employees in each department.
select DEPARTMENT_ID, max(HIRE_DATE), min(HIRE_DATE)
from EMPLOYEES
group by DEPARTMENT_ID;


--avg salary for the job title man idfk
select JOB_ID, avg(salary)
from EMPLOYEES
group by JOB_ID
order by JOB_ID;


--AVG commission pct per job
select JOB_ID, avg(nvl(COMMISSION_PCT,0))
from EMPLOYEES
group by JOB_ID
order by JOB_ID;

--Hoeveel employees elk jaar in dienst worden genomen
select trunc(HIRE_DATE, 'YYYY'), count(*) as hire_year
from EMPLOYEES
group by trunc(hire_date, 'yyyy')
order by hire_year;

--Hoeveel employees in dienst per location. Je kan location_id veranderen naar location_name and same thing
select loc.LOCATION_ID, count(EMP.EMPLOYEE_ID)
from EMPLOYEES emp
join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
join LOCATIONS loc on loc.LOCATION_ID=dep.LOCATION_ID
group by LOC.LOCATION_ID
order by loc.LOCATION_ID;

select EMP.FIRST_NAME, EMP.LAST_NAME, loc.LOCATION_ID, emp.SALARY
from EMPLOYEES emp
join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
join LOCATIONS loc on loc.LOCATION_ID=dep.LOCATION_ID
order by loc.LOCATION_ID;

--Calculate the average salary for employees in each location.
select loc.LOCATION_ID, avg(EMP.SALARY)
from EMPLOYEES emp
join DEPARTMENTS dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
join LOCATIONS loc on loc.LOCATION_ID=dep.LOCATION_ID
group by LOC.LOCATION_ID
order by loc.LOCATION_ID;


SELECT e.*, sum(e.SALARY) over() as salary_sum
FROM
EMPLOYEES e;


--Je mag een group function hebben in je statement
select FIRST_NAME, max(SALARY)
from EMPLOYEES
group by FIRST_NAME
order by min(SALARY);

--Die aggregate function is verplicht for it to work
-- and since die aggregate function verplicht is dan is die group by clause ook verplicht
select first_name, max(SALARY) from EMPLOYEES
group by FIRST_NAME
order by max(SALARY);


select count(EMPLOYEE_ID)
from EMPLOYEES;



--Dit mag niet zonder een group by 
select count(count(EMPLOYEE_ID))
from EMPLOYEES;



select count(count(employee_id))
from EMPLOYEES
group by EMPLOYEE_ID;


--Je having clause **moet** na de where clause anders gaat het een syntax error geven
select DEPARTMENT_ID, count(EMPLOYEE_ID)
from EMPLOYEES
where DEPARTMENT_ID<>10
having count(EMPLOYEE_ID)>20
group by DEPARTMENT_ID;