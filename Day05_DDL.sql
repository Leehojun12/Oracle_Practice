/*
    DDL (Data Definition Language)
    : ������ ���Ǿ�
    : �����ͺ��̽� ��ü ����(create), ����(alter), ����(drop), �ϴ� ����
    
    ����Ŭ ��ü ����
    : �����(user),���̺�(table), ��(view), ������(sequence)..
    
    ���̺� ���� ����..
    ����(create)
    -> create table ���̺��(�÷��� �ڷ���(ũ��), �÷��� �ڷ���(ũ��)......);
*/
create table temp(
    id varchar2(300),
    pw varchar2(500),
    age number(100),
    join_date date
);
/*
    ���� ����(constraints)
    : ���̺��� ������ �� �����ϴ� �÷��� �� �����Ϳ� ���� ���������� �����ϴ� ��
    -> �������� �ϰ����� ��Ȯ���� �����ϱ� ���ؼ�(������ ���Ἲ)
    
    - not null : �ش� �÷��� null ���� �� �� ���� -> null �� ��� X
    - unique : �ߺ��� ���� ��� X
    - primary key(�⺻Ű) : null �� ��� X �ߺ��� ��� X -> �÷� �� ���� �ĺ��ڷ� ���
    - foreign key(����Ű) : �� ���̺��� ���� ���踦 �����ϰ� -> A���̺�(id,pw,...) B���̺�(member_id,count..)
        B���̺��� member_id �÷��� �� �� �ִ� ���� A���̺��� id�� �ִ� �����Ϳ����ϴ� ���
    - check : �ش� �÷��� ���� ������ ���� ���� ������ �����ؼ� ������ ���� ���
*/
select
    constraint_name, constraint_type
from user_constraints
    where table_name = 'EMPLOYEE';
-- P : primary key / C : check or not null
/*
    not null : null ���� ��� X -> �ش� �÷��� �ݵ�� ���� ��ϵǾ��ϴ� ��� ���
*/
create table user_nocons(
    no number,
    npw varchar2(100),
    name varchar2(100),
    gender varchar2(10)
);
select *from user_nocons;
insert into user_nocons values(1, 'abc123', 'tom','��');
insert into user_nocons values(2, null, null,'��');

create table user_cons(
    no number not null, -- �÷��� �ڷ���(����) ��������
    pw varchar2(100) not null,
    name varchar2(100) not null,
    gender varchar2(10)
);
select * from user_cons;
insert into user_cons values(1,'aaa555','paul','��');
insert into user_cons values(2,null,null,'��');
-- �����͸� ������ ������ �������ǿ� �������� �ʴ´ٸ� �����Ͱ� ���� ����
================================================================================
/*
    unique : �ش� �÷��� �ߺ����� �����ϴ� ��������
*/
drop table user_cons;
/*
    �������� �Ŵ� ���
    - �÷� ���� : �÷��� �ڷ��� ���� �������Ǹ��� ����ϴ� ���
    - ���̺� ���� : �÷��� ��� ������ �� �������� �������Ǹ�(�÷���) �������� ���������� �ɾ��ִ� ���
    - ** not null -> �÷� ���������� �������� �ɾ��� �� ����
*/
create table user_cons(
    no number unique not null, -- unique
    pw varchar2(100) not null,
    name varchar2(100) not null,
    gender varchar2(10)
);
create table user_cons( -- ���̺� �������� �������� �ɱ�
    no number , 
    pw varchar2(100) not null,
    name varchar2(100) not null,
    gender varchar2(10),
    unique(no) -- ���̺� �������� unique �������� �ɱ�
);
select * from user_cons;
insert into user_cons values(1, '11234','tom','��');
insert into user_cons values(null, '11235','sam','��');

================================================================================
/*
    primary key : �÷��� �����Ͱ� �ߺ����� ��� X null �� ��� X = ���� �ĺ���
    -> unique + not null = primary key
    -> �ϳ��� ���̺��� primary key�� �� �ϳ��� �ɾ��� �� ���� -> ���� �ĺ����̱� ������
    -> unique + not null ���������� �ϳ��� ���̺����� ������ ����� �����ϱ� ������
        �����ĺ��ڴ� �ƴ����� �ߺ����� null ���� ����ϸ� �ȵǴ� ��쿡 ����Ѵ�.
*/
create table user_cons(
    no number primary key, 
    id varchar2(100) unique not null,
    nickname varchar2(200) unique not null,
    pw varchar2(100),
    name varchar2(100) not null,
    gender varchar2(10)
);
insert into user_cons values(3, '11235','sam','��');