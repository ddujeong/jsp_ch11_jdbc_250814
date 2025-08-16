<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
</head>
<body>
<% 
out.println("member_id 파라미터 값: " + request.getParameter("member_id"));
%>
	<h2>게시판 글쓰기</h2>
	<hr>
	<form action="boardWriteOk.jsp">
		글 제 목 : <input type="text" name="btitle" size="50"><br><br>
		글 내 용 : <textarea rows="15" cols="50" name="bcontent"></textarea><br><br>
		글 쓴 이 : <input type="text" name="member_id" value="${param.member_id}" readonly="readonly"><br><br>
		<input type="submit" value="글 등록">
	</form>

</body>
</html>