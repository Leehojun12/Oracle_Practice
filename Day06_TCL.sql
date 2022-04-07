/*
    TCL (Transaction Control Language) : 트랜잭션 제어 언어
    - commit, rollback
    
    commit : 트랜잭션 작업이 정상적으로 완료되면 변경 내용을 영구적으로 저장 (모든 savepoint 삭제)
    savepoint <savepoint명> : 현재 트랜잭션 작업 시점에다가 이름 부여(하나의 트랜잭션 안에서 구역을 나누는 것)
    rollback : 트랜잭션 작업을 모두 취소하고 최근에 commit했던 지점으로 돌아가는 것.
    rollback to savepoint명 : 해당 savepoint로 되돌아 간다.
    
    트랜잭션 : 한번에 수행되야하는 작업의 단위
    
    ex) ATM
    1. 카드 삽입
    2. 메뉴선택(인출)
    3. 금액 확인 / 비밀번호 인증
    4. 사용자가 입력한 금액이 해당 계좌에서 뽑을 수 있는 금액인지 확인
    5. 실제 현금
    6. 카드 뽑고 끝
    
    == 현금을 인출 -> 6번까지 작업이 정상적으로 완료가 됬을 때 (commit)
    -> 하나라도 비정상 흐름이 발생하면 그때는 모든 작업을 (rollback)
*/
create table tbl_user(
    no number unique,
    id varchar2(100) primary key,
    pw varchar2(100) not null
);
select * from tbl_user;
insert into tbl_user values(1, 'user1', 'pw1');
insert into tbl_user values(2, 'user2', 'pw2');
insert into tbl_user values(3, 'user3', 'pw3');
commit;
insert into tbl_user values(4, 'user4', 'pw4');
rollback;
savepoint sp1;
insert into tbl_user values(5, 'user5','pw5');
rollback to sp1;