create table test(
    id number constraint test_pk primary key,
    name varchar2(50)
);


create sequence test_s;


--Data dictionary table
select * from USER_SEQUENCES;


--using a sequence
insert into test values(test_s.NEXTVAL, 'Sameer');


select * from test;

--die sequence gaat gewoon altijd +1 doen(by default), zo als je eerst manually
--een value zet voor je pk and then die sequence weer gebruikt gaat het die value die volgde geven, which you have just inserted
--waardoor het gaat erroren 
insert into test values(2, 'Gavin');
insert into test values(test_s.NEXTVAL, 'Jasmine');


--Maar als je het daarna nog een keer runned gaat het wel. Another Demo.
select * from test;
insert into test values(test_s.NEXTVAL, 'Jasmine');


insert into test values(4, 'Claire');

--Die sequence will dus nu 4 genereren, so it will fail
insert into test values(test_s.NEXTVAL, 'Jasmine');

--However if we do it again it will succeed
insert into test values(test_s.NEXTVAL, 'Shamar');


select * from test;

--If i wanna know what the current value is for the sequence i can do this
--The sequence value rn should be 5 bc that was the last value you inserted
select TEST_S.CURRVAL from dual;

select * from test;

insert into test values(test_s.NEXTVAL, 'Akash');


--Als je dit doet gaat het die function callen i think which does in fact increment the nextval
select test_s.NEXTVAL from dual;

select test_s.CURRVAL from dual;

--So nu als ik iets ga invullen in die table gaat die value van die id 9 zijn?
insert into test values(test_s.NEXTVAL, 'Kewal');


--yes that is right
select * from test;


--Je kan ook invullen using currval

select test_s.NEXTVAL from dual;


insert into test values(test_s.CURRVAL, 'UNASAT');

select * from test;

create sequence TEST_S
start with 10
increment by 20;

select * from USER_SEQUENCES where sequence_name='TEST_S';


--Als je net je sequence hebt defined and you do sequencename.currval it will not work and will tell you that 
--sequence sequencename is not yet defined in this session
select test_s.CURRVAL from dual;

insert into test values(test_s.NEXTVAL, 'Sameer');
insert into test values(test_s.NEXTVAL, 'Gavin');
insert into test values(test_s.NEXTVAL, 'Jasmine');
insert into test values(test_s.NEXTVAL, 'Claire');

insert into test values(110, 'man');
insert into test values(test_s.NEXTVAL, 'Claire2');





select * from test;


delete from TEST;
COMMIT;

drop sequence test_s;


create sequence TEST_S
INCREMENT by -5;



select * from ALL_SEQUENCES
where sequence_name='TEST_S';

--Als je met een negatieve increment een sequence maakt, gaat je eerste value een id hebben van -1. 
insert into test values(test_s.NEXTVAL, 'Sameer');
insert into test values(test_s.NEXTVAL, 'Jasmine');


select * from test;

select * from test
order by 2;

--And as seen on the error when running this statement there is nothing you can do to change that fact. (start with cannot be more than maxvalue)
create sequence test_s
start with 1
increment by -5;


--Je kan je nextval ook met update gebruiken(ofc ofc)
update test set id = test_s.NEXTVAL;

select * from test
order by 2;


--You can create default value as sequence when creating the table 
drop sequence test_s;

create sequence test_s; 

create table em(
    empid number default test_s.NEXTVAL primary key,
    name varchar2(100),
    deptno number
);

insert into em(name)
values('Sameer');

insert into em(name)
values('Jasmine');

select * from em;


--For ascending sequences, the default value is the minimum value of the sequence. 
--For descending sequences, the default value is the maximum value of the sequence. 
drop sequence test_s;

--dus dit kan niet
create sequence TEST_S
increment by -1
start with 1;
;

--maar moet zo instead
create sequence test_s
increment by -1
start with -1;



drop sequence test_s;

create sequence TEST_S
increment by 1;


select * from USER_SEQUENCES
where sequence_name='TEST_S';


drop sequence test_s;

create sequence test_s 
increment by 1
start with 20
MAXVALUE 25
cycle;


create sequence TEST_S
increment by 1
maxvalue 21
cycle;



