/*
    DCL(Data Control Language) : ������ �����
    -> �����ͺ��̽��� ���� ����, ���Ἲ, ���� �� DBMS�� �����ϱ� ���� ���
    -> grant , revoke / TCL(commit, rollback)
    
    grant : ����� �Ǵ� role(resource, connect, dba)�� ���� ���� �ο�
    -> system/ ������ ���� ���� -> �ű� ����� ���� -> grant ���� ���� �ο� -> ���ҽ� ���� �ο�
*/

create user test01 identified by test01;
grant connect, resource to test01;

create table coffe(
    name varchar2(100) primary key,
    price number not null,
    brand varchar2(100) not null
);
select *from kh.coffe;
insert into coffe values('�ƽ�', 3000, 'MAXIM');
insert into coffe values('�Ƹ޸�ī��', 2000, 'KANU');
insert into coffe values('ī���', 3500, 'NESCAFE');
insert into kh.coffe values('�ٴҶ��', 6000, 'STARBUCKS');
commit;

-- system �������� test01 �������� kh ������ ������ �ִ� coffe���̺� ���� ���� �ο�
grant select on kh.coffe to test01;

-- system �������� test01 �������� kh ������ coffe���̺� ���� insert ���� �ο�
grant insert on kh.coffe to test01;

-- revoke -> �ο��� ������ ����/ ȸ���ϴ� ��ɾ�
revoke select, insert on kh.coffe from test01;

-- � ������ �ο��ߴ��� �˼� �ִ� ��ɾ�
select * from dba_role_privs where grantee ='KH';