/*
    자바에서의 메서드(method) = 오라클에서는 함수(function)
    
    - 단일 행 함수 : 각 행마다 반복적으로 적용돼서 입력받은 행의 개수만큼 결과를 반환
    ex) length() -> 데이터의 길이 값 반환
    - 그룹 함수 : 특정한 행들의 집합으로 그룹이 형성되어 => 그룹당 1개의 결과를 반환
    - 문자형 함수 
    - lengthb() : 주어진 컬럼 / 문자열에 대한 길이(byte)로 반환해주는 함수
    
    - instr(컬럼 / 문자열, 찾고자 하는 문자(열), 시작 인덱스, 검색된 문자(열)의 순번) : 특정 문자열에서 찾고자 하는 문자열을 찾아주는 함수
    
    - dual 테이블 : Oracle에서 제공해주는 테이블 (연산, 함수, 실행 용도로 사용하는 특수한 테이블)
    
    - lpad(대상이 되는 컬럼/문자열, 반환할 길이, 덧붙일 문자(열)) / rpad() 
    : 주어진 컬럼/문자열을 대상으로 해서 임의의 문자열을 왼쪽 /오른쪽에 덧붙여서 길이 N의 문자열을 반환하는 함수
    
    - 가장왼쪽 - ltrim(대상이 되는 컬럼/문자열, 제거하고 싶은 문자(열)) / 가장 오른쪽 - rtrim()
    : 주어진 컬럼/문자열을 대상으로 제거하고 싶은 문자를 제거한 뒤 나머지를 반환하는 함수
    */
select emp_name, length(email) from employee;
select sum(salary) from employee;
select emp_name, length(emp_name), lengthb(emp_name) from employee;
select instr('Hello World Hi High','H',-1,2) from dual;
-- employee 테이블에서 email, email 컬럼의 @ 위치를 조회
select email, instr(email,'@',1,1) from employee;
select lpad(email, 20,'#') from employee;
select rpad(email, 20,'#') from employee;
select rtrim (email,'kh.or.kr') from employee;
select ltrim (email, 'n') from employee;
=======================================================================================================================
-- 문제 1
-- Hello KH Java 문자열을 Hello KH 가 출력되게 하여라.
select rtrim('Hello KH Java','Java') from dual;

-- 문제 2
-- Hello KH Java 문자열을 KH Java 가 출력되게 하여라.
select ltrim('Hello KH Java','Hello') from dual;

-- 문제 3
-- DEPARTMENT 테이블에서 DEPT_TITLE을 출력하여라
-- 이때, 마지막 부 글자를 빼고 출력되도록 하여라 / ex)회계관리부 -> 회계관리
select dept_title, rtrim(dept_title,'부') from department;

-- 문제 4
-- 다음문자열에서 앞뒤 모든 숫자를 제거하세요.
-- '982341678934509hello89798739273402'
select rtrim(ltrim('982341678934509hello89798739273402','0123456789'),'0123456789') from dual;
=======================================================================================================================
-- substr(대상이 되는 컬럼/문자열, 문자열을 잘라낼 위치(인덱스), 반환할 문자의 개수)
--  : 대상이 되는 컬럼/문자열에서 시작위치로부터 제시한 문자의 개수만큼 문자(열)을 잘라서 반환해주는 함수
select substr('HappyHappyDay',-7,3) from dual;
-- employee 테이블에서 사원명 조회 -> 성만 중복없이 사전순으로 조회
select distinct substr(emp_name,1,1) from employee order by 1;
=======================================================================================================================
-- employee 남자 사원의 사원번호, 사원명, 주민번호, 연봉을 조회
-- 주민번호 111111-******로 표기
select * from employee;
select emp_id"사원명", emp_name "이름", rpad(rtrim(emp_no,'0123456789'),13,'*') "주민번호", salary"봉급" from employee 
    where emp_no like '%-1%';
select emp_id"사원명", emp_name "이름", substr(emp_no,1,8) || '******' "주민번호", salary"봉급" from employee 
    where substr(emp_no, 8,1) in ('1','3');
=======================================================================================================================
-- concat(대상문자열1, 대상 문자열2) : 두개의 문자열을 하나로 합친 후 반환해주는 함수
select concat(concat('ABCD','가나다라'),'Hi') from dual;
select 'ABCD' || '가나다라' || 'Hi' from dual;
=======================================================================================================================
--  lower(대상 문자열/컬럼) / upper(대상 문자열/컬럼) / initcap(대상 문자열/컬럼)
--   : lower -> 대상 문자열을 모두 소문자로 변환해주는 함수
--   : upper -> 대상 문자열을 모두 대문자로 변환해주는 함수
--   : initcap -> 단어의 첫 글자만 대문자로 변환해주는 함수
select lower('Welcome To My World') from dual;
select upper('Welcome To My World') from dual;
select initcap('welcome to my world') from dual;
=======================================================================================================================
-- replace(대상이 되는 문자열/컬럼, 변경대상이 되는 문자(열), 변경할 문자(열)) 
--    : 대상이 되는 문자열/컬럼을 기준으로 변경대상이 되는 문자(열)를 찾아서 변경할 문자(열)로 바꿔주는 함수
select replace('Hello Hi High','Hi','Ho') from dual;
select replace('Hello Hi High','Hi','') from dual;
=======================================================================================================================
-- 숫자형 함수
--  abs(숫자) : 인자로 전달받은 숫자의 절대값을 반환해주는 함수
select abs(-10) from dual;

