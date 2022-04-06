/*
    서브 쿼리(SubQuery)
    : 하나의 sql 문 안에 포함된 다른 sql 문
    -> 메인 쿼리가 버스 쿼리를 포함하는 종속적인 관계
    -> 서브 쿼리는 소괄호 묶어줌 / 연산자의 오른쪽에 위치 / order by 절은 suvquery 내에서 사용 불가
*/
select * from employee where emp_name = '전지연';
-- 전지연 직원의 매니저명 출력

-- 전지연 직원의 매니저 아이디
select
    emp_name, manager_id
from employee
    where emp_name = '전지연';
-- 매니저 아이디와 사번이 같은 직원명 = 매니저명
select
    emp_id, emp_name
from employee
    where emp_id = 214; -- 방명수 
    
select
    emp_id, emp_name 
from employee
    where emp_id = (select manager_id from employee where emp_name = '전지연')
    or emp_id = (select manager_id from employee where emp_name = '박명수');
================================================================================
/*
    서브쿼리 종류
    1. 단일행 서브쿼리
    2. 다중행 서브쿼리 
    3. 다중열 서브쿼리
    4. 다중행 다중열 서브쿼리
    5. 상호연관 서브쿼리
    6. 스칼라 서브쿼리
*/
-- 단일행 서브쿼리 : 서브쿼리 조회 결과 값이 1개(행)일 경우
-- 전 직원의 급여 평균보다 급여를 많이 받은 사원의 사번, 사원명, 직급코드, 월급 조회
select floor(avg(salary)) from employee; --3047662

-- 하드웨어적 방식(좋은 방법이 아닌 방식)
select
    emp_id, emp_name, job_code, salary
from employee
    where salary > 3057662;
    
-- 서브쿼리
select
    emp_id, emp_name, job_code, salary
from employee
    where salary > (select floor(avg(salary)) from employee);

-- 윤은해 직원과 급여가 같은 사원들을 검색 -> 사번, 사원명, 급여 출력( 윤은해는 출력X )
select salary from employee where emp_name = '윤은해'; -- 2000000

select
    emp_id, emp_name, job_code, salary
from employee
    where salary = 2000000
    and emp_name not in '윤은해';
    
-- 서브 쿼리
select
    emp_id, emp_name, job_code, salary
from employee
    where salary = (select salary from employee where emp_name in '윤은해')
    and emp_name not in '윤은해';

-- employee : 급여가 제일 높은 사람과 제일 낮은 사람의 사번, 직원명, 급여조회
select
    max(salary), min(salary)
from employee;
    
-- 서브 쿼리
select 
    emp_id, emp_name, salary
from employee
    where salary in((select max(salary) from employee),(select min(salary) from employee));
    
-- D5부서 직원들의 평균월급(소수점버림)보다 더 많은 월급을 받는 D1, D2부서 직원의 사번, 부서번호, 사원명, 월급조회
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
    다중행 서브쿼리 : 서브쿼리 조회 결과가 여러개(여러 행) 일때.
    -> 다중행 서브쿼리 앞에는 = != 연산자 X
    -> in, not in, any, all, exists..
*/
-- 송종기(D9) 박나라(D5) 사원이 속해있는 부서와 같은 부서원들의 모든 정보 출력
select emp_name, dept_code from employee where emp_name in('송종기', '박나라');
select * from employee where dept_code in ('D9','D5');
select * from employee 
    where dept_code in (select dept_code from employee where emp_name in ('송종기','박나라'));
    
    select * from employee;
    select * from job;
-- 차태연(s5), 전지연(s4) 사원의 급여등급(sal_level)과 같은 등급을 가진 사원의 직급명, 사원명, 급여등급 출력
select emp_name, sal_level from employee where emp_name in ('차태연', '전지연');

select j.job_name, emp_name, sal_level from employee e, job j
    where sal_level in ('S5','S4')
    and e.job_code = j.job_code;
select 
    job_name, 
    emp_name, 
    sal_level 
from employee inner join job
    using(job_code)
    where sal_level in (select sal_level from employee where emp_name in ('차태연','전지연'));

-- 직급이 대표, 부사장이 아닌 직원들의 사원명, 부서명, 직급코드 -> 정렬은 부서명, 사원명 순으로 오름차순 정렬
select 
    emp_name, dept_title, job_code, job_name
from employee left outer join department on(dept_code = dept_id)
    inner join job using(job_code)
    where job_code in (select job_code from job where job_name not in ('대표','부사장'));
    order by 2,1;
================================================================================
/*
    any : 서브 쿼리 결과 중에 하나라도 참이라고 한다면 참 (or)
    값 > any(1,2,3) : 왼쪽에 있는 값이 오른쪽의 최소값보다 크면 된다.
    값 < any(1,2,3) : 왼쪽에 있는 값이 오른쪽의 최댓값보다 작으면 된다.
    값 = any(1,2,3) : in 과 같은 의미
*/
-- 급여가 200만원 혹은 300만원보다 큰 사람의 사원명, 급여 출력
select 
    emp_name, salary
