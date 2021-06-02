-- 도전 정산 :
-- 달성률 0 ~ 85% - 참가비의 85%
-- 달성률 85 ~ 99% - 참가비 + 상금
-- 달성률 100% - 참가비 + 상금 + 누적 후원금
create or replace view complete_challenge as
select
    T.challenge_writer,
    SUM(t."challenge_calc_pushpoint" + t."challenge_calc_reward" + t."challenge_calc_donate") challenge_calc_total
from (select
     C.challenge_no, c.challenge_writer, c.challenge_pushpoint, c.challenge_percent, 
    case 
        when C.challenge_percent < 85 then C.challenge_pushpoint * 0.85
        else C.challenge_pushpoint
    end "challenge_calc_pushpoint",
    case
        when C.challenge_percent between 85 and 99 then 0
        else C.challenge_reward
    end "challenge_calc_reward",
    case
        when c.challenge_percent = 100 then 0
        else c.challenge_donate
    end "challenge_calc_donate"
from challenge C 
    where 
        sysdate >= c.challenge_enddate 
        and 
        c.challenge_result = 'N') T
group by T.challenge_writer
order by T.challenge_writer;

select * from complete_challenge;

-- MERGE : 도전 정산 결과 적용 (스케줄링 적용 예정)
merge into member M
using complete_challenge C on (C.challenge_writer = M.member_no)
when matched then
    update set M.member_point = M.member_point + C.challenge_calc_total;

-- 테스트 : 도전 정산
select * from member;

rollback;

-- 도전 정산 :
-- 달성률 0 ~ 85% - 후원금
-- 달성률 85 ~ 99% - 후원금 2배
-- 달성률 100% - 후원금 3배
create or replace view complete_donate as
select
    T.member_no,
    SUM(t."donate_calc_pushpoint") donate_calc_total
from (select
    d.challenge_no, d.member_no, c.challenge_percent, d.donate_pushpoint,
    case 
        when C.challenge_percent = 100 then d.donate_pushpoint*3
        when C.challenge_percent between 85 and 99  then d.donate_pushpoint*2
        else d.donate_pushpoint
    end "donate_calc_pushpoint"
from donate d
left outer join challenge c on (d.challenge_no = c.challenge_no)
    where 
        sysdate >= c.challenge_enddate 
        and 
        c.challenge_result = 'N') T
group by T.member_no
order by T.member_no;

select * from complete_donate;

commit; 

-- MERGE : 후원 정산 결과 적용 (스케줄링 적용 예정)
merge into member M
using complete_donate d on (d.member_no = M.member_no)
when matched then
    update set M.member_point = M.member_point + d.donate_calc_total;

-- 테스트 : 후원 정산
select * from member;

rollback;