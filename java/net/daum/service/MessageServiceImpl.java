package net.daum.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.daum.dao.MessageDAO;
import net.daum.dao.PointDAO;
import net.daum.vo.MessageVO;

@Service
public class MessageServiceImpl implements MessageService {
	
	@Autowired
	private MessageDAO messageDao;
	
	@Autowired
	private PointDAO pointDao;
	
	//메시지 insert+메시지를 보낸 사람에게 포인트 점수 10점 업데이트=>스프링의 AOP를 통한 트랜잭션 적용 대상
	@Transactional //트랜잭션 적용함으로써 데이터 불일치 현상을 제거
	@Override
	public void insertMessage(MessageVO vo) {
		this.messageDao.insertMessage(vo);//메시지 추가
		this.pointDao.updatePoint(vo.getSender(),10);//메시지를 보낸 사람에게 포인트 점수 10점 up
	}
}
