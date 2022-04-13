create table member_tbl(
    id varchar2(50) primary key,
    pw varchar2(50) not null,
    nickname varchar2(20) not null
);

create sequence seq_meb
    start with 1
    increment by 1
    nomaxvalue
    nocycle
    nocache;
commit;

select * from member_tbl;

alter table member_tbl add constraint nickname_unq unique(nickname);
alter table member_tbl rename column nickname_unq to nickname;
select constraint_name, constraint_type from user_constraints where table_name = 'MEMBER_TBL';
