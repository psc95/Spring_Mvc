<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스프링 MVC 게시판 내용보기와 아작스 댓글 프로그램</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
  <%--jQuery 라이브러리 CDN --%>
<style type="text/css">
 #modDiv{ /*댓글 수정폼 ui */
 	width:300px; height:100px; background-color:gray;
 	position: absolute; /*절대위치*/
 	top:50%;
 	left:50%;
 	margin-top: -50px;
 	margin-left: -150px;
 	padding : 10px;
 	z-index: 1000; /*position속성이 absolute,fixed(고정위치) 로 설정된 곳에서 사용한다.
 	이 속성은 요소가 겹쳐지는 순서를 제어할 수 있다. 숫자값이 큰것이 먼저 앞에 나온다.*/
 }
</style>
</head>
<body>
 <table border="1">
 <tr>
  <th colspan="2">스프링 MVC게시판 내용보기</th>
 </tr>
 <tr>
  <th>제목</th>
  <td>${b.title}</td>
 </tr>
 <tr>
  <th>내용</th>
  <td>${content}</td>
 </tr>
 <tr>
  <th>조회수</th>
  <td>${b.viewcnt}</td>
 </tr>
 <tr>
  <th colspan="2">
   <input type="button" value="수정"
   onclick="location='/controller/board/board_cont?bno=${b.bno}&page=${page}&state=edit';">
   <%--state=edit 구분값 때문에 동일 매핑주소를 사용해도 수정폼으로 이동한다. --%>
   
   <input type="button" value="삭제" onclick="if(confirm('정말로 삭제할까요?') == true){
	   location='/controller/board/board_del?bno=${b.bno}&page=${page}';}else{return;}">
	   <%--자바 스크립트에서 confirm()내장함수는 확인/취소버튼을 가진 경고창을 만들어 준다. 확인을 클릭하면
	   true를 반환하고 취소를 클릭하면 false를 반환한다.즉 확인클리하면 삭제로 이동하고 취소를 클릭하면 return;에
	   의해서 종료가 되어서 현재 내용보기에 그대로 있는다. 다시 한번더 삭제 유뮤를 확인하게 한다. --%>
	   
	   <input type="button" value="목록" onclick="location=
	   '/controller/board/board_list?page=${page}';">
  </th>
 </tr>
 </table>
 
 <br>
 <hr>
 <br>
 
 <%-- 댓글 수정화면 --%>
 <div id="modDiv" style="display:none;">
   <%--display:none;은 댓글 수정화면을 안나오게 한다. --%>
   <div class="modal-rno"></div><%-- 댓글 번호 출력부분 --%>
   <div>
    <textarea rows="3" cols="30" id="replytext"></textarea>
   </div> 
   <div>
     <button type="button" id="replyModBtn">댓글수정</button>
     <button type="button" id="replyDelBtn">댓글삭제</button>
     <button type="button" id="closeBtn" onclick="modDivClose();">닫기</button>
   </div>
 </div>
 
 <h2>아작스 댓글 연습페이지</h2>
 <div>
   <div>
       댓글 작성자 : <input type="text" name="replyer" id="newReplyWriter">
   </div>
   <br>
   
   <div>
      댓글 내용 : <textarea rows="5" cols="30" name="replytext" id="newReplyText"></textarea>
   </div>
   <br>
   
   <input type="button" id="replyAddBtn" value="댓글등록" >
 </div>
 
 <br>
 <hr>
 [<strong>${b.replycnt}개의 댓글</strong>]
 <!-- <h2>[댓글 갯수: ${b.replycnt} 개]</h2><br> -->
 <br>
 
 <%-- 댓글 목록 --%>
 <ul id="replies"></ul>
 
  
  <script>
    $bno=${b.bno};//게시판 번호, 자바스크립트에서 JSTL or EL 가능함
    
    getAllList(); //댓글 목록함수 호출
    
    function getAllList(){
    	$.getJSON("/controller/replies/all/"+$bno, function(data){
    		//get방식으로 JSON데이터를 읽어오는 jQuery 비동기식 아작스 함수, 가져온 데이터는 data매개변수
    		//에 저장
    		$result="";
    		$(data).each(function(){//jQuery each()함수로 반복
    			$result += "<li data-rno='"+this.rno+"' class='replyLi'>"
    			+ this.rno +": <span class='com' style='color:blue;font-weight:bole;'>"
    			+ this.replytext +"</span> <button type='button'>댓글수정</button></li><br>";
    		});
    		$('#replies').html($result);// html() jQuery함수는 해당 replies아이디 영역에 문자와
    		//태그를 함께 변경 적용
    	});
    }//getAllList()
    
    //댓글 등록
    $('#replyAddBtn').on('click',function(){
    	$replyer = $('#newReplyWriter').val();//댓글 작성자
    	$replytext = $('#newReplyText').val();//댓글 내용
    	
    	$.ajax({
    		type:'post',//보내는 방식을 post로 지정
    		url:'/controller/replies/reply_add', //서버 매핑주소
    		headers : {
    			"Content-Type" : "application/json",
    			"X-HTTP-Method-Override" : "POST"
    		},
    		dataType : 'text', //보내는 자료형
    		data : JSON.stringify({
    			bno : $bno, //bno 피라미터 이름에 게시판 번호값을 담아서 전달,왼쪽이 json데이터 키이름,오른쪽이 값
    			replyer : $replyer, //댓글 작성자
    			replytext : $replytext //댓글 내용
    		}),
    		success:function($data){
    			if($data == 'SUCCESS'){
    				alert('댓글이 등록되었습니다!');
    				location.reload();//자바스크립트에서 새로고침(단축키는 F5),평가시험에 나옴
    				getAllList();//댓글 목록 함수 호출
    			}
    		}
    	});//jQuery 비동기식 아작스 함수
    });
    
    //댓글 수정화면
    $('#replies').on('click','.replyLi button',function(){
    	var reply = $(this).parent(); //부모 요소인 li태그를 구함
    	var rno = reply.attr('data-rno');//댓글 번호를 구함 => li태그의 data-rno속성값을 구함
    	var replytext = reply.children('.com').text();//댓글 내용을 구함=>li태그 자식요소중 클래스
    	//선택자 .com의 댓글 내용 문자만 text()함수로 구함.
    	
    	$('.modal-rno').html(rno);//modal-rno 클래스 선택자 영역에 댓글 번호를 변경 적용
    	$('#replytext').val(replytext);//textarea 입력박스에 val()함수로 댓글 내용을 변경 적용
    	$('#modDiv').show('slow');//댓글 수정화면을 천천히 보이게 한다.
    });
    
    //댓글 수정화면 닫기
    function modDivClose(){
    	$('#modDiv').hide('slow');
    }//modDivClose()h
    
    //댓글 수정 완료
    $('#replyModBtn').on('click',function(){
    	$rno = $('.modal-rno').html(); //댓글 번호
    	$replytext = $('#replytext').val(); //수정할 댓글 내용
    	
    	$.ajax({
    		type:'put', //보내는 방식
    		url:'/controller/replies/'+$rno, //서버 매핑주소
    		headers:{
    			"Content-Type" : "application/json",
    			"X-HTTP-Method-Override" : "PUT"
    		},
    		data:JSON.stringify({
    			replytext : $replytext
    		}),
    		dataType:'text',
    		success:function(result){
    			if(result == 'SUCCESS'){
    				alert('댓글이 수정이 되었습니다!');
    				$('#modDiv').hide(300);//댓글 수정화면을 닫는다. 1000이 1초
    				getAllList(); //댓글 목록함수 호출
    			}
    		}
    	});
    });
    
    //댓글 삭제
    $('#replyDelBtn').on('click',function(){
    	$rno = $('.modal-rno').html(); //댓글 번호
    	
    	$.ajax({
    		type : 'delete',
    		url : '/controller/replies/'+$rno,
    		headers : {
    			"Content-Type" : "application/json",
    			"X-HTTP-Method-Override" : "DELETE"
    		},
    		dataType:"text",
    		success:function(data){
    			if(data == 'SUCCESS'){
    				alert('댓글이 삭제되었습니다!');
    				$('#modDiv').hide('slow');
    				location.reload();//자바스크립트에서 새로고침(단축키는 F5),평가시험에 나옴
    				getAllList();
    			}
    		}
    	});
    });
  </script>
</body>
</html>











