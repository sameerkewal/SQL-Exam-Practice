create table copy_emp
as select *
from employees;

UPDATE COPY_EMP E
SET SALARY=(SELECT SALARY
            FROM COPY_EMP W
            WHERE DEPARTMENT_ID=80
            AND E.EMPLOYEE_ID=W.EMPLOYEE_ID
            );

select * 
from copy_emp
where department_id=80
order by employee_id;

rollback;



create table emp(
    emp_id number constraint emp_pk primary key deferrable initially deferred,
    name varchar2(25)
);

select * from user_ind_columns
where table_name='EMP';

select * from user_indexes
where table_name='EMP';


alter table emp
disable constraint emp_pk;

create table emp_2(
    emp_id number constraint emp_pk2 primary key
);
alter table emp_2 
disable constraint emp_pk2;

select * from user_ind_columns
where table_name='EMP_2';


select * from session_privs;

SELECT * 
FROM USER_TAB_PRIVS;

drop table test;

create table test(
    name varchar2(50)
);

insert into test values('Lex De Haan');
insert into test values('Renske Ladwig');
insert into test values('Jose Manuel Urman');
insert into test values('Jason Mallin');



select * from test;

SELECT LPAD(SUBSTR(name, INSTR(name, ' ')),LENGTH(name),'*') "CUST NAME" FROM test WHERE INSTR(name, ' ',1,2)<>0;

select
    lpad(substr(name, instr(name,' ')),
    length(name),'*') "CUST NAME"
from test
where instr(name,' ',-1,2)<>0;

SELECT  LPAD(SUBSTR(name, INSTR (name, ' ')),
        LENGTH(name) - INSTR(name, ' '), '*') "CUST NAME" 
FROM test 
WHERE INSTR(name, ' ',1,-2)<>0;

SELECT  LPAD(SUBSTR(name, INSTR (name, ' ')),
        LENGTH(name) - INSTR(name, ' '), '*') "CUST NAME" 
FROM test 
WHERE INSTR(name, ' ',1,2)<>0;



select lpad('sameer', 4, '*')
from dual;


create user shavien identified by oracle;
grant create session to shavien;
grant create table to shavien;
grant unlimited tablespace to shavien;
grant create synonym to shavien;
grant create public synonym to shavien;


select count(all department_id)
from employees;

SELECT * FROM employees WHERE first_name BETWEEN 'A' AND 'C';

select *
from employees
where first_name >= 'A' and first_name<='C';

select *
from employees
where first_name like 'C%';

drop table emp_copy;
drop table dept_copy;

create table emp_copy
as select * from employees;


create table dept_copy
as select * from departments;

alter table dept_copy
add constraint dept_copy_pk primary key(department_id);

alter table emp_copy
add constraint emp_copy_pk primary key(employee_id);


alter table emp_copy
add constraint emp_dept_fk_copu foreign key(department_id) references dept_copy(department_id) 
on delete cascade;



truncate table dept_copy cascade;

select * from dept_copy;
select * from emp_copy;