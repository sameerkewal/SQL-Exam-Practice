--TBh idk what this is, maar ik heb niet altijd plek in me bestaande folders
--waar bepaalde dingen van die examen passen dus dan zal ik ze hier dumpen



--Use of rownum for some reason
select rownum, inlineview.department_id, inlineview.mysal   
from (select  department_id, 
              max(salary) as mysal
       from employees
       group by department_id
)inlineview;



select  employee_id, 
        first_name, 
        case when salary > (select avg(salary)
                            from employees
                            where department_id=40)

        then 'high'
        else 'low'
        end as uh
from employees;


select * from employees emp
natural join departments dept
using(department_id);


drop table test;
create table test(
    datum interval year to month
);

insert into test(datum) 
values(interval '20-10' year to month);

select *
from test;


CREATE TABLE CUSTOMERS(
CUSTNO NUMBER PRIMARY KEY,
CUSTNAME VARCHAR2(20),
CITY VARCHAR2(20));

INSERT INTO CUSTOMERS(CUSTNO, CUSTNAME, CITY) VALUES(1,'KING','SEATTLE');
INSERT INTO CUSTOMERS(CUSTNO, CUSTNAME, CITY) VALUES(2,'GREEN','BOSTON');
INSERT INTO CUSTOMERS(CUSTNO, CUSTNAME, CITY) VALUES(3,'KOCHAR','SEATTLE');
INSERT INTO CUSTOMERS(CUSTNO, CUSTNAME, CITY) VALUES(4,'SMITH','NEW YORK');


select c1.custname, c1.city
from customers c1 full outer join customers c2
on(c1.city=c2.city and c1.custname<>c2.custname);


select dept.department_id
from employees emp
join departments dept
using(department_id);


select * from v$nls_parameters;


drop table test;
create table test(
    datum date
);


create index test_idx on test(datum desc);

insert into test values(sysdate);
insert into test values(null);


select nvl2('test', datum+15,'')
from test;

select nvl2('dk',2, null)
from dual;



select * 
from employees emp
where emp.first_name='Steven'
natural join departments dept;

select * 
from employees emp
where first_name='Steven'
join departments dept
on emp.department_id=dept.department_id;


--Onderzoek dit ffs
update(select first_name from copy_emp)
set first_name = null;



select  to_char((sysdate+'90'), 'hh24:mi:ss'),
        to_char(trunc(sysdate+'90'), 'hh24:mi:ss')
from dual;

show recyclebin;


--A
select to_char(to_number('$1,234.55', '$999,999.99')* . 25, '$999,999.00')
from dual;


select to_number('$20,000', '$99,999')
from dual;

--C
select to_char((to_number('11234.55', '999,999.99')*.25), '$999,999.00')
from dual;



select first_name, avg(salary)
from employees
where first_name='Steven'
group by first_name
order by first_name;


create table emp_copy
as select *
from employees;


insert into emp_copy values
(200, 'Sameer', 'Kewal', 'skewal', '115', sysdate, 'AD_PRES', 12, null, null, null);


create table test(
    jdjdjd num
);

delete from emp_copy;

create table dept_copy(
    department_id,
    department_name
) as
select department_id from departments;

select *
from emp_copy;

rollback;


select dbtimezone from dual;
select sessiontimezone from dual;

select *
from employees;



select substr('sameer', null, 1)
from dual;

select instr('sameer', 'b', 1)
from dual;

select substr('shavien', 7, 1)
from dual;


select 2
from dual d1
cross join dual d2
cross join dual d3;

select 2
from employees;

select *
from dual;

select *
from employees
where salary = &&sal
or salary = &sal*2;


select *
from dictionary
where table_name='SESSION_PRIVS';


select to_number(to_char(sysdate, 'ddmmyyyy'))
from dual;



create index test_idx2 on copy_emp(first_name);
create unique index test_idx22 on copy_emp(first_name);


drop table test;

create table test(
    test_name varchar2(20)
);

insert into (select * from test)values('test_name');


select distinct first_name
from employees
order by salary;


select department_id, max(distinct salary)
from employees
group by department_id
order by max(all salary);

select *
from employees emp
join departments dept
using(department_id)
where dept.department_id>0;


drop table copy_emp;

create table copy_emp
as
select *
from employees;


alter table copy_emp
modify first_name constraint fn_nn not null;

select *
from user_constraints
where table_name='COPY_EMP';


drop table test;

create table test(
    test_id number constraint test_nn not null
);

select *
from user_constraints
where table_name='TEST';


select  first_name,
        last_name
from copy_emp
where department_id in(
    (select department_id
    from departments
    where department_id= 40
    ),
    (select department_id
    from departments
    where department_id = 90)
);

select  employee_id, 
        first_name
from employees
union
select  '1000',
        first_name
from employees;


select *
from hr.employees e1
where e1.employee_id =
(select min(e2.employee_id)
from hr.employees e2);

select *
from hr.employees e1
where
(select min(e2.employee_id)
from hr.employees e2) =
e1.employee_id;


-- ORA-01776: cannot modify more than one base table through a join view
insert into 
(select department_id, department_name, manager_id, loc.location_id from copy_dept dept
join
locations loc on loc.location_id=dept.location_id)
values(1000, 'Construction2', null, null);


insert into(
select  department_id, 
        department_name, 
        manager_id, 
        location_id 
from copy_dept 
where department_id=0
)
values(1009, 'Construction99', null, null);



select *
from copy_dept;


select *
from employees
where employee_id not in(
    select test_s.currval from dual
);


select *
from employees emp
join departments dept 
on emp.department_id=dept.department_id
and salary>0;

select *
from employees emp
join departments dept 
on emp.department_id=dept.department_id
where salary>0;




select sysdate-'20-MAY-02'
from dual;


drop table dept;

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


CREATE OR REPLACE VIEW v_emp AS
SELECT e.empno, e.ename, d.loc FROM emp e, dept d WHERE d.deptno = e.deptno;

delete from v_emp where loc='Dallas';

select *
from v_emp;



alter table dept
add constraint dept_pk2 primary key(deptno);

alter table emp
add constraint emp_pk3 primary key(empno);


alter table emp
add constraint emp_fk3 foreign key(deptno) references dept(deptno);









create table a(
    id char(1),
    val number
);

create table b(
    id char(1),
    val number
);



insert into a values('A', 10);
insert into a values('B', 20);
insert into a values('C', 30);
insert into a values('C', 30);


insert into B values('B', 20);
insert into B values('C', 30);
insert into B values('D', 50);

select val
from a
union all
select val
from b;




select employee_id, first_name "name", last_name "lname"
from employees
union
select department_id, 'test' "test", department_name "deptname"
from departments
order by 2, last_name;


select employee_id, first_name "name", last_name "lname"
from employees
order by 2, last_name;



select 1, 'John' as first_name
from dual
union
select 1 as id, 'John' as name
from dual;

select 1, 'John' as first_name
from dual
union all
select 1 as id, 'John' as name
from dual;



select 1
from dual;


select 1
from employees;