<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
</body>
</html>