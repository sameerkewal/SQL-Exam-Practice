select *
from COPY_EMP
where EMPLOYEE_ID in(200, 201);


select * from DEPT_COPY;


update COPY_EMP
set SALARY=SALARY+100
where EMPLOYEE_ID=200;


update COPY_EMP
set SALARY=SALARY+50
where EMPLOYEE_ID=201;


insert into DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
            VALUES      (1, 'Administration 2', 200, 1700);


--Commit
--Woops accidentally committed into the real departments table instead of the department copy table
--Now when i commit all of the 3 statements will be committed(no posibility to rollback to the state before that)
commit;


select *
from COPY_EMP
where EMPLOYEE_ID in(200, 201);


select * from DEPARTMENTS where DEPARTMENT_ID=1;




----------------------------DML statements and then rolling back-------------------------
delete from DEPARTMENTS where DEPARTMENT_ID=1;

delete from COPY_EMP where EMPLOYEE_ID=100; 

--Als je nu queried kan je die records niet terugvinden 
select * from COPY_EMP order by EMPLOYEE_ID;

select * from COPY_EMP
where EMPLOYEE_ID=100;

--Rollback time:
rollback;


--Als je dit weer queried dan vind je het terug YIPPEEEE
select * from COPY_EMP
where EMPLOYEE_ID=100;


--statement level rollback. Bij delete from departments gaat die statement failen
--want er zijn child rows in emp table which depend on it. In dat geval opened sql in memory een cursor en delete het tot het failed,
--dus waar het een record vind die een child heeft in other table. In dat geval rolled hij die statement specifically terug 
--NOT THE WHOLE TRANSACTION JUST THAT STATEMENT
--Dat is een statement level rollback   

select * from COPY_EMP
where EMPLOYEE_ID in(106, 107);

delete from COPY_EMP
where EMPLOYEE_ID=106;

delete from DEPARTMENTS;

delete from COPY_EMP
where EMPLOYEE_ID=107;


rollback;



--Next case: automatic commit 
insert into DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
            VALUES      (1000, 'Dept 1', 200, 1700);


insert into DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
            VALUES      (1001, 'Dept 2', 200, 1700);

--Tot en met hier i didnt do any commit or rollback


--Maar hier omdat je een DDL statement execute is er sprake van automatic commit
create table test_table(
    emp_id number,
    name varchar2(20)
);

rollback;

--it still exists despite rolling back bc the ddl statement made it automatically commit
select * from DEPARTMENTS
where DEPARTMENT_ID in (1000, 1001);









----------------------------Savepoints------------------------


select * from COPY_EMP
where EMPLOYEE_ID=108;

update COPY_EMP
set salary=salary+10
where EMPLOYEE_ID=108;


SAVEPOINT a;


select * from COPY_EMP
where EMPLOYEE_ID=108;


update COPY_EMP
set salary=salary+20
where EMPLOYEE_ID=108;


select * from COPY_EMP
where EMPLOYEE_ID=108;

rollback to SAVEPOINT a;

rollback;






update COPY_EMP
set salary=salary+3000
where EMPLOYEE_ID=101;


select * from COPY_EMP where EMPLOYEE_ID=101;

SAVEPOINT "_test";


update COPY_EMP
set salary=salary+5000
where EMPLOYEE_ID=101;

SAVEPOINT b;


update COPY_EMP
set salary=salary+5000
where EMPLOYEE_ID=101;

savepoint "C";


select * from COPY_EMP where EMPLOYEE_ID=101;

rollback;

select * from COPY_EMP where EMPLOYEE_ID=101;

--Dit kan niet meer bc you rolled back the whole transaction
rollback to SAVEPOINT b;

update COPY_EMP
set salary=salary+7000
where EMPLOYEE_ID=101;

select * from COPY_EMP;

rollback to SAVEPOINT c;

rollback to SAVEPOINT "_test";


rollback;

select * from COPY_EMP;


update COPY_EMP set salary=SALARY+3000 where EMPLOYEE_ID=108;
SAVEPOINT "def";



update COPY_EMP set salary=SALARY+9000 where EMPLOYEE_ID=108;


select *
from COPY_EMP
where EMPLOYEE_ID=108;

--Dit gaat niet bv, maar als je ABC zet dan gaat het wel
rollback to SAVEPOINT def;

rollback;


update COPY_EMP set salary=SALARY+3000 where EMPLOYEE_ID=108;
SAVEPOINT "ABC";



update COPY_EMP set salary=SALARY+9000 where EMPLOYEE_ID=108;


select *
from COPY_EMP
where EMPLOYEE_ID=108;

--hier gaat het wel
rollback to SAVEPOINT abc;




