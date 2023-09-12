package net.daum.vo;

import lombok.Getter;
import lombok.Setter;

@Setter //setter()메서드 자동 제공
@Getter //getter()메서드 자동 제공
public class UserVO {// tbl_user 테이블의 컬럼명과 일치하는 데이터 저장빈 클래스
	
	private String uid2; //회원 아이디
	private String upw; //비번
	private String uname; //회원 이름
	private int upoint; //보낸 메시지 하나당 포인트 점수 10점 up, default:0
	
}
