-----------------------Update-----------------------

create table dept_copy
as select * from departments;


insert into DEPT_COPY
select * from DEPARTMENTS where DEPARTMENT_ID=10;

insert into DEPT_COPY
select * from DEPARTMENTS where DEPARTMENT_NAME like 'C%';

select * from dept_copy;



select * from DEPT_COPY
where DEPARTMENT_ID=10;


delete from DEPT_COPY
where DEPARTMENT_ID=10;


--from keyword is optional in delete
delete DEPT_COPY
where DEPARTMENT_ID=10;


--dont have to showcase this but yk what happens when you dont include a where condition


--Net als insert and update kan je ook deleten based on a subquery
--This deletes 4 rows(DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID
                        --130,Corporate Tax,,1700
                        --140,Control And Credit,,1700
                        --180,Construction,,1700
                        --190,Contracting,,1700)

delete from DEPT_COPY
where DEPARTMENT_ID in(select DEPARTMENT_ID from DEPT_COPY where DEPARTMENT_NAME like 'C%');

rollback;


select * from DEPT_COPY;



--Hier kan je niet deleten omdat er child records zijn die dependen on deze department in je employees table
--Integrity constraint child record found
--If you wanna do this zou je eerst alle child records moeten verwijderen in je employees table
delete from departments where DEPARTMENT_ID=90;



--Truncate is een ddl statement which means you cannot rollback

truncate table dept_copy;

select * from dept_copy;