-- mod(숫자, 나눌 값) : 인자로 전달받은 숫자를 나눌 값으로 나머지를 반환해주는 함수
select mod(10, 4) from dual;
-- round(숫자) : 인자로 받은 숫자를 반올림하여 반환해주는 함수
select round(123.678) from dual;
-- round(숫자, 소숫점 인덱스 위치) : 인자로 받은 숫자를 지정한 위치 다음 자리수에서 반올림하여 반환해주는 함수
select round(123.456, 2) from dual;
-- floor(숫자) : 인자로 받은 숫자의 소수점 자리를 모두 버리는 함수
select floor(123.455123) from dual;
-- trunc(숫자, 소수점위치) : 인자로 받은 숫자를 지정한 위치까지 잘라서 반환해주는 함수
select trunc(123.345, 2) from dual;
-- ceil(숫자) : 인자로 받은 숫자의 소수점 자리를 버리고 반환해주는 함수(올림)
select ceil(123.345) from dual;

-- employee 테이블에서 직원명, 입사일, 오늘까지의 근무일수 조회(주말도 포함, 소수점아래는 버림)
select * from employee;
select emp_name"직원명", hire_date"입사일", floor(sysdate-hire_date)"근무일수" from employee;
=======================================================================================================================
-- 날짜 함수
-- sysdate : 시스템에 저장되어있는 현재 날짜(시간 포함) 반환
select sysdate from dual;
-- current_date : session(접속) timezone에 따라 현재 날짜(시간) 반환
select current_date from dual;
-- months_between(날짜형, 날짜형) : 두 날짜 사이의 개월 수 차이를 반환해주는 함수
select floor(months_between(sysdate, hire_date)/12) from employee;
select floor(months_between(sysdate, sysdate+32)) from employee;
-- add_months(기준 날짜, 더할 개월 수) : 첫 번째 인자 값인 날짜를 기준으로 해서 두 번째 인자값을 더해서 반환해주는 함수
select add_months(sysdate, -1) from dual;
select emp_name, hire_date, add_months(hire_date,6) from employee;
-- next_day(기준 날짜, 요일/숫자) : 기준 날짜를 기준으로 오른쪽에 해당하는 가장 가까운 날짜를 반환해주는 함수
-- 요일의 형식 : '월' 혹은'월요일'
-- 1~7 -> 일~토
select next_day(sysdate, 1) from dual;

-- last_day(기준 날짜) : 기준 날짜를 바탕으로 해당 날짜가 속한 달의 마지막 날을 반환해주는 함수
select last_day(add_months(sysdate,1)) from dual;
select emp_name, hire_date, last_day(add_months(sysdate,1)) from employee;

-- extract(year/month/day from date(기준날짜)) : 기준날짜로부터 년/월/일을 추출해서 반환해주는 함수
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;
=======================================================================================================================
-- 문제
-- 입사년도 YYYY년 MM월DD일 표현
-- 년차는 올림
-- 
select * from employee;
select emp_name, extract(year from hire_date)||'년'
    || extract(month from hire_date)||'월'
    || extract(day from hire_date)||'일' "입사년도",
    ceil((sysdate-hire_date)/365)||'년차' "년차"
    from employee
     order by 3;
-- 문자열을 기준으로 order by -> 문자로써 더 작은 숫자를 작다고 인식 (10과 3이 있다면 10이 더 작은수)

-- 특별 보너스를 지급 -> 자료가 필요 
-- employee -> 입사일을 기준으로 다음달 1일부터 6개월 계산해서 조회
-- 사워명, 입사일, 기준일, 기준일 + 6개월
-- 22/01/05 입사 -> 22/02/01 기준일 -> 22/08/01 기준일+ 6개월
-- 출력시 입사일 기준 출력
select emp_name "사원명", hire_date"입사일",last_day(add_months(hire_date,6))+1"기준일+6" from employee order by 2;
=======================================================================================================================
-- 형변환
-- to_char(date/number, format) : 날짜 혹은 숫자를 특정한 형식의 문자형으로 반환해주는 함수
select sysdate from dual;
select to_char(sysdate, 'YYYY-MM-DD') from dual;

select emp_name "사원명", 
    to_char(hire_date,'YYYY"년"MM"월"DD"일"')"입사년월일" 
from employee;

--day : x요일
select to_char(sysdate, 'YY/MM/DD/DAY') from dual;
--dy : x(요일)
select to_char(sysdate, 'YY/MM/DD/DY') from dual;
-- MONTH : x월
select to_char(sysdate, 'YY/MONTH/DD/DY') from dual;
-- HH / MI / SS 시분초
select to_char(sysdate, 'HH:MI:SS') from dual;
-- PM/AM : 오후 / 오전
select to_char(sysdate, 'PMHH:MI:SS') from dual;
--HH24 : 24시간 기준 표기
select to_char(sysdate, 'HH24:MI:SS') from dual;

