--user demo can check his privileges by doing this:
select * from session_privs;


--Yippeee
create table emp(
    empid number constraint emp_pk primary key,
    ename varchar2(200)
);

--Since die table van hem is, kan hij basically doen wat hij wilt ermee
insert into emp values(1, 'Sameer');

select * from emp;


alter table emp add (salary number);

select * from emp;


--Has privilege to create a sequence so let's create one:
create sequence emp_s;


--Has privilege to create index for the table he created
create index ename_ind on emp(ename);


--Has privilege to create view
create or replace view emp_test_vw
as select * from emp;


--We can also create a force view
create or replace force view emp_test_vw as
select * from hey;


--User demo can also change his pw:
alter user demo identified by demo12345;




--The demo can user can only do select * from employees without the schema name(hr) if
--there is a public synonym for it
select * from hr.EMP_COPY;

--Al bestaat er een public synonym, die user moet wel eerst rechten krijgen to do selects on that specific table
select * from heeheehaw;



--No wholeass update privileges:
update hr.EMP_COPY set DEPARTMENT_ID=null where EMPLOYEE_ID=100;


--Does have update privileges on salary
update hr.EMP_COPY set salary = null where EMPLOYEE_ID=101;

select * from hr.EMP_COPY where EMPLOYEE_ID=100;


--Dit zijn je system privileges
select * from SESSION_PRIVS;


--same as above but with more info
select * from USER_SYS_PRIVS;


--object privileges
select * from USER_TAB_PRIVS_RECD;

--Alle privileges dat demo heeft als hij all privileges op specific table heeft
select * from USER_TAB_PRIVS_RECD
where table_name='DEPT_COPY';



--Privileges dat je hebt op specific columns van een table bv in dit geval
--dan heb je update privileges op salary van table emp_copy
select * from USER_COL_PRIVS_RECD;



--Omdat user demo table emp heeft gemaakt kan hij dan anyone privileges geven tot deze table
grant select on emp to hr;





--Hier kan je alle privileges zien dat je hebt gegrant to other users op table basis ofc
select * from USER_tab_PRIVS_MADE;



grant update(ename) on emp to hr;


--Hier kan je alle privileges zien dat je hebt gegrant to other users on column basis ofc
select * from USER_COL_PRIVS_MADE;


SELECT * FROM USER_COL_PRIVS_MADE;


--Deze bevat alle privileges, The ones you granted(made) and the ones you received(rcd)
SELECT * FROM USER_COL_PRIVS;


--Cannot insert null into ???
insert into locations(location_id)values(2000);