--Als je het op cycle zet gaat het opnieuw beginnen after it has hit the max value
--But it doesnt start at the "start again value you indicated, instead begint het gewoon bij 1"
-- After an ascending sequence reaches its maximum value, it generates its minimum value. 
-- After a descending sequence reaches its minimum, it generates its maximum value(-1).
insert into test values(test_s.NEXTVAL, 'Sam'); 
insert into test values(test_s.NEXTVAL, 'Jas'); 
insert into test values(test_s.NEXTVAL, 'Gav'); 
insert into test values(test_s.NEXTVAL, 'Claire'); 
insert into test values(test_s.NEXTVAL, 'Akash');
insert into test values(test_s.NEXTVAL, 'Sham'); 
insert into test values(test_s.NEXTVAL, 'Stef'); 


select * from test;
commit;
delete from test;






--------------------------Idk But New Section Just Dropped-----------------
drop table test;
drop table dept_test;


create table test(
    id number constraint test_pk primary key,
    name varchar2(20),
    dept_id constraint test_fk references dept_test(deptno)
);

delete from test;
drop SEQUENCE test_s;

create table dept_test(
    deptno number,
    dept_name varchar2(20),
    constraint dept_test_pk primary key(deptno)
);
insert into dept_test values(test_s.NEXTVAL, 'HR');

select * from dept_test;
select test_s.CURRVAL from dual;

insert into test(id, name, dept_id)values(1, 'Sameer', test_s.CURRVAL);
insert into test(id, name, dept_id)values(2, 'Jasmine', test_s.CURRVAL);

insert into dept_test values(test_s.NEXTVAL, 'Finance');

insert into test values(3, 'Gavin', test_s.CURRVAL);

select * from test;
select * from dept_test;

describe test;


------------------Altering Sequences---------------------
drop sequence test_s;
create sequence test_s;

select * from user_sequences where sequence_name='TEST_S';


select * from USER_SEQUENCES where sequence_name='TEST_S';

alter sequence test_s INCREMENT by 100;
alter sequence test_s cache 30;
alter sequence test_s MAXVALUE 9999;

alter sequence test_s INCREMENT by 5;
alter sequence test_s MAXVALUE 10;

--You cannot alter the start with. Just a rule
alter sequence test_s start with 100;



--You can perform multiple alters at once
alter sequence test_s INCREMENT by 100
maxvalue 1000
MINVALUE 10;


--Altering the sequence minvalue
alter sequence test_s
minvalue -1;

select test_s.nextval from dual;
select test_s.currval from dual;





--sequence TEST_S.NEXTVAL exceeds MAXVALUE and cannot be instantiated
insert into test(id, name, dept_id)values(1, 'Sameer', null);
insert into test(id, name, dept_id)values(2, 'Jasmine', null);
insert into test(id, name, dept_id)values(3, 'Gavin', null);
insert into test(id, name, dept_id)values(test_s.NEXTVAL, 'Claire', null);
insert into test(id, name, dept_id)values(test_s.NEXTVAL, 'Claire', null);
insert into test(id, name, dept_id)values(test_s.NEXTVAL, 'Claire', null);

select test_s.CURRVAL from dual;


drop sequence test_s;
create sequence test_s
start with 1
increment by 1
maxvalue 5
NOCACHE
cycle;


drop sequence test_s;

create sequence TEST_S
start with 7
increment by 1
minvalue 5
MAXVALUE 10
cycle
cache 5;


select * from test;
delete from test;

--Als je cycle doet begint het bij je minvalue for ascending sequences
insert into test values(test_s.NEXTVAL, 'Sameer', null);
insert into test values(test_s.NEXTVAL, 'Gavin', null);
insert into test values(test_s.NEXTVAL, 'Jasmine', null);
insert into test values(test_s.NEXTVAL, 'Claire', null);



--Bij descending sequences werkt het natuurlijk met je maxvalue
drop sequence test_s;
create sequence test_s
start with -7
increment by -1
MINVALUE -10
MAXVALUE -5
cycle
cache 5;

delete from test;

select * from test;

insert into test values(test_s.NEXTVAL, 'Sameer', null);
insert into test values(test_s.NEXTVAL, 'Gavin', null);
insert into test values(test_s.NEXTVAL, 'Jasmine', null);
insert into test values(test_s.NEXTVAL, 'Claire', null);


--Not allowed
select *
from employees
where employee_id not in(
    select test_s.currval from dual
);

--Not allowed
select test_s.nextval
from dual
group by test_s.nextval;


--For some reason also not allowed
select test_s.nextval
from dual
order by 1;


--So ook niet hier
select test_s.nextval
from dual
union
select 10
from dual;