--default date display = DD-MON-RR

select FIRST_NAMe, HIRE_DATE from EMPLOYEES;

--important for testing out how the rr format works
--als het tussen 0-49 is dan is het 20xx
--en tussen 50 en 99 is het dus 19xx
select to_char(to_date('1-JAN-51', 'DD-MON-RR'), 'YYYY') from dual;


select SYSDATE from dual;



--using arithmetic operators with dates
--date+number=date
select SYSDATE, SYSDATE+3 from dual;

--date-number=date(logisch!)
select SYSDATE, SYSDATE -3 from dual;


--date - date = number of days
select EMPLOYEE_ID, SYSDATE, HIRE_DATE, SYSDATE-HIRE_DATE, round(SYSDATE-HIRE_DATE)
from EMPLOYEES;


--als je date + number/24 doet = adding number of hours to a date
--hierbij add je 5 hours to je sysdate
select SYSDATE, SYSDATE+5/24 from dual;


select EMPLOYEE_ID, FIRST_NAME, SYSDATE-HIRE_DATE "number of days", round((SYSDATE-HIRE_DATE)/7) "number of weeks"
from EMPLOYEES
where FIRST_NAME='Adam';


select months_between(to_date('9-JUN-23', 'DD-MON-RR'), to_date('9-JUN-22', 'DD-MON-RR'))from dual;

--calculeert het aantal maanden tussen vandaag en de datum 

select sysdate, hire_date, months_between(SYSDATE, HIRE_DATE), round(months_between(sysdate, HIRE_DATE))from EMPLOYEES;

--dont do the following bc not all months have 31 days obviously
select sysdate, HIRE_DATE, months_between(SYSDATE, HIRE_DATE), (SYSDATE-HIRE_DATE)/30 from EMPLOYEES;


--als je kleinere date als eerste parameter zet en grotere als 2e dan gaat ie negatief geven. check it:
select months_between(to_date('23-JUN-00', 'DD-MON-RR'), to_date('23-JUN-01', 'DD-MON-RR')) from dual;


--add months 😎🈷️
--aangezien ik slecht ben met maanden tellen zal ik het verder uitleggen.
--als je hire date january is dan tel je zo. Februari is 1. Maart is 2 en April dat is 3
select EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) from EMPLOYEES
where LAST_NAME='King';


--oefenen met nesting functions!!!!
--obviously gaat je add months een date returnen dus dan kan je daarom to_char toepassen,
--although ik denk dat je to_char kan toepassen op basically anything
select EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, to_char(ADD_MONTHS(HIRE_DATE, 3), 'DD-MON-YYYY') from EMPLOYEES
where LAST_NAME='King';


--obviously mag je ook negatieve values definen voor add months en dan gaat ie gewoon aftrekken
select add_months(sysdate, -3) from dual;



select 'sameer', to_date('1-JUN-01', 'DD-MON-RR') as first_employee_date, 
add_months(to_date('1-JUN-01', 'DD-MON-RR'), 6) as eind_contract_date
from dual;

--next_day
--retrieves the next day vanuit the given date
--als vandaag vrijdag is en je zoekt friday dan gaat ie je de van volgend week geven(en niet 0 or something)
--het accepteert ook nummers:
-- 1 = zondag, 2 = maandag, 3 = dinsdag, 4 = woensdag, 5 = donderdag, 6 = vrijdag, 7 = zaterdag(according to nls date language)
select SYSDATE, next_day(SYSDATE, 7) from dual;

--any date kan eerste argument zijn en dan vanuit daar gaat ie de volgende gegeven dag(2de argument zoeken)
--check calender. De volgende vrijdag vanuit 17 juni is op 23 juni
select SYSDATE, next_day(to_date('17-JUN-23'), 'friday') from dual;

--je mag ook gewoon die abbrevation van die dag geven bv fri/sat/sun etc etc
select sysdate, next_day(sysdate, 'thu') from dual;


--ik wil dus vanuit vandaag(whichever date that might be) zondag retrieven
select sysdate, next_day(sysdate ,1) from dual;

/* 
last_day
retrieves the last day of the given month 
kan van alles zijn bv sysdate, gewoon een to_date thing zoals hieronder zolang het een valid date is ofc*/
select last_day(to_date('23-JUL-23', 'DD-MON-RR'))from dual;



--display employee number, first name, hiredate, number of months employed, six month review, first friday after hire date
--for all employees who have been employed for longer than 150 months
select EMPLOYEE_ID, FIRST_NAME,HIRE_DATE, round(months_between(sysdate,HIRE_DATE),1), add_months(HIRE_DATE, 6),
next_day(HIRE_DATE, 6) from EMPLOYEES
where months_between(SYSDATE, HIRE_DATE)>150;



--met round als je het met MONTH gebruikt,
--dates 1-15 resulteren in the first day of the nearest year or month
--dates 16-31 result in the first day of the next month

