/*
    DCL(Data Control Language) : 데이터 제어어
    -> 데이터베이스에 관한 보안, 무결성, 복구 등 DBMS를 제어하기 위한 언어
    -> grant , revoke / TCL(commit, rollback)
    
    grant : 사용자 또는 role(resource, connect, dba)에 대해 권한 부여
    -> system/ 관리자 계정 접속 -> 신규 사용자 생성 -> grant 접속 권한 부여 -> 리소스 권한 부여
*/

create user test01 identified by test01;
grant connect, resource to test01;

create table coffe(
    name varchar2(100) primary key,
    price number not null,
    brand varchar2(100) not null
);
select *from kh.coffe;
insert into coffe values('맥심', 3000, 'MAXIM');
insert into coffe values('아메리카노', 2000, 'KANU');
insert into coffe values('카페라떼', 3500, 'NESCAFE');
insert into kh.coffe values('바닐라라떼', 6000, 'STARBUCKS');
commit;

-- system 계정에서 test01 계정한테 kh 계정이 가지고 있는 coffe테이블에 접근 권한 부여
grant select on kh.coffe to test01;

-- system 계정에서 test01 계정한테 kh 계정의 coffe테이블에 대한 insert 권한 부여
grant insert on kh.coffe to test01;

-- revoke -> 부여된 권한을 해제/ 회수하는 명령어
revoke select, insert on kh.coffe from test01;

-- 어떤 권한을 부여했는지 알수 있는 명령어
select * from dba_role_privs where grantee ='KH';