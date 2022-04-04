/*
    group by : 그룹함수를 이용해 여러 개의 결과값을 도출하고 싶을 때(그룹별 집계)
    -> 그룹함수는 단 한개의 결과값을 도출
    -> 그룹함수가 적용될 그룹 기준으로 해서 group by 절에 해당 그룹(컬럼) 기술해 사용
    
    select sum(salary) from employee group by dept_code;
*/
select nvl(dept_code, '인턴'), 
    sum(salary) 
from employee 
    group by dept_code;
    
select count(*) from employee
    group by dept_code;