------------Alter table--------------
drop table test;

create table test(
    test_id number,
    test_name varchar2(20)
);

insert into test values(1, 'Sameer');
insert into test values(2, 'Jasmine');

--Dit gaat niet
alter table test add test_lname VARCHAR2(20) not null;


--dit gaat wel, omdat je een default value specified, zo die 2 existing rows gaan die default value nemen
--voor die test_lname
alter table test add test_lname VARCHAR2(20) default 'UNASAT' not null;

--check:
select * from test;


--Voor een empty table kan je wel een not null column zetten
create table test2(
    test_id number,
    test_name varchar2(20)
);

alter table test2 add test_lname varchar2(100) not null;



--Add new column
alter table test add gender char(1);


--Ook hier al doe je geen not null, die nieuwe column voor existing rows gaat toch gewoon die 0 hier als value nemen
alter table test add commission number default 0;

select * from test;

--You can add 2 columns
--Als je 2 columns add moeten ze tussen haakjes(vanaf na die add) anders gaat het niet
alter table TEST add (created_date date default sysdate not null, created_by varchar2(100) default user);


select * from test;


describe test;
--Test name is 20 and i can increase it to 200;

alter table test modify test_name varchar2(200);

--
describe test;


--Decrease test name size
alter table test modify test_name varchar2(50);

--Dit kan niet bc jasmine is 7 characters long
alter table test modify test_name varchar2(6);

--dit gaat obviously wel
alter table test modify test_name varchar2(7);


select * from test;

alter table test modify;

describe test;

alter table test modify CREATED_BY varchar2(2) not null;

--Cannot put it to not null twice lmfao
alter table test modify CREATED_BY not null;

update test set gender = 'M';



alter table test add new_column varchar2(20) default 'hey';
alter table test add new_column varchar2(20);
alter table test drop column new_column;

update test set new_column = null;

--Als je values voor die column which you're trynna change empty zijn(as in you've never inserted data into them)
--dan kan je die datatype wel aanpassen
--For some reason als je data zet en het dan update naar null en daarna die datatype probeert te veranderen gaat het niet

select * from test;

ALTER TABLE test MODIFY new_column NUMBER;


select * from test where new_column is null;
commit;
describe test;


--Moving on

alter table test drop column gender;

alter table test add gender char(1);

update test set gender ='M';

--Je kan van char naar varchar2 converten en ook omgekeerd
alter table test modify gender varchar2(11);


alter table test modify gender char(10);


--Char is een fixed length dus als die values eenmaal char(10) als datatype hebben, betekent het dat hun length 10 is
--Nu wil je die datatype korter maken dan hun length which we already know isn't possible so this will give the same error 
--as before van "cannot decrease column length because some value is too big"
alter table test modify gender varchar2(9);



--this will work maar any value kleiner kan niet, omdat ze permanently zijn gezet op length 10
--tenzij je ze trimmed naar 1 en die getrimde als hun nieuwe value zet
alter table test modify gender varchar2(10);


--To get around the problem, you'd first have to convert to null
update test set gender = null;
commit;

--Now it will work bc the values in the table were null so this is allowed
alter table test modify gender varchar2(9);

alter table test
modify gender varchar2(5);

alter table TEST
modify gender varchar2(1);


alter table test 
modify gender char(2);


--Aangezien die table null is kan ik het, ondanks ik van char naar varchar2 ga die length well kleiner maken!
alter table TEST
modify gender varchar2(1);



-----------Adding constraints---------------


alter table test drop column test_id;
alter table test add test_id number;
describe test;

update test set test_id = 1 where test_name='Sameer';
update test set test_id = 2 where test_name='Jasmine';

select * from test;
alter table test modify test_id primary key check(test_id not between 1000 and 2000);

--Constraints adden kan zo
alter table test modify test_id primary key constraint test_chk check(test_id not between 1000 and 2000);


--add constraint syntax
alter table test modify test_id number add constraint test_pk primary key(TEST_ID);

alter table test drop constraint test_pk;
alter table test drop constraint test_chk;



--Je mag maar 1 add constraint doen per keer als je het zo doet(???)
alter table test modify test_id number add constraint test_pk primary key(test_name),
add constraint test_chk check(test_id not between 20 and 30);

alter table test modify test_id number add constraint test_pk primary key(test_name),
constraint test_chk check(test_id not between 20 and 30);


--However als je het zo doet kan je any number of constraints zetten voor die column alleen ofc!
alter table test modify test_id constraint test_pk primary key constraint test_chk check(test_id not between 1000 and 2000)
constraint test_chk2 check(length(test_id)<20000);


--So basically als je het net als column level doet mag je alleen die table referencen maar je mag meerdere constraints zetten
--(op die column)
--Op table level kan je maar 1 constraint zetten maar je mag dan any table referencen in die constraint






------------------Dropping columns-----------------------
select * from test;

--met deze syntax kan je maar 1 table droppen
alter table test drop column gender;

--Met deze syntax kan je >1 column droppen
alter table test drop(gender, test_lname);


alter table test add gender char(1);
alter table test add test_lname varchar2(100) default 'UNASAT';
update test set gender ='M';




-------------------Set unused--------------------

select * from test;

--het moet tussenhaakjes en je kan multiple columns at the same time op unused zetten
alter table test set unused (gender, test_lname);



--Deze syntax kan je alleen 1 column op unused zetten en hier hoeft het niet tussen haakjes
alter table test set unused column test_lname;


--Deze gaan niet
alter table test set unused column test_lname, gender;
alter table test set unused column (test_lname, gender);


-



--Data dictionary table dat je access geeft tot je columns which have been set to unused
select * from USER_UNUSED_COL_TABS;




--This will error
select * from test;

--Invalid identifier bc basically it sees the column as not there anymore
update test set gender = 'F';


--Je kan ook niet andere kolommen updaten bc it locks the table
update test set test_name = 'newtest';
commit;
rollback;


--Bringing back gender

select * from test;

--Als je **online** keyword gebruikt, kan je wel nog DML statements op die table doen 
alter table test set unused (gender) online;


alter table test set unused(gender, test_lname);

--This physically drops the columns
alter table test drop unused column;

select * from USER_UNUSED_COL_TABS;

drop table test;








---------------Read only/Read write--------------------

select * from test;

alter table test read ONLY;

delete from test;

--Will work
alter table test add gender char(1);


--Keyword is **changing data**
alter table test add gender2 char(2) default 'M';

--even tho you're not changing any data you're doing a dml statement
insert into test values(3, 'Kewal', 'M', 'F');

alter table test read write;






alter table test drop column gender;
