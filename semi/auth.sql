-- 인증 테이블 && 인증 테이블 시퀀스(05/27 수정)
create table auth(
auth_no number(19) primary key,
auth_challengeNo number(19) references challenge(challenge_no) not null, -- FK : 나중에 CHALLENGE DAO 를 활용하기 위해 외래키 사용 (EX. 도전글 제목 불러오는 DAO 에서 매개변수 활용 용도)
auth_writer number(19) references member(member_no) not null, -- FK : 나중에 MEMBER DAO 를 활용하기 위해 외래키 사용 (EX. 닉네임 불러오는 DAO 에서 매개변수 활용 용도)
auth_categoryType number(19) references category(category_no) not null, -- FK : 나중에 CATEGORY DAO 를 활용하기 위해 외래키 사용 (EX. 카테고리 분류 불러오는 DAO 에서 매개변수 활용 용도)
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

create sequence auth_seq nocache;