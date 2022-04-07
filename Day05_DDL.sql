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
    - foreign key(�ܷ�Ű) : �� ���̺��� ���� ���踦 �����ϰ� -> A���̺�(id,pw,...) B���̺�(member_id,count..)
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

-- primary key�� ���� �ϳ��� �÷��� �ƴ϶� �������� �÷��� ���� ����Ű ���·� ������ ��Ű�� ������ �÷����������� �Ұ�
-- ����Ű -> �÷� �ΰ� �̻��� ��� �����ϴ� Ű

create table user_cons( -- no,id�� �ϳ��� ��� primary key
    no number , 
    id varchar2(100) ,
    pw varchar2(100),
    gender varchar2(10),
    primary key(no, id)
);

select * from user_cons;
insert into user_cons values(1, '11234','tom','��');
insert into user_cons values(1, '1234','tom','��');
================================================================================
/*
    foreign key ( �ܷ�Ű ) : �������Ἲ�� ��Ű�� ������, ������ �ٸ� ���̺��� �����ϴ� ���� ����� �� �ֵ��� �����ϰ� ���� ��.
    => �����ϴ� �÷��� �����Ǵ� �÷��� ���� �� ���̺��� ���谡 ������ ��.
    => �����ϴ� �÷��� �����Ǵ� �÷��� �ִ� ���� ��ġ�ϰų�, null ���� ������ ����
    ** �����ϴ� �÷� : ���� ����� �����ϴ� ���̺��� �÷� (B_�뿩_���̺�)
    ** �����Ǵ� �÷� : ���� ����� �Ǵ� ���̺� �÷� (A_�л�_���̺�)    
*/
-- �л� ���̺� / �뿩 ���̺�
create table student(
    id varchar2(100) primary key,
    name varchar2(100) not null,
    age number not null
);
insert into student values('001','tom',20);
insert into student values('002','salley',30);
insert into student values('003','chloe',25);
select * from student;

drop table borrow;
-- ���� �뿩 ���̺�
create table borrow(-- ���̺� ����
    book_id varchar2(100) primary key,
    std_id varchar2(100),
    rent_date date,
    foreign key(std_id) references student (id) -- foreign key (�����ϴ� �÷�) references ����������̺�� (������� �÷���)
);

create table borrow(-- �÷� ����
    book_id varchar2(100) primary key,
    std_id varchar2(100) references student(id), -- �÷��� �ڷ��� references ������� ���̺��(������� �÷���)
    rent_date date
);

select * from borrow;
insert into borrow values('500','002',sysdate);

-- �����ǰ� �ִ� id -> 002 -> ����
-- delete (������ ���̺��) where (����);
-- �����ǰ� �ִ� �÷��� �����͸� ������ �ִ� �ڽ� �÷��� �ִٸ� ���� ���̺��� ������ ����X - �������� ���Ἲ ħ��, �ϰ��� X
delete student where id = '003';

/*
    ���� �ɼ�
    -> �θ� ���̺��� ������ ���� �Ҷ� �ڽ� ���̺� �ִ� �����͸� � ������� ó������ -> ���������� �ɶ� ���� �ɼǵ� �Բ� �ɾ� ��.
    -> �⺻ ���� �ɼ��� on delete no action -> �ڽ��� �����ϴ� �����Ͱ� �ִٸ� ���� �� �� ����.
*/
-- on delete set null
-- ���� �����ϰ� �ִ� �θ� �����Ͱ� �����Ǹ� �ڽ� �����͸� null ������ ����
create table borrow(
    book_id varchar2(100) primary key,
    std_id varchar2(100) references student(id) on delete set null, 
    rent_date date
);
-- on delete cascade
-- �θ� �����Ͱ� �����Ǹ� �ش� �����͸� �����ϰ� �ִ� �ڽ� ������ ���õ� �Բ� ����
-- ����) 1�� �Խñ� �ۼ� -> 1�� �۹�ȣ�� �����ϴ� ��� 3�� �޷���. 1�� �Խñ� ������ 3�� ��� �� ����
create table borrow(
    book_id varchar2(100) primary key,
    std_id varchar2(100) references student(id) on delete cascade, 
    rent_date date
);
insert into borrow values('501','003',sysdate);
================================================================================
/*
    check
    : �ش� �÷��� �Էµǰų�, �����Ǿ� ������ ���� üũ�� ������ ���� ���� �� �ְԲ� ����
    
*/
drop table user_cons;
create table user_cons(
    no number , 
    id varchar2(100) ,
    pw varchar2(100),
    gender varchar2(10) check(gender in ('��','��')),
    primary key(no, id)
);
select *from user_cons;
insert into user_cons values(1,'ab123','sdfsdf','��');
================================================================================
-- default

create table temp(
    date_one date,
    date_two date default sysdate
);
insert into temp values(sysdate); -- �÷��� �� ������ ��ġ���� �ʴ� �����͸� �ְ� �־� ���� �߻�
insert into temp values(sysdate, default);
select * from temp; -- default��� Ű���带 �̿��� ���� ������ ���̺� ������ default�� ��� �� ���� ����.
================================================================================
/*
    drop : ��ü�� �����ϱ� ���� ����ϴ� ����
*/
drop table temp;
================================================================================
/*
    alter : ���̺� ���ǵ� ������ �����ϰ��� �� �� ����ϴ� ������ ���Ǿ�
    -> �÷� �߰�/����, �������� �߰�/����, �÷��� �ڷ��� ����, default�� ����
    -> ���̺��/�÷���/���������� �̸� ����
*/
create table member(
    no number primary key,
    id varchar2(100),
    pw varchar2(100)
);
select * from member;
-- ���̺��� ������ ���� ���ؼ��� desc
desc member;

-- �̹� �����ϴ� member ���̺� ���ο� �÷� �߰�(name)
alter table member add (name varchar2(100));

-- ���ο� �÷� �߰�(age) + default
alter table member add (age number default 0);

-- ���� ���� �߰� -> id �÷��� unique �������� �߰�
alter table member add constraint id_unq unique(id);
select constraint_name, constraint_type from user_constraints where table_name = 'MEMBER';

-- ���� ���� �߰� -> pw �÷��� not null �������� �߰� -> add�� ���� X
-- modify
alter table member add constraint pw_nn not null(pw); -- X
alter table member modify pw constraint pw_nn not null;

-- �÷��� ���� -> pw �÷��� password��� ����
alter table member rename column idea to id;

-- �÷��� ������ Ÿ�� ���� - name varchar2(100) -> char(100)
alter table member modify name char(100);

-- �÷� ���� -> age �÷� ����
alter table member drop column age;

-- �������� ���� -> password �÷��� �������� ����
-- ���������� �̸��� ���� �˰� �־�ߴ�
select constraint_name from user_constraints where table_name = 'MEMBER';
alter table member drop constraint pw_nn;
 
-- �������� ����
alter table member rename constraint SYS_C007116 to no_pk;
 
-- ���̺�� ����
alter table member rename to tbl_member;
select * from tbl_member;
