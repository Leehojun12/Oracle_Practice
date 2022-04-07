/*
    TCL (Transaction Control Language) : Ʈ����� ���� ���
    - commit, rollback
    
    commit : Ʈ����� �۾��� ���������� �Ϸ�Ǹ� ���� ������ ���������� ���� (��� savepoint ����)
    savepoint <savepoint��> : ���� Ʈ����� �۾� �������ٰ� �̸� �ο�(�ϳ��� Ʈ����� �ȿ��� ������ ������ ��)
    rollback : Ʈ����� �۾��� ��� ����ϰ� �ֱٿ� commit�ߴ� �������� ���ư��� ��.
    rollback to savepoint�� : �ش� savepoint�� �ǵ��� ����.
    
    Ʈ����� : �ѹ��� ����Ǿ��ϴ� �۾��� ����
    
    ex) ATM
    1. ī�� ����
    2. �޴�����(����)
    3. �ݾ� Ȯ�� / ��й�ȣ ����
    4. ����ڰ� �Է��� �ݾ��� �ش� ���¿��� ���� �� �ִ� �ݾ����� Ȯ��
    5. ���� ����
    6. ī�� �̰� ��
    
    == ������ ���� -> 6������ �۾��� ���������� �Ϸᰡ ���� �� (commit)
    -> �ϳ��� ������ �帧�� �߻��ϸ� �׶��� ��� �۾��� (rollback)
*/
create table tbl_user(
    no number unique,
    id varchar2(100) primary key,
    pw varchar2(100) not null
);
select * from tbl_user;
insert into tbl_user values(1, 'user1', 'pw1');
insert into tbl_user values(2, 'user2', 'pw2');
insert into tbl_user values(3, 'user3', 'pw3');
commit;
insert into tbl_user values(4, 'user4', 'pw4');
rollback;
savepoint sp1;
insert into tbl_user values(5, 'user5','pw5');
rollback to sp1;