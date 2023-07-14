select EMPLOYEE_ID, HIRE_DATE, SALARY, MANAGER_ID
from EMPLOYEES;

drop table sal_hist;
drop table MANAGER_HIST;

create table sal_hist(
    empid number,
    HIREDATE date,
    SALARY number,
    MGR     number
);

create table manager_hist(
    empid number,
    HIREDATE DATE,
    SALARY number,
    mgr number
);


--die values die je hebt tussenhaakjes na keyword value haal je uit je subquery
-----------Unconditional Insert-----------------
insert all 
into SAL_HIST(empid, HIREDATE, salary)values(EMPLOYEE_ID, HIRE_DATE, SALARY)
into MANAGER_HIST(empid, HIREDATE, mgr)values(EMPLOYEE_ID, HIRE_DATE, MANAGER_ID)
select EMPLOYEE_ID, HIRE_DATE, SALARY, MANAGER_ID from EMPLOYEES;


select * from SAL_HIST;
select * from MANAGER_HIST;

delete from SAL_HIST;
delete from MANAGER_HIST;
commit;


--this looks messy but point is je mag aliasses gebruiken
insert all
into EMP_COPY(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, MANAGER_ID, DEPARTMENT_ID) 
			values(78, fname1, lname1, mail1, number1, hiredate1, jid1, slry1, cmt1, mgrid1)
select FIRST_NAME as fname1, LAST_NAME as lname1, EMAIL as mail1, PHONE_NUMBER as number1, HIRE_DATE as hiredate1, JOB_ID as jid1,
SALARY as slry1, COMMISSION_PCT as cmt1, MANAGER_ID as mgrid1
from EMPLOYEES where EMPLOYEE_ID=101;


-------------Conditional Insert----------------------



--when from the subquery the salary is bigger than 9000 then insert into sal_hist
--for the 2nd insert we look at the manager_id. When the manager_id is not null then insert into manager_hist table
--Bij insert all vergelijkt het 1 row met elke condition. bv
--je kijkt eerst "is het salaris groter dan 9000? yes okay dan insert het into sal_hist. Vervolgens kijk je voor hetzelfde row
--naar de volgende condition which is manager_id is not null. Is it not null then you insert into manager_hist"
insert ALL
when salary>9000 then
into sal_hist(EMPID, HIREDATE, SALARY, mgr)values(EMPLOYEE_ID, HIRE_DATE, SALARY, MANAGER_ID)
when MANAGER_ID is not null then
into MANAGER_HIST(empid, HIREDATE, salary, mgr)values(EMPLOYEE_ID, HIRE_DATE, SALARY, MANAGER_ID)
select EMPLOYEE_ID, HIRE_DATE, salary, MANAGER_ID from EMPLOYEES;

delete from SAL_HIST;
delete from MANAGER_HIST;

select * from SAL_HIST;

select * from MANAGER_HIST;

select EMPID from SAL_HIST
INTERSECT
select empid from MANAGER_HIST;


commit;


-----------------------Insert First------------------

--Verschil is dat bij insert all het elke row evaluate for elke condition, terwijl bij insert first het alleen gaat tot
--die statement waarbij het true hits and then skips all subsequent evaluations
--dus in dit geval ziet het bv dat salary meer dan 3000 is voor een specific row is en dan insert het 
--Doesn't even look at the other evaluation van waar manager_id not null is
insert FIRST
when SALARY>6000 then
into SAL_HIST(empid, HIREDATE, SALARY, MGR)values(EMPLOYEE_ID, HIRE_DATE, SALARY, MANAGER_ID)
when MANAGER_ID is not null then
into MANAGER_HIST(empid, HIREDATE, SALARY, MGR)values(EMPLOYEE_ID, HIRE_DATE, SALARY, MANAGER_ID)
select EMPLOYEE_ID, HIRE_DATE, SALARY, MANAGER_ID
from EMPLOYEES;
commit;



