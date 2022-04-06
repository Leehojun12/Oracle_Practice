/*
    Top N �м� (Top N Query)
    : �÷����� ���� ū n���� ���� Ȥ�� ���� ���� n���� ���� ��û�� �� ����ϴ� ����
    -> ���� / ���� n���� �����͸� �����ϴ� ����
    -> ȸ�翡�� ���� ���� �ȸ� ��ǰ 10���� �����ΰ�? / ȸ�翡�� ������ ���� ���� �޴� ��� 3���� �����ΰ�?
    -> �Խ��� ����¡ / ��ȸ���� ���� �α�� 
*/
-- employee ���̺��� ���� ���� �޿��� �޴� ��� 5��
select
    emp_name, salary
from employee
    order by 2 desc;
    
/*
    rownum : ��µǴ� select ���� �ึ�� �ڵ������� ������ �Ű��ִ� ��
*/
select
    rownum,
    emp_name,
    salary
from employee
    order by 3 desc;
-- from -> where -> group by -> select -> order by
-- select ���� order by ������ ���� ����Ǹ鼭 �̹� rownum�� �Ű��� �Ŀ� �ٽ� �����ĵǱ� ������ ������ ���׹���.
-- �츮�� ���ϴ� ���ؿ� ���� �̹� ������ �� ������ �����Ϳ� ���� rownum -> ������ �Űܾ� ��
-- �ζ��κ� -> �������� �ȿ��� ������ ���� ū ������� �ϴ� �����͸� ����
-- -> ���� �������� rownum ����ϰ� �Ǹ� �̹� ���ĵ� �����Ϳ� ���� ������ �Ű���.
select * from employee order by salary desc;
select 
    rownum, emp_name, salary
from (select * from employee order by salary desc);

-- ���� ���� �޿��� �޴� �ѻ���� ���� ����, emp_name, salary
select 
    rownum, emp_name, salary
from (select * from employee order by salary desc)
    where rownum <= 5;

-- �ζ��κ並 ��� ����ؾ��ϴ� �������� �����.
/*
    row_number() over(order by �÷�..) : over() ������ �÷� ������ ���� �ϴ� ������ �� �Ŀ� ������ �Ű���
    ���� ������ �����Ϳ� �ߺ� ���� �ִٸ� ���� ������� ������ 19,20 ������ �Űܹ�����.
*/

select
    row_number() over(order by salary desc)"����",
    emp_name,
    salary
from employee;

-- ������ ���� ���� �޴� top 5
/* ���� ��Ȳ���� rownum�� where���� ����ϰ� �Ǹ� ���� �������� ���ļ����� �������� 
�ϴ� 5���� �����Ͱ� ���� ������ -> �� ������ select ������ row_number()�� ���� ������ ������ �Ǵ� ��Ȳ
-> �� where ���� rownum �� ���� ���� ��Ȳ */
select
    row_number() over(order by salary desc)"����",
    emp_name,
    salary
from employee
    where rownum <= 5;
================================================================================
/*
    rank() over(order by �÷�...) :over() �ȿ� �ִ� �÷��� ���� �ϴ� �����͸� ������ �Ŀ� ������ �ű�
    ������ �ű涧 �ߺ������Ͱ� �ִٸ� ���� ������ �ű��, ���� ������ �ű� �����͸�ŭ �ǳʲ�� ���� ������ �ű�.
*/

select
    rank() over(order by salary desc)"����",
    emp_name,
    salary
from employee;
================================================================================
/*
    dense_rank() over(order by �÷�...) : over() ���� �÷��� ���� ���� �� ������ �ű�.
    �ߺ������Ϳ� ���� ���� ������ �ű�� �� ���� �������ʹ� �ǳʶ� ���� ���������� ������ �ű�
    -> �� �������� ������ ������ ��ȣ�� ��ġ���� ���� �� ����
*/

select
    dense_rank() over(order by salary desc)"����",
    emp_name,
    salary
from employee;
================================================================================
-- �޿��� ���� ���� �޴� 1~5 ��� ����
select
    "����",
    emp_name,
    salary
from (select 
        row_number() over(order by salary desc)"����",
        employee.* -- �ٸ� �����ͳ� �÷��� �Բ� *�� ���ְ� ������ ���̺��. *�� �������� ���ָ� ��
        from employee)
    where "����" <= 5;
    
    
    
select -- 5�� 10�� ������ ��� -> 1���������� 5������ �Խ���( �� �������� �� 10���� �Խñ� -> �۹�ȣ�� ���� ū �������� �������� ����)
    *
from(select
        row_number() over(order by salary desc)"����",
        emp_name"�����",
        salary"����"
        from employee)
    where ���� between 5 and 10;

-- ����(���ʽ����� -(salary +(salary*bounus)) *12)�� ���� ���� ������� ���� �ű�
-- 10~15�� ������ �������� ����, �����, ����, �����ڵ�, �μ��ڵ���� ���
select
    *
from(select 
        row_number() over(order by (salary + ((salary * nvl(bonus,0))) * 12) desc)"����",
        emp_name"�����",
        to_char((salary + (salary * nvl(bonus,0)) * 12),'L999,999,999')"����",
        job_code"�����ڵ�",
        nvl(dept_code,'����')"�μ��ڵ�"
        from employee)
    where ���� between 10 and 15;

-- ���� ���ʽ��� ���� �޴� ������ ������ �ű�
-- 4~8�� ������� ����, �̸�, �޿�, ���ʽ��� ���
select
    *
from(select
        dense_rank() over(order by nvl(bonus,0) desc)"����",
        emp_name"�̸�",
        salary"�޿�",
        nvl(bonus,0)"���ʽ�"
        from employee)
    where ���� between 4 and 8;
================================================================================