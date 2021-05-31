-- DB 추가할 구문 list

-- 챌린지 게시글 페이지
-- challenge, member, category 테이블 합쳐서 조회(outer join 및 view 생성)
-- 이유 : member_no -> member_nick / category_no -> category_type 변경을 위해서
create or replace view challenge_list as
select 
    C.challenge_no, C.Challenge_title, C.Challenge_pushpoint, C.challenge_startdate,
    C.challenge_enddate, C.challenge_percent, C.challenge_reward, C.challenge_donate, c.challenge_content,
    M.member_no, M.member_nick, M.member_point, T.category_no, T.category_type
from challenge C
    left outer join member M on C.challenge_writer = M.member_no
    left outer join category T on C.category_no = T.category_no;
    
-- 정산 처리하는 로직 구현 (완료!)
-- 1. 순서 :
-- 스케줄러 패키지를 이용하여 검사 메소드 1회 실행 후 정산 메소드가 각각 1회씩, 총 3회 실행되는 구조 (위치 : semi.scheduler)

-- 2. 연결 방식 (위치 : TestScheduler.java)
-- 2-1. 달성률을 체크하는 메소드 : 도전 테이블 DAO 에서 가져온다
-- 2-2. 달성률을 기준으로 3개의 정산 메소드를 조건부로 실행한다
-- 2-3. 이후 정산이 마쳤다는 메소드를 실행.

-- DB 내 수정 항목 (★★★) : 도전 테이블 정산결과 처리 컬럼 추가, 뷰 3개 추가

-- 도전 테이블 정산결과처리 컬럼 추가
alter table challenge add challenge_result char(1) default 'N' check(challenge_result IN ('N', 'Y'));

-- 도전결과 정산

-- 정산 처리 뷰 : 달성률 50~85%
-- 참가자 : 참가비에서 벌금(15%) 뺀 나머지 페이백
-- 후원자 : (달성률 기준으로) 후원금만 페이백
CREATE VIEW result_done AS
SELECT SUM(TRUNC(c.challenge_pushpoint*0.85) + d.donate_pushpoint) "RESULT_POINT", m.member_no "RESULT_NO"
FROM MEMBER M 
LEFT OUTER JOIN challenge C ON m.member_no = c.challenge_writer 
-- 조건 1 : 달성기간이 지났으면서 정산 되지 않은 ...
AND SYSDATE >= c.challenge_enddate AND c.challenge_result = 'N' 
-- 조건 2 : 달성율이 50-85% 사이의 도전글 -> 후원 금액 계산하려고...
AND c.challenge_percent >= 50 AND c.challenge_percent < 85
LEFT OUTER JOIN donate D ON m.member_no = d.member_no
GROUP BY m.member_point, m.member_no;

-- 정산 처리 뷰 : 달성률 85~99%
-- 참가자 : 참가비 전액 환급 + 상금
-- 후원자 : 후원금 + 참가비의 1%
CREATE VIEW result_good AS
SELECT SUM(c.challenge_pushpoint + c.challenge_reward + d.donate_pushpoint + TRUNC(c.challenge_pushpoint*0.01)) "RESULT_POINT", m.member_no "RESULT_NO"
FROM MEMBER M 
LEFT OUTER JOIN challenge C ON m.member_no = c.challenge_writer 
-- 조건 1 : 달성기간이 지났으면서 정산 되지 않은 ...
AND SYSDATE >= c.challenge_enddate AND c.challenge_result = 'N' 
-- 조건 2 : 달성율이 85-99% 사이의 도전글 -> 후원 금액 계산하려고...
AND c.challenge_percent >= 85 AND c.challenge_percent < 99
LEFT OUTER JOIN donate D ON m.member_no = d.member_no
GROUP BY m.member_point, m.member_no;

-- 정산 처리 뷰 : 달성률 100%
-- 참가자 : 참가비 전액 환급 + 상금 + 누적 후원금
-- 후원자 : 후원금 + 참가비의 1% 의 2배 
CREATE VIEW result_perfect AS
SELECT SUM(c.challenge_pushpoint + c.challenge_reward + c.challenge_donate + (d.donate_pushpoint + TRUNC(c.challenge_pushpoint*0.01))*2) "RESULT_POINT", m.member_no "RESULT_NO"
FROM MEMBER M 
LEFT OUTER JOIN challenge C ON m.member_no = c.challenge_writer 
-- 조건 1 : 달성기간이 지났으면서 정산 되지 않은 ...
AND SYSDATE >= c.challenge_enddate AND c.challenge_result = 'N' 
-- 조건 2 : 달성율이 100%인 도전글 -> 후원 금액 계산하려고...
AND c.challenge_percent = 100
LEFT OUTER JOIN donate D ON m.member_no = d.member_no
GROUP BY m.member_point, m.member_no;