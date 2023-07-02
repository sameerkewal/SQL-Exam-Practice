----------------Constraints----------------
alter table test drop constraint TEST_PK;

select * from test;

--Dit kan niet
alter table test add constraint primary key(emp_id);

--Op zo een manier als je alter table doet ben je verplicht om een naam te specifyen voor je constraint
alter table test add constraint TEST_PK primary key(EMP_ID);





--------------------Creating table with column level constraints

create table test(
    emp_id number constraint test_pk primary KEY,
    ename varchar2(100) constraint test_uk1 unique,
    salary number not null,
    gender char(1) constraint test_chq check (gender in ('M', 'F')),
    dept_id number constraint test_fk1 references departments(DEPARTMENT_ID)
); 

--Zo kan je die fk ook referencen
--In this case referenced het altijd gewoon de primary key van die table which you're referencing
create table test(
    emp_id number constraint test_pk primary KEY,
    ename varchar2(100) constraint test_uk1 unique,
    salary number not null,
    gender char(1) constraint test_chq check (gender in ('M', 'F')),
    dept_id number constraint test_fk1 references departments
); 


--Alternative way of doing a not null constraint just dropped????
drop table test;

create table test(
    emp_id number constraint test_pk PRIMARY key,
    ename varchar2(100) constraint test_uk1 unique,
    salary number not null,
    gender char(1),-- constraint test_chk check(gender is not null),
   dept_id number constraint test_fk1  references departments
);

--totally works!
insert into test(emp_id, ename, SALARY, gender, dept_id)
values(5, 'Sam', '20000', null, 10);


create table test(
    emp_id number 
);

--If you dont wanna name the constraint do this(not recommended)
create table uhm_test(
    uhm number primary key,
    yeah number references departments(DEPARTMENT_ID)
);
drop table uhm_test;


--If you do wanna name the constraint add the constraint keyword like so
--Btw you cant have the same constraint name even if the constraints are on different tables
create table uhm_test(
    uhm number constraint test_pk2 primary key,
    yeah number constraint test_fk REFERENCES DEPARTMENTS
);


--multiple constraints
create table uh(
    uh1 number primary key,
    uh2 varchar2(20) check(length(uh2)=3) check(substr(uh2, 1, 1)='S')
);

--Kan met of zonder comma(ook als je constraint name specified, kan het met of zonder comma)
create table uh(
    uh1 number primary key,
    uh2 varchar2(20) check(length(uh2)=3), check (substr(uh2,1,1)='S')
);

insert into uh values(1, 'Sam');


--Constraints stored in data dictionary table called user_constraints
select * from USER_CONSTRAINTS
where table_name='TEST';


--checking the check constraint
--Obviously maakt die capitalization wel uit
insert into test(emp_id, ename, SALARY, gender, dept_id)
values          (1, 'Sameer', 10000, 'm', 10);


--This works!
insert into test(emp_id, ename, SALARY, gender, dept_id)
values          (1, 'Sameer', 10000, 'M', 10);


--Null values gaan ook, bc the check constraint isnt preventing null values from being inserted
insert into test(emp_id, ename, salary, gender, dept_id)
VALUES          (2, 'Jennifer', 20000, null, 10);



--Checking the unique constraint:
insert into test(emp_id, ename, SALARY, gender, dept_id)
            values(2, 'khaled', 500, null, null);









--Table level constraints
/*Doing it this way makes it so you can make your PK more than one column
  It also forces you to name your constraints*/

drop table test;

--Not null constraint kan alleen op column level not on table level
--Bij foreign key constraint bij table level moet je die keyword foreign key well erbij vermelden
create table test(
    emp_id number,
    emp_id2 number,
    ename varchar2(100),
    salary number not null,
    gender char(1),
    dept_id number,
    constraint test_pk primary key(emp_id, emp_id2),
    constraint test_uk1 unique(ename),
    constraint test_chk check(gender in('M', 'F')),
    constraint test_FK1 FOREIGN key (dept_id) references departments(DEPARTMENT_ID)
);


