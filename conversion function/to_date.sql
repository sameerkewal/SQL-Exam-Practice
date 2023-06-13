--to_number, to_date


--logisch maar dan moet je valid formats gebruiken for it to work

--NIET VERPLICHT OM EEN FORMAT TE SPECIFEREN BUT IT IS RECOMMENDED TO SPECIFY A VALUE FOR THE FORMAT
--als je niets specifeert gebruikt het gewoon je nls_date_format parameter in table
select to_date('17 JUN 2003') from dual;
select to_char(HIRE_DATE) from EMPLOYEES;

--dit is je standaard date format. To change it use alter session set nls_date_format="DD-MON-YYYY" for example
--any format works, maar het moet wel worden gezet tussen double quotes
select value from V$NLS_PARAMETERS
where PARAMETER = 'NLS_DATE_FORMAT';


select to_date('10-11-2015', 'dd-mm-yyyy')
from dual;


select to_date('10.11.2015', 'dd.mm.yyyy')
from dual;


select to_date('10.November.2015', 'dd.month.yyyy')
from dual;

--Het probeert(and succeeds) om je format waar te maken(???)/voldoen aan je formatting
select to_date('10 November 2015', 'dd mm yyyy') from dual;
select to_char(to_date('Sunday 01 November 2015', 'Day dd mm yyyy'), 'Day Month yyyy')from dual;





select * from EMPLOYEES
where HIRE_DATE>=to_date('5 JAN 2005', 'DD Month YYYY')
ORDER BY HIRE_DATE;


--Oracle haalt spaces automatisch weg
select * from EMPLOYEES where HIRE_DATE >= to_date('27-01-     2004', 'dd-mm-yyyy')
order by HIRE_DATE;


--Als je wilt dat Oracle je exact string moet matchen, dan moet je gebruik maken van fx
select * from EMPLOYEES where HIRE_DATE>to_date('10-11- 2003', 'fxdd-mm- yyyy');

--The following also works
select * from EMPLOYEES where HIRE_DATE>to_date('10-11- 2003', 'dd-fxmm- yyyy');

--and so does the following
select * from EMPLOYEES where HIRE_DATE>to_date('5 january 2005', 'dd month fxyyyy');

--die fx begint te werken vanaf je het dropped 
select * from EMPLOYEES where HIRE_DATE>to_date('5 January 05', 'dd month fxrr');


--bc look at the following example. Hier beging ie te werken bij die dd. ik zou 07 juni moeten gebruiken
select * from EMPLOYEES where HIRE_DATE=to_date('7 June 2002', 'fxDD Month yyyy');


--hier is die fx gezet bij month and it works regardless. die foutieve DD wordt niet geflagged
--btw wordt mentioning dat fx niet oplet op het dat Day/day/DAY/Month/MONTH/month ding
select * from EMPLOYEES where HIRE_DATE=to_date('7 June 2002', 'DD fxMonth yyyy');

select * from EMPLOYEES where HIRE_DATE=to_date('7 June 2002', 'DD fxmonth yyyy');

--deze begint te erroren voor die maand niet voor die day eventho dat fout is aangegeven
select * from EMPLOYEES where HIRE_DATE=to_date('7 6 2002', 'DD fxmm yyyy');

--yeah want deze werkt eventho beide die dag en maand verkeerd zijn aangeven. Meaning dat die fx begint te werken vanaf waar je hem zet
select * from EMPLOYEES where HIRE_DATE=to_date('7 6 2002', 'DD mm fxyyyy');



select to_char(HIRE_DATE, 'Day dd Month yyyy')
from EMPLOYEES WHERE
to_char(HIRE_DATE, 'dd-mm-yyyy')='13-01-2001';

select to_char(HIRE_DATE, 'dd month yyyy') from EMPLOYEES 
order by HIRE_DATE;


select to_char(HIRE_DATE, 'dd Month yyy')from EMPLOYEES;


select to_date('13 January 2005', 'fxDD Month yyyy') from dual;



--difference between yy and rr
--bij rr als het tussen 50 en 99 is gaat het 19xx jaar returnen.
--Tussen 0 en 49 returned het een 20xx year


select to_date('01-01-1985', 'dd-mm-rr') from dual;

--om te weten hoe Oracle die rr convert naar een volledig jaartal
select to_char(to_date('01-01-75', 'dd-mm-rr'), 'yyyy')from dual;

select to_char(to_date('01-01-75', 'dd-mm-rr'), 'yyyy')from dual;


select to_date('1-1-85', 'dd-mm-yy') from dual;


--Bij yyyy convert het het in any case naar 20xx
select to_char(to_date('1-1-85', 'dd-mm-yy'), 'yyyy') from dual;
select to_char(to_date('1-1-41', 'dd-mm-yy'), 'yyyy') from dual;
select to_char(to_date('1-1-00', 'dd-mm-yy'), 'yyyy') from dual;


select *
from EMPLOYEES
where HIRE_DATE>=to_date('13 Jan 2001', 'DD Month yyyy')
order by hire; 


select *
from EMPLOYEES
where HIRE_DATE>=to_date('13 January 2001', 'DD MM yyyy')
order by HIRE_DATE;

select * from EMPLOYEES
order by HIRE_DATE;




