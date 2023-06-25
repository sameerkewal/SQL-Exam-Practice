select * from COPY_EMP 
where DEPARTMENT_ID=110
for UPDATE;

--Now open another session and do this
update copy_emp set salary=salary+100
where department_id=110;  


--Het gaat hangen tot session 1 een commit of rollback doet
commit;



--Case 2 
--do the following in another session
--session 2 gaat dan die row locken until er een commit of rollback is gedaan
update copy_emp set salary=salary+100
where department_id=110;  


--en dit doe je hier
--this means dat je die row wilt locken
--But uh oh wait. Session 2 heeft nog niet commit of rollback so 
--how can you lock this row
--Als je zonder die no wait runned gaat het blijven hangen
select * from COPY_EMP
where DEPARTMENT_ID=110
for update;

--However met die for update clause gaat het
--je gelijk die error geven
select * from COPY_EMP
where DEPARTMENT_ID=110
for update nowait;

commit;



--Case 3
--Do this in another session
--this ofc automatically locks these rows
update copy_emp set salary=salary+200
where department_id=110;


--Do this here
--This will just wait for 10 secs tot 
--session 2 een commit of rollback heeft gedaan
--if not then the resource busy error will appear
select *
from COPY_EMP
where DEPARTMENT_ID=110
for update wait 10;



--Case 4


--Wat dit gaat doen is:
--Lock the row in employees waar department_id 10 is
--and lock the row in departments waar department_id 10 is
select EMPLOYEE_ID, FIRST_NAME, emp.department_id, DEPARTMENT_NAME
from COPY_EMP emp, DEPT_COPY dep
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
and emp.DEPARTMENT_ID=110
for update;

--The following 2 statements will not work then
update dept_copy set department_name='Hi'
where department_id=110;


update copy_emp set salary=salary+100
where employee_id=205;

commit;


--Case 5
--Dit betekent dat die lock alleen zal gelden op die table having that column which is in this case salary
select EMPLOYEE_ID, FIRST_NAME, emp.department_id, DEPARTMENT_NAME
from COPY_EMP emp, DEPT_COPY dep
where emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
and emp.DEPARTMENT_ID=110
for update of salary;


update COPY_EMP set salary = 0
where DEPARTMENT_ID=110;



--The first statement zal dus anyways werken but the 2nd one will not work bc thats the one that has the salary column
update dept_copy set department_name='Hi'
where department_id=110;


update copy_emp set salary=salary+100
where employee_id=205;

rollback;