drop table test;

--Als je die unique key zo defined betekent het dat die combinatie van ename and salary maar 1 keer mag worden inserted
create table test(
    emp_id number,
    emp_id2 number,
    ename varchar2(100),
    salary number not null,
    gender char(1),
    dept_id number,
    constraint test_pk primary key(emp_id, emp_id2),
    constraint test_uk1 unique(ename, SALARY),
    constraint test_chk check(gender in('M', 'F')),
    constraint test_FK1 FOREIGN key (dept_id) references departments(DEPARTMENT_ID)
);


--Bv zo:
insert into test values(10, 20, 'Sameer', 20000, 'M', 10);

--Dan deze gaat niet 
insert into test values(10, 21, 'Sameer', 20000, 'M', 10);

--En dus deze zal dan wel werken
insert into test values(10, 22, 'Sam', 20000, 'M', 10);


create table test(
    emp_id number,
    ename varchar2(50) not null,
    salary number(10,2) not null,
    gender char(1),
    dept_id number,
    constraint TEST_PK primary key(emp_id),
    constraint ename_chk check(length(ename)>=3),
    constraint salary_chk check(salary>=0),
    constraint gender_chk check(gender in('M', 'F')),
    constraint test_dept_fk foreign key(dept_id) references departments
);


-------------------------------Constraint Guidelines----------------------

create table nulltest(
    id1 number,
    id2 number,
    constraint nulltest_uk unique(id1, id2)
);

insert into nulltest values(1, 2);
insert into nulltest values(2, 2);

--Null values like this do not trigger the composite unique thing
insert into nulltest values(null, null);
insert into nulltest values(null, null);

insert into nulltest values(1, null);
--But like this they do trigger the unique constraint
--So basically nulls samen mogen well, maar zodra je een combinatie van null met iets anders zet, gaat het de unique constraint triggeren
insert into nulltest values(1, null);


select * from nulltest;







--------------------On delete Cascade--------------------------

--Is een master table. There are child records which depend on this table
delete from DEPARTMENTS;


create table dept1(
    deptno number,
    dept_name varchar2(100),
    constraint dept1_pk primary key(deptno)
);


insert into dept1 values(1, 'HR dept');
insert into dept1 values(2, 'PO dept');

commit;


create table emp1(
    empid number primary key,
    ename varchar2(200),
    deptno number,
    constraint emp1_fk FOREIGN key(deptno) references dept1(deptno) on delete cascade
);

insert into emp1 values(1, 'Sameer', 1);
insert into emp1 values(2, 'Ali', 1);
insert into emp1 values(3, 'Hiba', 1);
insert into emp1 values(4, 'Rania', 2);
insert into emp1 values(5, 'Lara', 2);

commit;

select * from emp1 join dept1 on (emp1.deptno = dept1.deptno);


--So aangezien ik nu me on delete heb gedefined, wanneer ik iets uit department table wilt deleten(master table)
--gaat het eerst door alle child records in je employees table and delete all records which depend on that specific department

delete from dept1 where deptno = 1;

select * from emp1 join dept1 on (emp1.deptno = dept1.deptno);


--On delete set null
--Wat er hierbij gebeurd is when you delete the master record, Oracle will go through the child records which depend on it
--and put the foreign key as null(foreign keys mogen null zijn)
--Je moet die tables definen met on delete set null

create table dept2(
       deptno number,
       dept_name varchar2(100),
       constraint dept2_pk primary key(deptno)
);

insert into dept2 values(1, 'HR dept');
insert into dept2 values(2, 'PO dept');


create table emp2(
    empid number primary key,
    ename varchar2(200),
    deptno number,
    constraint emp2_fk FOREIGN key(deptno) references dept2(deptno) on delete set null
);

