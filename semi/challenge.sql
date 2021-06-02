-- DB 추가할 구문 list


-- 챌린지 조회수 추가 컬럼
alter table challenge add challenge_read number(19) default 0 not null check(challenge_read >= 0);

-- 챌린지 게시글 페이지
-- challenge, member, category 테이블 합쳐서 조회(outer join 및 view 생성)
-- 이유 : member_no -> member_nick / category_no -> category_type 변경을 위해서
create or replace view challenge_list as
select 
    C.challenge_no, C.Challenge_title, C.Challenge_pushpoint, C.challenge_startdate,
    C.challenge_enddate, C.challenge_percent, C.challenge_reward, C.challenge_donate, 
    c.challenge_content, C.challenge_result, C.challenge_read,
    M.member_no, M.member_nick, M.member_point, T.category_no, T.category_type
from challenge C
    left outer join member M on C.challenge_writer = M.member_no
    left outer join category T on C.category_no = T.category_no;

