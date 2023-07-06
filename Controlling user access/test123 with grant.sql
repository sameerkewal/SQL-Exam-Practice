--test123 == ahmed

drop table course;

create table course(
    course_id number,
    course_name varchar2(20)
);

-- Inserting data into the "course" table
INSERT INTO course (course_id, course_name)
VALUES (1, 'Mathematics');

INSERT INTO course (course_id, course_name)
VALUES (2, 'English');

INSERT INTO course (course_id, course_name)
VALUES (3, 'History');

commit;


grant select on course to hr;



--override die oude grant pretty sure
grant select on course to hr 
with grant option;


--Maar deze override die andere niet. You need to revoke 
grant select on course to hr;



revoke select on course from demo;

--Je kan alleen revoken van die originele persoon who you granted it to
--You did not grant it to demo(eventhough demo has privileges bc of with grant option)
revoke select on course from demo;

--Revoken van HR who was the original user you granted the privileges to
revoke select on course from hr;