from employee
    where salary = any(2000000,3000000);

-- job_code J3인 직원들의 급여보다 더 많은 급여를 받은 사원들의 이름, 급여
select 
    emp_name,salary
from employee
    where salary > any(select min(salary) from employee where job_code = 'J3');
    
-- D1, D5의 부서코드를 가진 사원들의 급여보다 적게 받는 사원들의 사원명, 급여, 부서코드 출력
-- 단 D1, D5부서 직원은 출력 X
select salary from employee
    where dept_code in ('D1','D5');
    
select 
    emp_name,to_char(salary,'L999,999,999')"급여", dept_code
from employee
    where salary < any(select salary from employee where dept_code in ('D1','D5'))
    and nvl(dept_code,'미정') not in ('D1','D5')
    order by 3;
================================================================================
/*
    ALL : 서브 쿼리 결과 중에 모든 것이 참이여야만 
    값 > all(1,2,3) : 왼쪽에 있는 값이 오른쪽에 있는 최대값보다 커야함.
    값 < all(1,2,3) : 왼쪽에 있는 값이 오른쪽에 있는 최솟값보다 작아야함.
*/
-- J3 인 직원 중에서 가장 큰 급여보다 더 많은 급여를 받는 사원들의 사원명, 급여
select 
    emp_name, salary 
from employee 
    where salary < all(select salary from employee where job_code = 'J3');
================================================================================
/*
    다중열 서브 쿼리 : 서브쿼리 조회 결과 값이 여러개(열)일 때
*/
-- 퇴사한 여직원 -> 같은 부서, 같은 직급에 해당하는 사원의 사원명, 직급코드, 부서코드, 입사일 조회
select 
    dept_code, job_code
from employee
    where ent_yn = 'Y'
    and substr(emp_no,8,1) = 2; -- D8,J6

select
    emp_name, job_code, dept_code, hire_date
from employee
    where (dept_code, job_code) in (select dept_code, job_code from employee where ent_yn = 'Y' and substr(emp_no,8,1) = 2);

-- 하이유 직원과 같은 매니저를 가지고 있고, 같은 급여레벨을 가지고 있는 사원의 이름, 급여레벨, 매니저 ID를 조회
select * from employee
    where emp_name = '하이유';
select 
    emp_name, sal_level, manager_id
from employee
    where (sal_level , manager_id) in (select sal_level, manager_id from employee where sal_Level = 'S5' and manager_id = 200)
    and emp_name not in '하이유';
    
-- 기술지원부이면서 급여가 200만원인 직원의 상원명, 부서코드, 급여, 부서의 지역명 출력
select 
    emp_name, dept_code, salary, local_name
from employee inner join department on(dept_id = dept_code)
    inner join location on(location_id = local_code)
    where (salary,dept_code) in(select salary, dept_code from employee where salary = 2000000 and dept_title = '기술지원부');

-- 생일이 8/8인 사원들과 같은 부서코드, 직급코드를 가진 사원들의 사원명, 생일('0808'), 부서코드, 부서명 출력
-- 다중행 다중열 서브 쿼리
select 
    emp_name, substr(emp_no,3,4), dept_code, dept_title
from employee inner join department on(dept_code = dept_id)
    where (dept_code, job_code) in (select dept_code, job_code from employee where substr(emp_no,3,4)= '0808')
    and substr(emp_no,3,4) not in '0808';
================================================================================
-- Join -> group by
-- 부서코드, 부서명, 부서별 평균급여, 부서별 인원수 출력
select
    nvl(dept_code,'없음')"부서코드", 
    nvl(dept_title,'없음')"부서명",
    floor(avg(salary)) "부서별 평균급여",
    count(*) "부서별 인원수"
from employee left outer join department on(dept_code = dept_id)
    group by dept_code, dept_title
    having count(*) >= 3
    order by 1;
================================================================================
/*
    인라인 뷰(inlien-view)
    : from 절에서 사용하는 서브쿼리
    -- 인라인뷰를 사용할때는 인라인뷰에서 조회해온 데이터에 대해서만 메인쿼리문에서 데이터를 가져올 수 있음
*/
select 
    emp_name, salary
from employee;

select 
    * -- from 절에 column만 가져올수 있음
from(select emp_name, salary from employee);
================================================================================
/*
    스칼라 서브쿼리 : select 절에서 사용하는 서브쿼리 -> 하나의 컬럼만 가져올 수 있음
*/
select
    emp_name
    ,(select dept_title from department where dept_code = dept_id)"dept_title"
from employee;