package net.daum.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UploadController {//파일 첨부 즉 이진파일 업로드 스프링 컨트롤러 클래스

	@GetMapping("/uploadForm") //get으로 접근하는 매핑주소 처리,uploadForm매핑주소 등록
	public void uploadForm() {
		//리턴타입이 없는 void형이면 매핑주소가 뷰페이지 파일명이 된다. => 뷰리졸브 경로는 /WEB-INF/views/
		//uploadForm.jsp
		
	}//uploadForm()
	
	//동기식 이진파일 업로드
	@PostMapping("/uploadFormAction") //post로 접근하는 매핑주소 처리
	public void uploadFormAction(MultipartFile[] uploadFile,HttpServletRequest request) {
		/* MultipartFile 스프링 api를 사용해서 업로드 되는 파일 데이터를 쉽게 처리, 다중 업로드 파일은 배열로
		 * 받는다. 매개변수명(즉 전달인자명) uploadFile은 <input type="file" name="uploadFile"
		 * 네임피라미터 이름(네임속성)과 같아야 한다.
		 */
		String uploadFolder = request.getRealPath("/resources/upload"); //첨부 파일 업로드
		//실제 경로를 구함.
		System.out.println("첨부 파일 업로드 실제 경로 : "+uploadFolder);
		
		for(MultipartFile multi : uploadFile) {
			System.out.println("==================================>");
			System.out.println("Upload file name : "+ multi.getOriginalFilename());
			//첨부된 실제 원본 파일명
			System.out.println("Upload file size : "+ multi.getSize());//업로드 파일 크기
			
			File saveFile = new File(uploadFolder, multi.getOriginalFilename());
			
			try {
				multi.transferTo(saveFile);//업로드 폴더에 첨부파일 실제 업로드 됨.
			}catch(Exception e) {e.printStackTrace();}
		}//for
		
		/* 문제)Tomcat 서버에 의해서 실제 upload폴더에 첨부된 파일이 업로드 되게 만들어 보자. 한개 첨부파일
		 * 뿐만 아니라 다중 파일 첨부확인도 해보자. 에러가 나면 디버깅도 해보고 정상적인 프로그램이 될 때 까지
		 * 개발자 테스트 과정을 해보자.
		 */
	}//uploadFormAction()
	
	//비동기식 아작스 이진파일 업로드 폼 뷰페이지 작성
	@GetMapping("/uploadAjax")
	public ModelAndView uploadAjax() {
		return new ModelAndView("uploadAjaxForm");//생성자 인자값으로 뷰페이지 파일명이 들어감.
		//뷰리졸브 경로는 /WEB-INF/views/uploadAjaxForm.jsp
	}//uploadAjax()
	
	@PostMapping("/uploadAjaxAction") //비동기식 post로 접근하는 매핑주소 uploadAjaxAction을 처리
	public void uploadAjaxAction(MultipartFile[] uploadFile) {
		
		System.out.println("upload ajax post...");
		String uploadFolder = "C:\\upload2"; //이진 파일 업로드 서버 경로
				
		for(MultipartFile multi:uploadFile) {
			
			System.out.println("=========================>");
			System.out.println("첨부된 원본 파일명 : "+multi.getOriginalFilename());
			System.out.println("첨부된 파일크기 : "+multi.getSize());
			
			String uploadFileName = multi.getOriginalFilename();//
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			/* IE인 경우는 전체 파일경로가 전송되기 때문에 마지막 경로 구분 \이후부터 마지막 문자까지 구한다. 즉
			 * 첨부된 실제 파일명만 구한다.
			 */
			System.out.println("only file name:"+uploadFileName);
			
			File saveFile = new File(uploadFolder,uploadFileName);
			
			try {
				multi.transferTo(saveFile);//실제 첨부파일을 업로드
			}catch(Exception e) {e.printStackTrace();}
			/* 문제)비동기식으로 한개 나 하나 이상 다중 첨부파일이 C:\\upload2폴더에 실제 업로드가 되는지
			 * 확인해 보고 에러가 난 경우는 디버깅하면서 개발자 단위 테스트까지 해보자.
			 */
		}//for
	}//uploadAjaxAction()
}
