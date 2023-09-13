package net.daum.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import net.daum.dao.BoardDAO;
import net.daum.vo.BoardVO;

@Service //@Service 애노테이션을 추가함으로써 스프링에 서비스라는 것을 인식하게 한다.
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDao;

	@Override
	public void insertBoard(BoardVO b) {
		this.boardDao.insertBoard(b);
	}

	@Override
	public int getTotalCount() {
		return this.boardDao.getTotalCount();//this.생략가능함;
	}

	@Override
	public List<BoardVO> getBoardList(BoardVO b) {
		return this.boardDao.getBoardList(b);
	}
	
	//조회수 증가+내용보기 => 스프링의 AOP를 통한 트랜잭션 적용대상(데이터 불일치 현상 제거)
	@Transactional(isolation = Isolation.READ_COMMITTED)
	//트랜잭션 격리(트랜잭션이 처리되는 중간에 외부 간섭을 없앰, READ_COMMITTED는 커밋된 데이터에 대해 읽기 허용)
	@Override
	public BoardVO getBoardCont(int bno) {
		this.boardDao.updateHit(bno);//조회수 증가
		return this.boardDao.getBoardCont(bno);//번호에 해당하는 레코드 가져오기
	}

	@Override
	public BoardVO getBoardCont2(int bno) {
		return this.boardDao.getBoardCont(bno);
	}//조회수 증가는 빼고 내용보기만 처리

	@Override
	public void editBoard(BoardVO eb) {
		this.boardDao.editBoard(eb);
	}

	@Override
	public void delBoard(int bno) {
		this.boardDao.delBoard(bno);
	}
}
