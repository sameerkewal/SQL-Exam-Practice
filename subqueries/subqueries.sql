------------------------------Single Row Subqueries-----------------------------------

--Whose salary is greater than abels

--first we need to know what abel's salary actually is
select salary from EMPLOYEES where LAST_NAME='Abel';

select FIRST_NAME, LAST_NAME, salary from EMPLOYEES where salary>(select salary from EMPLOYEES where LAST_NAME='Abel');

--subquery mag ook aan de linkerkant but this is recommended
select FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where (select SALARY from EMPLOYEES where LAST_NAME='Abel')<SALARY;


--When using single row operators then the subquery should also return single row
--single row operators ( =, >, <, >=, <=, <>, !=)

select *
from EMPLOYEES where JOB_id=(select JOB_ID from EMPLOYEES where LAST_NAME='Abel');

--Dit errored, omdat die subquery a whole bunch of rows returned. Het moet maar 1 rows returnen
select *
from EMPLOYEES
where salary>(select salary from EMPLOYEES where DEPARTMENT_ID=30);


--Single row subquery mag 1 of 0 rows returnen
select *
from EMPLOYEES
where salary>(
    select salary from EMPLOYEES where DEPARTMENT_ID = 999
);


--You can use group functions in your subquery
select *
from EMPLOYEES
where salary=(select max(salary) from EMPLOYEES);


--van elke department in employees table check who the highest earner is
select emp.EMPLOYEE_ID, emp.FIRST_NAME, emp.SALARY
from EMPLOYEES emp
join(select DEPARTMENT_ID, max(SALARY) as highest_sal from EMPLOYEES group by DEPARTMENT_ID)max_sal 
on emp.DEPARTMENT_ID=MAX_SAL.DEPARTMENT_ID and emp.SALARY=max_sal.highest_sal;

select DEPARTMENT_ID, max(SALARY) from EMPLOYEES
group by DEPARTMENT_ID;

select *
from EMPLOYEES where DEPARTMENT_ID=30;

--The WHERE clause specifies the condition e.salary = (SELECT MAX(salary) FROM employees WHERE department_id = e.department_id). 
--This condition checks if the salary of the current employee (e.salary) is 
--equal to the maximum salary (MAX(salary)) within the same department (WHERE department_id = e.department_id).
SELECT e.*
from EMPLOYEES e where e.salary=(
    select max(SALARY) from EMPLOYEES where DEPARTMENT_ID=e.department_id
);


--You can also have subquery in having clause
--Welke departments hebben meer employees dan department met id number 90
select DEPARTMENT_ID, count(EMPLOYEE_ID)
from EMPLOYEES
group by DEPARTMENT_ID
having count(EMPLOYEE_ID)>(select count(1) from EMPLOYEES where DEPARTMENT_ID=90);


--if the subquery returns 0 rows then all select statements return no rows
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where SALARY>(select SALARY from EMPLOYEES where FIRST_NAME='dddd');



------------------------Multiple Row Subqueries------------------------------------

select SALARY
from EMPLOYEES where DEPARTMENT_ID=90;


select FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where (SALARY,DEPARTMENT_ID) in (select SALARY,DEPARTMENT_ID from EMPLOYEES where DEPARTMENT_ID=90);
--je kan die in statement ook gewoon replacen met in(17000, 24000)

--this ugly shit kan ook 
select  first_name,
        last_name
from copy_emp
where department_id in(
    (select department_id
    from departments
    where department_id= 40
    ),
    (select department_id
    from departments
    where department_id = 90)
);



--Je kan een subquery gebruiken in een having, maar niet in een group by clause
select DEPARTMENT_ID, count(DEPARTMENT_ID)
from EMPLOYEES
group by DEPARTMENT_ID
having count(DEPARTMENT_ID)=(
    select count(DEPARTMENT_ID) from EMPLOYEES  where DEPARTMENT_ID=50 group by DEPARTMENT_ID);


--If a subquery returns null the main query may still return rows
select * from EMPLOYEES where DEPARTMENT_ID IN
(select DEPARTMENT_ID from EMPLOYEES where FIRST_NAME='Kimberely');



--Any value greater than/equal 17000 or any value greater than/equal 24000
select FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where salary >= any(select SALARY from EMPLOYEES where DEPARTMENT_ID=90);


--Je value moet groter of gelijk zijn aan elke value dat komt uit die subquery 
select FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where salary>=all(select SALARY from EMPLOYEES where DEPARTMENT_ID=90);

--will retrieve any of the values bigger than department_id 10
select *
from EMPLOYEES where DEPARTMENT_ID > any(40, 30, 20, 10)
order by DEPARTMENT_ID;

--will retrieve any of the values smaller than 110
select *
from EMPLOYEES
where DEPARTMENT_ID < any(110, 100, 90)
order by DEPARTMENT_ID desc;

