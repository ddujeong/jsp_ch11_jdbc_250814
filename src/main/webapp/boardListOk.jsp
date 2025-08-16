<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 게시글</title>
<style>
  body {
    font-family: "Noto Sans KR", "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
    background: #fff;
    padding: 20px;
  }

  table {
    width: 60%;
    border-collapse: collapse;
    font-size: 14px;
    color: #333;
  }

  thead tr {
    background-color: #f0f0f0;
    border-bottom: 2px solid #ddd;
  }

  thead th {
    padding: 10px 15px;
    text-align: center;
    font-weight: 600;
    color: #555;
  }

  tbody tr {
    border-bottom: 1px solid #e1e1e1;
  }

  tbody tr:hover {
    background-color: #f9f9f9;
  }

  tbody td {
    padding: 10px 15px;
    vertical-align: middle;
  }

  tbody td:nth-child(1) {
    width: 5%;
    text-align: center;
    color: #666;
  }

  tbody td:nth-child(2) {
    width: 65%;
  }

  tbody td:nth-child(3) {
    width: 15%;
    color: #777;
    text-align: center;
  }

  tbody td:nth-child(4) {
    width: 15%;
    color: #777;
    text-align: center;
  }

  /* 제목 링크 스타일 */
  tbody td:nth-child(2) a {
    color: #2a78f4;
    text-decoration: none;
  }
  tbody td:nth-child(2) a:hover {
    text-decoration: underline;
  }
</style>
</head>
<body>
<h2>게시글 목록</h2>
	<hr>
	<table>
		<thead>
			<tr>
				<th>NO.</th>
				<th>글 제 목</th>
				<th>글 내 용</th>
				<th>글 쓴 이</th>
				<th>작 성 일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="boardDto" items="${boardList }">
			
				<tr>
					<td>${boardDto.bnum}</td>
					<td>${boardDto.btitle }</td>
					<td>${boardDto.bcontent }</td>
					<td>${boardDto.member_id }</td>
					<td>${boardDto.bdate }</td>
				</tr>
		</c:forEach>
		</tbody>
	</table>
	<a href="boardWrite.jsp">글 쓰러 가기</a>
</body>
</html>