select * from EMPLOYEES;
select FIRST_NAME from EMPLOYEES;

rollback;

commit;
select ROWNUM, FIRST_NAME from EMPLOYEES;




--------------Complex Views------------------



--In een view moet je die group functions namen
--complex view bc group functions
create or replace view emp_dept_analysis
AS
select DEPARTMENT_ID, count(EMPLOYEE_ID) as emp_count,
max(SALARY) as max_sal, 
min(SALARY) as min_sal
from EMPLOYEES
group by DEPARTMENT_ID;

select * from emp_dept_analysis;



--Complex view bc data from more tables
--Alle functions namen I suppose
create or replace view emp_dept_vw
as
select EMPLOYEE_ID, FIRST_NAME || LAST_NAME name, SALARY, nvl(DEPARTMENT_NAME, 'No dept') as dept_name
from EMPLOYEES e left join DEPARTMENTS dept
on e.DEPARTMENT_ID=dept.DEPARTMENT_ID;

select * from emp_dept_vw;




--WOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOH
drop view emp_v1;
create view EMP_V1(
    FNAME,
    LNAME,
    dept_id,
    CONSTRAINT fk_emp_deptid FOREIGN KEY (dept_id) REFERENCES departments(DEPARTMENT_ID) disable
)
as select FIRST_NAME, LAST_NAME, DEPARTMENT_ID from EMPLOYEES;



--Creating views as read only
create or replace view emp_vw_read
AS
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
from EMPLOYEES
where DEPARTMENT_id=90
with read only;


select * from emp_vw_read;

--Kan dan obviously niet
delete from emp_vw_read;


--So basically you put a constraint on the view
--die O in constraint type betekent read Only 
select * from user_constraints where table_name='EMP_VW_READ';


--Create view with check option
--this means that you can only make DML operations in the scope of the range of this query
create table emp_copy AS
select * from EMPLOYEES;

create or replace view emp_vw_chq_option
AS
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
, DEPARTMENT_ID
from emp_copy
where DEPARTMENT_ID=90
with check option;


--V voor die check option I suppose
select * from USER_CONSTRAINTS WHERE table_name='EMP_VW_CHQ_OPTION';


--You can only make operations within this scope(I think basically zolang hetv voldoet aan die 
--where statement in je original view creation query)
select * from emp_vw_chq_option;


--Als je update wilt doen kan het alleen voor die results van die query
update emp_vw_chq_option set FIRST_NAME='200' where DEPARTMENT_ID=90;


--DIT GAAT DUS NIET
update emp_vw_chq_option set DEPARTMENT_ID=100 where DEPARTMENT_ID=90;

--Ook bij inserts gaat het whacky doen(dit gaat niet:)
insert into EMP_VW_CHQ_OPTION(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, DEPARTMENT_ID)
                            values(444, 'Sameer', 'Kewal', 'skewal', sysdate, 'IT_PROG', 100);

--Dit gaat wel
insert into EMP_VW_CHQ_OPTION(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, DEPARTMENT_ID)
                            values(444, 'Sameer', 'Kewal', 'skewal', sysdate, 'IT_PROG', 90);


select * from EMP_COPY where DEPARTMENT_ID=90;





-----Force View


--So basically als je force clause specified, even if the tables from which you are selecting it will
--create anyways


--success with compilation error
create or replace force view test_force_vw
as select test from jrx;

--If you try to select from it, it will tell you that the view has errors
select * from test_force_vw;


--NOW WE CREATE THE TABLE
create table jrx(
    test number default 0 constraint jrx_pk primary key
);

--And when we select now it will easily go!
INSERT into jrx values(2);
select * from test_force_vw;


alter view  test_force_vw compile;

select * from user_views where view_name='TEST_FORCE_VW';
