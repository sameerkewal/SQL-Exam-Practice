--Mag niet
create table 2emp
(empno number);


create table "%test"(empno number);
drop table "%test";

--Max length is 128 bytes;
select length('helloworldthisisatesttoseehowlongthisstringis') from dual;
select length('helloworldthisisatesttoseehowlongthisstringisjdcdnjvcnfvnfnnvfnvnfnvnfvnfnvnfnvfnnvfndnjcdnjfnjevnfvnfnvnfnvfvnjjdjdjdjdfnvnjdjjv') 
from dual;

create table helloworldthisisatesttoseehowlongthisstringisjdcdnjvcnfvnfnnvfnvnfnvnfvnfnvnfnvfnnvfndnjcdnjfnjevnfvnfnvnfnvfvnjjdjdjdjdfnvnjdjjv;

create table emp-t(empno number);