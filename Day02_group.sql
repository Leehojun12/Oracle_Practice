/*
    group by : �׷��Լ��� �̿��� ���� ���� ������� �����ϰ� ���� ��(�׷캰 ����)
    -> �׷��Լ��� �� �Ѱ��� ������� ����
    -> �׷��Լ��� ����� �׷� �������� �ؼ� group by ���� �ش� �׷�(�÷�) ����� ���
    
    select sum(salary) from employee group by dept_code;
*/
select nvl(dept_code, '����'), 
    sum(salary) 
from employee 
    group by dept_code;
    
select count(*) from employee
    group by dept_code;