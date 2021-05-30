create table review (
    review_no number(19) primary key,
    review_nick number(19) REFERENCES member(member_no)on delete set null,
    review_time date DEFAULT sysdate,
    review_star number(1)not null,
    review_content varchar2(3000) not null
);

create SEQUENCE review_seq NOCACHE;

insert into review values( 
    REVIEW_SEQ.nextval,4,sysdate,1, '좋아요' 
);

commit;

create or replace view review_list as select r.*, m.member_nick
from review r left outer join member M ON r.review_nick = m.member_no; 

select review_seq.nextval from dual;
