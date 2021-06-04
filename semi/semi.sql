-- 테이블 새로 생성하기 위해서 데이터 초기화
delete admin;
delete auth;
delete category;
delete challenge;
delete donate;
delete review;
delete member;

-- 테이블 데이터 삭제 후 커밋
commit;

-- 테이블 삭제
drop table admin;
drop table auth;
drop table category;
drop table challenge;
drop table donate;
drop table review;
drop table member;

-- 제약조건 추가된 테이블 추가

-- 회원 테이블
CREATE TABLE MEMBER (
    member_no NUMBER(19) PRIMARY KEY,
    member_id VARCHAR2(30) NOT NULL UNIQUE,
    member_pw VARCHAR2(30) NOT NULL,
    member_nick VARCHAR2(60) NOT NULL UNIQUE,
    member_point NUMBER(19) DEFAULT 200000 NOT NULL,
    member_email VARCHAR2(60) NOT NULL UNIQUE
);

-- 관리자 테이블 
CREATE TABLE ADMIN (
    admin_no NUMBER(19) PRIMARY KEY,
    admin_id VARCHAR2(30) NOT NULL UNIQUE,
    admin_pw VARCHAR2(30) NOT NULL,
    admin_nick VARCHAR2(60) NOT NULL UNIQUE
);

-- 관리자 데이터 생성
INSERT INTO admin VALUES(admin_seq.NEXTVAL, 'admin0001', 'admin0001', '관리자0001');

COMMIT;

-- 유형 테이블
CREATE TABLE CATEGORY (
    category_no NUMBER(19) PRIMARY KEY,
    category_type VARCHAR2(30) NOT NULL,
    category_auth VARCHAR2(3000) NOT NULL
);

-- 유형 데이터 생성 (시간 되면 활용 예정)
INSERT INTO category VALUES(1, '운동', '운동 유형 인증 방법');
INSERT INTO category VALUES(2, '공부', '공부 유형 인증 방법');

commit;

-- 도전 테이블 (06/03, 제약조건 추가) 
CREATE TABLE CHALLENGE(
    challenge_no NUMBER(19) PRIMARY KEY,
    challenge_writer NUMBER(19) REFERENCES MEMBER(member_no) ON DELETE SET NULL NOT NULL, -- 제약조건 : 멤버가 탈퇴하면 작성자 번호는 NULL 이 된다 (백엔드 수정 필요!)
    category_no NUMBER(19) REFERENCES CATEGORY(category_no) ON DELETE SET NULL NOT NULL, -- 유형이 삭제되면 번호는 NULL 이 된다
    challenge_title VARCHAR2(300) NOT NULL,
    challenge_pushPoint NUMBER(6) DEFAULT 10000 NOT NULL,
    challenge_startDate DATE NOT NULL,
    challenge_endDate DATE NOT NULL,
    challenge_percent NUMBER(3) DEFAULT 0 NOT NULL,
    challenge_reward NUMBER(6) DEFAULT 100 NOT NULL,
    challenge_donate NUMBER(9) DEFAULT 0 NOT NULL,
    challenge_content VARCHAR2(3000) NOT NULL,
    challenge_result char(1) default 'N' check(challenge_result IN ('N', 'Y')) -- 정산 결과 처리 여부
);

-- 도전 조회수 구문 컬럼 추가
alter table challenge add challenge_read number(19) default 0 not null check(challenge_read >= 0);

-- 뷰 : 도전 LIST 재생성 (06/03, 제약조건이 추가되었고 테이블을 삭제 후 새로 생성하였기에 뷰도 재생성 필요!)
create or replace view challenge_list as
select 
    C.challenge_no, C.Challenge_title, C.Challenge_pushpoint, C.challenge_startdate,
    C.challenge_enddate, C.challenge_percent, C.challenge_reward, C.challenge_donate, 
    c.challenge_content, C.challenge_result, C.challenge_read,
    M.member_no, M.member_nick, M.member_point, T.category_no, T.category_type
from challenge C
    left outer join member M on C.challenge_writer = M.member_no
    left outer join category T on C.category_no = T.category_no;
    
-- 인증 테이블 (06/03, 제약조건 추가)
create table auth(
    auth_no number(19) primary key,
    auth_challengeNo number(19) references challenge(challenge_no) ON DELETE SET NULL not null, -- 도전글 삭제 시 NULL 형태로 변경
    auth_writer number(19) references member(member_no) ON DELETE SET NULL not null, -- 멤버 탈퇴 시 NULL 형태로 변경
    auth_categoryType number(19) references category(category_no) ON DELETE SET NULL not null, -- 유형 삭제 시 NULL 형태로 변경
    auth_title varchar2(300) not null,
    auth_content varchar2(3000) not null,
    auth_timeLine date default sysdate not null,
    auth_result char(1) default 'N' check(auth_result in ('N', 'S', 'D')),
    auth_reason varchar2(3000) default '미정' not null,
    auth_uploadName varchar2(256) not null,
    auth_saveName varchar2(256) not null,
    auth_contentType varchar2(30),
    auth_fileSize number(19) default 0 not null
);

-- 인증테이블 뷰 추가(member_nick) 가져오기 위함
create or replace view auth_list as
select 
    A.*, M.member_nick 
from auth A
    left outer join member M on A.auth_writer = M.member_no;

-- 후원 테이블 (06/03, 제약조건 추가)
CREATE TABLE DONATE (
    donate_no NUMBER(19) PRIMARY KEY,
    challenge_no NUMBER(19) REFERENCES CHALLENGE(challenge_no) ON DELETE SET NULL NOT NULL,
    member_no NUMBER(19) REFERENCES MEMBER(member_no) ON DELETE SET NULL NOT NULL,
    category_no NUMBER(19) REFERENCES CATEGORY(category_no) ON DELETE SET NULL NOT NULL,
    donate_pushPoint NUMBER(9)DEFAULT 0 NOT NULL 
);

-- 후기 테이블
create table review (
    review_no number(19) primary key,
    review_nick number(19) REFERENCES member(member_no)on delete set null,
    review_time date DEFAULT sysdate,
    review_star number(1)not null,
    review_content varchar2(3000) not null
);

-- 뷰 : 후기 리스트 불러오기
create or replace view review_list as 
select r.*, m.member_nick from review r 
left outer join member M ON r.review_nick = m.member_no; 

-- 뷰 : 도전 정산
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

-- 뷰 : 후원 정산
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