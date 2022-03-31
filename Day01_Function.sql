/*
    �ڹٿ����� �޼���(method) = ����Ŭ������ �Լ�(function)
    
    - ���� �� �Լ� : �� �ึ�� �ݺ������� ����ż� �Է¹��� ���� ������ŭ ����� ��ȯ
    ex) length() -> �������� ���� �� ��ȯ
    - �׷� �Լ� : Ư���� ����� �������� �׷��� �����Ǿ� => �׷�� 1���� ����� ��ȯ
    - ������ �Լ� 
    - lengthb() : �־��� �÷� / ���ڿ��� ���� ����(byte)�� ��ȯ���ִ� �Լ�
    
    - instr(�÷� / ���ڿ�, ã���� �ϴ� ����(��), ���� �ε���, �˻��� ����(��)�� ����) : Ư�� ���ڿ����� ã���� �ϴ� ���ڿ��� ã���ִ� �Լ�
    
    - dual ���̺� : Oracle���� �������ִ� ���̺� (����, �Լ�, ���� �뵵�� ����ϴ� Ư���� ���̺�)
    
    - lpad(����� �Ǵ� �÷�/���ڿ�, ��ȯ�� ����, ������ ����(��)) / rpad() 
    : �־��� �÷�/���ڿ��� ������� �ؼ� ������ ���ڿ��� ���� /�����ʿ� ���ٿ��� ���� N�� ���ڿ��� ��ȯ�ϴ� �Լ�
    
    - ������� - ltrim(����� �Ǵ� �÷�/���ڿ�, �����ϰ� ���� ����(��)) / ���� ������ - rtrim()
    : �־��� �÷�/���ڿ��� ������� �����ϰ� ���� ���ڸ� ������ �� �������� ��ȯ�ϴ� �Լ�
    */
select emp_name, length(email) from employee;
select sum(salary) from employee;
select emp_name, length(emp_name), lengthb(emp_name) from employee;
select instr('Hello World Hi High','H',-1,2) from dual;
-- employee ���̺��� email, email �÷��� @ ��ġ�� ��ȸ
select email, instr(email,'@',1,1) from employee;
select lpad(email, 20,'#') from employee;
select rpad(email, 20,'#') from employee;
select rtrim (email,'kh.or.kr') from employee;
select ltrim (email, 'n') from employee;
=======================================================================================================================
-- ���� 1
-- Hello KH Java ���ڿ��� Hello KH �� ��µǰ� �Ͽ���.
select rtrim('Hello KH Java','Java') from dual;

-- ���� 2
-- Hello KH Java ���ڿ��� KH Java �� ��µǰ� �Ͽ���.
select ltrim('Hello KH Java','Hello') from dual;

-- ���� 3
-- DEPARTMENT ���̺��� DEPT_TITLE�� ����Ͽ���
-- �̶�, ������ �� ���ڸ� ���� ��µǵ��� �Ͽ��� / ex)ȸ������� -> ȸ�����
select dept_title, rtrim(dept_title,'��') from department;

-- ���� 4
-- �������ڿ����� �յ� ��� ���ڸ� �����ϼ���.
-- '982341678934509hello89798739273402'
select rtrim(ltrim('982341678934509hello89798739273402','0123456789'),'0123456789') from dual;
=======================================================================================================================
-- substr(����� �Ǵ� �÷�/���ڿ�, ���ڿ��� �߶� ��ġ(�ε���), ��ȯ�� ������ ����)
--  : ����� �Ǵ� �÷�/���ڿ����� ������ġ�κ��� ������ ������ ������ŭ ����(��)�� �߶� ��ȯ���ִ� �Լ�
select substr('HappyHappyDay',-7,3) from dual;
-- employee ���̺��� ����� ��ȸ -> ���� �ߺ����� ���������� ��ȸ
select distinct substr(emp_name,1,1) from employee order by 1;
=======================================================================================================================
-- employee ���� ����� �����ȣ, �����, �ֹι�ȣ, ������ ��ȸ
-- �ֹι�ȣ 111111-******�� ǥ��
select * from employee;
select emp_id"�����", emp_name "�̸�", rpad(rtrim(emp_no,'0123456789'),13,'*') "�ֹι�ȣ", salary"����" from employee 
    where emp_no like '%-1%';
