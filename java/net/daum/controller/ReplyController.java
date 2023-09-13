package net.daum.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import net.daum.service.ReplyService;
import net.daum.service.ReplyServiceImpl;
import net.daum.vo.ReplyVO;

@RestController //@RestController 애노테이션을 추가함으로써 해당 컨트롤러는 REST API 서비스 프로그램을
//개발 가능하게 된다.
@RequestMapping("/replies") //컨트롤러 자체 매핑주소 등록
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	//댓글등록
	@RequestMapping(value="/reply_add",method=RequestMethod.POST) //post로 접근하는 매핑주소
	//처리 => reply_add 매핑주소 등록
	public ResponseEntity<String> reply_add(@RequestBody ReplyVO vo){
		/* @RequestBody 애노테이션은 키,값 쌍의 josn 형태의 전송된 데이터를 ReplyVO 객체 타입으로 변경해
		 * 준다.
		 */
		ResponseEntity<String> entity = null;
		
		try {
			this.replyService.addReply(vo);//댓글저장
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
			//댓글 저장 성공시 'SUCCESS'문자와 200 정상상태 코드가 반환
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
			//댓글 저장 실패시 예외 에러 메시지와 나쁜 상태 코드 반환
		}
		return entity;
	}//reply_add()
	
	//게시판 번호에 해당하는 댓글 목록
	@RequestMapping(value="/all/{bno}",produces="application/json")
	public ResponseEntity<List<ReplyVO>> getReplyList(@PathVariable("bno") int bno){
		/* @PathVariable("bno")는 매핑주소로 부터 게시판 번호값을 추출하는 용도로 활용된다.
		 */
		ResponseEntity<List<ReplyVO>> entity = null;
		
		try {
			entity = new ResponseEntity<>(this.replyService.listReply(bno), 
					HttpStatus.OK);
			//게시판 번호에 해당하는 댓글 목록을 반환
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}//getReplyList()
	
	//댓글 수정
	@RequestMapping(value="/{rno}", method= {RequestMethod.PUT,RequestMethod.PATCH})
	//PUT은 전체자료 수정, PATCH는 일부 자료 수정
	public ResponseEntity<String> updateReply(@PathVariable("rno") int rno,
			@RequestBody ReplyVO vo){
		
		ResponseEntity<String> entity = null;
		
		try {
			vo.setRno(rno);//댓글 번호 저장
			this.replyService.editReply(vo);//댓글 수정
			entity=new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}//updateReply()
	
	//댓글 삭제
	@RequestMapping(value="{rno}", method=RequestMethod.DELETE)
	public ResponseEntity<String> delReply(@PathVariable("rno") int rno){
		ResponseEntity<String> entity = null;
		
		try {
			this.replyService.deleteReply(rno); //댓글 삭제
			entity=new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}//delReply()
}
