-----------------Creating Simple Views-------------
--One table, no functions, no group, allow dml OPERATIONS
drop view emp_v1;

create view emp_v1
AS
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
from EMPLOYEES;

select * from emp_v1;



---Data Dictionary Table
select * from USER_VIEWS
where view_name='EMP_V1';

select * from ALL_VIEWS;



--You can do describe on a view
desc emp_v1;


--I can do dml operations on this
commit;

insert into emp_v1(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
            values(333, 'David', 'Fish', 'dfish', sysdate, 'IT_PROG');


select * from emp_v1;

select * from EMPLOYEES;


drop table test;

create table test(
        test_id number primary key,
        test_name varchar2(20) not null,
        test_date date,
        test_type varchar2(1)
);

-- Inserting records into the test table
INSERT INTO test (test_id, test_name, test_date, test_type)
VALUES (1, 'Test 1', TO_DATE('2023-07-04', 'YYYY-MM-DD'), 'A');

INSERT INTO test (test_id, test_name, test_date, test_type)
VALUES (2, 'Test 2', TO_DATE('2023-06-30', 'YYYY-MM-DD'), 'B');

INSERT INTO test (test_id, test_name, test_date, test_type)
VALUES (3, 'Test 3', TO_DATE('2023-07-02', 'YYYY-MM-DD'), 'A');

INSERT INTO test (test_id, test_name, test_date, test_type)
VALUES (4, 'Test 4', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'B');

INSERT INTO test (test_id, test_name, test_date, test_type)
VALUES (5, 'Test 5', TO_DATE('2023-07-03', 'YYYY-MM-DD'), 'A');


create view test_vw AS
select test_id,test_date, test_type from test;

--Je kan obviously niet inserten in je view, omdat je in je table een non null column hebt en in je view heb je die column niet opgenonmen
select * from test_vw;
insert into test_vw(test_id, test_date, test_type)values(6, sysdate, 'A');




---Simple view v2


--Als je het zo doet dan heb je je eigen kolumn header things
create view emp_v2
as 
select EMPLOYEE_ID emp_id, FIRST_NAME fname, LAST_NAME lname, EMAIL, HIRE_DATE, JOB_ID
from EMPLOYEES;

select * from emp_v2;

--so when doing dml becomes this:
insert into emp_v2(emp_id, fname, lname, email, HIRE_DATE, JOB_ID)
VALUES              (444, 'Sameer', 'Kewal', 'skewal', sysdate, 'IT_PROG');


--If you try to insert using the original column headers dan gaat het niet
insert into emp_v2(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES              (555, 'Jasmine', 'de Vries', 'jdevries', sysdate, 'IT_PROG');

select * from EMPLOYEES;


------Another way om die alias namen ig te specifyen is this:

create view emp_v3(empid, fnmame, lname, mail, hiredate, job)
as
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
from EMPLOYEES;

--Ook hier kan je obviously niet zo inserten
insert into emp_v3(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, job)
VALUES              (555, 'Gaby', 'WOman', 'Gwoman', sysdate, 'IT_PROG');


create view emp_v3(empid, fnmame, lname, mail, hiredate, job)
as
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
from EMPLOYEES;


--Je mag in je subquery aliasses hebben maar die kolumn header gaat nog steeds zijn van wat je hebt bij je create view statement
create view emp_v4(empid, fname, lname, male, hiredate, job)
as
select EMPLOYEE_ID eee, FIRST_NAME, LAST_NAME, EMAIL,HIRE_DATE, JOB_ID
from EMPLOYEES;

select * from emp_v4;


--creating a view with constraints
--Kan alleen in disabled mode
drop view emp_v5;


create view emp_v5
(
    empid unique disable,
    FIRST_NAME
)
as
select EMPLOYEE_ID, FIRST_NAME from EMPLOYEES;


drop view emp_v5;
create view emp_v5
(
    empid primary key disable,
    FIRST_NAME
)
as
select EMPLOYEE_ID, FIRST_NAME from EMPLOYEES;

--Alleen column level constraints
drop view emp_v5;
create view emp_v5
(
    empid primary key disable,
    FIRST_NAME,
    departments references departments(DEPARTMENT_ID) disable novalidate
)
as
select EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID from EMPLOYEES;

--JE KAN TABLE LEVEL CONSTRAINTS ZETTEN 
drop table emp_v5;
create view emp_v5
(
    empid,
    FIRST_NAME,
    departmentss,
    constraint emp_id_pk primary key(empid) disable
)
as
select EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID from EMPLOYEES;

--TABLE LEVEL CONSTRAINTS
drop view emp_v1;
create view EMP_V1(
    FNAME,
    LNAME,
    dept_id,
    CONSTRAINT fk_emp_deptid FOREIGN KEY (dept_id) REFERENCES departments(DEPARTMENT_ID) disable
)
as select FIRST_NAME, LAST_NAME, DEPARTMENT_ID from EMPLOYEES;




--Alter views
alter view emp_v5 add constraint emp_v5_unique unique(FIRST_NAME);
alter view emp_v5 drop constraint emp_v5_unique;


--Data dictionary om je view constraints te vinden
select * from USER_CONSTRAINTS where table_name = 'EMP_V5';

drop table test;

create table test(
    test_id number generated by default on null as identity,
    test_name varchar2(20) constraint test_chk check(length(test_name)>3),
    test_dept number,
    constraint test_fk foreign key(test_dept) references departments
);

drop view v1;

create view v1(
    v1_id constraint v1_chk check(v1_id>0) disable NOVALIDATE
)
as select EMPLOYEE_ID
from employees;


-- ORA-01702: a view is not appropriate here
insert all
into copy_emp_vw
select 'Kewal', 'skewal', sysdate, 'IT_PROG'
from dual;


drop table emp;
drop table dept;

-- If you delete rows from the view v_emp with the WHERE condition loc='Dallas', the rows with department location 'Dallas' 
-- will be removed from the view. Since the view v_emp is created using data from the dept table, 
-- the rows with department location 'Dallas' will no longer be shown in the view.
create table emp(
    empno number,
    ename varchar2(20),
    deptno number
);

create table dept(
    deptno number,
    dname varchar2(20),
    loc varchar2(20)
);

insert into emp values(7369, 'Smith', 20);
insert into emp values(7499, 'Allen', 30);
insert into emp values(7521, 'Ward', 30);
insert into emp values(7566, 'Jones', 20);
insert into emp values(7654, 'Martin', 30);
insert into emp values(7698, 'Blake', 30);
insert into emp values(7782, 'Clark', 10);


insert into dept values(10, 'Accounting', 'New York');
insert into dept values(20, 'Research', 'Dallas');
insert into dept values(30, 'Sales', 'Chicago');
insert into dept values(40, 'Operations', 'Boston');

alter table dept
add constraint dept_pk2 primary key(deptno);
alter table emp
add constraint emp_pk3 primary key(empno);
alter table emp
add constraint emp_fk3 foreign key(deptno) references dept(deptno);

CREATE OR REPLACE VIEW v_emp AS
SELECT e.empno, e.ename, d.loc FROM emp e, dept d WHERE d.deptno = e.deptno;

CREATE OR REPLACE VIEW v_emp AS
SELECT e.empno, e.ename, d.deptno, d.loc FROM emp e right join dept d on d.deptno=e.deptno;
-- If you delete rows from the view v_emp with the WHERE condition loc='Dallas', the rows with department location 'Dallas' 
-- will be removed from the view. Since the view v_emp is created using data from the dept table, 
-- the rows with department location 'Dallas' will no longer be shown in the view.


CREATE OR REPLACE VIEW v_emp AS
SELECT e.empno, e.ename, d.deptno, d.loc
FROM emp e
JOIN dept d ON d.deptno = e.deptno;

-- How to know a table is key preserved?
-- If the number of records in view represent 
-- exactly same numbers of records after applying filter than table is Key Preserved.
delete from v_emp where loc='Dallas';



select *
from v_emp;



select *
from copy_emp;


desc copy_emp;


drop table test;

create or replace view test
as select employee_id,hire_date, job_id
from copy_emp;


create table copy_emp
as select *
from employees;
drop table copy_emp;


select *
from test;

select *
from test;

merge into test t
using(select * from employees) e
on(e.employee_id=t.employee_id)
when matched then
update set t.hire_date = e.hire_date;


select *
from test;


--Als je een view maakt van een table en dan een column van die table dropped of op unused zet
--dan gaat je view errors hebben en moet je het opnieuw compilen voordat je die view weer kan queryen
create or replace view test_vw
as
select *
from copy_dept;


select *
from test_vw;

alter table copy_dept set unused column department_name;



create or replace view test_vw
as select first_name
from employees;

--Not possuble
create index test_vw_ind on test_vw(first_name);


grant select on test_vw to shavien;



select *
from hr.test_vw;