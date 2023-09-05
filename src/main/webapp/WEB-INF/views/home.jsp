<%@ page contentType="text/html; charset=UTF-8" %>
<%-- 웹브라우저에 출력되는 문자와 태그, 언어코딩 타입을 설정을 해야 HTML태그,자바스크립트가 잘 적용이 되고
출력되는 한글이 안 깨진다. --%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<%-- serverTime은 EL 즉 표현언어에서 HomeController.java에 설정된 키이름을 참조해서 값을 가져온다. --%>
</body>
</html>
