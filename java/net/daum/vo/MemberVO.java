package net.daum.vo;

import java.sql.Timestamp;

public class MemberVO {//되도록이면 TBL_MEMBER테이블의 컬럼명과 일치하는 빈클래스 변수명을 가진 데이터 저장
	//빈 클래스를 만든다.

	private String userid; //회원 아이디
	private String userpw; //회원 비밀번호
	private String username; //회원 이름
	private String email; //회원 이메일
	private Timestamp regdate; //날짜
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
}
