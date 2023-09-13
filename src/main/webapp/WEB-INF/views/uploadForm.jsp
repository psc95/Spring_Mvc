<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
 <h1>스프링 MVC 이진파일 업로드</h1>
 <form method="post" action="uploadFormAction"  enctype="multipart/form-data">
   <%-- 파일 첨부 기능인 자료실 기능 만들때 주의사항)
    	1.method=post방식으로 해야 한다. method속성을 생략하면 기본값이 get방식이다. get방식으로는 파일
    	첨부 기능을 만들 수 없다. 즉 자료실 기능을 못만들기 때문에 method 속성을 생략하면 안된다. 반드시 post로
    	해야 자료실 기능인 파일 첨부기능을 만들 수 있다.
    	
    	2.form태그내에 enctype="multipart/form-data" 속성을 지정해야 자료실 기능인 파일첨부를 만들 수 있다.
    --%>
    <input type="file" name="uploadFile" multiple >
    <%-- 최근 브라우저에서는 multiple속성을 지원하는대 이를 사용하면 하나의 첨부파일 뿐만 아니라 다중 첨부파일도
    	  처리가 가능하다  이 속성은 IE 10이상 버전에서만 지원된다. --%>
    <input type="submit" value="파일 업로드" >
 </form>
</body>
</html>