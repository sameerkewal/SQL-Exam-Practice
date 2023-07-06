--Will show all privileges. Ones granted directly and ones granted by role
select * from session_privs;


--Will only show privileges that were granted directly
select * from user_sys_privs;


--Will show you what roles the current user has
select * from USER_ROLE_PRIVS;


--Will show you the roles and all the privileges associated with it
select * from ROLE_SYS_PRIVS;



--Will show you the privileges you got via the role to tables
select * from ROLE_TAB_PRIVS;


create table student(
    student_id number,
    student_name varchar2(100),
    student_subject_id number constraint student_subject_fk references subject(subject_id)
);

create table subject(
    subject_id number,
    subject_name varchar2(100),
    constraint subject_id primary key(subject_id)
);


-- Inserting data into the "subject" table
INSERT INTO subject (subject_id, subject_name)
VALUES (1, 'Mathematics');

INSERT INTO subject (subject_id, subject_name)
VALUES (2, 'English');

-- Inserting data into the "student" table
INSERT INTO student (student_id, student_name, student_subject_id)
VALUES (1, 'John Doe', 1);

INSERT INTO student (student_id, student_name, student_subject_id)
VALUES (2, 'Jane Smith', 2);

INSERT INTO student (student_id, student_name, student_subject_id)
VALUES (3, 'Mike Johnson', 1);

create or replace view student_subject_vw
AS
select STUDENT_NAME, subject_name
from STUDENT join subject on student.student_subject_id=subject.subject_id;

grant select on student_subject_vw to hr;


--Any user can select this table now as long as they do test123.student
grant select on student to public;

--Omdat hij select any table privilege heeft
select * from hr.LOCATIONS;

select * from demo.EMP;