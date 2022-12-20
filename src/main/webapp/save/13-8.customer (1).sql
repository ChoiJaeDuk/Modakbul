INSERT INTO customer " +
			"VALUES(CUSTOMER_SEQ.NEXTVAL,?,?,?,?)


CREATE TABLE customer2(
    id varchar2(20) primary key, --고객아이디
    NAME VARCHAR2(20), --고객이름
    age NUMBER(3), --고객나이
    tel VARCHAR2(30), --고객연락처
    addr VARCHAR2(50)--고객주소
)

drop table customer

insert into customer2 values('jang','장희정',20,'02-222-8282','서울시 강남구')
insert into customer2 values('kim','김삿갓',25,'031-222-8282','경기도 수원시')
insert into customer2 values('lee','이연희',30,'010-222-8282','경기도 하남시')
commit




select * from customer2