select * from manager_hist;





--------------------------Insert All More Examples---------------------
create table emp_sales(
    emp_id number,
    week_id number,
    sales_sun number,
    sales_mon number,
    sales_tue number,
    sales_wed number,
    sales_thur number
);

insert into emp_sales(EMP_ID, WEEK_ID, SALES_SUN, SALES_MON, SALES_TUE, SALES_WED, SALES_THUR)
            VALUES   (1, 14, 2000, 3000, 4000, 2500, 1500);

select * from EMP_SALES;


create table sales_info(
    emp_id number,
    week_id number,
    sales number,
    day varchar2(10)
);


insert all 
into sales_info(EMP_ID, WEEK_ID, SALES, day)values(emp_id, WEEK_ID, SALES_SUN, 'Sun')
into sales_info(EMP_ID, WEEK_ID, SALES, DAY)values(EMP_ID, WEEK_ID, SALES_MON, 'Mon')
into sales_info(EMP_ID, WEEK_ID, sales, day)values(emp_id, WEEK_ID, sales_tue, 'Tue')
into sales_info(emp_id, WEEK_ID, sales, day)values(EMP_ID, week_id, SALES_WED, 'Wed')
into sales_info(EMP_ID, WEEK_ID, sales, day)values(EMP_ID, WEEK_ID, SALES_THUR, 'Thu')
select EMP_ID, WEEK_ID, sales_sun, sales_mon, SALES_TUE, SALES_WED, SALES_THUR
from emp_sales;


select * from SALES_INFO;






--------------------------------Pivot(idt we need to know this tbh)-----------------------------
select DEPARTMENT_ID, JOB_ID, count(1)
from EMPLOYEES
where JOB_ID in('MK_MAN', 'MK_REP', 'PU_CLERK', 'PU_MAN')
group by DEPARTMENT_ID, JOB_ID
order by 1, 2;


select * from(
    select DEPARTMENT_ID, JOB_ID
    from EMPLOYEES
    where JOB_ID in('MK_MAN', 'MK_REP', 'PU_CLERK', 'PU_MAN')
)
pivot
(
    count(1) for job_id in('MK_MAN', 'MK_REP', 'PU_CLERK', 'PU_MAN')
)
order by 1;



--Wihout the where clause it will also work
select * from(
    select DEPARTMENT_ID, JOB_ID
    from EMPLOYEES
)
PIVOT(
    count(1) for job_id in ('MK_MAN', 'MK_REP', 'PU_CLERK', 'PU_MAN')
)
order by 1;


--YOu can't use a subquery it won't work
select * from(
    select DEPARTMENT_ID, job_id
    from EMPLOYEES
)
pivot(
    count(1) for job_id in (select distinct JOB_ID from EMPLOYEES)
)
order by 1;


select * from(
    select DEPARTMENT_ID, JOB_ID, HIRE_DATE
    from EMPLOYEES
    where JOB_ID in ('MK_MAN', 'MK_REP', 'PU_CLERK', 'PU_MAN')
)
pivot(
    count(1) for job_id in ('MK_MAN', 'MK_REP', 'PU_CLERK', 'PU_MAN')
)
order by 1;



create table table_a(
    id NUMBER,
    name varchar2(100)
);

insert into table_a values(1, 'Khalid');
insert into table_a values(2, 'ali');
insert into table_a values(3, 'ahmed');
insert into table_a values(4, 'sameer');

select * from table_a;


create table table_b(
    id number,
    name varchar2(20)
);


insert into table_b values(1, 'xxxxx');
insert into table_b values(2, 'xxxxx');

select * from table_b;
commit;


merge into table_b b 
using(select * from table_a) a
on (b.id=a.id)
when matched then
update set b.name=a.name
when not matched then
insert values(a.id, a.name);

select * from TABLE_B;


delete from TABLE_A;
delete from table_b;

