<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비동기식 아작스 댓글연습</title>
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
<%-- 댓글 수정화면 --%>
 <div id="modDiv" style="display:none;">
   <%--display:none;은 댓글 수정화면을 안나오게 한다. --%>
   <div class="modal-no"></div><%-- 댓글 번호 출력부분 --%>
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
 
 <br><hr><br>
 
 <%-- 댓글 목록 --%>
 <ul id="replies"></ul>
 
  <script src="https://code.jquery.com/jquery-latest.min.js"></script>
  <%--jQuery 라이브러리 CDN --%>
  <script>
    $bno=13;//게시판 번호
    
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
    }//modDivClose()
  </script>
</body>
</html>








