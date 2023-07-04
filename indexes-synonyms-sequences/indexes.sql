---Automatic Index Momento

create table emp_ind(
    empno number constraint emp_ind_pk primary key,
    ename varchar2(100) unique,
    nickname varchar2(100),
    email varchar2(100)
);


insert into emp_ind(empno, ename, nickname, email)
            values(1, 'Sameer Kewal', 'Sameer.Kewal', 'skewal@test.com');

insert into emp_ind(empno, ename, nickname, email)
            values(2, 'Jasmine de Vries', 'jasminevries', 'jdevries@test.com');

insert into emp_ind(empno, ename, nickname, email)
            values(3, 'Gavin Soemo', 'Gav.Soemo', 'gsoemo@test.com');

insert into emp_ind(empno, ename, nickname, email)
            values(4, 'Claire Amat', 'Claire.Amat', 'camat@test.com');
commit;

--Oracle will create implicit unique indees for the PK, UK
--The name for these indexes will be the same as the constraint name

select * from USER_INDEXES
where table_name='EMP_IND';

select * from USER_IND_COLUMNS
where table_name='EMP_IND';

drop table emp_ind;


create table emp_ind(
    empno number,
    ename varchar2(100) unique,
    nickname varchar2(100),
    email varchar2(100),
    constraint emp_ind_pk primary key(empno, EMAIL)
);

--Omdat je een composite key hebt dan komen beide kolommen nu als index. Eentje met position 1 en die andere met position 2
select * from USER_IND_COLUMNS
where table_name='EMP_IND';


select * from USER_IND_COLUMNS where table_name='EMP_IND';


--Oracle will now use the index in the where clause to speed up the query
select * from emp_ind where empno = 1;

--Ook hier zal er gebruik worden gemaakt van een index to speed up the query
select * from emp_ind where ename ='Sameer Kewal';


--Hier wordt er geen gebruik gemaakt van een index dus er zal een full scan worden gedaan op deze table
select * from emp_ind where nickname='Sameer.Kewal';


--Manually create index
create index emp_ind_nickname on emp_ind(nickname);

select * from user_ind_columns where table_name='EMP_IND';

select * from USER_INDEXES where table_name='EMP_IND';

--Now it will use an index for this query
select * from EMP_IND
where NICKNAME ='Sameer.Kewal';


--When you create a unique index, you're basically making an unique constraint(not literally its not gonna appear in data dictionary views or sth)
create unique index EMP_IND_EMAIL on emp_ind(EMAIL);

--Unique constraint violated 
insert into emp_ind values(9, 'Mister Test', 'Mister.Test', 'skewal@test.com');

select * from USER_CONSTRAINTS where table_name='EMP_IND';


select * from emp_ind where upper(ename)='SAMEER KEWAL';


--You can create indexes using functions for some reason???
--bv bovenstaande query ga je meestal gebruiken bc you dont wanna worry abt capitalization
--Zo dan kan je gewoon een index based on that maken


create index emp_ind_ename_upper on emp_ind(upper(ename));

select * from user_indexes where table_name='EMP_IND';


--check die column name here. De reden hiervoor is dat die kolumn niet actually bestaat in die table
select * from USER_IND_COLUMNS where table_name='EMP_IND';


--New data dictionary view just dropped
select * from USER_IND_EXPRESSIONS;


--Als ik explain had hier, I assume this'd work
select * from emp_ind where upper(ename)='SAMEER KEWAL';



--Zo stuff like this, ik neem aan dat round, trunc
create index emp_test on employees(round(SALARY));

--Just remember a single row function you'd use in a where statement you can probably use here
create index emp_test2 on employees(round(COMMISSION_PCT));

select * from EMPLOYEES where round(COMMISSION_PCT)=0;


select round(COMMISSION_PCT) from EMPLOYEES;

--No group functions!!!!!!!!!!!!
create index emp_test2 on employees(max(SALARY));