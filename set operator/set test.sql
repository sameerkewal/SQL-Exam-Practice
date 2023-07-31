SELECT FIRST_NAME || ' ' || LAST_NAME as emp_name 
from EMPLOYEES
union
select DEPARTMENT_NAME as test from DEPARTMENTS;


select DEPARTMENT_ID
from EMPLOYEES
MINUS
select DEPARTMENT_ID
from DEPARTMENTS;


select sysdate from dual
union all
select localtimestamp from dual;