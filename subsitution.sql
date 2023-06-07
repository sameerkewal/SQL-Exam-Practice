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
define EMPLOYEE_NUM=200;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
from EMPLOYEES
where EMPLOYEE_ID=&EMPLOYEE_NUM;

undefine EMPLOYEE_NUM;






