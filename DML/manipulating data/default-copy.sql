

create table emp_default(
    empno number,
    ename varchar2(200),
    status varchar2(100) default 'Active'
);

--If you dont mention the value in the insert it will insert as its default value(in this case 'Active')

insert into emp_default(empno, ename)values(1, 'David');

select * from EMP_DEFAULT;


--YOU CAN DO THIS WTF
insert into emp_default(empno, ENAME, status)values(2, 'Steve', DEFAULT);


--Je mag wel null zetten and it will work
insert into emp_default(empno, ename, status)values(3, 'Sameer', null);

select * from EMP_DEFAULT;


--je kan keyword "default" ook gebruiken in je update statement, zoals volgt:
update EMP_DEFAULT set status=default where EMPNO=3;

--Deze mogen **niet**
delete from EMP_DEFAULT where status=default;
select * from EMP_DEFAULT where status=default;


--**practice**
insert into EMP_DEFAULT(empno, ENAME, status)values(5, 'Jen', default);
insert into emp_default(empno, ename, status)values(6, 'Jasmine', null);
insert into EMP_DEFAULT(empno, ename, status)values(7, 'Claire', 'Inactive');

select * from EMP_DEFAULT;

update EMP_DEFAULT set status=default where empno=6;


--------------------------Copy Rows from Another Table----------------------------------

insert into emp_default(EMPNO, ename)
select EMPLOYEE_ID, FIRST_NAME
from EMPLOYEES
where DEPARTMENT_ID=100;
commit;

insert into EMP_DEFAULT(empno, ename)
select EMPLOYEE_ID, FIRST_NAME
from EMPLOYEES
where DEPARTMENT_ID=30;


select * from EMP_DEFAULT;


--You can also sth like an union/union all/minus/intersect
insert into EMP_DEFAULT(EMPNO, ename)
select EMPLOYEE_ID, FIRST_NAME
from EMPLOYEES
where DEPARTMENT_ID=40
UNION
SELECT EMPLOYEE_ID, FIRST_NAME
from EMPLOYEES
where DEPARTMENT_ID=80;