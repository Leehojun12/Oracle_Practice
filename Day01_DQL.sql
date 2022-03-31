/*
select : 테이블에서 데이터를 조회
    1. select 컬럼명 from 테이블명;
    2. select 컬럼명 from 테이블명 where 조건;
*/

select * from employee;
select emp_name from employee;
select emp_name, email, phone from employee;
-- 조건 
select * from employee where dept_code = 'D9';
select * from employee where salary >= 7000000;
select * from employee where dept_code = 'D5' and sal_Level = 'S5';
select * from employee where salary >= 3000000 or job_code = 'J6';

-- job 테이블에서 job_name의 정보를 모두 조회해 보시오.
select job_name from job;
-- department 테이블의 모든 데이터를 조회
select * from department;
-- employee 테이블에서 emp_name, email, phone, hire_date 의 데이터 조회
select emp_name, email, phone, hire_date from employee;
-- employee 테이블에서 월급(salary)이 250만원 이상인 사람들의 emp_name, sal_level 조회
select emp_name, sal_level from employee where salary >= 2500000;
-- employee 테이블에서 emp_name, phone을 조회 -> 조건: 월급이 350만원 이상이면서 job_code가 J3인 사람
select emp_name, phone from employee where salary >= 3500000 and job_code = 'J3';
-- 컬럼 산술 연산
select emp_name, salary*12 from employee;
-- select문을 통해 조회되는 결과들 ResultSet
select emp_name as "직원명", salary*12 "연봉(원)" from employee;
-- 임의의 문자열을 실제 데이터 값처럼 보이게끔 리터럴 추가 가능
select emp_name "직원명", salary*12 || '원' "연봉" from employee;

--employee 테이블에서 emp_name(이름), 근무 일수를 출력해보세요.(sysdate)
select emp_name "이름", sysdate-hire_date "근무 일수"from employee;

select * from employee;
-- employee 테이블에서 20년 이상 근무한 사람의 이름, 월급, 보너스율 조회
select emp_name "이름", salary "월급", bonus "보너스율" from employee 
    where (sysdate-hire_date)/365 >= 20;
    
-- disticnt : 중복값 제거 -> 한번만 표시
select job_code from employee;
select DISTINCT job_code from employee;

/*
    연산자 
    = : 같다 
    > , < : 작다, 크다
    >= , <= : 이상, 이하
    != : 같지 않다
    between A and B : A와 B의 사이 특정범위가 포함하는지
    like / not like : 문자 패턴 비교
    is null / is not null : null 값 비교
    in / not in : 특정한 값이 값 목록에 포함 여부 
*/

-- between
-- employee 급여가 350만원보다 많고 600만원보다 적은 사원의 이름 급여 조회
select emp_name "이름", salary"월급" from employee where salary between 3500000 and 6000000;
-- employee 테이블에서 고용일이 90/01/01 ~ 01/01/01 사이인 직원의 전체 데이터를 조회
select * from employee where hire_date between '90/01/01' and '01/01/01';

-- like : 비교하려고 하는 값이 특정한 패턴을 만족시켰을 때 true 값을 반환하는 연산자
-- '%' '_' : 와일드카드(아무값이 대체해서 사용할 수 있는 것)
-- % : 0글자이상
-- _ : 한글자
-- 와일드카드 문자와 만약 문자열로써 사용하고픈 특수문자가 동일한 경우 -> 모두다 와일드카드 문자로 인식
-- escape 옵션 사용 -> like '_#_' escape '#' : #뒤로 오는 문자는 와일드카드가 아닌 문자열로 인식
-- employee 테이블에서 직원명, 급여 -> 조건 : '전'씨 성을 가진 직원
select emp_name, salary from employee where emp_name like '전__';

-- employee 테이블에서 직원의 이메일 중에서 '_' 앞자리가 3자리인 직원명과 이메일을 조회
select * from employee;
select emp_name, email from employee where email like '___!_%' escape '!';

-- not like
-- '이'씨 성이 아닌 직원의 사번, 이름, 이메일을 조회
select emp_id,emp_name,email from employee where emp_name not like '이%';
-- employee 에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호 조회
select emp_name, phone from employee where phone not like '010%';

-- employee 테이블에서 메일주소에 's'가 들어가고, dept_code는 D9 혹은 D6이고, 
--    고용일이 90/01/01~00/12/01 이면서, 월급이 270만원 이상인 직원의 모든 정보 조회
select * from employee where email like '%s%' and (dept_code = 'D9' or dept_code = 'D6')
     and (hire_date between '90/01/01' and '00/12/01') and salary >= 2700000; 
     
-- is null / is not null
select * from employee where manager_id is null;
select * from employee where manager_id is not null;

-- in / not in
-- employee 테이블에서 부서코드가 D9 이거나 D6 이거나인 사원의 정보를 조회
select * from employee where dept_code in ('D9','D6','D5');
select * from employee where dept_code not in ('D9','D6','D5');

select emp_name, salary from employee;
-- order by : select 한 컬럼에 대해 정렬을 할때 사용하는 구문
-- order by 기준 컬럼명/ 인덱스
-- default 값 -> 오름차순 값(ASC_Ascending)
-- 내림차순(DESC_Descending)
select * from employee order by salary;
select * from employee order by salary desc;
select * from employee order by 10;

select * from employee;

-- 쿼리문의 실행 순서
-- from -> where -> select -> order by
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라
select emp_name "이름", emp_no"주민번호", salary"월급",(sysdate-hire_date)/365"근무년수" from employee 
    where (sysdate-hire_date)/365 
    between 5 and 10;
-- 재직중이 아닌 직원의 이름,부서코드를 검색하여라 (퇴사 여부 : ENT_YN)
select emp_name, dept_code from employee 
    where ent_yn != 'N';
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 조회
select emp_name, emp_no, salary, email, phone , hire_date from employee 
    where (hire_date between '99/01/01' and '10/01/01') and 
    salary <= 2000000;
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수를  오름차순(근속년수 기준)으로 정렬하여 조회
-- 단, 급여는 50% 인상된 급여로 조회
select salary *1.5, emp_name, (sysdate-hire_date)/365 from employee 
    where(sysdate-hire_date)/365 >= 10 
    order by 3;
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 조회.
select emp_name, emp_no, salary, dept_code from employee 
    where (salary between 2000000 and 3000000) and 
    emp_no like '___4%-2%' 
    order by emp_no desc;   
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 오름 차순 정렬(사원명 기준) 조회.
-- 즉 근무일수 1000일마다 급여의 10% 보너스 발생
select emp_name,((sysdate-hire_date) / 1000)*(salary * 0.1)"특별보너스" from employee 
    where emp_no like '%-1%' and 
    bonus is null 
    order by emp_name;






