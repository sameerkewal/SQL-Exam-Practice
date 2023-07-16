-----------------------Updates----------------------

--Copy table emp:(apparently maakt dit gewoon een copy van je originele table? Pretty cool)
create table copy_emp
AS
select * from EMPLOYEES;

--You can update more than one column at a time
update COPY_EMP
set SALARY=24100, DEPARTMENT_ID=10
where EMPLOYEE_ID=100;

select *
from COPY_EMP
order by SALARY desc;


--Don't forget where conidition or else you'll be updating a lotta rows
update COPY_EMP set PHONE_NUMBER = '115';

select *
from COPY_EMP;

--Kinda obvious maar je kan een value updaten to null
update COPY_EMP
set DEPARTMENT_ID=NULL
where EMPLOYEE_ID=100;

--Tenzij er een not null constraint erop is ofc
update COPY_EMP
set LAST_NAME=NULL
where DEPARTMENT_ID=100;


--You can also use subqueries here
--Make the salary for employee 100 the same salary as what employee 200 has
select * from COPY_EMP where EMPLOYEE_ID in(100, 200);

update COPY_EMP
set salary = (select SALARY from EMPLOYEES where EMPLOYEE_ID=200)
where EMPLOYEE_ID=100;

--Make the salary and department_id for emplpoyee 105 like the salary and department_id for employee 108
select * from COPY_EMP where EMPLOYEE_ID in(105,108);

update copy_emp set SALARY=6000, DEPARTMENT_ID=80
where EMPLOYEE_ID=105;


--This works
update COPY_EMP
set salary =        (select salary from EMPLOYEES where EMPLOYEE_ID=108),
    DEPARTMENT_ID=  (select DEPARTMENT_ID from EMPLOYEES where EMPLOYEE_ID=108)           
where EMPLOYEE_ID=105;



--so this one and tbh it does seem syntax wise prettier(beide methods zijn valid)
update COPY_EMP
set (salary, DEPARTMENT_ID)=(select SALARY, DEPARTMENT_ID from EMPLOYEES where DEPARTMENT_ID=108)
where EMPLOYEE_ID=105;

--DIT KAN NIET DONT FORGET THE PARENTHESES
update COPY_EMP
set (salary, DEPARTMENT_ID) = (select SALARY,DEPARTMENT_ID from EMPLOYEES where EMPLOYEE_ID=108)
where EMPLOYEE_ID=105;



update COPY_EMP
set FIRST_NAME =    (select 'Steven' from dual),
    LAST_NAME  =    (select 'King' from dual)
where EMPLOYEE_ID=100;

select *
from COPY_EMP;


update COPY_EMP
set salary = (select max(SALARY) from EMPLOYEES)
where EMPLOYEE_ID=100;


--Je mag die row waarop je filtered in je where clause ook updaten in je update statement
update copy_emp set FIRST_NAME='Steve'
where FIRST_NAME='Steven';



--Je kan ook functions gebruiken in je update statements. Gaat over die rows
--which you're updating at that moment. Hier zet het voor die rows, if the commission_pct is null
--then it sets them to 0. Otherwise it returns then commission_pct
update EMP_COPY
set COMMISSION_PCT = nvl(COMMISSION_PCT, 0);

--Zet die salary op die manager_id(is gewoon een test, ignore the logica)
--If the manager_id is null it returns 1000, otherwise it just returns the manager_id
update EMP_COPY
set SALARY = nvl(MANAGER_ID, 1000);