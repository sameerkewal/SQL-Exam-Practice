---Automatic Index Momento

create table emp_ind(
    empno number constraint emp_ind_pk primary key,
    ename varchar2(100) unique,
    nickname varchar2(100),
    email varchar2(100)
);


insert into emp_ind(empno, ename, nickname, email)
            values(1, 'Sameer Kewal', 'Sameer.Kewal', 'skewal@test.com');

insert into emp_ind(empno, ename, nickname, email)
            values(2, 'Jasmine de Vries', 'jasminevries', 'jdevries@test.com');

insert into emp_ind(empno, ename, nickname, email)
            values(3, 'Gavin Soemo', 'Gav.Soemo', 'gsoemo@test.com');

insert into emp_ind(empno, ename, nickname, email)
            values(4, 'Claire Amat', 'Claire.Amat', 'camat@test.com');
commit;

--Oracle will create implicit unique indees for the PK, UK
--The name for these indexes will be the same as the constraint name

select * from USER_INDEXES
where table_name='EMP_IND';

select * from USER_IND_COLUMNS
where table_name='EMP_IND';

drop table emp_ind;


create table emp_ind(
    empno number,
    ename varchar2(100) unique,
    nickname varchar2(100),
    email varchar2(100),
    constraint emp_ind_pk primary key(empno, EMAIL)
);

--Omdat je een composite key hebt dan komen beide kolommen nu als index. Eentje met position 1 en die andere met position 2
select * from USER_IND_COLUMNS
where table_name='EMP_IND';


select * from USER_IND_COLUMNS where table_name='EMP_IND';

lnn 