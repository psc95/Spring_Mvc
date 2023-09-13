<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- JSTL 코어 태그립 추가 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스프링 MVC 게시판 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<table border="1">
  <tr>
   <th colspan="5">스프링 MVC게시판 목록</th>
  </tr>
  <tr>
   <td colspan="5" align="right">
    <span style="font-weight:bolder;">총 게시물 수: ${totalCount} 개</span>
    	<%--EL에 사용한 totalCount는 BoardController.java에서 사용한 키이름이다. --%>
   </td>
  </tr>
  <tr>
   <th>번호</th> <th>제목</th> <th>글쓴이</th> <th>조회수</th> <th>등록날짜</th>
  </tr>
  <c:if test="${!empty blist}">
   <c:forEach var="b" items="${blist}">
    <tr>
     <th>${b.bno}</th> <%-- b.bno는 b.getBno();와 같은 기능이다. --%>
     <th>
     <a href="/controller/board/board_cont?bno=${b.bno}&page=${page}&state=cont">${b.title}</a>
     <%-- board_cont?bno=번호&page=쪽번호 &state=cont가 get방식으로 bno에 번호,page에 쪽번호 &state=cont가 &구분기호로 구분해서
     3개의 피라미터값이 get방식으로 전달된다. 이런 방식을 쿼리스트링 방식 이라고 한다.특히 쪽번호를 get으로 전달
     하는 이유는 책갈피 기능 구현 때문이다. --%>
     <c:if test="${b.replycnt != 0}"><!-- 댓글이 있는 경우 실행 -->
       <strong>[댓글 개수 : ${b.replycnt}개]</strong>
     </c:if>
     
     </th>
     <th>${b.writer}</th>
     <th>${b.viewcnt}</th>
     <th>${b.regdate}</th>
    </tr>
   </c:forEach>
  </c:if>
  <c:if test="${empty blist}">
   <tr>
    <th colspan="5">게시물 목록이 없습니다.</th>
   </tr>
  </c:if>
  
  <%-- 페이징(쪽나누기) 시작 --%>
  <tr>
  <th colspan="5">
   <c:if test="${page <= 1}">
    [이전]&nbsp; <%-- &nbsp;은 한칸의 빈공백 처리 --%>
   </c:if>
   <c:if test="${page > 1}">
     <a href="/controller/board/board_list?page=${page-1}">[이전]</a>&nbsp;
   </c:if>
   
   <%--쪽번호 출력 부분 --%>
   <c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
     <c:if test="${a == page}"> <%--현재 쪽번호가 선택된 경우 --%>
      <${a}>
     </c:if>
     <c:if test="${a != page}"> <%-- 현재 쪽번호가 선택 안된 경우 --%>
     <a href="/controller/board/board_list?page=${a}">[${a}]</a>&nbsp;
     <%-- board_list?page=쪽번호가 웹주소창에 노출되는 get방식으로 전달된다. --%>
     </c:if>
   </c:forEach>
   
   <c:if test="${page >= maxpage}">
    [다음]
   </c:if>
   <c:if test="${page < maxpage}">
    <a href="/controller/board/board_list?page=${page+1}">[다음]</a>
   </c:if>
  </th>
 </tr>
  <%-- 페이징 끝 --%>
  <tr>
   <td colspan="5" align="right">
   <input type="button" value="글쓰기" onclick="location=
	   '/controller/board/board_write?page=${page}';">
   </td>
  </tr>
</table>
<script>
 $msg = "${result}";//자바스크립트에서 jsp문법인 EL(표현언어) 또는 JSTL 사용가능함. BoardController.
 //java에서 result키이름에 저장된 success문자를 EL인 ${result} 가져온다
 
 if($msg == 'success'){
	 alert('스프링 MVC 게시물 처리가 완료 되었습니다!');
 }
</script>
</body>
</html>