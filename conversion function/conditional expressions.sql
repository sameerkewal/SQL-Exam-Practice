--2 syntaxes mogelijk. Dit is de eerste syntax:
--ELSE is optioneel
--Deze is more restricting, since je gebonden bent aan je value na je case statement
SELECT FIRST_NAME, JOB_ID, SALARY,
    case job_id when 'IT_PROG' then 1.10*SALARY
                when 'ST_CLERK' then 1.15*SALARY
                when 'SA_REP' then 1.20*SALARY
                else "SALARY"
                end "Revised Salary"
from EMPLOYEES
order by JOB_ID;

--Maar als je else niet include dan laat het dat geval van else gewoon als null which is pretty weird
SELECT FIRST_NAME, JOB_ID, SALARY,
    case job_id when 'IT_PROG' then 1.10*SALARY
                when 'ST_CLERK' then 1.15*SALARY
                when 'SA_REP' then 1.20*SALARY
                end revised_salary
from EMPLOYEES
order by JOB_ID;


--Tweede Syntax:
--Deze syntax better, omdat je dan any column kan zetten bij je when statement
select FIRST_NAME, JOB_ID, SALARY,
    case when JOB_ID='IT_PROG' then salary*1.10
         when JOB_ID='ST_CLERK' then salary*1.15
         when JOB_ID='SA_REP' then SALARY*1.20
         end "Revised Salary"
    from EMPLOYEES;



--Something like this is not logically correct
--Als die eerste statement al is voldaan, then it will show the result regardless of the other conditions
--omdat die statements in volgorde worden geavuleerd
select SALARY,
    case when SALARY > 3000 then 'salary>3000'
        when salary > 4000 then 'salary>4000'
        when salary > 5000 then 'salary>5000'
        end "Testing salaries" from EMPLOYEES;


--Als je zoiets zou willen doen, dan zou je het in the opposite way moeten doen of yk gewoon een between statement or sth
select salary,
        case when salary > 10000 then 'salary>10000'
             when salary > 4000 then 'salary > 4000'
             when salary > 5000 then 'salary > 3000'
             end "The Correct Way of Doing it"
             from EMPLOYEES;