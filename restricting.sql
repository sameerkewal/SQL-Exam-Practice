--where statement with date column:
--Formatting needs to be correct
select * from employees where HIRE_DATE = '17-JUN-03';

--This will throw an error bc unexistant date
select * from EMPLOYEES where HIRE_DATE='50-JUN-03';

select * from EMPLOYEES WHERE HIRE_DATE >= '17-JUN-03' order by HIRE_DATE desc;


--Oracle compared de ascii values van de karakters.
--worth looking into blank padded and non padded
--Bij blank padded is 'a ' = 'a', maar bij non padded is het 'a ' > 'a', omdat
--die a met die extra space meer ascii values heeft or sth??
--verder zet oracle ook nog een extra space bij die eerste om het equal te maken but doesnt do that with the 2nd one
--Blank padded wordt gebruikt voor datatype CHAR, NCHAR, text literals, or values returned by the USER function.
--Non padded wordt gebruikt voor he datatype VARCHAR2 or NVARCHAR2.
select * from EMPLOYEES WHERE FIRST_NAME > 'Alberto' order by FIRST_NAME;



--between and is inclusive
select * from EMPLOYEES where SALARY BETWEEN 10000 and 17000 order by SALARY;


--where first name first letter falls between A and C
--not inclusive for some reason of C???
--OOH THE REASON FOR THAT IS THAT THE NAMES STARTING WITH C FOR EXAMPLE CHARLES IS GREATER THAN C 
--BC OF THE WHOLE ASCII VALUES THING
select FIRST_NAME from EMPLOYEES where FIRST_NAME BETWEEN 'A' and 'C';


--if salary is 10000 or 25000 or 170000
select * from EMPLOYEES where SALARY in(10000, 25000, 17000);


--like operator
select * from EMPLOYEES where FIRST_NAME like 'N%';


select * from employees where FIRST_NAME like '%s';

--in the middle 
select * from EMPLOYEES where FIRST_NAME like '%am%';


--first character anything, 2nd character o and after that we dont care
select * from employees where FIRST_NAME like '_o%';


select * from EMPLOYEES where FIRST_NAME like '__s%';


select * from JOBS;

--u can use any escape character as long as je het include in die escape thing
--die escape character is voor als je wilt dat je result werkelijk die _ moet containen
select * from JOBS where JOB_ID like 'SA/_%' ESCAPE '/';


select FIRST_NAME, COMMISSION_PCT from EMPLOYEES WHERE COMMISSION_PCT is null;


--not operator:
--not null
select * from employees where COMMISSION_PCT is not null;

--hierbij haalt het alle rows op waar het niet begint met s. 
select * from employees WHERE FIRST_NAME not like 'S%';


--alles waar die first name niet een van deze is 
select * from EMPLOYEES where FIRST_NAME not in ('Steven', 'Nancy');

--waar salary niet tussen 10k en 20k is
select * from EMPLOYEES where salary not between 10000 and 20000;

--the following two statements are the same 
select * from employees where EMPLOYEE_ID <> 100;

select * from EMPLOYEES where EMPLOYEE_ID != 100;



--simple and statement:
--salary bigger than 2000 and department id is either 60 or 90 and the commission pct is null
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, SALARY, DEPARTMENT_ID, COMMISSION_PCT
from EMPLOYEES
WHERE SALARY > 2000
and DEPARTMENT_ID in (60, 90)
and COMMISSION_PCT is null
order by EMPLOYEE_ID;

select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, SALARY, DEPARTMENT_ID, COMMISSION_PCT
from EMPLOYEES
WHERE SALARY > 2000
and DEPARTMENT_ID = 60 or department_id = 90
and COMMISSION_PCT is null
order by EMPLOYEE_ID;



select last_name, JOB_ID, SALARY
from EMPLOYEES
where JOB_ID = 'SA_REP'
or JOB_ID = 'AD_PRES' AND SALARY > 15000;
--job_id='AD_PRES' and salary > 15000 is one statement
--2nd condition: job_id = 'SA_REP' 
--so basically die statement is te lezen als haal alle data op waar die job_id SA_REP is of
--job_id='AD_PRES' and salary groter dan 15000

