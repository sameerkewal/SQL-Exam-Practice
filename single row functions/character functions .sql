--character FUNCTIONS
select first_name, upper(LAST_NAME) from EMPLOYEES;
select upper(FIRST_NAME) FROM EMPLOYEES;

select INITCAP(lower(FIRST_NAME || ' ' || LAST_NAME || ' ' || 'test')) from EMPLOYEES;



--You can use upper, lower, initcap in select, where and order by statements


--omdat hij die first name convert naar uppercase en je zoekt naar die row waar hij is converted naar uppercase
select EMPLOYEE_ID, FIRST_NAME, upper(FIRST_NAME), LOWER(FIRST_NAME), INITCAP(FIRST_NAME)
from EMPLOYEES
where UPPER(FIRST_NAME) = 'PATRICK';

select EMPLOYEE_ID, FIRST_NAME, UPPER(FIRST_NAME), lower(FIRST_NAME), INITCAP(FIRST_NAME)
from EMPLOYEES
where upper(FIRST_NAME) = UPPER('Patrick');


select EMPLOYEE_ID, FIRST_NAME, UPPER(FIRST_NAME), LOWer(LAST_NAME), INITCAP(FIRST_NAME)
from EMPLOYEES
where lower(LAST_NAME)='king';

select EMPLOYEE_ID, FIRST_NAME, UPPER(FIRST_NAME) as uppered, LOWER(LAST_NAME), INITCAP(FIRST_NAME)
from EMPLOYEES
where LOWER(LAST_NAME) = LOWER('KING')
order by uppered
fetch first 2 row with ties;


select upper('Patrick') from dual;


select INITCAP('t b s') from DUAL;


--concat 
--als je null concatenate dan wordt dat omgezet in een empty string
select length(concat('testing', null)) from dual;

--concat neemt maar 2 arguments so like uhm als je space zou willen using the concat argument zou je zoiets moeten doen???
--tbh just use the || way more flexible
select concat(concat(FIRST_NAME, ' '), LAST_NAME) from EMPLOYEES;

--als je 0 zet voor position wordt dat behandeld als 1
select SUBSTR('man', 0, 2) from dual;

select first_name, substr(FIRST_NAME, 0, 4) from EMPLOYEES order by substr(FIRST_NAME, 2, 1);

--look at the results
select FIRST_NAME, substr(first_name, 2, 3) from EMPLOYEES;


--returns null
select substr(null, 0, 3) as subbed from dual ORDER by subbed;

--als je geen end position specifieerd dan gaat het gewoon tot het einde van die string
select substr(FIRST_NAME, 1) from EMPLOYEES;


--als je POSITION negatief is dan begint hij met tellen vanaf het einde van die string
--dus "david" wordt "id"
select first_name,substr(FIRST_NAME, -2) from EMPLOYEES;

--hierbij wordt "david" dus "vi"
select FIRST_NAME, substr(FIRST_NAME, -3, 2) from EMPLOYEES;


--length: self explanatory??? exactly like other programming languages

--gelijk in een where and order by statement geplaatst

select FIRST_NAME from EMPLOYEES where (LENGTH(FIRST_NAME)>=3)
order by LENGTH(FIRST_NAME);


--instr function
--instring wordt gebruikt om in een string een substring te vinden
--heeft 2 optional parameters
-- de eerste specified the position at which to start searching for the substring
--and the 2nd one searches the Nth occurence of the substring(default values are 1 and 1 here)



SELECT FIRST_NAME, instr(FIRST_NAME, 'e') from EMPLOYEES WHERE FIRST_NAME='Nanette';


--start searching for the substring 'e' from the 2nd position
select FIRST_NAME, instr(FIRST_NAME, 'e', 2) from EMPLOYEES where FIRST_NAME ='Nanette';

--start searching for the substring 'e' but start searching from position numbero 5
SELECT FIRST_NAME, instr(FIRST_NAME, 'e', 5) from EMPLOYEES where FIRST_NAME ='Nanette';

select FIRST_NAME, instr(FIRST_NAME, 'e', 1, 2) from EMPLOYEES where FIRST_NAME ='Nanette';


select FIRST_NAME, instr(FIRST_NAME, 'et', 1, 1) from EMPLOYEES where FIRST_NAME ='Nanette';


