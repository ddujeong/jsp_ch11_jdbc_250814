<%@page import="com.ddu.member.memberDto"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	String mid = request.getParameter("mid");
	
	// DB 커넥션 준비
	String driverName = "com.mysql.jdbc.Driver"; // mysql JDBC 드라이버 이름
	String url = "jdbc:mysql://localhost:3306/jspdb"; // mysql이 설치된 서버의 주소(ip)와 연결할 DB(스키마)의 이름
	// jdbc:mysql://172.30.1.55:3306 <- 선생님 ip주소 
	String username = "root";
	String password = "12345";
	
	// sql문 만들기
	String sql = "SELECT * FROM members WHERE member_id= '" + mid + "'";

	Connection conn = null; // connection 인터페이스로 선언 후 null값으로 초기화 (인스턴스화XX)
	Statement stmt = null; // sql문을 관리(실행)해주는 객체를 선언해주는 인터페이스로 stmt 선언 후 null값으로 초기화(인스턴스화 XX)
	ResultSet rs = null; // selest문 실행시 db에서 반환해주는 레코드의 값을 받아줄 rs
	memberDto memberDto = new memberDto(); // DTO 객체 채우기
	
	try {
		Class.forName(driverName); // mysql 드라이버 클래스 불러오기
		conn = DriverManager.getConnection(url, username, password);	
		// connection 이 메모리에 생성(DB와 연결 커넥션 conn 생성)
		stmt = conn.createStatement(); // stmt 객체 생성 
		//int sqlResult = stmt.executeUpdate(sql);
		// sql문을 DB로 보내서 실행해줌 -> 성공하면 1을 반환, 실패면 1이 아닌 값을 반환 (영향을 받은 행의 갯수)
		rs =  stmt.executeQuery(sql); 
		// SELECT문 실행 -> 결과가 DB로 반환 -> 결과(레코드)를 받아주는 ResultSet 타입 객체로 받아야함
		
		if (rs.next()){ // 아이디가 존재 
			do {
				mid = rs.getString("member_id");
				String mpw = rs.getString("member_pw");
				String mname = rs.getString("member_name");
				String memail = rs.getString("member_email");
				
				
				memberDto.setMember_id(mid);
				memberDto.setMember_pw(mpw);
				memberDto.setMember_name(mname);
				memberDto.setMember_email(memail);
			} while (rs.next());
		}else{ // 아이디가 존재 하지않으면
			response.sendRedirect("memberModify.jsp");
		}
		 
		} catch(Exception e) {	
		e.printStackTrace();
	} finally { // 에러 발생여부와 상관없이 connection 닫기 실행
		try {
			if(rs != null){ // stmt 가 null이 아니면 닫기 (conn 보다 먼저 닫아야함)
				rs.close();
			}
			if(stmt != null){ // stmt 가 null이 아니면 닫기 (conn 보다 먼저 닫아야함)
			stmt.close();
			}
			if(conn != null){ // connection이 null이 아닐 때만 닫기
			conn.close();
			} 
		} catch(Exception e) {
			e.printStackTrace();
		}	
		
		}
		request.setAttribute("memberDto", memberDto);
		// 조회된 회원정보가 들어있는 memberDto를 request 객체에 set
	%>
	<h2>회원 정보 수정</h2>
	<form action="memberModifyOk.jsp" method="post">
		아이디 : <input type="text" name="mid" value="${memberDto.member_id }" readonly="readonly"><br><br>
		비밀번호 : <input type="password" name="mpw" value="${memberDto.member_pw }"><br><br>
		이름 : <input type="text" name="mname" value="${memberDto.member_name }"><br><br>
		이메일 : <input type="text" name="memail" value="${memberDto.member_email }"><br><br>
		<input type="submit" value="수정완료">
	</form>
</body>
</html>