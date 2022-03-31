/*
select : ���̺��� �����͸� ��ȸ
    1. select �÷��� from ���̺��;
    2. select �÷��� from ���̺�� where ����;
*/

select * from employee;
select emp_name from employee;
select emp_name, email, phone from employee;
-- ���� 
select * from employee where dept_code = 'D9';
select * from employee where salary >= 7000000;
select * from employee where dept_code = 'D5' and sal_Level = 'S5';
select * from employee where salary >= 3000000 or job_code = 'J6';

-- job ���̺��� job_name�� ������ ��� ��ȸ�� ���ÿ�.
select job_name from job;
-- department ���̺��� ��� �����͸� ��ȸ
select * from department;
-- employee ���̺��� emp_name, email, phone, hire_date �� ������ ��ȸ
select emp_name, email, phone, hire_date from employee;
-- employee ���̺��� ����(salary)�� 250���� �̻��� ������� emp_name, sal_level ��ȸ
select emp_name, sal_level from employee where salary >= 2500000;
-- employee ���̺��� emp_name, phone�� ��ȸ -> ����: ������ 350���� �̻��̸鼭 job_code�� J3�� ���
select emp_name, phone from employee where salary >= 3500000 and job_code = 'J3';
-- �÷� ��� ����
select emp_name, salary*12 from employee;
-- select���� ���� ��ȸ�Ǵ� ����� ResultSet
select emp_name as "������", salary*12 "����(��)" from employee;
-- ������ ���ڿ��� ���� ������ ��ó�� ���̰Բ� ���ͷ� �߰� ����
select emp_name "������", salary*12 || '��' "����" from employee;

--employee ���̺��� emp_name(�̸�), �ٹ� �ϼ��� ����غ�����.(sysdate)
select emp_name "�̸�", sysdate-hire_date "�ٹ� �ϼ�"from employee;

select * from employee;
-- employee ���̺��� 20�� �̻� �ٹ��� ����� �̸�, ����, ���ʽ��� ��ȸ
select emp_name "�̸�", salary "����", bonus "���ʽ���" from employee 
    where (sysdate-hire_date)/365 >= 20;
    
-- disticnt : �ߺ��� ���� -> �ѹ��� ǥ��
select job_code from employee;
select DISTINCT job_code from employee;

/*
    ������ 
    = : ���� 
    > , < : �۴�, ũ��
    >= , <= : �̻�, ����
    != : ���� �ʴ�
    between A and B : A�� B�� ���� Ư�������� �����ϴ���
    like / not like : ���� ���� ��
    is null / is not null : null �� ��
    in / not in : Ư���� ���� �� ��Ͽ� ���� ���� 
*/

-- between
-- employee �޿��� 350�������� ���� 600�������� ���� ����� �̸� �޿� ��ȸ
select emp_name "�̸�", salary"����" from employee where salary between 3500000 and 6000000;
-- employee ���̺��� ������� 90/01/01 ~ 01/01/01 ������ ������ ��ü �����͸� ��ȸ
select * from employee where hire_date between '90/01/01' and '01/01/01';

-- like : ���Ϸ��� �ϴ� ���� Ư���� ������ ���������� �� true ���� ��ȯ�ϴ� ������
-- '%' '_' : ���ϵ�ī��(�ƹ����� ��ü�ؼ� ����� �� �ִ� ��)
-- % : 0�����̻�
-- _ : �ѱ���
-- ���ϵ�ī�� ���ڿ� ���� ���ڿ��ν� ����ϰ��� Ư�����ڰ� ������ ��� -> ��δ� ���ϵ�ī�� ���ڷ� �ν�
-- escape �ɼ� ��� -> like '_#_' escape '#' : #�ڷ� ���� ���ڴ� ���ϵ�ī�尡 �ƴ� ���ڿ��� �ν�
-- employee ���̺��� ������, �޿� -> ���� : '��'�� ���� ���� ����
select emp_name, salary from employee where emp_name like '��__';

-- employee ���̺��� ������ �̸��� �߿��� '_' ���ڸ��� 3�ڸ��� ������� �̸����� ��ȸ
select * from employee;
select emp_name, email from employee where email like '___!_%' escape '!';

-- not like
-- '��'�� ���� �ƴ� ������ ���, �̸�, �̸����� ��ȸ
select emp_id,emp_name,email from employee where emp_name not like '��%';
-- employee ���� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ ��ȸ
select emp_name, phone from employee where phone not like '010%';

-- employee ���̺��� �����ּҿ� 's'�� ����, dept_code�� D9 Ȥ�� D6�̰�, 
--    ������� 90/01/01~00/12/01 �̸鼭, ������ 270���� �̻��� ������ ��� ���� ��ȸ
select * from employee where email like '%s%' and (dept_code = 'D9' or dept_code = 'D6')
     and (hire_date between '90/01/01' and '00/12/01') and salary >= 2700000; 
     
-- is null / is not null
select * from employee where manager_id is null;
select * from employee where manager_id is not null;

-- in / not in
-- employee ���̺��� �μ��ڵ尡 D9 �̰ų� D6 �̰ų��� ����� ������ ��ȸ
select * from employee where dept_code in ('D9','D6','D5');
select * from employee where dept_code not in ('D9','D6','D5');

select emp_name, salary from employee;
-- order by : select �� �÷��� ���� ������ �Ҷ� ����ϴ� ����
-- order by ���� �÷���/ �ε���
-- default �� -> �������� ��(ASC_Ascending)
-- ��������(DESC_Descending)
select * from employee order by salary;
select * from employee order by salary desc;
select * from employee order by 10;

select * from employee;

-- �������� ���� ����
-- from -> where -> select -> order by
-- �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���
select emp_name "�̸�", emp_no"�ֹι�ȣ", salary"����",(sysdate-hire_date)/365"�ٹ����" from employee 
    where (sysdate-hire_date)/365 
    between 5 and 10;
-- �������� �ƴ� ������ �̸�,�μ��ڵ带 �˻��Ͽ��� (��� ���� : ENT_YN)
select emp_name, dept_code from employee 
    where ent_yn != 'N';
-- �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� ��ȸ
select emp_name, emp_no, salary, email, phone , hire_date from employee 
    where (hire_date between '99/01/01' and '10/01/01') and 
    salary <= 2000000;
-- �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ����  ��������(�ټӳ�� ����)���� �����Ͽ� ��ȸ
-- ��, �޿��� 50% �λ�� �޿��� ��ȸ
select salary *1.5, emp_name, (sysdate-hire_date)/365 from employee 
    where(sysdate-hire_date)/365 >= 10 
    order by 3;
-- �޿��� 2000000�� ~ 3000000�� �� ������ �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ��ȸ.
select emp_name, emp_no, salary, dept_code from employee 
    where (salary between 2000000 and 3000000) and 
    emp_no like '___4%-2%' 
    order by emp_no desc;   
-- ���� ��� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ���� �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ���� ���� ����(����� ����) ��ȸ.
-- �� �ٹ��ϼ� 1000�ϸ��� �޿��� 10% ���ʽ� �߻�
select emp_name,((sysdate-hire_date) / 1000)*(salary * 0.1)"Ư�����ʽ�" from employee 
    where emp_no like '%-1%' and 
    bonus is null 
    order by emp_name;






