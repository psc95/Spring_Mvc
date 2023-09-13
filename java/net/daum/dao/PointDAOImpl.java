package net.daum.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PointDAOImpl implements PointDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void updatePoint(String sender, int point) {
		Map<String,Object> pm = new HashMap<>();
		pm.put("sender", sender);//sender 키이름에 보낸 사람 저장
		pm.put("point", point);//point.xml에서는 키이름을 참조해서 값을 가져온다.
		
		this.sqlSession.update("pointUp", pm);
	}//메시지를 보낸 사람에게 10점 업데이트
	
}
