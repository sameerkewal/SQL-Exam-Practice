--number functions
select round(9.9) from dual;


select round(150.49) from dual;

select round(10.48) from dual;

select round(10.48, 1) from dual;

select round(10.499, 1) from dual;

--op 2 decimalen afronden. Third number is een 9 dus hij wordt .50
select round(10.499, 2)from dual;


--blijft hetzelfde(10.49) bc the third number is een 3. Lagere school stof
select round(10.493, 2)from dual;


select round(55.993, 1) from dual;
select round(55.879, 1) from dual;


--if the 2nd parameter is negative dan round hij the numbers left of the decimal
--omdat hij hierhij -1 is, dan kijkt het naar het eerst getal voor de komma, which in this case is 5
select round(55.993, -1) from dual;


--WHAT!?
--Het kijkt naar die 5, zo dan wordt het 100
--dus je moet kijken naar die 5. and then you add one more to it
select round(55.493, -2) from DUAL;


select round(555.493, -3) from dual;


select round(570.493, -3) From dual;


select round(470.493, -3) from dual;

--die 4 is minder dan 5 dus dan wordt het 1000(naar binnen afronden)
select round(1470.93, -3) from dual;



--man just do them
select trunc(10.6565) from dual;

select trunc(10.6565, 2) from dual;

select trunc(10.656565, 3) from dual;


select trunc(9998.6565, -2) from dual;


select trunc(998.6565, -2) from dual;


select trunc(9998.6565, -2) from dual;

select trunc(998.6565, -3) from dual;


--mod: returns the remainder of the division
select mod(15, 2) from dual;

select mod(15, 3) from dual;


select mod(100, 2) from dual;

select mod(101, 2) from dual;



--The first argument is called the dividend and the 2nd argument is called the divisor
select mod(10,4) from dual;


--the sign of the remainder is decided by the dividend. Je dividend is hier positief
select mod(11, -4) from dual;

--dividend is hier negatief so result is negatief
select mod(-11, 4) from dual;

--dividend is hier also negatief
select mod(-11, -4) from dual;




--kinda net als modulus, maar deze zoekt naar de dichtsbijzijnde hele getal dat deelbaar is door die 4
--like in dit geval is dat 12 dus dan doe je 11-12=-1 
select remainder(11, 4) from dual;

--hier is dat 20 dus dan je 21-20=1
select remainder(21, 4) from dual;

--Hier heb je 2 dichtsbijzijnde hele getallen precies deelbaar, 8 en 12.
--in dit geval neemt het die kleinste which is 8
-- 10 - 8 = 2
select remainder(10, 4)from dual;


--dichtsbijzijnde is 100 so dan wordt het 101-100 = -
select remainder(101, 4)from dual;


--Altijd dat getal in je function aftrekken met dichtsbijzijnde yk
select remainder(26, 4)from dual;



