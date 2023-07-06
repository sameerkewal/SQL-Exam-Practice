--Creating a role
create role manager;

grant create table, create view, create sequence to manager;


--Welke privileges de role heeft
select * 
from ROLE_SYS_PRIVS
where role='MANAGER';


create user test123 identified by test123;

grant create session to test123;
grant unlimited tablespace to test123;


grant manager to test123;


create role qonly;

grant select any table to qonly;

grant qonly to test123;


create role IUD_EMP;

grant insert, update, delete on HR.EMP_COPY TO IUD_EMP;
grant update(DEPARTMENT_NAME) on HR.dept_copy to IUD_EMP;

grant iud_emp to test123;


select * from ROLE_TAB_PRIVS
where role='IUD_EMP';

