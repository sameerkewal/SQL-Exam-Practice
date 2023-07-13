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



---In de eerste 2 then statements heb je een number en dan plotseling een varchar in die derde. Dit mag niet
select salary,
        case when salary>=1000 and salary<=3000 then salary*2
             when salary>3001 and salary<=4000 then salary*3
             when salary > 4000 then 'High earner!!!'
             end as "Revised Salary"
             from EMPLOYEES
             order by SALARY;


--Elke kolumn moet dus in dezelfde format zijn for it to work
select salary,
        case when salary>=1000 and salary<=3000 then to_char(salary*2)
             when salary>3001 and salary<=4000 then to_char(salary*3)
             when salary > 4000 then 'High earner!!!'
             end as "Revised Salary"
             from EMPLOYEES
             order by SALARY;


--Dit is waarom case when condition beter is basically 
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID,
        case when length(FIRST_NAME)=4 then 'first name is 4 characters'
             when FIRST_NAME = 'Steven' then 'Steve spotted!!!'
             end as "test"
            from EMPLOYEES;



--Decode function
--Decode simpler and not as powerful as case statement
--die job_is die column op basis waarvan je je comparison doet
--die laatste salary is die else statement(called default value)
--first value is called search(IT_PROG) and the 2nd result is called result(the calculation)
--best practice is to write the decode statement like this bc its easier to read
select LAST_NAME, JOB_ID, SALARY,
decode(JOB_ID, 'IT_PROG', salary*1.10,
                'ST_CLERK', salary*1.15,
                'SA_REP', salary*1.20,
        salary)
        revised_salary
        from EMPLOYEES
        order by JOB_ID;



--net als bij die case statement, als je niets specified voor die else(default value in this case), gaat hij null returnen
select LAST_NAME, JOB_ID, SALARY,
decode(JOB_ID, 'IT_PROG', salary*1.10,
                'ST_CLERK', salary*1.15,
                'SA_REP', salary*1.20) as new_salary
                from EMPLOYEES;



select EMPLOYEE_ID, FIRST_NAME, SALARY,
case when salary<3000 then '0%'
    when salary between 3000 and 7000 then '10%'
    when salary>7000 then '20%'
    end "taxes"
    from EMPLOYEES;


--Mogelijk om bovengenoemde statement te schrijven using decode?
--NOPE NOT POSSIBLE.  
select EMPLOYEE_ID, FIRST_NAME, salary,
decode(salary, salary<3000, '0%')
from EMPLOYEES;


--decode so simple used for stuff like this.
select EMPLOYEE_ID, FIRST_NAME,
decode(FIRST_NAME, 'Steven', 'YOOOOOO')
as "stuff"
from EMPLOYEES;

--first syntax
select EMPLOYEE_ID, FIRST_NAME,
case JOB_ID when 'ST_CLERK' then 'epcic'
end as "stuff"
from EMPLOYEES;


select EMPLOYEE_ID, FIRST_NAME, SALARY,
case JOB_ID when 'AD_PRES' then 'test'
end as "new test"
from employees;


--Belangrijk verschil tussen decode and case statement is dat je bij DECODE WEL
--een andere datatype mag hebben bij je nieuwe column terwijl dat helemaal niet mag bij case statements
 select JOB_ID, SALARY,
decode(JOB_ID, 'AD_PRES', 'president',
                'ST_CLERK', 'clerk',
                'IT_PROG', 'brogrammer',
                'whack')
                as full_title
                from EMPLOYEES;


select JOB_ID, SALARY, 
case when JOB_ID='AD_PRES' then 'president'
     when JOB_ID='ST_CLERK' then 'clerk'
     when JOB_ID='IT_PROG' then 2
     end as "test"
     from EMPLOYEES;
