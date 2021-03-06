/*
    Top N 분석 (Top N Query)
    : 컬럼에서 가장 큰 n개의 값을 혹은 가장 작은 n개의 값을 요청할 때 사용하는 쿼리
    -> 상위 / 하위 n개의 데이터를 추출하는 쿼리
    -> 회사에서 가장 많이 팔린 제품 10개는 무엇인가? / 회사에서 월급을 제일 많이 받는 사람 3명은 누구인가?
    -> 게시판 페이징 / 조회수가 높은 인기글 
*/
-- employee 테이블에서 가장 높은 급여를 받는 사람 5명
select
    emp_name, salary
from employee
    order by 2 desc;
    
/*
    rownum : 출력되는 select 문의 행마다 자동적으로 순위를 매겨주는 것
*/
select
    rownum,
    emp_name,
    salary
from employee
    order by 3 desc;
-- from -> where -> group by -> select -> order by
-- select 절이 order by 절보다 먼저 실행되면서 이미 rownum이 매겨진 후에 다시 재정렬되기 때문에 순서가 뒤죽박죽.
-- 우리가 원하는 기준에 맞춰 이미 정렬이 된 상태의 데이터에 대해 rownum -> 순서를 매겨야 함
-- 인라인뷰 -> 서브쿼리 안에서 월급이 제일 큰 순서대로 일단 데이터를 정렬
-- -> 실제 메인쿼리 rownum 사용하게 되면 이미 정렬된 데이터에 대해 순서가 매겨짐.
select * from employee order by salary desc;
select 
    rownum, emp_name, salary
from (select * from employee order by salary desc);

-- 가장 높은 급여를 받는 한사람의 대한 순위, emp_name, salary
select 
    rownum, emp_name, salary
from (select * from employee order by salary desc)
    where rownum <= 5;

-- 인라인뷰를 계속 사용해야하니 쿼리문이 길어짐.
/*
    row_number() over(order by 컬럼..) : over() 안쪽의 컬럼 순서에 따라 일단 정렬을 한 후에 순위를 매겨줌
    정렬 기준의 데이터에 중복 값이 있다면 원래 순서대로 순위를 19,20 식으로 매겨버린다.
*/

select
    row_number() over(order by salary desc)"순위",
    emp_name,
    salary
from employee;

-- 월급을 가장 많이 받는 top 5
/* 지금 상황에서 rownum을 where절에 사용하게 되면 원래 데이터의 정렬순서를 기준으로 
일단 5개의 데이터가 뽑혀 나오고 -> 그 다음에 select 구문의 row_number()를 통해 순서가 재정렬 되는 상황
-> 즉 where 절에 rownum 을 쓸수 없는 상황 */
select
    row_number() over(order by salary desc)"순위",
    emp_name,
    salary
from employee
    where rownum <= 5;
================================================================================
/*
    rank() over(order by 컬럼...) :over() 안에 있는 컬럼에 따라서 일단 데이터를 정렬한 후에 순위를 매김
    순위를 매길때 중복데이터가 있다면 같은 순위를 매기고, 같은 순위를 매긴 데이터만큼 건너뀌어 다음 순위를 매김.
*/

select
    rank() over(order by salary desc)"순위",
    emp_name,
    salary
from employee;
================================================================================
/*
    dense_rank() over(order by 컬럼...) : over() 안의 컬럼에 따라 정렬 후 순위를 매김.
    중복데이터에 대해 같은 순위를 매기고 그 다음 순위부터는 건너뜀 없이 순차적으로 순위를 매김
    -> 총 데이터의 개수와 끝순위 번호가 일치하지 않을 수 있음
*/

select
    dense_rank() over(order by salary desc)"순위",
    emp_name,
    salary
from employee;
================================================================================
-- 급여를 제일 많이 받는 1~5 사원 정보
select
    "순위",
    emp_name,
    salary
from (select 
        row_number() over(order by salary desc)"순위",
        employee.* -- 다른 데이터나 컬럼과 함께 *을 써주고 싶으면 테이블명. *의 형식으로 써주면 됨
        from employee)
    where "순위" <= 5;
    
    
    
select -- 5위 10위 사이의 사원 -> 1페이지부터 5페이지 게시판( 각 페이지는 총 10개의 게시글 -> 글번호가 가장 큰 순서에서 작은순서 순위)
    *
from(select
        row_number() over(order by salary desc)"순위",
        emp_name"사원명",
        salary"월급"
        from employee)
    where 순위 between 5 and 10;

-- 연봉(보너스포함 -(salary +(salary*bounus)) *12)이 가장 높은 순서대로 순위 매김
-- 10~15위 사이인 직원들의 순위, 사원명, 연봉, 직급코드, 부서코드까지 출력
select
    *
from(select 
        row_number() over(order by (salary + ((salary * nvl(bonus,0))) * 12) desc)"순위",
        emp_name"사원명",
        to_char((salary + (salary * nvl(bonus,0)) * 12),'L999,999,999')"연봉",
        job_code"직급코드",
        nvl(dept_code,'인턴')"부서코드"
        from employee)
    where 순위 between 10 and 15;

-- 가장 보너스를 많이 받는 순으로 순위를 매김
-- 4~8위 사원들의 순위, 이름, 급여, 보너스를 출력
select
    *
from(select
        dense_rank() over(order by nvl(bonus,0) desc)"순위",
        emp_name"이름",
        salary"급여",
        nvl(bonus,0)"보너스"
        from employee)
    where 순위 between 4 and 8;
================================================================================