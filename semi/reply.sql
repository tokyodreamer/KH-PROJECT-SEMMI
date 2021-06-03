-- 댓글 테이블
create table reply(
reply_no number(19) primary key,
reply_content varchar2(4000) not null,
reply_time date default sysdate not null,
reply_writer references member(member_no) on delete set null,
reply_origin references challenge(challenge_no) on delete cascade
);

create sequence reply_seq nocache;