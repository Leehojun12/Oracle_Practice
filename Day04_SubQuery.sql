/*
    ���� ����(SubQuery)
    : �ϳ��� sql �� �ȿ� ���Ե� �ٸ� sql ��
    -> ���� ������ ���� ������ �����ϴ� �������� ����
    -> ���� ������ �Ұ�ȣ ������ / �������� �����ʿ� ��ġ / order by ���� suvquery ������ ��� �Ұ�
*/
select * from employee where emp_name = '������';
-- ������ ������ �Ŵ����� ���

-- ������ ������ �Ŵ��� ���̵�
select
    emp_name, manager_id
from employee
    where emp_name = '������';
-- �Ŵ��� ���̵�� ����� ���� ������ = �Ŵ�����
select
    emp_id, emp_name
from employee
    where emp_id = 214; -- ���� 
    
select
    emp_id, emp_name 
from employee
    where emp_id = (select manager_id from employee where emp_name = '������')
    or emp_id = (select manager_id from employee where emp_name = '�ڸ��');
================================================================================
/*
    �������� ����
    1. ������ ��������
    2. ������ �������� 
    3. ���߿� ��������
    4. ������ ���߿� ��������
    5. ��ȣ���� ��������
    6. ��Į�� ��������
*/
-- ������ �������� : �������� ��ȸ ��� ���� 1��(��)�� ���
-- �� ������ �޿� ��պ��� �޿��� ���� ���� ����� ���, �����, �����ڵ�, ���� ��ȸ
select floor(avg(salary)) from employee; --3047662

-- �ϵ������ ���(���� ����� �ƴ� ���)
select
    emp_id, emp_name, job_code, salary
from employee
    where salary > 3057662;
    
-- ��������
select
    emp_id, emp_name, job_code, salary
from employee
    where salary > (select floor(avg(salary)) from employee);

-- ������ ������ �޿��� ���� ������� �˻� -> ���, �����, �޿� ���( �����ش� ���X )
select salary from employee where emp_name = '������'; -- 2000000

select
    emp_id, emp_name, job_code, salary
from employee
    where salary = 2000000
    and emp_name not in '������';
    
-- ���� ����
select
    emp_id, emp_name, job_code, salary
from employee
    where salary = (select salary from employee where emp_name in '������')
    and emp_name not in '������';

-- employee : �޿��� ���� ���� ����� ���� ���� ����� ���, ������, �޿���ȸ
select
    max(salary), min(salary)
from employee;
    
-- ���� ����
select 
    emp_id, emp_name, salary
from employee
    where salary in((select max(salary) from employee),(select min(salary) from employee));
    
-- D5�μ� �������� ��տ���(�Ҽ�������)���� �� ���� ������ �޴� D1, D2�μ� ������ ���, �μ���ȣ, �����, ������ȸ
select floor(avg(salary)) from employee where dept_code = 'D5';-- 2626666

select 
    emp_id, emp_name, dept_code, salary
from employee
    where salary > 2626666
    and dept_code in ('D1','D2');

select
    emp_id, emp_name, dept_code, salary
from employee
    where salary > (select floor(avg(salary)) from employee where dept_code ='D5')
    and dept_code in ('D1','D2');
================================================================================
/*
    ������ �������� : �������� ��ȸ ����� ������(���� ��) �϶�.
    -> ������ �������� �տ��� = != ������ X
    -> in, not in, any, all, exists..
*/
-- ������(D9) �ڳ���(D5) ����� �����ִ� �μ��� ���� �μ������� ��� ���� ���
select emp_name, dept_code from employee where emp_name in('������', '�ڳ���');
select * from employee where dept_code in ('D9','D5');
select * from employee 
    where dept_code in (select dept_code from employee where emp_name in ('������','�ڳ���'));
    
    select * from employee;
    select * from job;
-- ���¿�(s5), ������(s4) ����� �޿����(sal_level)�� ���� ����� ���� ����� ���޸�, �����, �޿���� ���
select emp_name, sal_level from employee where emp_name in ('���¿�', '������');

select j.job_name, emp_name, sal_level from employee e, job j
    where sal_level in ('S5','S4')
    and e.job_code = j.job_code;
select 
    job_name, 
    emp_name, 
    sal_level 
from employee inner join job
    using(job_code)
    where sal_level in (select sal_level from employee where emp_name in ('���¿�','������'));

-- ������ ��ǥ, �λ����� �ƴ� �������� �����, �μ���, �����ڵ� -> ������ �μ���, ����� ������ �������� ����
select 
    emp_name, dept_title, job_code, job_name
from employee left outer join department on(dept_code = dept_id)
    inner join job using(job_code)
    where job_code in (select job_code from job where job_name not in ('��ǥ','�λ���'));
    order by 2,1;
