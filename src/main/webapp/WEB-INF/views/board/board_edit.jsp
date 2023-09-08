<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스프링 MVC 게시판 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
  function check(){
	  if($.trim($('#writer').val()) == ''){
		  alert('글쓴이를 입력하세요!');
		  $('#writer').val('').focus();
		  return false;
	  }
	  
	  if($.trim($('#title').val()).length == 0){
		  alert('글제목을 입력하세요!');
		  $('#title').val('').focus();
		  return false;
	  }
	  
	  if($.trim($('#content').val()) == ""){
		  alert('글내용을 입력하세요!');
		  $('#content').val('').focus();
		  return false;
	  }
  }
</script>
</head>
<body>
 <form method="post" action="board_edit_ok" onsubmit="return check();">
  <input type="hidden" name="bno" value="${b.bno}" >
  <%-- hidden은 브라우저 상에서 만들어 지지 않는다. 하지만 값을 네임피라미터 이름에 담아서 전달할 때 사용한다.
  브라우저 출력창에서 페이지 소스보기 하면 hidden이 노출되기 때문에 보안상 중요한 비번같은 값은 hidden으로 전달하는
  것이 아니다. --%>
  <input type="hidden" name="page" value="${page}" >
  <%--책갈피 기능때문에 쪽번호 전달 --%>
  
  <h2>스프링 MVC 게시판 수정폼</h2>
  글쓴이 : <input name="writer" id="writer" size="14" value="${b.writer}"><br><br>
  글제목 : <input name="title" id="title" size="36" value="${b.title}"><br><br>
  글내용 : <textarea name="content" id="content" rows="10" cols="36">${b.content}</textarea>
  <hr>
  <input type="submit" value="수정" >
  <input type="reset" value="취소" onclick="$('#writer').focus();">
  <input type="button" value="목록"
  onclick="location='/controller/board/board_list?page=${page}';">
  <%-- 페이징에서 책갈피 기능을 구현하기 위해서 board_list?page=쪽번호를 get방식으로 전달하면
  내가 본 페이지 번호로 바로 이동한다. --%>
 </form>
</body>
</html>