insert into emp2 values(1, 'Sameer', 1);
insert into emp2 values(2, 'Ali', 1);
insert into emp2 values(3, 'Hiba', 1);
insert into emp2 values(4, 'Rania', 2);
insert into emp2 values(5, 'Lara', 2);

commit;


select * from emp2 join dept2 on (emp2.deptno = dept2.deptno);


delete from dept2 where deptno = 1;

--As seen here is het gewoon gezet on null and not nuked from existence or sth
select * from emp2;

select * from emp2 join dept2 on (emp2.deptno = dept2.deptno);






-----------------Creating table using Subquery---------------


--When you use an expression you should use an alias
--Note the error tells u what to do
create table newtest as
select EMPLOYEE_ID, LAST_NAME, salary*12
from EMPLOYEES;

create table newtest as
select EMPLOYEE_ID, LAST_NAME, salary*12 as annual_salary
from EMPLOYEES;

drop table newtest;


--If you want to use your own column names
create table newtest(
    emp_id,
    fname,
    lname,
    sal default 0,
    dept_id
) as select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES;

desc newtest;

drop table newtest;


--JE MAG WEL CONSTRAINTS ZETTEN ALLEEN GEEN DATATYPE
create table newtest(
    emp_id constraint pk_test primary key,
    fname,
    lname,
    sal default 0,
    dept_id
)as select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES;


--create as select with referential constraints not allowed
--dus geen FK constraints allowed
create table newtest(
    emp_id constraint pk_test primary key,
    fname,
    lname,
    sal default 0,
    dept_id,
    constraint newtest_dept_fk foreign key(dept_id) references DEPARTMENTS
)as select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES;


--Non varchar column with substring type check
--Check error(check constraint violated)
--Dus basically wanneer je insert zijn die constraints al defined. So if you define a constraint wat zal violated worden
--bij het inserten gaat die create table statement failen
create table newtest(
    emp_id constraint pk_test primary key,
    fname,
    lname,
    sal default 0,
    dept_id check(substr(dept_id, 1, 1)='S')
)as select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES;

--A constraint which won't be violated when inserting will work
create table newtest(
    emp_id constraint pk_test primary key,
    fname,
    lname constraint newtest_chk check(length(lname)<100),
    sal default 0,
    dept_id
    )as select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES;

drop table newtest;

--Constraints mogen ook hier defined worden op table level of op column level
create table newtest(
    emp_id,
    fname,
    lname constraint newtest_chk check(length(lname)<100),
    sal default 0,
    dept_id,
    constraint newtest_pk primary key(emp_id) 
    )as select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES;


--Ook not null constraints mogen defined worden
create table newtest(
    emp_id,
    fname not null,
    lname constraint newtest_chk check(length(lname)<100),
    sal default 0,
    dept_id,
    constraint newtest_pk primary key(emp_id) 
    )as select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES;


/*In the newtest table, when inserting data from the EMPLOYEES table, if the DEPARTMENT_ID in the original table is NULL, 
the corresponding value in the dept_id column of the newtest table will also be NULL. 
This is because the dept_id column has a default value of 0, 
but the default value is not used when explicitly inserting data from the source table.*/

--Final test with a default value and constraint!
drop table newtest;

create table newtest(
    emp_id,
    fname not null check(length(fname)<1000),
    lname constraint newtest_chk check(length(lname)<100),
    sal default 0 not null,
    dept_id  default 0 constraint newtest_chk2 check(dept_id not between 0 and 5),
    constraint newtest_pk primary key(emp_id)
    )as select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES;



insert into newtest(emp_id, fname, lname, dept_id)
VALUES              (1001, 'Sameer', 'Kewal', 10);

select * from NEWTEST;

drop table NEWTEST;

create table newtest(
    emp_id,
    fname not null check(length(fname)<1000),
    lname constraint newtest_chk check(length(lname)<100),
    sal default 0 not null,
    dept_id  default 20 not null,
    constraint newtest_pk primary key(emp_id)
    )as select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES;

select * from newtest
order by dept_id;
