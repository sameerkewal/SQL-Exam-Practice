--Demo


select * from USER_TAB_PRIVS
where table_name='COURSE';

--Cant grant bc didnt get it with grant
grant select on test123.course to sameer;


--Now can grant it bc I got it with grant
--maar sameer gaat dan niet kunnen granten
grant select on test123.course to sameer;


select * from test123.COURSE;






--Doesnt have privileges anymore bc it got revoked from hr which has a cascading effect ig
select * from test123.COURSE;