================================================================================
/*
    any : ���� ���� ��� �߿� �ϳ��� ���̶�� �Ѵٸ� �� (or)
    �� > any(1,2,3) : ���ʿ� �ִ� ���� �������� �ּҰ����� ũ�� �ȴ�.
    �� < any(1,2,3) : ���ʿ� �ִ� ���� �������� �ִ񰪺��� ������ �ȴ�.
    �� = any(1,2,3) : in �� ���� �ǹ�
*/
-- �޿��� 200���� Ȥ�� 300�������� ū ����� �����, �޿� ���
select 
    emp_name, salary
from employee
    where salary = any(2000000,3000000);

-- job_code J3�� �������� �޿����� �� ���� �޿��� ���� ������� �̸�, �޿�
select 
    emp_name,salary
from employee
    where salary > any(select min(salary) from employee where job_code = 'J3');
    
-- D1, D5�� �μ��ڵ带 ���� ������� �޿����� ���� �޴� ������� �����, �޿�, �μ��ڵ� ���
-- �� D1, D5�μ� ������ ��� X
select salary from employee
    where dept_code in ('D1','D5');
    
select 
    emp_name,to_char(salary,'L999,999,999')"�޿�", dept_code
from employee
    where salary < any(select salary from employee where dept_code in ('D1','D5'))
    and nvl(dept_code,'����') not in ('D1','D5')
    order by 3;
================================================================================
/*
    ALL : ���� ���� ��� �߿� ��� ���� ���̿��߸� 
    �� > all(1,2,3) : ���ʿ� �ִ� ���� �����ʿ� �ִ� �ִ밪���� Ŀ����.
    �� < all(1,2,3) : ���ʿ� �ִ� ���� �����ʿ� �ִ� �ּڰ����� �۾ƾ���.
*/
-- J3 �� ���� �߿��� ���� ū �޿����� �� ���� �޿��� �޴� ������� �����, �޿�
select 
    emp_name, salary 
from employee 
    where salary < all(select salary from employee where job_code = 'J3');
================================================================================
/*
    ���߿� ���� ���� : �������� ��ȸ ��� ���� ������(��)�� ��
*/
-- ����� ������ -> ���� �μ�, ���� ���޿� �ش��ϴ� ����� �����, �����ڵ�, �μ��ڵ�, �Ի��� ��ȸ
select 
    dept_code, job_code
from employee
    where ent_yn = 'Y'
    and substr(emp_no,8,1) = 2; -- D8,J6

select
    emp_name, job_code, dept_code, hire_date
from employee
    where (dept_code, job_code) in (select dept_code, job_code from employee where ent_yn = 'Y' and substr(emp_no,8,1) = 2);

-- ������ ������ ���� �Ŵ����� ������ �ְ�, ���� �޿������� ������ �ִ� ����� �̸�, �޿�����, �Ŵ��� ID�� ��ȸ
select * from employee
    where emp_name = '������';
select 
    emp_name, sal_level, manager_id
from employee
    where (sal_level , manager_id) in (select sal_level, manager_id from employee where sal_Level = 'S5' and manager_id = 200)
    and emp_name not in '������';
    
-- ����������̸鼭 �޿��� 200������ ������ �����, �μ��ڵ�, �޿�, �μ��� ������ ���
select 
    emp_name, dept_code, salary, local_name
from employee inner join department on(dept_id = dept_code)
    inner join location on(location_id = local_code)
    where (salary,dept_code) in(select salary, dept_code from employee where salary = 2000000 and dept_title = '���������');

-- ������ 8/8�� ������ ���� �μ��ڵ�, �����ڵ带 ���� ������� �����, ����('0808'), �μ��ڵ�, �μ��� ���
-- ������ ���߿� ���� ����
select 
    emp_name, substr(emp_no,3,4), dept_code, dept_title
from employee inner join department on(dept_code = dept_id)
    where (dept_code, job_code) in (select dept_code, job_code from employee where substr(emp_no,3,4)= '0808')
    and substr(emp_no,3,4) not in '0808';
================================================================================
-- Join -> group by
-- �μ��ڵ�, �μ���, �μ��� ��ձ޿�, �μ��� �ο��� ���
select
    nvl(dept_code,'����')"�μ��ڵ�", 
    nvl(dept_title,'����')"�μ���",
    floor(avg(salary)) "�μ��� ��ձ޿�",
    count(*) "�μ��� �ο���"
from employee left outer join department on(dept_code = dept_id)
    group by dept_code, dept_title
    having count(*) >= 3
    order by 1;
================================================================================
/*
    �ζ��� ��(inlien-view)
    : from ������ ����ϴ� ��������
    -- �ζ��κ並 ����Ҷ��� �ζ��κ信�� ��ȸ�ؿ� �����Ϳ� ���ؼ��� �������������� �����͸� ������ �� ����
*/
select 
    emp_name, salary
from employee;

select 
    * -- from ���� column�� �����ü� ����
from(select emp_name, salary from employee);
================================================================================
/*
    ��Į�� �������� : select ������ ����ϴ� �������� -> �ϳ��� �÷��� ������ �� ����
*/
select
    emp_name
    ,(select dept_title from department where dept_code = dept_id)"dept_title"
from employee;