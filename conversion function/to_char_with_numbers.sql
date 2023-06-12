--to char using numbers
--refer to "../resources/to_char_with_numbers.sql"


select to_char(1598) from dual;
--so die 9999 just representers the number en die formattings add je bij die 9999
select to_char(1598, '9999') from dual;


select to_char(1598, '9,999') from dual; 

select to_char(1598, '$9,999')from dual;

--another way to get the 1000 seperator is by using G(looks pretty ugly)
select to_char(1598, '$9G999') from dual;


select to_char(1598.87)from dual;


--als je het zo doet(zoals hier onderin), gaat ie automatisch afronden voor je, omdat je het hebt gespecified op 4 numbers
--langer dan 4 numbers specified gaat het also afronden voor je
select to_char(1598.51, '99999999')from dual;


select to_char(1598.98, '9999.99') from dual;

--same logic as way above. Comma seperator:
select to_char(1598.98, '9,999.99') from dual;


select to_char(1598.98, '$9,999.99')from dual;

--ALS JE DECIMALEN GEBRUIKT KAN JE GEEN G GEBRUIKEN TENZIJ JE DIE DECIMALEN FORMATTING REPLACED MET EEN D
select to_char(1598.99, '$9G999.99') from dual;


--SO ALS JE G WILT GEBRUIKEN DAN MOET JE D GEBRUIKEN IN DE PLAATS VAN JE DECIMALEN BIJ HET FORMATTEREN
select to_char(1598.98, '9G999D99') from dual;


--als je minder nummers heb in je formatting bij decimalen dan gaat ie afronden op hoeveel cijfers je wel hebt na je komma
--hier gaat ie afronden op 1 cijfer na de komma
select to_char(1598.49, '9999.9') from dual;

--hier gaat het afronden op 2 decimalen sinds je 2 decimalen in je formatting na je komma hebt gespecifeerd
select to_char(1598.527, '9999.99') from dual;

--als je minder cijfers specifieerd *voor je komma* gaat hij # geven since its invalid
--je geeft 4 digits and ask it to convert it into 2 digits, basically impossible
select to_char(1598.76, '99') 
from dual;

--0 is same as 9
select to_char(1598.88, '0000.00') from dual;


select to_char(1598.88, '99999999.99') from dual;
select to_char(1598, '99999999') from dual;

--als je 0 gebruikt en 0's gebruikt dan je origineel getal is, dan gaat het 0 zetten voor je cijfer to pad it
select to_char(1598, '0000000') from dual;

--in dit geval prioritiseert die 0 een actual digit and not trynna pad it with 0's
select to_char(1598, '0999') from dual;

--same as above case. Je kan 0's en 9's mixen
select to_char(1577.99, '9900.90') from dual;

--maar zet je een 0 teveel dan pad hij hem wel weer met een 0
select to_char(1598.77, '009900.90') from dual;


select to_char(1598.69, '0099.99') from dual;


select to_char(1598989, '9G999G999') from dual;

select to_char(1598989, '99G999G99') from dual;



--minus
--the minus will not be removed
select to_char(-1587, '9999') from dual;


select to_char(1598, '9999mi') from dual;

--wat mi doet is hij schuift je negatief sign gewoon op naar right(if number is positive nothing happens)
select to_char(-1598, '9999mi') from dual;


select to_char(1598, '9999PR') from dual;

--zet je negatief getaal tussen <>(if number is positive nothing happens)
select to_char(-1598, '9999PR') from dual;

--best practices:
--letop dat deze hem gewoon pad naar de gegeven format
select to_char(1598, '999,999,999'), length(to_char(1598, '999,999,999')) from dual;

--so this also pads to the given format + 1 for some reason
select to_char(1598, '999999'), length(to_char(1598, '999999')) from dual;


--om die unneccessary spaces weg te halen wanneer je bovengegeven format gebruikt kan je fm gebruiken
select to_char(1598, '999999'), length(to_char(1598, 'FM999999')) from dual;

--Alles krijgt automatisch een extra space aan het begin in geval dat je getal negatief is. 
select to_char(8, '9'), length(to_char(8, '9'))from dual;

--Als je die unneccessary space weg wilt laten, kan je gebruik maken van fm(trim also works)
select to_char(8, '9'), length(to_char(8, 'fm9'))from dual;

--length hiervan blijft 2 omdat het actually negatief is
select to_char(-8, '9'), length(to_char(-8, 'fm9'))from dual;




--die $ is altijd leading al plaats je het aan het einde
select to_char(2222, '9999$') from dual;

--Unlike the $ als je U gebruikt kan het ook aan het einde
select to_char(9999, 'U9999') from dual;
select to_char(9999, '9999U') from dual;

--WHAT
SELECT TO_CHAR('01110' + 1) FROM DUAL;

SELECT TO_CHAR('01110' + 2) FROM DUAL;


select to_char(22222, '9G9999') from dual;

--so voor nls_currency kan je anything zetten basically
--voor NLS_ISO_CURRENCY moet het wel voorkomen op die iso lijst i assume
--NLS_NUMERIC_CHARACTER wordt gebruikt om value van D en G respectievelijk aan te geven
select to_char(10000.99, 'L99G999D99', 'NLS_NUMERIC_CHARACTERS=''.,'' NLS_CURRENCY=''AusDollars'' ') "Amount" from dual;


--NLS_ISO_CURRENCY
select to_char(10000.99, 'L99999.99', 'NLS_NUMERIC_CHARACTERS=''.,'' NLS_ISO_CURRENCY=''America'' ')from dual;
select to_char(10000.99, 'C99999.99', 'NLS_NUMERIC_CHARACTERS=''.,'' NLS_ISO_CURRENCY=''dsd'' ')from dual;



--wat je zet bij NLS_CURRENCY IS WAT KOMT ALS JE L GEBRUIKT
select to_char(10000.99, 'L99999d99', 'NLS_ISO_CURRENCY=''Poland'' NLS_NUMERIC_CHARACTERS=''.,'' NLS_CURRENCY=''DOLLAR'' ')from dual;


select to_char(10000.99, 'L99999', 'NLS_NUMERIC_CHARACTERS=''.,'' NLS_ISO_CURRENCY=''Suriname'' NLS_CURRENCY=''TEST'' ')
from dual;


select to_char(10000.99, 'C99999D99', 'NLS_ISO_CURRENCY=''Suriname'' NLS_NUMERIC_CHARACTERS=''.,'' ')
from dual;


select to_char(10000, 'C99999D99', 'NLS_ISO_CURRENCY=''Suriname'' NLS_CURRENCY=''SRD'' NLS_NUMERIC_CHARACTERS=''.,'' ')
from dual;


--BIJ L gebruikt het je NLS_CURRENCY
--BIJ C gebruikt het je NLS_ISO_CURRENCY
select to_char(20000, 'L99999', 'NLS_ISO_CURRENCY=''Suriname'' NLS_NUMERIC_CHARACTERS=''.,'' NLS_CURRENCY=''TEST'' ' )
FROM DUAL;

--dus die V multiplied met 10. Als je 1V zet dan wordt het je getal maal 10. 2V's worden maal 100
select to_char(5000, '9999V9')
from dual;

--maal 100
select to_char(3000, '9999V99')
from dual;

--doesnt work
select to_char(3000, '9V999')
from dual;

--S zegt je gewoon of hij positief of negatief is
select to_char(3000, 'S9999')
from dual;

select to_char(-3000, 'S9999')
from dual;

--no clue what this does. Klopt niet volgens het voorbeeld?
select to_char(3000.00, 'B9999.99') from dual;