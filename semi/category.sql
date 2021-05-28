-- 카테고리 테이블 고정값
-- 설명 : 추후 구현할 카테고리에 대한 설명 페이지에 기준이 되는 데이터(EX. 인증 기준에 대하여 안내를 해야 하는데 이를 불러오거나 타 테이블 활용 용도)
insert into category values(category_seq.nextval, '운동', '운동 인증 기준');
insert into category values(category_seq.nextval, '공부', '공부 인증 기준');