<%@page import="com.ddu.member.boardDto"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ddu.member.memberDto"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 리스트</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String bnum = request.getParameter("bnum");
		String btitle = request.getParameter("btitle");
		String bcontent = request.getParameter("bcontent");
		String member_id = request.getParameter("member_id");
		String bdate = request.getParameter("bdate");
		// DB에 삽입할 데이터 준비 완료
		
		// DB 커넥션 준비
		String driverName = "com.mysql.jdbc.Driver"; // mysql JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // mysql이 설치된 서버의 주소(ip)와 연결할 DB(스키마)의 이름
		// jdbc:mysql://172.30.1.55:3306 <- 선생님 ip주소 
		String username = "root";
		String password = "12345";
		
		// sql문 만들기
		String sql = "INSERT INTO board(btitle, bcontent, member_id) VALUES('" + btitle + "','" + bcontent + "','" + member_id +  "')";
	
		Connection conn = null; // connection 인터페이스로 선언 후 null값으로 초기화 (인스턴스화XX)
		Statement stmt = null; // sql문을 관리(실행)해주는 객체를 선언해주는 인터페이스로 stmt 선언 후 null값으로 초기화(인스턴스화 XX)
		
		try {
			Class.forName(driverName); // mysql 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);	
			// connection 이 메모리에 생성(DB와 연결 커넥션 conn 생성)
			stmt = conn.createStatement(); // stmt 객체 생성 
			int sqlResult = stmt.executeUpdate(sql);
			// sql문을 DB로 보내서 실행해줌 -> 성공하면 1을 반환, 실패면 1이 아닌 값을 반환 (영향을 받은 행의 갯수)
			
			System.out.print("sqlResult : " + sqlResult);
			
		} catch(Exception e) {	
			out.print("DB 에러 발생 ! 회원가입 실패!");
			e.printStackTrace();
		} finally { // 에러 발생여부와 상관없이 connection 닫기 실행
			try {
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
	%>
	<a href="boardList.jsp">게시글리스트 보기</a>
</body>
</html>
