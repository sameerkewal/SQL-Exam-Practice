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
   dept_id number constraint test_fk1 references departments
);


--totally works!
insert into test(emp_id, ename, SALARY, gender, dept_id)
values(5, 'Sam', '20000', null, 10);







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