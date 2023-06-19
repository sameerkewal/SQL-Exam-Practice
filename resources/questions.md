SELECT TO_CHAR('01110' + 1) FROM DUAL;
SELECT TO_CHAR('01110' + 1) FROM DUAL;

SELECT TO_CHAR('01110' + 2) FROM DUAL;



--47 Write a query to print the salary of an employee with commission. Use coalesce.

--final answer:
select FIRST_NAME, SALARY, COMMISSION_PCT, coalesce(nullif(COMMISSION_PCT, null), null)*0+salary as new_salary
from EMPLOYEES;



select *
from EMPLOYEES
where not salary between 9000 and 24000;

select *
from EMPLOYEES
where salary not between 9000 and 24000;

Is er hier sprake van implicit conversion?
select FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where salary like '___0';




select *
from EMPLOYEES
where DEPARTMENT_ID != any(10, 20)
order by DEPARTMENT_ID;

Why does this query not work