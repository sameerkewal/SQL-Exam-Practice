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