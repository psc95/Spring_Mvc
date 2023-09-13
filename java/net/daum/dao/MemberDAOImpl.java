package net.daum.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.daum.vo.MemberVO;

@Repository //@Repository 애노테이션을 설정해서 스프링에 DAO로 인식하게 한다.
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired //자동의존성 주입(DI설정)
	private SqlSession sqlSession; //mybatis에서 쿼리문을 수행할 sqlSession을 생성

	@Override
	public void insertMember(MemberVO m) {
		this.sqlSession.insert("mem_in",m);
		/* mybatis에서 insert()메서드는 레코드를 저장시킨다.
		 * mem_in은 member_test.xml 매퍼태그에서 설정할 유일 아이디 명이다.
		 */
	}//회원 저장
}
