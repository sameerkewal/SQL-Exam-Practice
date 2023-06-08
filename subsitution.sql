/* You can use temporary variables to replace the following things:
where conditions
order by clauses
column expressions
table NAMES
entire select statements */


--variable is erased after use
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
from EMPLOYEES
where EMPLOYEE_ID=&emp_id;


--use quotations when dealing with varchar
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
from EMPLOYEES
where FIRST_NAME = '&f_name'
order by 2;


--You can also just put the single quotes in the prompt window and it'll have the same result
select EMPLOYEE_ID, FIRST_NAME, SALARY
from EMPLOYEES
where FIRST_NAME = &first_name;



--you can substitute any valid value. Just try it out!
select EMPLOYEE_ID, LAST_NAME, JOB_ID, &column_name
from EMPLOYEES
where &condition
order by &column;

--define and undefine
--define is voor die hele session
define EMPLOYEE_NUM=200;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
from EMPLOYEES
where EMPLOYEE_ID=&EMPLOYEE_NUM;


undefine EMPLOYEE_NUM;


--accept and prompt:
--nadat je die prompt hebt gedaan blijft het ook voor die hele session, so use
--undefine to undefine the variable
--je kan ze ook apart runnen. Although first one first and then the 2nd one om het "correct" te doen,
--cause once je die eerste hebt gerunned dan is die variable gezet voor die hele session, waardoor je die 2e nadat apart kan runnen
--je kan die 2e ook apart runnen, maar als je die eerste voordien niet had gerunned, dan gaat hij gewoon zn eigen prompt window openen
accept dept_id prompt 'please enter department id!!';
accept table prompt 'please enter table!!';
select * from &table where DEPARTMENT_ID = &dept_id;


undefine dept_id;
undefine table;


--die & subsitution thing is case insensitive
accept LAST_NAME prompt 'plz enter last name';
select *
from EMPLOYEES
where LAST_NAME='&last_name'




--double ampersand &&
/* verschil tussen double ampersand and single ampersand is dat bij die single ampersand die prompt window thing elke keer gaat appearen,
terwijl bij double ampersand gaat hij je value onthouden en gaat die prompt window niet opnieuw appearen tenzij je undefine gebruikt */


undefine dept_id;
select * from EMPLOYEES where DEPARTMENT_ID=&&dept_id;







