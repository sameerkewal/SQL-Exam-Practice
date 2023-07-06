--HR

select * from sy;

select * from session_privs;

select * from USER_TAB_PRIVS;


select * from test123.COURSE;

--kan niet tenzij je die privilege hebt gehad met een with grant option
grant select on test123.course to demo;

select * from test123.COURSE;

select * from USER_TAB_PRIVS;

--ALS JE HET ZO ONPASSED kan demo dan niet granten!!
grant select on test123.course to demo;


grant select on test123.course to demo with grant option;