--in gevallen van YEAR werkt hij op de volgende manier:
--maanden 1-6 resulteren in january 1st of the current YEAR
--maanden 7-12 resulteren in january 1st of the next year


--MET DAY GAAT IE ROUNDEN NAAR HET EIND VAN THE NEAREST WEEK WHICH IS SUNDAY
--vanaf de donderdag gaat ie rounden naar de volgende zondag, voordien round het naar de zondag voorheen
select round(to_date('25-JUN-23', 'DD-MONTH-RR'), 'DAY')from dual;


--bij trunc op basis van month reset hij je terug naar het begin van de maand
select FIRST_NAME, HIRE_DATE, round(HIRE_DATE, 'MONTH'), trunc(HIRE_DATE, 'MONTH')
from EMPLOYEES
order by HIRE_DATE;


--bij trunc op basis van year reset hij je terug naar het begin van het jaar
select FIRST_NAME, HIRE_DATE, round(HIRE_DATE, 'YEAR'), trunc(HIRE_DATE, 'YEAR')
from EMPLOYEES
order by HIRE_DATE;


--bij trunc op basis van dag reset hij je terug naar het begin van de week!
--and again bij day round ie naar het eind van de week vanaf donderdag
select FIRST_NAME, HIRE_DATE, round(HIRE_DATE, 'DAY'), trunc(HIRE_DATE, 'DAY')
from EMPLOYEES
order by HIRE_DATE; 


--what abt if u dont specify any value?
--then it does absolutely nothing
select FIRST_NAME, to_char(HIRE_DATE, 'DD-MON-YYYY: HH24:MI:SS'), to_char(round(HIRE_DATE), 'DD-MON-YYYY:HH24:MI:SS'), 
to_char(trunc(HIRE_DATE), 'DD-MON-YYYY:HH24:MI')
from EMPLOYEES;

--als je dit doet rond hij af op like het eind van de dag
--so if u dont specify a value for the round parameter(the 2nd parameter)dan rond hij de dag gewoon af
select to_char(round(to_date('24-MARCH-2002 12:30:00', 'DD-MON-YYYY HH24:MI:SS'))) from dual;

--the cutoff value is het midden van de dag dus 11:59 cut off naar hetzelfde dag en vanaf 12:00 gaat naar de volgende dag
select to_char(round(to_date('24 MARCH 2002 11:59:00', 'DD-MON-YYYY HH24:MI:SS'))) from dual;


--trunc reset het gewoon naar 00:00:00 van dezelfde dag
select to_char(trunc(to_date('24-MARCH-2002 11:59:00', 'DD-MON-YYYY HH24:MI:SS'))) from dual;

--ik include dit gewoon om te checken om nested functions te wijzen
--check waar de vorige function eindigt door te kijken naar die opening bracket. Just hover the 
--opening bracket after you specified the function
select to_char(round(to_date('24-JUN-2002 20:08:00', 'DD-MON-YYYY HH24:MI:SS')), 'DD-MM-YYYY HH24:MI:SS') from dual;



--nesting functions
select FIRST_NAME, upper(FIRST_NAME), substr(upper(FIRST_NAME), 1, 3) from EMPLOYEES;

select FIRST_NAME, upper(FIRST_NAME), substr(upper(FIRST_NAME), 1, 3), 
lpad(substr(upper(FIRST_NAME), 1, 3), 10, '*') from EMPLOYEES;




--first_name werkt als volgt:
--Hij substringed vanaf het eerste letter tot en met een space -1. De reden voor -1 is zodat die space niet included is
--Middle name kinda complicated maar werkt door alvast vanaf die space +1 te nemen. Daar begint natuurlijk die tweede naam.
--Nu heb je de lengte nodig van die middle name en dat bereken je door de index te nemen vanuit na die 2e space -1. Daar eindigt die 2nd
--name en nadat trek je die index af van waar de eerste space occured -1 ???
--voor last name doe je gewoon basically vanaf waar je laatste space begint t/m het einde


select 'Sameer Deepak Kewal' as full_name,
substr('Sameer Deepak Kewal', 1, instr('Sameer Deepak Kewal',  ' ', 1, 1)-1 as first_name,
substr('Sameer Deepak Kewal', instr('Sameer Deepak Kewal', ' ', 1, 1)+1,
instr('Sameer Deepak Kewal', ' ', 1, 2) - instr('Sameer Deepak Kewal', ' ', 1, 1)-1) middle_name,
substr('Sameer Deepak Kewal', instr('Sameer Deepak Kewal', ' ', 1, 2)) as last_name
from dual;


select instr('Sameer Deepak Kewal', ' ', 1, 1) from dual;

select substr('Sameer Deepak Kewal', 8, 6) from DUAL;

select instr('Sameer Deepak Kewal',  ' ', 1, 1) from dual;

select instr('Sameer Deepak Kewal', ' ', 1, 2) from dual;