select emp_id"�����", emp_name "�̸�", substr(emp_no,1,8) || '******' "�ֹι�ȣ", salary"����" from employee 
    where substr(emp_no, 8,1) in ('1','3');
=======================================================================================================================
-- concat(����ڿ�1, ��� ���ڿ�2) : �ΰ��� ���ڿ��� �ϳ��� ��ģ �� ��ȯ���ִ� �Լ�
select concat(concat('ABCD','�����ٶ�'),'Hi') from dual;
select 'ABCD' || '�����ٶ�' || 'Hi' from dual;
=======================================================================================================================
--  lower(��� ���ڿ�/�÷�) / upper(��� ���ڿ�/�÷�) / initcap(��� ���ڿ�/�÷�)
--   : lower -> ��� ���ڿ��� ��� �ҹ��ڷ� ��ȯ���ִ� �Լ�
--   : upper -> ��� ���ڿ��� ��� �빮�ڷ� ��ȯ���ִ� �Լ�
--   : initcap -> �ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ���ִ� �Լ�
select lower('Welcome To My World') from dual;
select upper('Welcome To My World') from dual;
select initcap('welcome to my world') from dual;
=======================================================================================================================
-- replace(����� �Ǵ� ���ڿ�/�÷�, �������� �Ǵ� ����(��), ������ ����(��)) 
--    : ����� �Ǵ� ���ڿ�/�÷��� �������� �������� �Ǵ� ����(��)�� ã�Ƽ� ������ ����(��)�� �ٲ��ִ� �Լ�
select replace('Hello Hi High','Hi','Ho') from dual;
select replace('Hello Hi High','Hi','') from dual;
=======================================================================================================================
-- ������ �Լ�
--  abs(����) : ���ڷ� ���޹��� ������ ���밪�� ��ȯ���ִ� �Լ�
select abs(-10) from dual;

-- mod(����, ���� ��) : ���ڷ� ���޹��� ���ڸ� ���� ������ �������� ��ȯ���ִ� �Լ�
select mod(10, 4) from dual;
-- round(����) : ���ڷ� ���� ���ڸ� �ݿø��Ͽ� ��ȯ���ִ� �Լ�
select round(123.678) from dual;
-- round(����, �Ҽ��� �ε��� ��ġ) : ���ڷ� ���� ���ڸ� ������ ��ġ ���� �ڸ������� �ݿø��Ͽ� ��ȯ���ִ� �Լ�
select round(123.456, 2) from dual;
-- floor(����) : ���ڷ� ���� ������ �Ҽ��� �ڸ��� ��� ������ �Լ�
select floor(123.455123) from dual;
-- trunc(����, �Ҽ�����ġ) : ���ڷ� ���� ���ڸ� ������ ��ġ���� �߶� ��ȯ���ִ� �Լ�
select trunc(123.345, 2) from dual;
-- ceil(����) : ���ڷ� ���� ������ �Ҽ��� �ڸ��� ������ ��ȯ���ִ� �Լ�(�ø�)
select ceil(123.345) from dual;

-- employee ���̺��� ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ(�ָ��� ����, �Ҽ����Ʒ��� ����)
select * from employee;
select emp_name"������", hire_date"�Ի���", floor(sysdate-hire_date)"�ٹ��ϼ�" from employee;
=======================================================================================================================
-- ��¥ �Լ�
-- sysdate : �ý��ۿ� ����Ǿ��ִ� ���� ��¥(�ð� ����) ��ȯ
select sysdate from dual;
-- current_date : session(����) timezone�� ���� ���� ��¥(�ð�) ��ȯ
select current_date from dual;
-- months_between(��¥��, ��¥��) : �� ��¥ ������ ���� �� ���̸� ��ȯ���ִ� �Լ�
select floor(months_between(sysdate, hire_date)/12) from employee;
select floor(months_between(sysdate, sysdate+32)) from employee;
-- add_months(���� ��¥, ���� ���� ��) : ù ��° ���� ���� ��¥�� �������� �ؼ� �� ��° ���ڰ��� ���ؼ� ��ȯ���ִ� �Լ�
select add_months(sysdate, -1) from dual;
select emp_name, hire_date, add_months(hire_date,6) from employee;
-- next_day(���� ��¥, ����/����) : ���� ��¥�� �������� �����ʿ� �ش��ϴ� ���� ����� ��¥�� ��ȯ���ִ� �Լ�
-- ������ ���� : '��' Ȥ��'������'
-- 1~7 -> ��~��
select next_day(sysdate, 1) from dual;

