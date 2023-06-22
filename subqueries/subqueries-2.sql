---------------Using Subquery as a source table------------------------

select loc.LOCATION_ID, city
from locations loc;



select DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID
from DEPARTMENTS;

--Ik neem de eerste query and gebruik dat nu als de source
select dept.DEPARTMENT_ID, dept.DEPARTMENT_NAME, loc.city
from DEPARTMENTS dept, 
(select LOCATION_ID, loc.CITY from locations loc) loc--deze subquery noemen we inline view
where loc.LOCATION_ID=dept.LOCATION_ID;


--Well dit werkt niet. Wat kon in je exists function, kan hier niet
select *
from DEPARTMENTS dept, 
(select 1 from locations loc)loc
where loc.location_id=dept.LOCATION_ID;


--Dit werkt wel, alhoewel je geen autocomplete or sth krijgt hier(so you're better off including everything u want specifically)
select dept.DEPARTMENT_ID, dept.DEPARTMENT_NAME, loc.city
from DEPARTMENTS dept,
(select * from locations loc)loc
where loc.location_id=dept.LOCATION_ID;


create table student
( student_id number primary key,
  student_name varchar2(100)
);

insert into student values (1,'ahmed ali');
insert into student values (2,'ammer jamal');
insert into student values (3,'sara nayef');
commit;


create table student_major
( term varchar2(6),
  student_id number,
  major varchar2(100),
  constraint student_major_pk primary key (term,student_id),
  constraint student_major_fk1 foreign key (student_id) references student (student_id)
);


insert into student_major values (201401,1,'IT');
insert into student_major values (201402,1,'Computer Science');
insert into student_major values (201401,2,'Accounting');
insert into student_major values (201402,2,'Accounting');
insert into student_major values (201401,3,'Markiting');
insert into student_major values (201402,3,'Markiting');
insert into student_major values (201403,3,'Adminstration');
commit;

--Je select de max term voor elke student in je student_major table
select STUDENT_ID, term, major from STUDENT_MAJOR s where term=(
    select max(sm.term)from STUDENT_MAJOR sm where sm.STUDENT_ID=s.student_id
);

select st.STUDENT_ID, ST.STUDENT_NAME, ST_MAJOR.TERM
from student st,
(select student_id, term, major
from student_major a where term=(
    select max(b.term)from STUDENT_MAJOR b where b.STUDENT_ID=a.student_id
)) st_major where ST_MAJOR.student_id=st.STUDENT_ID;



select *
from STUDENT_MAJOR a where term=(select max(term) from STUDENT_MAJOR b where a.student_id=b.STUDENT_ID);



select *
from student st, (select *
                    from student_major a 
                    where term =(select max(term) from STUDENT_MAJOR b where a.student_id=b.STUDENT_ID)) sm
where sm.student_id=st.student_id;



-----------------------------Pairwise/Non Pairwise subqueries------------------------------
select *
from EMPLOYEES
where FIRST_NAME='John';


select *
from EMPLOYEES
where MANAGER_ID=108 and DEPARTMENT_ID=100 and FIRST_NAME<>'John'
union ALL
select * from employees
where MANAGER_ID=100 and DEPARTMENT_ID=80 and FIRST_NAME<>'John'
union all
select * from EMPLOYEES
where MANAGER_ID=123 and DEPARTMENT_ID=50 and FIRST_NAME<>'John';


/*  Display the details for the employees who are managed by the same manager and work in the same department as the employees
    with the first name of John*/

--Holy shit?
--dus basically die subquery gaat like een lijst retrieven met die manager_id and department_id and dan gaat die
--main query dat matchen with the same manager_id in the list and same department_id also ofcourse
select * from EMPLOYEES where(MANAGER_ID, DEPARTMENT_ID) in (select MANAGER_ID, DEPARTMENT_ID
                                                            from EMPLOYEES
                                                            where FIRST_NAME='John')
                        and FIRST_NAME<>'John';


/*display the details of the employees who are managed by the same manager as the employees with first name of John
and work in the department as employees with FIRST_NAME of John*/

select *
from EMPLOYEES where MANAGER_ID in(108, 100, 123)
and DEPARTMENT_ID in (100, 80, 50)
and FIRST_NAME<>'John';

--In dit geval is er geen comparison tussen 2 kolumns
select * from EMPLOYEES
where MANAGER_ID in (select MANAGER_ID from EMPLOYEES where FIRST_NAME ='John')
and DEPARTMENT_ID in (select DEPARTMENT_ID from EMPLOYEES where FIRST_NAME='John')
and FIRST_NAME<>'John';










------------------------Scalar Subquery/Correlated Subquery--------------------------------

--Scalar subquery is a subquery that returns exactly one column value from every row
select EMP.FIRST_NAME, EMP.LAST_NAME, EMP.SALARY, (select max(salary) from employees) as max_sal
from EMPLOYEES emp;




--We want to display the department name also in the query using subquery
--This is a scalar subquery but also a correlated subquery at the same time
--Correlated subquery: subquery references a column in the parent query
/*Bv voor Steven kan je het zien als: "select employee_id, first_name, last_name, department_id
,(select department_name from DEPARTMENTS b where b.department_id=90) "*/ 
--Yk omdat zn department_id 90 is. Vergelijkbaar met een join

select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID,
    (select DEPARTMENT_NAME from departments b where b.department_id=e.DEPARTMENT_ID)
from EMPLOYEES e;



--Unlike bij een join(not in case of an outer join ofc) komen die null values hier *wel*
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, E.DEPARTMENT_ID,
    (select DEPARTMENT_NAME from DEPARTMENTS dep where dep.DEPARTMENT_ID=20)
from EMPLOYEES e;

--Als je null ofzo passed of als die values niet matchen dan gaat die department_name gewoon displayen als null
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, e.DEPARTMENT_ID,
    (select DEPARTMENT_NAME from departments dep where dep.DEPARTMENT_ID=null)
from EMPLOYEES e;



--Zo je kan ook functions hierop gebruiken such as nvl:
--Remember the rules of nvl in this case vindt er implicit conversion plaats
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, e.department_id,
    nvl((select DEPARTMENT_NAME from DEPARTMENTS dep where dep.department_id=e.DEPARTMENT_ID), 'No department!')
from EMPLOYEES e;

--JE MAG MAAR 1 column HIER RETRIEVEN, ANDERS MOET JE EEN VOLGENDE scalar subquery schrijven, can't just retrieve 2 columns with one subquery
--This does not work
select EMPLOYEE_ID, FIRST_NAME, SALARY,
    (select job_title, J.MIN_SALARY from jobs j where j.JOB_ID=e.JOB_ID)
from EMPLOYEES e;

--zoals hier!
select EMPLOYEE_ID, FIRST_NAME, SALARY,
    (select JOB_TITLE from jobs j where j.JOB_ID=e.JOB_ID),
    (select min_salary from jobs j where j.JOB_ID=e.JOB_ID)
from EMPLOYEES e;


--Find the employee who makes more than what the average salary in their department is
select DEPARTMENT_ID, avg(SALARY)
from EMPLOYEES
group by DEPARTMENT_ID;

select *
from EMPLOYEES
where DEPARTMENT_ID=100 and salary>8609;

--Answer:
select E.FIRST_NAME, E.DEPARTMENT_ID, E.SALARY,
    (select avg(salary) from EMPLOYEES b where b.DEPARTMENT_ID=e.department_id group by b.DEPARTMENT_ID )
from EMPLOYEES e
where e.SALARY>(select avg(salary) from EMPLOYEES b where b.DEPARTMENT_ID=e.department_id group by b.DEPARTMENT_ID);




---------------------Exists and not exists Part 2-------------------------------
select * from DEPARTMENTS d where exists(select 1 from EMPLOYEES e where e.DEPARTMENT_ID=d.DEPARTMENT_ID);


--In(bad practice due to performance reasons):
select * from DEPARTMENTS d 
where d.DEPARTMENT_ID in(select department_id from EMPLOYEES);

--Display all the departments that have no employees:
select * from departments d
where not exists(select emp.department_id from employees emp where emp.DEPARTMENT_ID=d.DEPARTMENT_ID);



--Just to reiterate, als je null values hebt bij je IN condition dan is het alleen een probleem bij not in.
--Bij in it just ignores your null values
select * from departments dep 
where DEP.DEPARTMENT_ID not in(select emp.department_id from EMPLOYEES emp);





----------------------With clause-----------------------------
--Die emp kan je zien als een variabel and you store the result of that query in it
--Je main query(onderste line)gaat beginnen te lezen van boven
with emp 
as(
    select employee_id, first_name from employees
)
select first_name from emp;

--This totally works. 
with emp
as(
    select employee_id, first_name, last_name, department_name from employees emp join departments dep on emp.department_id=dep.department_id
)
select department_name from emp;



--Als je je kolumn niet specified in je subquery select statement dan kan je het for some reason niet accessen in the outer query
--So this query will not work at all
with emp
as(
    select * from employees join departments dep on dep.DEPARTMENT_ID=EMPLOYEES.DEPARTMENT_ID
)
select DEPARTMENT_ID from emp;


--If you specify the column then it will work
with emp
as(
    select EMP.FIRST_NAME, EMP.LAST_NAME, DEP.DEPARTMENT_ID, DEP.DEPARTMENT_NAME from employees emp join departments dep on dep.department_id=emp.department_id
)
select department_id from emp;


--Je mag ook aliases gebruiken when accessing values from your inner query
with test
as(
    select emp.first_name, emp.last_name, dep.department_name from employees emp join departments dep on emp.department_id=dep.department_id
)
select test.department_name from test;


--Als die kolumn 2 keer voorkomt in die subquery dan kan je het niet gewoon accessen in je main query, anders krijg je column 
--ambiguously defined error
with test
as(
    select emp.first_name, emp.last_name, dep.department_name, emp.DEPARTMENT_ID, dep.DEPARTMENT_ID from employees emp join departments dep on emp.department_id=dep.department_id
)
select test.department_id from test;

--TENZIJ JE OFC EEN COLUMN ALIAS GEBRUIKT
with test
as(
    select emp.first_name, dept.department_name, emp.department_id as dept_id, dept.department_id from employees emp join departments dept on emp.DEPARTMENT_ID=dept.department_id
)
select test.dept_id from test;


--Je kan 2 subqueries hebben:
--Die tweede subquery kan selecteren uit de eerste subquery
--The main query is pulling info out the 2nd query
with emp 
as (
    select first_name, department_id, salary from employees
),
dept_sum_sal as (
    select department_id, sum(salary)sum_sal from emp group by DEPARTMENT_ID
)
select * from dept_sum_sal;



/*Display each department_name and count for the employees */
select DEPARTMENT_ID, count(*)
from EMPLOYEES group by DEPARTMENT_ID
order by DEPARTMENT_ID;

--Dit select die count van elke department aantal employees and then joins the department_name on it
with dept_count
as(
    select department_id, count(1) as cnt
    from employees 
    group by department_id
    order by department_id
) select DEPARTMENT_NAME , dept_count.cnt from DEPARTMENTS dep, dept_count
where dep.DEPARTMENT_ID=dept_count.department_id;


--I think this is using subquery as a table source
select department_name, dept_count.cnt from departments dep, (select department_id, count(1) as cnt
    from employees 
    group by department_id
    order by department_id)dept_count
where dept_count.department_id=dep.DEPARTMENT_ID;


with dept_count 
as (
    select department_id, count(1) as cnt
    from employees
    group by department_id
    order by department_id
)
select dept.DEPARTMENT_ID, dept_count.cnt from DEPARTMENTS dept, dept_count where dept.DEPARTMENT_ID=dept_count.department_id;



--Write a query to display the department_name and total salaries for the department
--but only for the departments whose salaries is greater than the average salary across departments


--De sum van elke departments salaris
select DEPARTMENT_NAME, sum(salary)sum_sal
from EMPLOYEES e
join DEPARTMENTS dep on e.DEPARTMENT_ID=dep.DEPARTMENT_ID
group by DEP.DEPARTMENT_NAME;


--De average van alle departments
select sum(sum_sal)/count(*)
from (select DEPARTMENT_NAME, sum(salary)sum_sal
from EMPLOYEES e
join DEPARTMENTS dep on e.DEPARTMENT_ID=dep.DEPARTMENT_ID
group by DEP.DEPARTMENT_NAME);

--Department name and total salaries where total salary bigger than avg salary across all departments
SELECT e.department_Id, dep.department_name,sum(salary)
from (select sum(sum_sal)/count(*) as avg
from (select DEPARTMENT_NAME, sum(salary)sum_sal
from EMPLOYEES e
join DEPARTMENTS dep on e.DEPARTMENT_ID=dep.DEPARTMENT_ID
group by DEP.DEPARTMENT_NAME)), employees e join departments dep on e.department_id=dep.department_Id
group by e.department_Id, dep.department_name
having sum(salary)>(select sum(sum_sal)/count(*) as avg
from (select DEPARTMENT_NAME, sum(salary)sum_sal
from EMPLOYEES e
join DEPARTMENTS dep on e.DEPARTMENT_ID=dep.DEPARTMENT_ID
group by DEP.DEPARTMENT_NAME));





with avg_all
as (
    select department_name, sum(salary)sum_sal from employees emp join departments dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID group by DEP.DEPARTMENT_NAME
),
avged as (
    select sum(sum_sal)/count(*) as avg_sal from avg_all
),
test as (
    select department_name, sum(salary) from EMPLOYEES emp join departments dep on dep.DEPARTMENT_ID=emp.DEPARTMENT_ID
    group by DEP.DEPARTMENT_NAME
    having sum(salary)>(select * from avged)
)
select * from test; 

--Mooier
with avg_all
as (
    select department_name, sum(salary)sum_sal from employees emp join departments dep on emp.DEPARTMENT_ID=dep.DEPARTMENT_ID group by DEP.DEPARTMENT_NAME
),
avged as (
    select sum(sum_sal)/count(*) as avg_sal from avg_all
),
test as (
    select department_name, sum_sal from avg_all
    where sum_sal>(select * from avged)
)
select * from test; 