--instr kan ook werken met negatieve positions voor de starting positions.
--maar niet voor occurences anders krijg je argument out of range error
--Maaaaaaar hier als je negatief zet voor je position gaat hij backwards beginnen te tellen. 
--also je mag geen 0 zetten voor position. Definitely check out the documentation
--BIJ SUBSTRING GAAT IE GEWOON WEER NAAR VOREN???
--https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/INSTR.html#GUID-47E3A7C4-ED72-458D-A1FA-25A9AD3BE113
select instr('nanette', 'n', -3, 1) from dual; --probably 

select instr('nanette', 'n', -3, 2) from dual;


select 'nanette', instr('nanette', 'e', -1, -1) from dual;


--de derde occurence van n als je vanuit achterin begint met tellen
--btw je mag ook geen 0 zetten voor occurence(kinda obvious ig but not rly??)
select 'nanette', instr('nannette', 'n', -1, 3) from dual;


select 'nannette', instr('nannette', 'n', 1, 1) from dual;



--now with bigger strings
--7 remember dat het die spaces(just like any other programming language ook meetelt)
select 'hello there', instr('hello there', 'there', 1, 1) from dual; 



--needlessly ingewikkelde statement bc why not?(looking at this 2 weeks later and this is the simplest statement ever)
select 'HELLO there', instr('HELLO there', upper('hello'), 1, 1) from dual;


--remember dat, al begint hij backwards met tellen in geval van een negatieve position, die return value nog steeds vanaf voorin zal zijn 
select 'nannette', instr('nannette', 'n', -1, 1) from dual;



--lpad and rpad
select FIRST_NAME, LAST_NAME, SALARY, lpad(SALARY, 10, 'test'), rpad(salary, 10, 'test') from EMPLOYEES;
select FIRST_NAME, LAST_NAME, SALARY, lpad(SALARY, 10, '*'), rpad(salary, 10, '#') from EMPLOYEES;

--hierbij wil je het salaris gedeeld door 1000 weergeven door middel van sterretjes
--dus die empty space pad je door middel van sterretjes/asteriks
select LAST_NAME, rpad(' ', SALARY/1000/1, '*') as salary
from EMPLOYEES where EMPLOYEE_ID = 100
order by LAST_NAME, salary;




--replace
select EMPLOYEE_ID, FIRST_NAME, replace(FIRST_NAME, 'a', '*'), replace(first_name, 'en', '*') from EMPLOYEES;


--doesnt do anything
select EMPLOYEE_ID, FIRST_NAME, replace(FIRST_NAME, 'a', null) from EMPLOYEES;

--doesnt do anything either
SELECT EMPLOYEE_ID, FIRST_NAME, Replace(FIRST_NAME, null, 'a') from EMPLOYEES;

--Replaces cat with null
select replace('the null is on the cat', 'cat', null)
from dual;

--trim
--cant trim in the middle

select '  sameer kewal  ', length('  sameer kewal  ') from dual;


--if u dont specify then it will just do both, same thing as the last one
select trim(' ' from '  sameer kewal  '), length( trim(' ' from '  sameer kewal  ')) from dual;

--leading only clears the leading(the ones in front) from the string
select trim(leading ' ' from '  sameer kewal  '), length(trim(leading ' ' from '  sameer kewal  ')) from dual;


--trailing only clears the trailing(the ones in the back) from the string
select trim(trailing ' ' from '  sameer kewal  '), length(trim(leading ' ' from '  sameer kewal  ')) from dual;


select trim(both ' ' from '  sameer kewal  '), length(trim(both ' ' from '  sameer kewal  ')) from dual;


select trim(leading 'k' from 'kkkkkill') from dual;

select trim(trailing 'k' from 'kkkkillllkkkk') from dual;

select trim('k' from 'kkillk') from dual;


select trim(' Sameer             Kewal '), length(trim(' Sameer             Kewal ')) from dual;


--case sensitive ofc ofc
select trim(leading 'S' from 'Sameer') from dual;

--niet specified dus het cleared both the trailing and leading spaces
select trim(' ' from '  sameer kewal  '), length(trim(' ' from '  sameer kewal  ')) from dual;