-- last_day(���� ��¥) : ���� ��¥�� �������� �ش� ��¥�� ���� ���� ������ ���� ��ȯ���ִ� �Լ�
select last_day(add_months(sysdate,1)) from dual;
select emp_name, hire_date, last_day(add_months(sysdate,1)) from employee;

-- extract(year/month/day from date(���س�¥)) : ���س�¥�κ��� ��/��/���� �����ؼ� ��ȯ���ִ� �Լ�
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;
=======================================================================================================================
-- ����
-- �Ի�⵵ YYYY�� MM��DD�� ǥ��
-- ������ �ø�
-- 
select * from employee;
select emp_name, extract(year from hire_date)||'��'
    || extract(month from hire_date)||'��'
    || extract(day from hire_date)||'��' "�Ի�⵵",
    ceil((sysdate-hire_date)/365)||'����' "����"
    from employee
     order by 3;
-- ���ڿ��� �������� order by -> ���ڷν� �� ���� ���ڸ� �۴ٰ� �ν� (10�� 3�� �ִٸ� 10�� �� ������)

-- Ư�� ���ʽ��� ���� -> �ڷᰡ �ʿ� 
-- employee -> �Ի����� �������� ������ 1�Ϻ��� 6���� ����ؼ� ��ȸ
-- �����, �Ի���, ������, ������ + 6����
-- 22/01/05 �Ի� -> 22/02/01 ������ -> 22/08/01 ������+ 6����
-- ��½� �Ի��� ���� ���
select emp_name "�����", hire_date"�Ի���",last_day(add_months(hire_date,6))+1"������+6" from employee order by 2;
=======================================================================================================================
-- ����ȯ
-- to_char(date/number, format) : ��¥ Ȥ�� ���ڸ� Ư���� ������ ���������� ��ȯ���ִ� �Լ�
select sysdate from dual;
select to_char(sysdate, 'YYYY-MM-DD') from dual;

select emp_name "�����", 
    to_char(hire_date,'YYYY"��"MM"��"DD"��"')"�Ի�����" 
from employee;

--day : x����
select to_char(sysdate, 'YY/MM/DD/DAY') from dual;
--dy : x(����)
select to_char(sysdate, 'YY/MM/DD/DY') from dual;
-- MONTH : x��
select to_char(sysdate, 'YY/MONTH/DD/DY') from dual;
-- HH / MI / SS �ú���
select to_char(sysdate, 'HH:MI:SS') from dual;
-- PM/AM : ���� / ����
select to_char(sysdate, 'PMHH:MI:SS') from dual;
--HH24 : 24�ð� ���� ǥ��
select to_char(sysdate, 'HH24:MI:SS') from dual;

--employee ���̺� �����, �Ի��� -> 1990/02/05 ȭ���� ���� ��ȸ
select emp_name"�����", 
    to_char(hire_date,'YYYY/MM/DD/(DY)')"�Ի���" 
from employee;
=======================================================================================================================
-- ���� -> ������
-- to_char(��� ����, )
-- 123456789 -> 0�̳� 9�� �̿��� ���������� ��ȯ
select to_char(123456789, '000,000,000') from dual;
select to_char(12345, '999,999,999') "9",
    to_char(12345, '000,000,000') "0"
from dual;

-- ��(��)ȭ ǥ�� -> L (local)
-- nvl(����/�÷�, ġȯ ��) : ���� �ش� ����/�÷� ���� null ���̶�� ġȯ������ ��ȯ���ִ� �Լ�
select to_char(12345, 'L999,999') from dual;
-- employee -> ������, �����ڵ�, ����(��) ��ȸ
-- ��, ������  ��12,345
-- ���� ���ʽ��� ����� �ݾ����� ��ȸ((����*bonus)*12)
select emp_name "������",
    job_code"�����ڵ�",
    to_char(salary,'999,999,999') "����(��)",    
    to_char((salary + (salary*nvl(bonus, 0))*12),'L999,999,999')"����(��)*���ʽ�" 
