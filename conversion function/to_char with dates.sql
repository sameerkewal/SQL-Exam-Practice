--use of suffix th
select to_char(HIRE_DATE, 'DDTH " of "  MONTH YYYY') from EMPLOYEES;

--use of ddsp which makes numbers like "24" appear like "twenty-four"
select to_char(HIRE_DATE, 'DDSP MONTH YYYY') FROM EMPLOYEES;


--If you use ddspth will make it fourth for example or "twenty-fourth"
select to_char(HIRE_DATE, 'DDSPTH MONTH YYYY') from EMPLOYEES;


--you can put anything inbetween I think even stuff like percentages as seen in the following example
select to_char(SYSDATE, 'dd%mm%yyy') from dual;


--it doesnt matter whether you put am or pm here it will simply default to your actual time
--also als je die hh12 weglaat en hh zet gaat hij defaulten naar hh12
select to_char(sysdate, 'dd-mm-yyyy hh:mi:ss am') from dual;

select to_char(sysdate, 'dd-mm-yyyy hh:mi:ss pm') from dual;
select to_char(sysdate, 'dd-mm-yyyy hh:mi:ss') from dual;






--24 hr format
--u can still put am or pm here and it still won't matter
select to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss am') from dual;


--zo als je fm gebruikt dan gaat hij die trailing 0 weglaten van je datum bv 07 januari wordt gewoon 7 januari
select HIRE_DATE as "actual hire date",
to_char(HIRE_DATE, 'DD Month YYYY') as "simple to char",
to_char(HIRE_DATE, 'fmDD MonTh YYYY') as "hire date using fm"
from EMPLOYEES;



--good illustration also of the difference between using DD and using fmDD
select to_date('2023-06-05', 'YYYY-MM-DD'), to_char(to_date('2023-06-05', 'YYYY-MM-DD'), 'fmDD') from dual;

-- bij je maand als je de eerste karakter capitalized dan komt ie als "January"
--if u dont capitalize anything komt ie als "january"
--als je dat heel ding capitalized dan gaat ie komen als "JANUARY"
select to_char(HIRE_DATE, 'FMDD Month YYYY') from EMPLOYEES;
select to_char(HIRE_DATE, 'FMDD month YYYY') from EMPLOYEES;
select to_char(HIRE_DATE, 'FMDD MONTH YYYY') from EMPLOYEES;

--same thing with DAY/Day/day(obviously cant rly test with years dus daar maakt het niets uit(hopelijk))
select to_char(HIRE_DATE, 'DAY Month YYYY') from EMPLOYEES;
select to_char(HIRE_DATE, 'day Month YYYY') from EMPLOYEES;
select to_char(HIRE_DATE, 'Day Month YYYY') from EMPLOYEES;





select to_char(SYSDATE, 'FMDD " of "MoNTH yyyy')from dual;

--sp staat voor spelling
--deze komt gewoon als "five"/"twenty one"
--btw ook hier maakt die capitalization van dd uit(van derest niet hoor. You can spell those however u like)
select to_char(HIRE_DATE, 'fmDdsp " of " MONTH YYYY')from EMPLOYEES;
select to_char(HIRE_DATE, 'fmDDsp " of " MONTH YYYY')from EMPLOYEES;
select to_char(HIRE_DATE, 'fmddsp " of " MONTH YYYY')from EMPLOYEES;

--terwijl deze gaat komen als "fifth"/"twenty-first"
select to_char(HIRE_DATE, 'fmDdspth " of " Month YYYY')from EMPLOYEES;


--17th, en ook hier maakt je spelling uit, ondanks je het alleen hebt over cijfers, 
--maar is omdat het gaat om dat th stukje
--klein verschil, hier heb je maar 2 opties. Of in caps of in klein letters no eerste letter alleen capitalized dingetjes
select to_char(HIRE_DATE, 'fmDDTH "of" Month yyyy') from EMPLOYEES;
select to_char(HIRE_DATE, 'fmddTH "of" Month yyyy') from EMPLOYEES;

--Hierbij dezelfde 3 opties als bij sp. The spelling van die sp of th maakt niet uit, alleen van die DD/dd/Dd
select to_char(hire_date, 'fmDdspth') from EMPLOYEES;



select to_char(HIRE_DATE, 'DAY Month YYYY') from EMPLOYEES;

--list all the employees employed in 2003
select * from EMPLOYEES
where to_char(HIRE_DATE, 'yyyy') = '2003';


--list all the employees employed in february
select *
from EMPLOYEES
where to_char(HIRE_DATE, 'mm') = '02';

--als je alleen 2 zet is dat fout. Als je 2 zet dan **moet** je gebruik maken van fmMonth zoals volgt
SELECt *
from EMPLOYEES
where to_char(HIRE_DATE, 'fmmm') = '2';

--this works!
select *
from EMPLOYEES
where to_char(HIRE_DATE, 'MM YYYY') = '02 2004';


select to_char(HIRE_DATE, 'MM YYYY') 
from EMPLOYEES
WHERE to_char(HIRE_DATE, 'MM') = '02'
order by HIRE_DATE;

--the spelling of fm doesnt matter
--Just to reiterate, alleen die spellings van DD/MM matter the rest does not
select hire_date, to_char(HIRE_DATE, 'fmMM') from EMPLOYEES;

select to_char(HIRE_DATE, 'ddSP') from EMPLOYEES;

select to_char(HIRE_DATE, 'ddTH') from EMPLOYEES;


--Die volgorde van th/sp maakt niet uit
SELECT TO_CHAR(TO_DATE('11-oct-2007'), 'fmDdthsp "of" Month, Year')FROM DUAL;
SELECT TO_CHAR(TO_DATE('11-oct-2007'), 'fmDdspth "of" Month, Year')FROM DUAL;


--als je Abbrevation wilt hebben van day of number kan je gebruik maken van dy/mon zoals volgt:
--zelfde regels van hoofdletters gelden voor die abbrevation versies
select to_char(HIRE_DATE, 'dd mon yyyy')from EMPLOYEES;

select to_char(HIRE_DATE, 'dy mon yyyy') from EMPLOYEES;


--Je kan krijgen welke dag van de week is. Again Zondag is dag nummer 1.
select FIRST_NAME, LAST_NAME, HIRE_DATE, to_char(HIRE_DATE, 'Day Month yyyy'),
to_char(HIRE_DATE, 'd') from EMPLOYEES;



--Je kan ook quarter gebruiken to find out which quarter of the year it is
-- Q1 is from January 1 to March 31, 
-- Q2 is from April 1 to June 30, 
-- Q3 is from July 1 to September 30 
-- Q4 is from October 1 to December 31.
select FIRST_NAME, LAST_NAME, HIRE_DATE, to_char(HIRE_DATE, 'q')
from EMPLOYEES;


select to_char(sysdate, 'q dd-mm-yyyy hh24:mi:ss')
from dual;

select to_char(sysdate, 'QSpth')
from dual;

--Alles kleinletter
select to_char(sysdate, 'yyyySP')
from dual;

--Het eerste letter alleen is capitalized 
select to_char(sysdate, 'Yyyysp')
from dual;


--Alles is capitalized
select to_char(sysdate, 'YYyysp')
from dual;


--Kan ook met spelling ofc
select to_char(sysdate, 'Yyspth')
from dual;



--This works perfectly for some reason, its still converting the char to a date which(implicit conversion)
select *
from employees
where hire_date>=to_char(to_date('17-jun-2003'), 'dd-mon-rr')
order by hire_date;