--employee 데이블 사원명, 입사일 -> 1990/02/05 화요일 형태 조회
select emp_name"사원명", 
    to_char(hire_date,'YYYY/MM/DD/(DY)')"입사일" 
from employee;
=======================================================================================================================
-- 숫자 -> 문자형
-- to_char(대상 숫자, )
-- 123456789 -> 0이나 9를 이용해 문자형으로 변환
select to_char(123456789, '000,000,000') from dual;
select to_char(12345, '999,999,999') "9",
    to_char(12345, '000,000,000') "0"
from dual;

-- 통(원)화 표시 -> L (local)
-- nvl(숫자/컬럼, 치환 값) : 만약 해당 숫자/컬럼 등이 null 값이라면 치환값으로 변환해주는 함수
select to_char(12345, 'L999,999') from dual;
-- employee -> 직원명, 직급코드, 연봉(원) 조회
-- 단, 연봉은  ￦12,345
-- 연봉 보너스가 적용된 금액으로 조회((월급*bonus)*12)
select emp_name "직원명",
    job_code"직급코드",
    to_char(salary,'999,999,999') "월급(원)",    
    to_char((salary + (salary*nvl(bonus, 0))*12),'L999,999,999')"연봉(원)*보너스" 
from employee;
=======================================================================================================================
-- to_date(숫자/문자, 형식) : 숫자형 혹은 문자형 데이터를 데이트(날짜) 타입으로 바꿔주는 함수
-- 20100505
select to_date(20120505, 'YYYYMMDD') from dual;
select to_date('20120505', 'YYYYMMDD') from dual;
-- 시간값을 변환할때 앞에 년/월/일 정보를 주지 않으면 현재 달의 1일로 날짜를 인식해버림.
select to_char(to_date('110331', 'hh:mi:ss'), 'YYYY/MM/DD hh:MI:SS') from dual;
-- 년도 값을 변환할때 2000/1900년대에 대한 값을 명확히 제시하지 않으면 2000년대를 default 값으로 인식
select to_char(to_date('890909', 'YY/MM/DD'),'YYYY/MM/DD') from dual;
select emp_name "사원명",
    emp_no "사번",
    hire_date "입사일"
from employee
    where hire_date >= to_date('20000101','YYYYMMDD');
=======================================================================================================================
-- to_number(문자형, 형식) : 문자형을 숫자형으로 변환해주는 함수
select to_number('123,456,789', '999,999,999') from dual;
select to_number('123,456,789', '999,999') from dual; -- 넘겨주는 문자형식에 맞춰 숫자형식도 동일하게.
select to_number('s23,456', '999,999') from dual; -- 숫자로 변환불가한 문자열을 넘겨줄 수 X

-- 묵시적 형변환 : 오라클에서는 자동적으로 자료형을 유추해서 형변환
select emp_name, salary from employee
    where salary = 8000000;
select 25 + '25' from dual;
select emp_name, hire_date from employee
    where hire_date = to_date('20130206', 'YY/MM/DD');
    
/*
60년생의 직원명과 년생, 보너스 율을 출력
그때 보너스 값이 null인 경우에는 0% 라고 출력
*/
select emp_name "직원명",
    substr(emp_no,1,2)"년생",
    nvl(bonus,0)*100||'%'"보너스"
from employee
    where substr(emp_no,1,2) between 60 and 69;
=======================================================================================================================
-- 그룹 함수
-- sum(숫자/컬럼) : 해당 컬럼/ 숫자 값의 총 합을 구해주는 함수
-- 그룹함수를 사용할때에는 단일한 결과값이 나온다는 점
select dept_code, sum(salary) from employee
    where dept_code = 'D5';
select * from employee;
-- avg(컬럼) : 해당 컬럼 값들의 평균을 구해주는 함수
select round(avg(salary)) from employee;
-- 전 직원의 보너스 평균 -> 소수점 셋째자리수에서 반올림해서 조회
select round(avg(nvl(bonus,0)),2)"보너스" from employee;

--count(컬럼) : 해당 컬럼 -> 데이터의 개수를 반환해주는 함수
select count(*) from employee;
-- bonus를 지급해야하는 사원의 수 카운트
select count(*) from employee
    where bonus is not null;
-- 부서코드가 D5인 사원의 수 카운트
select count(*) from employee
    where dept_code = 'D5';
-- 사원들이 속해 있는 부서의 수 카운트
select count(distinct dept_code) from employee;

-- max/min(컬럼) : 해당 그룹에서 최대값/ 최솟값을 반환해주는 함수
select max(salary), min(salary) from employee;
--employee 테이블에서 가장 오래 일한 사원의 입사일 / 가장 적게 일한 사원의 입사일 조회
select min(hire_date), max(hire_date) from employee;
