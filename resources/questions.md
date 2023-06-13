SELECT TO_CHAR('01110' + 1) FROM DUAL;
SELECT TO_CHAR('01110' + 1) FROM DUAL;

SELECT TO_CHAR('01110' + 2) FROM DUAL;



--47 Write a query to print the salary of an employee with commission. Use coalesce.

--final answer:
select FIRST_NAME, SALARY, COMMISSION_PCT, coalesce(nullif(COMMISSION_PCT, null), null)*0+salary as new_salary
from EMPLOYEES;