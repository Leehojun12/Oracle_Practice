/*
    DML(Data Manipulation Language) : ������ ���۾�
    -> Data�� ����, ����, ����, ��ȸ�ϴ� ���
    -> insert, update, delete, select
    
    insert : ����Ʋ�� ���ο� ���� �߰��� �� ����ϴ� ����
    -> insert into ���̺� values(�Է��� ������, �Է��� ������....) -> ��� �࿡ ���� �����͸� �߰��ϰ��� �Ҷ� ����ϴ� ����
    -> insert into ���̺� (�÷���1, �÷���2...) values(�Է��� ������1, �Է� ������2...); -> Ư���� �÷����� �����͸� �ְ� ���� ��� ����ϴ� ����
    
*/
create table member(
    id varchar2(100) primary key,
    pw varchar2(100) not null,
    nickname varchar2(100) unique,
    email varchar2(100)
);
insert into member values('abc123', 'abc', 'ABC���ݸ�','abc@naver.com');
insert into member (id, pw) values('eee555', 'eee');
insert into member (id, pw, nickname, email) values('eee53', 'eee1', '���', 'dlghwns@naver.com');

-- �������� �̿��ؼ� insert ���� ���
-- employee
insert into member (select emp_id, job_code, emp_name, email from employee where emp_id = '200');
-- ������ ����ȯ -> ����Ŭ�� �ڵ����� �ڷ����� �����Ͽ� ��ȯ���ִ� ��
insert into member values(123, sysdate, 'dfd', 'asd@naver.com');
================================================================================
/*
    update : Ŀ���� ����� �����͸� �����ϴ� ���� -> ü�̺��� ��ü �� ������ ��ȭ�� ���� ����
    -> update ���̺�� set ������ �÷��� = ������ �� ... where ����  
*/
update member set email = 'mbt222@gamil.com';
update member set email = 'abc@naver.com' where id = 'abc123';
-- pw , nickname
update member set pw = '1234', nickname = 'ȣ��' where id = 'eee555';
================================================================================
/*
    delete : ���̺��� ���� �����ϴ� ���� -> ���� ������ ��ȭ�� ����
    -> ���ǹ��� �ɾ����� ������ ���̺��� ��� �����Ͱ� ������.
    
    -> delete from ���̺�� where ���ǽ�;
*/
commit; -- ������ ����
select * from member;
delete from member where id = '200';
delete from member;
rollback; -- �ٽ� �ǵ����� ��ɾ�
/*
    truncate : ���̺��� ��ü ���� �����Ҷ� ����ϴ� ����
    -> �ǵ��� �� ���� -> �� ���������� ���� -> rollback X
*/
truncate table member;