merge into table_b b
using (select * from table_a)a
on(b.id=a.id)
when matched then
update set b.name=a.name
when not matched then
insert values(a.id, a.name);

--Je mag geen gebruik maken van table prefixes, only Aliases allowed
merge into table_b
using(select * from table_a)
on(table_a.id=table_b.id)
when matched then
update set b.name=a.name
when not matched then
insert values(a.id, a.name);



merge into TABLE_B b 
using(select * from table_a)a
on(a.id=b.id)
when matched THEN
update set b.name=a.name
when not matched then
insert values(a.id, a.name);


--Testing it out with delete
select * from table_a;
select * from table_b;



--Specify the DELETE where_clause to clean up data in a table while populating or updating it. 
--The only rows affected by this clause are those rows in the destination table that are updated by the merge operation. 
--The DELETE WHERE condition evaluates the updated 
--value, not the original value that was evaluated by the UPDATE SET ... WHERE condition.
merge into table_b b
using(select * from table_a)a
on(a.id=b.id)
when matched then
update set b.name='HI'
delete where b.name='HI';



--Dit kan niet je kan het alleen bij een update doen
merge into table_b b
using(select * from table_a)a
on(a.id=b.id)
when not matched then
insert values(1, 'test')
delete where b.name='test';


--like this
--btw je delete moet een **where** clause hebben
merge into table_b b
using(select * from TABLE_A)a
on(a.id=b.id)
when matched THEN
update set b.name='test'
delete where b.name='test'
when not matched THEN


------Dit kan absolutely niet------
------Je delete moet samen zijn met een update, omdat het een soort van cleanup is------
merge into table_b b 
using(select * from TABLE_A)a
on(a.id=b.id)
when matched THEN
delete where b.name=a.name;


rollback;

select *
from TABLE_B;
select *
from TABLE_A;



merge into table_b b 
using(select * from TABLE_A)a
on(a.id=b.id)
when not matched then
insert values(a.id, a.name);

rollback;

--Hoe the fuck kan dit niet this shit makes 0 sense
merge into table_b b 
using(select * from TABLE_A)A
on(a.id=b.id)
when matched then
insert(id, name) values(a.id, a.name);


----
merge into table_b b 
using(select id from TABLE_A)A
on(a.id=b.id)
when not matched then
insert values(20, 'test');

select * from TABLE_A;
select * from TABLE_B;



merge into table_b b
using(select id from TABLE_A)A
on(a.id=b.id)
when  not matched THEN
insert values(20, 'hi')
delete where b.name='hi';



--Bij een not matched kan je niet updaten nor deleten
merge into table_b b
using(select id from TABLE_A)A
on(a.id=b.id)
when not  matched THEN
update set b.name='Hi';

--Maar kan je inserten en dan deleten na je inserten?
--Nope alleen na het updaten apparently 
merge into table_b b
using(select id, name from table_a)a 
on(a.id=b.id)
when not matched THEN
    insert(id, name)
    values(5, 'test')
    delete where b.name='test';

select * from table_a;
select * from table_b;
rollback;

--je kan alleen columns in je where clause hebben, die komen uit de using clause(source table)
--cannot reference the target table in the where clause
merge into EMP_COPY a
using(select * from EMPLOYEES) b
on(a.employee_id = b.employee_id)
when not matched then
    insert(a.EMPLOYEE_ID, a.FIRST_NAME, a.LAST_NAME, a.EMAIL, a.PHONE_NUMBER, a.HIRE_DATE, a.JOB_ID, a.salary, a.COMMISSION_PCT, a.MANAGER_ID, a.department_id)
    values(b.employee_id, b.FIRST_NAME, b.LAST_NAME, b.EMAIL, b.PHONE_NUMBER, b.HIRE_DATE, b.JOB_ID, b.salary, b.COMMISSION_PCT, b.manager_id, b.department_id)
where a.employee_id>100;