select *
from COPY_EMP
where EMPLOYEE_ID in(200, 201);



select * from DEPT_COPY where DEPARTMENT_ID=1;


delete from DEPT_COPY;
rollback;
select * from DEPT_COPY;

