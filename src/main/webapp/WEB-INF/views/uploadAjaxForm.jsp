<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비동기식 아작스 파일첨부 연습</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
  $(document).ready(function(){
	 
	  $('#uploadBtn').on('click',function(e){
		 
		  var formData = new FormData();//폼데이터 객체 생성
		  /* 첨부파일을 업로드 하는 또 다른 방식은 비동기식 아작스를 이용해서 폼데이터 객체를 이용하는 것이다.
		  	 이 방식은 IE 10 버전 이후에서만 지원된다.
		  */
		  
		  var inputFile = $("input[name='uploadFile']");//아이디 선택자 말고 네임 피라미터 이름으로
		  //jQuery에서 input type="file"에 접근한다.
		  
		  var files = inputFile[0].files; //첫번째 input type="file"로 첨부한 것을 배열로 구함
		  
		  for(var i=0; i<files.length; i++){
			  formData.append("uploadFile", files[i]);//첨부파일을 폼데이터에 추가
		  }
		  
		  $.ajax({
			 url:'/controller/uploadAjaxAction', //서버 매핑주소
			 processData:false, //컨텐트 타입에 맞게 반환 여부
			 contentType:false, //요청 컨텐트 타입
			 data:formData, //폼데이터 객체를 전송
			 type:'POST', //보내는 방식
			 success: function(result){
				 
			 }
		  });//비동기식 jQuery 아작스 함수
		  
	  });
  });
</script>
</head>
<body>
 <h1>Upload with Ajax</h1>
 <input type="file" name="uploadFile" multiple >
 <button type="button" id="uploadBtn">File Upload</button>
</body>
</html>