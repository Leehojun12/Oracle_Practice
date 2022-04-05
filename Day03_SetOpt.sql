/*
    SetOperator(집합 연산자) -> 두 개 이상의 테이블을 조인 없이 연관된 데이터를 조회하는 방식
    -> 여러 개의 질의 결과(ResultSet)를 연결해서 하나로 결합하는 방식
    -> 각 테이블에서 반환된 결과값을 하나의 테이블로 결합하는 방식
    -> 여러 개의 sql 문을 사용해서 하나의 테이블로 결과를 반환받아야 하는 경우
    
** 조건 **
- select 절에서 조회하려는 '컬럼의 수가 동일'
- select 절의 동일 위치에 존재하는 컬럼이 '데이터 타입이 상호 호환 가능'

** 종류 ** 
- UNION / UNION ALL / INTERSECT / MINUS
*/
create table A(
    no_a number(1),
    name_a nvarchar2(10)
);
create table B(
    no_b number(1),
    date_b date default sysdate
);
insert into A (no_a) values(1);
insert into A (no_a) values(5);
insert into A (no_a) values(3);
insert into A (no_a) values(4);
insert into A (no_a) values(2);

insert into B (no_b) values(7);
insert into B (no_b) values(6);
insert into B (no_b) values(3);
insert into B (no_b) values(8);
insert into B (no_b) values(5);
insert into B (no_b) values(9);

select *from A;
select * from B;
================================================================================
-- UNION : 합집합 -> 중복된 데이터를 제거하고 첫번째 컬럼을 기준으로 오름차순하여 데이터를 보여 줌

-- 조회하려는 컬럼의 수가 맞아야 된다
select no_a,name_a from A
UNION 
select no_b from B;

-- 조회하려는 컬럼이 서로 상호호환 불가한(즉 같지 않은) 데이터 타입이면 union 사용 X
select no_a, name_a from A
union
select no_b, date_b from B;

select no_a from A
union
select no_b  from B;

select no_a from A; -- 1, 5, 3, 4, 2
select no_b from B; -- 7, 6, 3, 8, 5, 9

/*
UNION ALL : 합집합 -> 중복된 데이터 제거 X, 정렬 없이 데이터를 그대로 보여줌
-> 조회된 결과값의 첫번째 테이블 아래로 두번째 테이블 결과 값을 그대로 이어 붙이는 식.
*/
select no_a from A
union all
select no_b from B;

-- INTERSECT : 교집합 -> 두 테이블의 쿼리 결과 중 공통된 결과 값만 보여 줌.

select no_a from A
intersect
select no_b from B;

-- MINUS : 차집합 -> 두 테이블의 쿼리 결과 중 공통된 요소를 뺀 한 테이블의 결과값만  보여줌

-- A - B
select no_a from A
minus
select no_b from B;
-- B - A
select no_b from B
minus
select no_a from A;
================================================================================
-- employee 부서코드가 D5인 사람의 사번, 사원명, 부서코드, 월급 출력
select emp_id"사번",
    emp_name"사원명",
    dept_code"부서코드",
    salary"월급"
from employee
    where dept_code = 'D5';
-- 월급이 300만원 이상 사람의 사번, 사원명, 부서코드, 월급 출력
select emp_id"사번",
    emp_name"사원명",
    dept_code"부서코드",
    salary"월급"
from employee
    where salary >= 3000000;

-- UNION / UNION ALL / INTERSECT / MINUS
select emp_id"사번",
    emp_name"사원명",
    dept_code"부서코드",
    salary"월급"
from employee
    where dept_code = 'D5'
minus
select emp_id"사번",
    emp_name"사원명",
    dept_code"부서코드",
    salary"월급"
from employee
    where salary >= 3000000;
