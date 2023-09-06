package net.daum.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository //@Repository 애노테이션을 등록함으로써 스프링에 모델 DAO로 인식되게함.
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;//mybatis쿼리문 수행할 sqlSession 자동 의존성 주입(DI)
	
	
}
