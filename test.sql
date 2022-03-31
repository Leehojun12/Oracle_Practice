--1
select emp_name"이름", email"이메일", length(email)"이메일 길이" from employee; 

--2
select email"이메일", rtrim(email,'@kh.or.kr')"ID" from employee;

--3
select emp_name"이름", substr(emp_no,1,8) || '******' "주민번호" from employee
    where substr(emp_no,6,1) in ('1','3');
    
--4
select emp_id"사번", emp_name"사원명", dept_code"부서코드", hire_date"입사일" from employee 
    where dept_code in('D5','D9') and hire_date like '04%';
--5
select emp_name"이름", emp_no"주민번호", replace(email,'kh.or.kr','iei.or.kr')"변경된 이메일" from employee;

select * from TB_DEPARTMENT;
select * from TB_STUDENT;
select * from TB_PROFESSOR;
select * from TB_CLASS;

--1
select department_name"학과명",category"계열" from TB_DEPARTMENT;

--2
select department_name || '의 정원은' || capacity ||'명 입니다.' from tb_department;

--3
select student_name"이름" from TB_STUDENT
    where student_ssn like '%-2%' and absence_yn ='Y';
    
--4
select student_name from TB_STUDENT
    where student_no in ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
    order by 1 desc;
    
--5
select department_name, category from TB_DEPARTMENT
    where capacity between 20 and 30;
    
--6
select professor_name from TB_PROFESSOR
    where department_no is null;
    
--7
select student_name from TB_STUDENT
    where department_no is null;
    
--8
select class_no from TB_CLASS
    where preattending_class_no is not null;
    
--9
select distinct category from TB_DEPARTMENT 
    order by 1;

--10 
select student_no,student_name,student_ssn from TB_STUDENT
    where entrance_date like '02%' and
    absence_yn ='N' and
    student_address like '%전주%';