--same query as last one. 
--of je job_id is SA_REP of je job_id is AD_PRES and je salary is groter dan 15000
--analyze the data
--rules of precedence doornemen
select LAST_NAME, JOB_ID, SALARY from EMPLOYEES
where JOB_ID ='SA_REP'
or (JOB_ID = 'AD_PRES' and salary>15000);


--or is last priority  
-- you can use parentheses to override precedence 
--best practice is to use parentheses
select LAST_NAME, JOB_ID, SALARY
from EMPLOYEES
where (JOB_ID='SA_REP' or JOB_ID='AD_PRES')
and SALARY > 15000;

select * from EMPLOYEES where JOB_ID ='SA_REP';



--ORDER BY:
--by default its ordered by ascending
--by default null comes last in ascending order
select * from EMPLOYEES order by HIRE_DATE desc;


select * from EMPLOYEES where DEPARTMENT_ID= 90 ORDER by EMPLOYEE_ID;



--if u order by descending then the null values come first
select * from EMPLOYEES order by COMMISSION_PCT desc;

--u can use nulls first to make null values appear first(then after that its predictably ascending order)
select * from EMPLOYEES order by COMMISSION_PCT NULLS first;


--you can use column aliases to sort your columns:
select FIRST_NAME "n" from EMPLOYEES order by "n";


--you can order by expression
select EMPLOYEE_ID, SALARY, salary+100
from EMPLOYEES
order by salary+100;

--you can sort by columns that aren't included in the select statement but this isn't really logical nor recommended
select EMPLOYEE_ID, SALARY from EMPLOYEES order by DEPARTMENT_ID;

--you can sort by more than one column
--first orders by department id and then by first name.
--Looking at the results kan je zien dat bij dezelfde department_id dan die first_name ook gesorteerd is
select DEPARTMENT_ID, FIRST_NAME, SALARY from EMPLOYEES
order by DEPARTMENT_ID, FIRST_NAME;



--just look at the results
SELECT DEPARTMENT_ID, FIRST_NAME, SALARY
from EMPLOYEES
order by DEPARTMENT_ID asc, FIRST_NAME desc;

--you can order by colummn number in select statement
SELECT DEPARTMENT_ID ,FIRST_NAME, SALARY from EMPLOYEES order by 1,3;


--fetch and offset
select EMPLOYEE_ID, FIRST_NAME
from EMPLOYEES
order by EMPLOYEE_ID
fetch first 5 rows only;


select EMPLOYEE_ID, FIRST_NAME
from EMPLOYEES
order by EMPLOYEE_ID
fetch first 50 PERCENT rows only;


--offset: I mean like this is obvious you have worked with offset in a different context b4
--rows and row are synonymous and so are first and next in the following contexts, same thing!
select EMPLOYEE_ID, FIRST_NAME
from EMPLOYEES
order by EMPLOYEE_ID
offset 5 rows;


select EMPLOYEE_ID, FIRST_NAME 
from EMPLOYEES
order by EMPLOYEE_ID
offset 5 rows fetch next 5 rows only;


select EMPLOYEE_ID, FIRST_NAME
from EMPLOYEES
order by EMPLOYEE_ID
offset 5 rows fetch first 5 rows only;



select EMPLOYEE_ID, FIRST_NAME, SALARY
from EMPLOYEES
order by EMPLOYEE_ID
offset 4 rows fetch first 50 percent rows only;


--when you do offset and then do fetch next 50 percent rows
--it means the total percentage of the total table not the percentage of the table after the offset
select EMPLOYEE_ID, first_name, SALARY
from EMPLOYEES
order by EMPLOYEE_ID
offset 4 rows fetch next 50 percent rows only;



--als je with ties gebruikt moet je die only weglaten van je fetch statement 
--with ties just look at the following statement. Als rows dezelfde value hebben, dan haalt het beide rows op al heb je
--alleen first 1 row gespecifieerd.
select EMPLOYEE_ID, FIRST_NAME, SALARY
from EMPLOYEES
order by SALARY desc
fetch first 1 rows  with ties;



--hierbij heb je 3 rows gespecifieerd, maar het haalt 4 rows up, omdat er nog een 4de salary is dat hetzelfde is als die derde salary
select EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME as full_name, SALARY
from EMPLOYEES
order by salary DESC
fetch first 3 rows with ties;


select * from EMPLOYEES order by salary desc;



