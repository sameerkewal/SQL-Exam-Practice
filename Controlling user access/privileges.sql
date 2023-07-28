--Welke system privileges die role heeft
select *
from role_sys_privs;


--welke users die role hebben gehad
select *
from user_role_privs;




--Welke roles welke privileges hebben op welke tables
select *
from role_tab_privs;

--Welke roles welke roles hebben??? Very confusing
select *
from role_role_privs;


--Same as role_tab_privs, maar behalve tables heeft het alle objects???
select *
from dba_tab_privs;

-- DBA_ROLE_PRIVS: This view describes all roles granted to users and roles.
select *
from DBA_ROLE_PRIVS;



select *
from dictionary
where table_name = 'DBA_TAB_PRIVS';