/*
    DDL (Data Definition Language)
    : 데이터 정의어
    : 데이터베이스 객체 생성(create), 수정(alter), 삭제(drop), 하는 구문
    
    오라클 객체 종류
    : 사용자(user),테이블(table), 뷰(view), 시퀀스(sequence)..
    
    테이블 생성 기준..
    생성(create)
    -> create table 테이블명(컬럼명 자료형(크기), 컬럼명 자료형(크기)......);
*/
create table temp(
    id varchar2(300),
    pw varchar2(500),
    age number(100),
    join_date date
);
/*
    제약 조건(constraints)
    : 테이블을 생성할 때 구성하는 컬럼에 들어갈 데이터에 대해 제약조건을 설정하는 것
    -> 데이터의 일관성과 정확성을 유지하기 위해서(데이터 무결성)
    
    - not null : 해당 컬럼에 null 값이 들어갈 수 없음 -> null 값 허용 X
    - unique : 중복된 값을 허용 X
    - primary key(기본키) : null 값 허용 X 중복값 허용 X -> 컬럼 중 고유 식별자로 사용
    - foreign key(외해키) : 두 테이블의 간의 관계를 설정하고 -> A테이블(id,pw,...) B테이블(member_id,count..)
        B테이블의 member_id 컬럼에 들어갈 수 있는 값이 A테이블의 id에 있는 데이터여야하는 경우
    - check : 해당 컬럼에 저장 가능한 값의 범위 조건을 지정해서 설정한 값만 허용
*/
select
    constraint_name, constraint_type
from user_constraints
    where table_name = 'EMPLOYEE';
-- P : primary key / C : check or not null
/*
    not null : null 값을 허용 X -> 해당 컬럼에 반드시 값이 기록되야하는 경우 사용
*/
create table user_nocons(
    no number,
    npw varchar2(100),
    name varchar2(100),
    gender varchar2(10)
);
select *from user_nocons;
insert into user_nocons values(1, 'abc123', 'tom','남');
insert into user_nocons values(2, null, null,'여');

create table user_cons(
    no number not null, -- 컬럼명 자료형(길이) 제약조건
    pw varchar2(100) not null,
    name varchar2(100) not null,
    gender varchar2(10)
);
select * from user_cons;
insert into user_cons values(1,'aaa555','paul','남');
insert into user_cons values(2,null,null,'여');
-- 데이터를 삽입할 때부터 제약조건에 부합하지 않는다면 데이터가 들어가지 않음
================================================================================
/*
    unique : 해당 컬럼에 중복값을 제한하는 제약조건
*/
drop table user_cons;
/*
    제약조건 거는 방식
    - 컬럼 레벨 : 컬럼명 자료형 옆에 제약조건명을 명시하는 경우
    - 테이블 레벨 : 컬럼을 모두 정의한 후 마지마겡 제약조건명(컬럼명) 형식으로 제약조건을 걸어주는 방식
    - ** not null -> 컬럼 레벨에서만 제약조건 걸어줄 수 있음
*/
create table user_cons(
    no number unique not null, -- unique
    pw varchar2(100) not null,
    name varchar2(100) not null,
    gender varchar2(10)
);
create table user_cons( -- 테이블 레벨에서 제약조건 걸기
    no number , 
    pw varchar2(100) not null,
    name varchar2(100) not null,
    gender varchar2(10),
    unique(no) -- 테이블 레벨에서 unique 제약조건 걸기
);
select * from user_cons;
insert into user_cons values(1, '11234','tom','남');
insert into user_cons values(null, '11235','sam','남');

================================================================================
/*
    primary key : 컬럼의 데이터가 중복값을 허용 X null 값 허용 X = 고유 식별자
    -> unique + not null = primary key
    -> 하나의 테이블에서 primary key는 딱 하나만 걸어줄 수 있음 -> 고유 식별자이기 때문에
    -> unique + not null 제약조건은 하나의 테이블에서도 여러번 사용이 가능하기 때문에
        고유식별자는 아니지만 중복값과 null 값을 허용하면 안되는 경우에 사용한다.
*/
create table user_cons(
    no number primary key, 
    id varchar2(100) unique not null,
    nickname varchar2(200) unique not null,
    pw varchar2(100),
    name varchar2(100) not null,
    gender varchar2(10)
);
insert into user_cons values(3, '11235','sam','남');