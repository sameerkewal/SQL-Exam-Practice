select * from COPY_EMP
where EMPLOYEE_ID=109;


update COPY_EMP
set SALARY=SALARY+20
where EMPLOYEE_ID=109;


select SALARY
from COPY_EMP
where EMPLOYEE_ID=109;

--Startup another session(idk als het kan using VSCode so i just use SQLDeveloper)

--Als je dit dan doet in je 2de session gaat het blijven hangen tot je een commit/rollback doet op je eerste session
update copy_emp set salary=salary+30
where employee_id=109;

commit;


update COPY_EMP
set SALARY=SALARY+20
where EMPLOYEE_ID=109;


rollback;
commit;

update COPY_EMP
set SALARY=SALARY+20
where EMPLOYEE_ID=109;

update COPY_EMP
set salary=salary+200;

rollback;







