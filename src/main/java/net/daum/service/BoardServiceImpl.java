package net.daum.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.daum.dao.BoardDAO;

@Service //@Service 애노테이션을 추가함으로써 스프링에 서비스라는 것을 인식하게 한다.
public class BoardServiceImpl implements BoardServie {
	
	@Autowired
	private BoardDAO boardDao;
}
