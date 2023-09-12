package net.daum.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BoardVO {//테이블 컬럼명,네임피라미터 이름,빈클래스 변수명을 같게하는 데이터 저장 빈 클래스
	//스프링 MVC게시판(tbl_board테이블)
	
	private int bno; //게시판 번호
	private String writer; //작성자
	private String title; //글제목
	private String content; //글내용
	private int viewcnt; //조회수
	private Timestamp regdate; //등록날짜
	private int replycnt; //댓글 수
	
	//페이징(쪽나누기)
	private int startrow; //시작행 번호
	private int endrow; //끝행 번호
	
}
