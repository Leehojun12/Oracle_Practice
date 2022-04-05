/*
    SetOperator(���� ������) -> �� �� �̻��� ���̺��� ���� ���� ������ �����͸� ��ȸ�ϴ� ���
    -> ���� ���� ���� ���(ResultSet)�� �����ؼ� �ϳ��� �����ϴ� ���
    -> �� ���̺��� ��ȯ�� ������� �ϳ��� ���̺�� �����ϴ� ���
    -> ���� ���� sql ���� ����ؼ� �ϳ��� ���̺�� ����� ��ȯ�޾ƾ� �ϴ� ���
    
** ���� **
- select ������ ��ȸ�Ϸ��� '�÷��� ���� ����'
- select ���� ���� ��ġ�� �����ϴ� �÷��� '������ Ÿ���� ��ȣ ȣȯ ����'

** ���� ** 
- UNION / UNION ALL / INTERSECT / MINUS
*/
create table A(
    no_a number(1),
    name_a nvarchar2(10)
);
create table B(
    no_b number(1),
    date_b date default sysdate
);
insert into A (no_a) values(1);
insert into A (no_a) values(5);
insert into A (no_a) values(3);
insert into A (no_a) values(4);
insert into A (no_a) values(2);

insert into B (no_b) values(7);
insert into B (no_b) values(6);
insert into B (no_b) values(3);
insert into B (no_b) values(8);
insert into B (no_b) values(5);
insert into B (no_b) values(9);

select *from A;
select * from B;
================================================================================
-- UNION : ������ -> �ߺ��� �����͸� �����ϰ� ù��° �÷��� �������� ���������Ͽ� �����͸� ���� ��

-- ��ȸ�Ϸ��� �÷��� ���� �¾ƾ� �ȴ�
select no_a,name_a from A
UNION 
select no_b from B;

-- ��ȸ�Ϸ��� �÷��� ���� ��ȣȣȯ �Ұ���(�� ���� ����) ������ Ÿ���̸� union ��� X
select no_a, name_a from A
union
select no_b, date_b from B;

select no_a from A
union
select no_b  from B;

select no_a from A; -- 1, 5, 3, 4, 2
select no_b from B; -- 7, 6, 3, 8, 5, 9

/*
UNION ALL : ������ -> �ߺ��� ������ ���� X, ���� ���� �����͸� �״�� ������
-> ��ȸ�� ������� ù��° ���̺� �Ʒ��� �ι�° ���̺� ��� ���� �״�� �̾� ���̴� ��.
*/
select no_a from A
union all
select no_b from B;

-- INTERSECT : ������ -> �� ���̺��� ���� ��� �� ����� ��� ���� ���� ��.

select no_a from A
intersect
select no_b from B;

-- MINUS : ������ -> �� ���̺��� ���� ��� �� ����� ��Ҹ� �� �� ���̺��� �������  ������

-- A - B
select no_a from A
minus
select no_b from B;
-- B - A
select no_b from B
minus
select no_a from A;
================================================================================
-- employee �μ��ڵ尡 D5�� ����� ���, �����, �μ��ڵ�, ���� ���
select emp_id"���",
    emp_name"�����",
    dept_code"�μ��ڵ�",
    salary"����"
from employee
    where dept_code = 'D5';
-- ������ 300���� �̻� ����� ���, �����, �μ��ڵ�, ���� ���
select emp_id"���",
    emp_name"�����",
    dept_code"�μ��ڵ�",
    salary"����"
from employee
    where salary >= 3000000;

-- UNION / UNION ALL / INTERSECT / MINUS
select emp_id"���",
    emp_name"�����",
    dept_code"�μ��ڵ�",
    salary"����"
from employee
    where dept_code = 'D5'
minus
select emp_id"���",
    emp_name"�����",
    dept_code"�μ��ڵ�",
    salary"����"
from employee
    where salary >= 3000000;