from employee;
=======================================================================================================================
-- to_date(����/����, ����) : ������ Ȥ�� ������ �����͸� ����Ʈ(��¥) Ÿ������ �ٲ��ִ� �Լ�
-- 20100505
select to_date(20120505, 'YYYYMMDD') from dual;
select to_date('20120505', 'YYYYMMDD') from dual;
-- �ð����� ��ȯ�Ҷ� �տ� ��/��/�� ������ ���� ������ ���� ���� 1�Ϸ� ��¥�� �ν��ع���.
select to_char(to_date('110331', 'hh:mi:ss'), 'YYYY/MM/DD hh:MI:SS') from dual;
-- �⵵ ���� ��ȯ�Ҷ� 2000/1900��뿡 ���� ���� ��Ȯ�� �������� ������ 2000��븦 default ������ �ν�
select to_char(to_date('890909', 'YY/MM/DD'),'YYYY/MM/DD') from dual;
select emp_name "�����",
    emp_no "���",
    hire_date "�Ի���"
from employee
    where hire_date >= to_date('20000101','YYYYMMDD');
=======================================================================================================================
-- to_number(������, ����) : �������� ���������� ��ȯ���ִ� �Լ�
select to_number('123,456,789', '999,999,999') from dual;
select to_number('123,456,789', '999,999') from dual; -- �Ѱ��ִ� �������Ŀ� ���� �������ĵ� �����ϰ�.
select to_number('s23,456', '999,999') from dual; -- ���ڷ� ��ȯ�Ұ��� ���ڿ��� �Ѱ��� �� X

-- ������ ����ȯ : ����Ŭ������ �ڵ������� �ڷ����� �����ؼ� ����ȯ
select emp_name, salary from employee
    where salary = 8000000;
select 25 + '25' from dual;
select emp_name, hire_date from employee
    where hire_date = to_date('20130206', 'YY/MM/DD');
    
/*
60����� ������� ���, ���ʽ� ���� ���
�׶� ���ʽ� ���� null�� ��쿡�� 0% ��� ���
*/
select emp_name "������",
    substr(emp_no,1,2)"���",
    nvl(bonus,0)*100||'%'"���ʽ�"
from employee
    where substr(emp_no,1,2) between 60 and 69;
=======================================================================================================================
-- �׷� �Լ�
-- sum(����/�÷�) : �ش� �÷�/ ���� ���� �� ���� �����ִ� �Լ�
-- �׷��Լ��� ����Ҷ����� ������ ������� ���´ٴ� ��
select dept_code, sum(salary) from employee
    where dept_code = 'D5';
select * from employee;
-- avg(�÷�) : �ش� �÷� ������ ����� �����ִ� �Լ�
select round(avg(salary)) from employee;
-- �� ������ ���ʽ� ��� -> �Ҽ��� ��°�ڸ������� �ݿø��ؼ� ��ȸ
select round(avg(nvl(bonus,0)),2)"���ʽ�" from employee;

--count(�÷�) : �ش� �÷� -> �������� ������ ��ȯ���ִ� �Լ�
select count(*) from employee;
-- bonus�� �����ؾ��ϴ� ����� �� ī��Ʈ
select count(*) from employee
    where bonus is not null;
-- �μ��ڵ尡 D5�� ����� �� ī��Ʈ
select count(*) from employee
    where dept_code = 'D5';
-- ������� ���� �ִ� �μ��� �� ī��Ʈ
select count(distinct dept_code) from employee;

-- max/min(�÷�) : �ش� �׷쿡�� �ִ밪/ �ּڰ��� ��ȯ���ִ� �Լ�
select max(salary), min(salary) from employee;
--employee ���̺��� ���� ���� ���� ����� �Ի��� / ���� ���� ���� ����� �Ի��� ��ȸ
select min(hire_date), max(hire_date) from employee;
