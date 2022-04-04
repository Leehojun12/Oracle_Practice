/*
    ���ι�(JOIN)
    : �� �� �̻��� ���̺��� ���� �ϴ°� ->
        �����Ϸ��� �ϴ� ���̺��� �� ���̺��� ����� �÷��� �����ͷ� ���ļ� ǥ���ϴ� ��
        ������ �������� ������ ���� for ���� ����� ���·� ���� -> ��� ����� ���� ��ȸ
    ANSI ǥ�� Join
    Oracle Join
    
    ���ι��� ����� �� �� ���̺��� ������ �ִ� �÷��� ���� �� / �÷����� �ٸ� ��
*/
select * from employee, department
    order by 1;
-- �μ��ڵ尡 ���� employee, department ���̺��� ���, �����, �μ��ڵ�, �μ��� ��ȸ
-- oracle
select emp_id"���",
    emp_name"�����",
    dept_code"�μ��ڵ�",
    dept_title"�μ���"
from employee, department
    where dept_code = dept_id;
-- ANSI
select emp_id"���",
    emp_name"�����",
    dept_code"�μ��ڵ�",
    dept_title"�μ���"
from employee join department
    on (dept_code = dept_id);
================================================================================
-- �ΰ��� ���̺��� �÷����� ���� ��
 - employee, job;
 -- ��� , �����, �����ڵ�, ���޸�
 -- �� ���̺� ��Ī (,���̺�� ��Ī)
 -- �̸��� ���� �÷��� �տ� ���̺��� ��Ī. �÷��� �������� � ���̺��� �÷��� ����ϴ°��� ���
 -- Oracle
 select emp_id, emp_name, e.job_code, job_name
from employee e, job j
    where e.job_code = j.job_code;
-- ANSI : �� ���̺��� ���� �÷��� -> using(�÷���)
 select emp_id, emp_name, job_code, job_name
from employee join job
    using(job_code);
================================================================================
/*
1.Cross Join(��ȣ ����) : ���εǴ� ���̺� ������ �ɾ����� �ʾƼ� ��� ������(��� ����� �Ұ�) ���յǾ� ������ ���
    : �� ���̺��� �� ��� * �ٸ� ���̺��� �� ��� 
    
2. Inner Join(���� ����/ ������) : ���� ���� ����ϴ� join ����
    : ���̺� A�� ���̺� B���� ������ �´� �����͸� ��ȯ
    select �÷�.. from ���̺�A, ���̺�B where ����;
    select �÷�.. from ���̺�A, inner join ���̺�B on ����;
    select �÷�.. from ���̺�A join ���̺�B on ����;
    
3. Outer Join
 3-1 Left Outer Join(�ܺ� ����/ ������ -> ���� �ܺ� ����)
    : �����ϴ� ���̺� A�� �����͸� ��� ��ȯ, ���̺� B�� ���� ������ ��ġ�ϴ� �����͸� ��ȯ
    -> inner join ������ �ɰ� �Ǹ� ���ǿ��� �´� �����Ͱ� ��ȯ
    -> left outer join ������ ��ġ���� �ʾƵ� ���� ���̺��� �����ʹ� ��� ��ȯ
    
    oracle : select �÷� .. from ���̺�A, ���̺�B where �÷� = �÷� (+);
    ANSI : select �÷�.. from ���̺�A left outer join ���̺�B on()/using();
    
 3-2 Right Outer Join(������/ ������ �ܺ� ����)
    : �����ϰ��� �ϴ� ���̺� A �� ���̺� B�� ���� ��, ���̺� A�� ���� ������ ��ġ�ϴ� �����͸� ��ȯ, ���̺� B�� ���ǿ� ������� ��� ������ ��ȯ
    
    oracle : select �÷� .. from ���̺� A , ���̺� B where �÷�(+) = �÷�;
    ANSI : select �÷�.. from ���̺� A, right outer join ���̺� B on()/using();
 
 3-3. Full Outer Join
    : ���̺� A�� ���̺� B�� ������ �� ���ǿ� ���� �ʴ��� ��� ������ ���
    
    ANSI : select �÷�.. from ���̺� A full outer join ���̺� B on()/using();
    
4. Self Join : �ٸ� ���̺��� �ƴ� ���� ���̺��� �����ϴ� ��
    -> �Ȱ��� ���̺��� join �ϱ� ������ �� ���̺� ��Ī�� �ݵ�� ����
    -> ����Ϸ��� �÷��� � ��Ī�� �ش��ϴ� �÷����� ����Ϸ��°��� ��Ȯ�� ������� -> ��ȣ...
    
5. ���� Join : ���� ���� ���ι��� ����ϴ� ���

** Non-Equi Join(�� ����)
    -> ������ �÷��� ���� ��ġ�ϴ� ��찡 �ƴ϶�
        ���� ������ ���ԵǴ� ���� ����(between , <, >, <= ��)
*/
================================================================================
-- 1. Cross
select * from employee, department; -- Oracle
select *from employee cross join department; -- ANSI
-- Inner join
select * from employee,department where dept_code = dept_id; -- Oracle
select * from employee inner join department on(dept_code = dept_id); -- ANSI

-- �ѹ���, ȸ��������� ������� �����, �̸���, �μ���, �μ��ڵ常 ��ȸ
select emp_name"�����", -- Oracle
    email"�̸���", 
    dept_title"�μ���", 
    dept_code"�μ��ڵ�"
