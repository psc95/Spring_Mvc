--tbl_board 테이블 생성
create table tbl_board(
 bno number(38) primary key --게시판 번호
 ,writer varchar2(50) not null --작성자
 ,title varchar2(200) not null --글제목
 ,content varchar2(4000) not null --글내용
 ,viewcnt number(38) default 0 --조회수, default 0제약조건을 설정하면 굳이 해당 컬럼에 레코드를 저장하지 않아도 기본값 0이 저장됨
 ,regdate timestamp --등록날짜
 );

select * from tbl_board order by bno desc;

--bno_seq 시퀀스 생성
create sequence bno_seq
start with 1 --1부터 시작
increment by 1 -- 1씩 증가
NOCACHE --임시메모리를 사용안함.
nocycle; --시퀀스 최대값 도달시 다시 처음부터 반복안함.

--bno_seq 시퀀스 다음번호값 확인
select bno_seq.nextval from dual;