select *
from EMPLOYEES
order by DEPARTMENT_ID;


--this one is pretty logical, any where department_id bigger than 40
select *
from EMPLOYEES where DEPARTMENT_ID>all(40, 30, 20, 10)
order by DEPARTMENT_ID asc;

--where dept id is smaller than 90
select *
from EMPLOYEES
where DEPARTMENT_ID<all(110,100,90)
order by DEPARTMENT_ID desc;



----------------"in" and "not in" when there are null values---------------------




--The null in this case will be ignored
--So steven will not be retrieved in this query
select * from EMPLOYEES
where MANAGER_ID in(100, 101, null);


--Retrieves 0 records bc:
--not in is equivalent to <>all
--So als je subquery set contains one null value no records will be retrieved
select *
FROM EMPLOYEES
where MANAGER_ID not in(100, 101, null);

--Retrieves all of the managers without a problem despite dat er null values gaan zijn in die subquery. It'll just ignore those
select EMPLOYEE_ID, FIRST_NAME, SALARY
from EMPLOYEES
where EMPLOYEE_ID in (select MANAGER_ID from EMPLOYEES);


--This one doesnt retrieve any rows bc not in and null values dont work very well together
select EMPLOYEE_ID, FIRST_NAME, SALARY
from EMPLOYEES
where EMPLOYEE_ID not in(select MANAGER_ID from EMPLOYEES);



--what abt met any
--Die null value wordt ook hier ignored, bc we know that there is one employee without a department(Kimberely)
select *
from EMPLOYEES where DEPARTMENT_ID = any(10, 20, null);

--This doesn't even work. Je moet het instead negaten met not, zoals in het voorbeeld na deze
select *
from EMPLOYEES
where DEPARTMENT_ID != any(10, 20)
order by DEPARTMENT_ID;

--This does work like how you expect it to 
select *
from EMPLOYEES
where  not(DEPARTMENT_ID = any(10, 20))
order by department_id;


--This also doesn't retrieve any rows. Basically werkt net als in
select *
from EMPLOYEES
where not(DEPARTMENT_ID = any(10, 20, null))
order by DEPARTMENT_ID;


--doesn't retrieve any rows
select *
from EMPLOYEES
where DEPARTMENT_ID>all(10, 20, null);

--also doesn't retrieve any rows, bc of the way null works
--
select *
from EMPLOYEES
where DEPARTMENT_ID < all(110, 100, 90, null)
order by EMPLOYEE_ID desc;


--hier zeg je basically het mag niet groter zijn dan 20
select *
from EMPLOYEES
where not (DEPARTMENT_ID > all(10, 20))
order by EMPLOYEE_ID asc;

--Hier zeg je het mag niet kleiner zijn dan 80 of 90
select *
from EMPLOYEES
where not(DEPARTMENT_ID<all(90, 80))
order by DEPARTMENT_ID asc;


select *
from EMPLOYEES
where DEPARTMENT_ID>all(10, 20);


-------------------------EXISTS/NOT EXISTS------------------------

--All of the departments with their info dat allemaal voorkomen in employees table

--Not good practice(probably due to performance reasons)
select *
from DEPARTMENTS
where DEPARTMENT_ID in(select DEPARTMENT_ID from EMPLOYEES emp)
order by DEPARTMENT_ID;


--The best practice is to use exist
select *
from DEPARTMENTS dept
where exists(select department_id from EMPLOYEES emp where emp.DEPARTMENT_ID=dept.DEPARTMENT_ID);


--Verplicht om gebruik te maken van alias
select *
from DEPARTMENTS dep 
where exists(select department_id from EMPLOYEES emp where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID);

--Obviously can also use table prefix
select *
from departments 
where exists(select DEPARTMENT_ID from EMPLOYEES emp where emp.DEPARTMENT_ID=departments.DEPARTMENT_ID);

--This actually doesnt throw an error but who knows wtf het ophaalt. Definitely not the right results
select *
from departments 
where exists(select DEPARTMENT_ID from EMPLOYEES where DEPARTMENT_ID=DEPARTMENT_ID);

--Haalt alle departments op die geen employees onder ze hebben
select *
from DEPARTMENTS dept
where not exists(select department_id from EMPLOYEES emp where emp.DEPARTMENT_ID=dept.DEPARTMENT_ID);

--Retrieves no rows
select *
from departments dept
where exists(select department_id from EMPLOYEES emp where EMP.FIRST_NAME='null');

/* This query returns the department_id from the departments table if there is at least one row in the employees 
table with the matching department_id */

SELECT department_id
FROM departments d
WHERE EXISTS (SELECT *
              FROM employees e
              WHERE d.department_id = e.department_id)
ORDER BY department_id;