from employee, department
    where dept_code = dept_id
    and dept_title in ('�ѹ���','ȸ�������');
select emp_name"�����", -- ANSI
    email"�̸���", 
    dept_title"�μ���", 
    dept_code"�μ��ڵ�"
from employee inner join department 
    on(dept_code = dept_id)
    where dept_title in('�ѹ���','ȸ�������');
    
-- �ؿܿ�����(�ؿܿ���1, 2, 3��)�� ��� �������� ���, �����, �μ���, �μ��ڵ�, ���� ���
select emp_no"���",
    emp_name"�����",
    dept_title"�μ���",
    dept_code"�μ��ڵ�",
    to_char(salary*12,'L999,999,999')"����"
from employee inner join department
    on(dept_code = dept_id)
    where dept_title like '%�ؿܿ���%'
    order by 3;
-- �븮�� ��� (��å = �븮)���� �޿� ��� Ȯ��
-- �븮�� ������� �����, �����ڵ�, ���޸�, �μ��ڵ�(null-����), ���� ��ȸ
select emp_name"�����",
    e.job_code"�����ڵ�",
    job_name"���޸�",
    nvl(dept_code,'����')"�μ��ڵ�",
    to_char(salary,'L999,999,999')"����"
from employee e, job j
    where e.job_code = j.job_code
    and job_name = '�븮'
    order by 1, 5 desc;
================================================================================
-- Left Outer Join
-- ��� ������ �μ����� ���
select emp_name, dept_title from employee, department where dept_code = dept_id;
-- inner join�� ������� ��� ������ ��ġ���� �ʴ� �����Ͱ� full�� ��ȸ���� ���� ��� �߻�

-- Oracle
select emp_name, dept_title
from employee, department
    where dept_code = dept_id(+);
-- ANSI
select emp_name, dept_title
from employee left outer join department
    on (dept_code = dept_id);
 
-- ��������θ� �����ϰ� ��� �μ� ������ ���, �����, �μ���, ���� ��ȸ
select emp_id"���", 
    emp_name"�����",
    nvl(dept_title,'����')"�μ���",
    salary*12"����"
from employee left outer join department
    on(dept_code = dept_id)
    where dept_title not like '���������'
    or dept_code is null
    order by 3,1,4;
-- != / = / like / not like ���� equal �����ڸ� �̿��ϰ� �Ǹ� null ���� ���� ����� �� �񱳰� ���� �ʾ� ��� ���ܵ� ����
-- null ���� ���Խ�Ű�� �ʹٸ� ��ȸ������ where���� ������ �߰� 
================================================================================
-- Right Outer Join
-- Oracle
select emp_name, dept_title
from employee, department
    where dept_code(+) = dept_id;
-- ANSI
select emp_name, dept_title
from employee right outer join department
    on(dept_code = dept_id);
================================================================================
-- Full outer join
-- ��� ������, ��� �μ��� ���
select emp_name, dept_title
from employee full outer join department
    on(dept_code = dept_id);
================================================================================
-- Non-Equi Join
insert into kh.employee -- ���� ������ �߰� 
    values('999', '�žƶ�', '990101-1111111', 'gg@kh.or.kr', '01011111111', 'D8', 'J5', 'S1',
        8000, 0.3, null, to_date('90/02/06', 'YY/MM/DD'), null, 'N');

-- emp_id, emp_name, salary, sal_level -> sal_level -> min_sal �� max_sal ������ ��쿡��
select emp_id, emp_name, salary, s.sal_level
from employee e join sal_grade s
    on(salary between min_sal and max_sal);
    
delete employee where emp_name = '�žƶ�'; -- ���� ������ ����
================================================================================
-- Self Join
-- ������ ����鿡 ���� manager_id Ȯ��
select emp_id, emp_name, manager_id
from employee;

-- manager_id �� �ش��ϴ� �����(�Ŵ�����)�� �߰�
select e1.emp_id"�������",
    e1.emp_name "������",
    e1.manager_id"�Ŵ��� ���",
    e2.emp_name"�Ŵ�����"
from employee e1 join employee e2
    on(e1.manager_id = e2.emp_id);
    
-- �Ŵ������ �ش� �Ŵ����� �����ϰ� �ִ� �����, �޿��� ��ȸ
select e1.emp_name"�Ŵ�����",
    e2.emp_name"�����",
    e2.salary"�޿�"
from employee e1 join employee e2
    on(e1.emp_id = e2.manager_id);
================================================================================
-- ���� Join
-- employee department ���� -> ���, �����, �μ��ڵ�, �μ���
select emp_id"���",
    emp_name "�����",
    dept_code"�μ��ڵ�",
    dept_title"�μ���"
from employee join department
    on(dept_code = dept_id);

-- ���, �����, �μ��ڵ�, �μ��� + �μ�������
select * from location;

select dept_id,
    dept_title,
    local_name
from department join location
    on(location_id = local_code);

-- ANSI    
select emp_id"���",
    emp_name "�����",
    dept_code"�μ��ڵ�",
    dept_title"�μ���",
    local_name"������"
from employee join department on(dept_code = dept_id)
    join location on(location_id = local_code); 

-- oracle
select emp_id"���",
    emp_name "�����",
    dept_code"�μ��ڵ�",
    dept_title"�μ���",
    local_name"������"
from employee, department, location                                     
    where dept_code = dept_id 
    and location_id = local_code;