select * from ALL_USERS;

alter user test_stud identified by test_stud;

select * from ALL_USERS;

DROP USER DEMO cascade;

--Get all privileges(independent van een scheme or sth this will always be consistent)
select * from SYSTEM_PRIVILEGE_MAP;


create user demo identified by demo1234;

--Pas nadat hij deze privilege krijgt kan die user inloggen
grant create session to demo;


grant create table to demo;

--Ondanks demo create table privileges heeft kan hij toch nog geen table createn
grant create session, create table to demo;


--Demo needs the grant unlimited tablespace to actually make the tables
grant UNLIMITED TABLESPACE to demo;




grant create sequence to demo;
grant create view to demo;
grant create synonym to demo;


--Object privileges

grant select on hr.EMP_COPY to demo;
grant delete on hr.EMP_COPY to demo;
grant select on hr.EMPLOYEES to demo;


--Dus Demo kan alleen salary updaten
grant update(salary)on hr.EMP_COPY TO DEMO;
grant delete(EMPLOYEE_ID) on hr.EMP_COPY TO DEMO;


-- Only INSERT, UPDATE, and REFERENCES privileges can be granted at the column level. 
-- When granting INSERT at the column level, you must include all the not null columns in the row.

GRANT SELECT (LOCATION_ID) ON hr.LOCATIONS TO DEMO;

--zo die grant gaat wel maar je kan niet inserten(cannot insert null into ???)
grant insert(LOCATION_ID) on hr.LOCATIONS to demo;



grant update(FIRST_NAME), update(last_name) on hr.EMP_COPY to demo;


revoke all on hr.EMP_COPY from demo;


--Dit betekent insert, update, delete select
grant all on hr.DEPT_COPY to demo;




grant select,insert on hr.DEPT_TEST to demo;f


revoke create operator from demo; 