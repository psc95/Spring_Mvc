package net.daum.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.daum.vo.ProductVO;

@Controller //@Controller 애노테이션을 사용하면 해당 컨트롤러를 스프링에서 인식하게 한다.
public class SampleController {
	
	@RequestMapping("/doA") //doA매핑주소 등록,GET or post로 접근하는 매핑주소를 처리
	public void doA() {
		//리턴타입이 없는 void형이면 매핑주소가 뷰페이지 파일명이 된다.
		System.out.println("doA 매핑주소가 실행됨");
	}//doA()
	
	@GetMapping("/doB") //doB매핑주소가 등록, get으로 접근하는 매핑주소를 처리
	public void doB() {
		
	}//doB()
	
	@RequestMapping("/doC")
	public String doC(@ModelAttribute("msg2") String msg) {
		//웹브라우저 주소창에 노출되는 get방식으로 doC?msg2=값 형태로 전달해야 한다.
		return "result";//뷰리졸브 즉 뷰페이지 경로는 /WEB-INF/views/result.jsp
	}//doC()
	
	@RequestMapping("/name_price") //name_price 매핑주소 등록
	public ModelAndView name_price() {
		ProductVO p = new ProductVO("수박",20000);
		ModelAndView pm = new ModelAndView("shop/water_melon");//생성자 인자값으로 뷰페이지
		//경로 설정 => /WEB-INF/views/shop/water_melon.jsp
		pm.addObject("p",p); //p키이름에 p객체를 저장
		return pm;
	}//name_price()
	
	@RequestMapping("/doE")
	public String doE(RedirectAttributes rttr) {
		rttr.addFlashAttribute("cityName","부산시");//벡엔드 컨트롤러 단에서 다른 매핑주소로 리다이렉트
		//즉 이동하는 경우 cityName키이름에 부산시 값을 담아서 전달한다. 주소창에 자료가 노출이 안되어서
		//보안이 좋다.
		return "redirect:/doF";//doE 매핑주소가 실행되면 doF매핑주소로 이동한다.
		//주소 값을 DB에 저장,수정,삭제 이후 변경된 레코드값을 정확히 확인하고자 할 때 주로 사용한다.
	}//doE()
	
	@GetMapping("/doF")
	public void doF(@ModelAttribute("cityName") String cityValue) {
		//cityName에 담겨져 온값을 가져온다.
		System.out.println("전달되어진 도시이름 : "+cityValue);
	}
	
	//키,값 쌍의 json 데이터 만들기
	@RequestMapping(value="/doJSON",produces="application/json")
	public @ResponseBody ProductVO doJSON() {
		//@ResponseBody 애노테이션을 메서드 리턴타입앞에 사용하면 jsp와 같은 뷰페이지 파일을 만들지 않고도
		//원하는 키,값쌍의 JSON데이터를 브라우저에 출력할 수 있다.리턴타입이 ProductVO빈 타입이면
		//해당 클래스의 변수명이 json데이터의 키이름이 된다.
		
		ProductVO p = new ProductVO("TV",1500000);
		return p;
	}//doJSON()
}
