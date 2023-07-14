select *
from EMPLOYEES
where EMPLOYEE_ID=176;


select *
from JOB_HISTORY
where EMPLOYEE_ID=176;

-----------------Union---------------------
select EMPLOYEE_ID, JOB_ID
from EMPLOYEES
where EMPLOYEE_ID=176
UNION
select employee_id, JOB_ID
from JOB_HISTORY
where EMPLOYEE_ID=176;



select employee_id, JOB_ID
from EMPLOYEES;

select EMPLOYEE_ID, JOB_ID
from JOB_HISTORY;

select EMPLOYEE_ID, JOB_ID
from EMPLOYEES
UNION
select employee_id, JOB_ID
from JOB_HISTORY;


--Job history heeft 10 rows and employees table has 108, vandaar 118 rows(duplicates aren't getting deleted)
--Also let op dat het resultaat niet geordend is
select EMPLOYEE_ID, JOB_ID
from EMPLOYEES
union all
select employee_id, JOB_ID
from JOB_HISTORY;


--The column alias van die eerste query komt, omdat die als eerste wordt geavuleerd ig
select EMPLOYEE_ID emp_id, JOB_ID job
from EMPLOYEES
union
select EMPLOYEE_ID empno, JOB_ID jobid
from JOB_HISTORY;



------------------------Intersect Operator-------------------------

--Only retrieves the common rows between the 2 queries
select EMPLOYEE_ID, JOB_ID
from EMPLOYEES
intersect
select EMPLOYEE_ID, JOB_ID
from JOB_HISTORY;


--Deze twee helpen om de volgende query te begrijpen.
--Die employee_id and job_id zijn wel hetzelfde, maar niet die department_id
select *
from EMPLOYEES where EMPLOYEE_ID=200;

select *
from JOB_HISTORY where EMPLOYEE_ID=200;

--Here the employee_id 200 won't appear bc we added another column(department_id), dus dan gaat het 3 kolummen vergelijken
--En waarschijnlijk is die department_id niet in alle 2 queries the same. 
select EMPLOYEE_ID emp_id, JOB_ID job, DEPARTMENT_ID
from EMPLOYEES
intersect 
select EMPLOYEE_ID emno, JOB_ID jobs, DEPARTMENT_ID
from JOB_HISTORY;


--The minus operator for example can be used to show employees who have not changed their job

select EMPLOYEE_ID from EMPLOYEES
MINUS
select EMPLOYEE_ID from JOB_HISTORY;


select EMPLOYEE_ID, JOB_ID, EMAIL
from EMPLOYEES
UNION
select EMPLOYEE_ID, JOB_ID, to_char(null) email
from JOB_HISTORY;

--Dit mag ook 
select EMPLOYEE_ID, JOB_ID, EMAIL
from EMPLOYEES
UNION
select EMPLOYEE_ID, JOB_ID, null as EMAIL
from JOB_HISTORY;

--Dit mag niet, it needs to be the same datatype
select EMPLOYEE_ID, JOB_ID, EMAIL
from EMPLOYEES
union
select EMPLOYEE_ID, JOB_ID, 0 as EMAIL
from EMPLOYEES;

--dit mag obviously wel
select EMPLOYEE_ID, JOB_ID, SALARY
from EMPLOYEES
union
select EMPLOYEE_ID, JOB_ID, 0
from JOB_HISTORY;


--Als je order by doet kan het niet in die eerste query, has to be in the 2nd query
select EMPLOYEE_ID emp_id, JOB_ID, SALARY
from EMPLOYEES order by salary
union
select EMPLOYEE_ID empno, JOB_ID, 0 SALARY
from JOB_HISTORY;


--Verder kan je die aliassen die je in je 2e query hebt gebruikt ook niet gebruiken om te ordenen. 
--Needs to be aliasses from the first query 
select EMPLOYEE_ID emp_id, JOB_ID, SALARY
from EMPLOYEES
union
select EMPLOYEE_ID empno, JOB_ID, 0 SALARY
from JOB_HISTORY
order by emp_id;

--Also je mag obv ook wel kolumn nummer gebruiken
select EMPLOYEE_ID emp_id, JOB_ID, SALARY
from EMPLOYEES
union
select employee_id empno, JOB_ID, 0 salary
from JOB_HISTORY
order by 3;


--Als je eenmaal een alias(ofc voor je eerste query hebt gebruikt), mag je in bij je sort by niet gewoon first_name schrijven
--Verplicht om je alias dan te gebruiken
--So this doesn't work
select FIRST_NAME as Voornaam, LAST_NAME as Achternaam from EMPLOYEES
UNION
select FIRST_NAME, LAST_NAME from EMPLOYEES
order by FIRST_NAME;

--But this one very much works
select FIRST_NAME as Voornaam, LAST_NAME as Achternaam from EMPLOYEES
UNION
select FIRST_NAME, LAST_NAME from EMPLOYEES
order by Voornaam;


--Al heb je dezelfde alias voor je tweede en eerste query, het gaat gewoon van die eerste query pakken gelukkig
select FIRST_NAME as Voornaam, LAST_NAME as Achternaam from EMPLOYEES
UNION
select FIRST_NAME as Voornaam, LAST_NAME as from EMPLOYEES
order by Voornaam;


--Will only work if subquery retrieves one row
select FIRST_NAME, (select DEPARTMENT_NAME from DEPARTMENTS dept where DEPT.DEPARTMENT_ID=100
                    UNION
                    select department_name from departments where department_id=90) 
from EMPLOYEES e;


