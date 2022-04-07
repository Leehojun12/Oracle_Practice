/*
    view : �ϳ��� �̻��� ���̺��� ���ϴ� �����͸� �����ؼ� ���ο� ���� ���̺� ����� �ִ� ��
    -> �並 ���� ������� ���̺��� ���������� �����ϴ� ���� �ƴϰ�, �ٸ� ���̺��� �����͸� �����Ͽ� �����ִ� ��
    -> Ư�� ������ ���� ���̺� �� �����ؼ� ��� ������(���ʿ��� ������)�� �����ϴ� �� ������ �� ����
    -> �並 �����ϴ� ���� -> ���� ������ �����ϸ� -> ���� ���� ���̺��� �����͵� ������
    -> ���� ���̺��� ������ �����Ǹ� ���� ���뵵 �����ȴ� -> ������ �ǽð� ����(������Ʈ)
    create view ���̸� as select ����
*/
-- �� ���� ���� �ο�
grant create view to kh;

-- employee -> emp_name, emp_no, email, phone
create view emp_view as select emp_no, emp_name, email, phone from employee;
select * from emp_view;
commit;
-- test01 �������� ������ ���� emp_view�� ������ �� ����
-- view�� ���� select ������ �� �� system�� �ƴ϶� ���� �� view�� ������ kh���� ���� �ο�
grant select on kh.emp_view to test01;
select * from kh.emp_view;

-- ������ -> �̸��� �赿������ ����
update employee set emp_name = '�赿��' where emp_name = '������';
select *from emp_view;

-- �� ����
drop view emp_view;
================================================================================
/*
    sequence : ���������� ���� ���� �ڵ����� �����ϴ� ��ü
                -> �ڵ� ��ȣ �߻���
    
    create sequence ��������
    1. start with -> ������� ��ȣ�� �����Ұ���
    2. increment by ���� -> ������� ���ڸ� ������ų����
    3. maxvalue ���� / nomaxvalue -> �������� �ִ밪 ���� / ���� X
    4. minvalue ���� / nominvalue -> �������� �ּڰ� ���� / ���� X
    5. cycle / nocycle -> ���� �ִ밪�� �����ϸ� ó������ ���ư� �ٽ� ������ �ű�� �����Ұ���
    6. cache / nocache -> �޸𸮻� �̸� �������� �̾� �÷��ΰ� ����ϴ� �� / �޸𸮻� �÷����� X
*/

create sequence seq_temp
    start with 1
    increment by 1
    nomaxvalue 
    nocycle 
    nocache;
    
drop sequence seq_temp;

select * from user_sequences where sequence_name = 'SEQ_TEMP';

/*
    nextval : ���� �������� ���� ���� ��ȯ�԰� ���ÿ� �ñǽ��� ���� 
    currval : ���� ���� ��ȯ
    -> �����ϰ��� nextval�� ���ѹ��� ������ �ʾҴٸ� ��� X
*/
    
select seq_temp.nextval from dual;
select seq_temp.currval from dual;

select * from coffe;
insert into coffe values(seq_temp.nextval,4000,'MAX'); 