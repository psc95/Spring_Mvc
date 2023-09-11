package net.daum.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.daum.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Autowired //자동 의존성 주입
	private SqlSession sqlSession; //mybatis 쿼리문 수행 sqlSession을 생성

	@Override
	public void addReply(ReplyVO vo) {
		this.sqlSession.insert("reply_in",vo); //reply_in은 reply.xml에서 설정할 유일 아이디명
	}//댓글 저장

	@Override
	public List<ReplyVO> listReply(int bno) {
		return this.sqlSession.selectList("reply_list",bno);//mybatis에서 selectList()
		//메서드는 하나이상의 레코드를 검색해서 컬렉션 List로 반환,
	}//게시판 번호에 해당하는 댓글 목록

	@Override
	public void editReply(ReplyVO vo) {
		this.sqlSession.update("reply_edit", vo);
	}//댓글 수정

	@Override
	public void deleteReply(int rno) {
		this.sqlSession.delete("reply_del", rno);
	}//댓글 삭제
}
