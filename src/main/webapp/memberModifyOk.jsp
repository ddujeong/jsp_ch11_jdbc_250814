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
<title>회원 수정 처리</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		String mname = request.getParameter("mname");
		String memail = request.getParameter("memail");
		// DB에 삽입할 데이터 준비 완료
		
		// DB 커넥션 준비
		String driverName = "com.mysql.jdbc.Driver"; // mysql JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // mysql이 설치된 서버의 주소(ip)와 연결할 DB(스키마)의 이름
		// jdbc:mysql://172.30.1.55:3306 <- 선생님 ip주소 
		String username = "root";
		String password = "12345";
		
		// sql문 만들기
		String sql = "UPDATE members SET member_pw =  '"+ mpw +"' , member_name = '"+ mname + "' , member_email = '" + memail + "' WHERE member_id = '" +  mid +"'";
	
		Connection conn = null; // connection 인터페이스로 선언 후 null값으로 초기화 (인스턴스화XX)
		Statement stmt = null; // sql문을 관리(실행)해주는 객체를 선언해주는 인터페이스로 stmt 선언 후 null값으로 초기화(인스턴스화 XX)
		try {
			Class.forName(driverName); // mysql 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);	
			// connection 이 메모리에 생성(DB와 연결 커넥션 conn 생성)
			stmt = conn.createStatement(); // stmt 객체 생성 
			int sqlResult = stmt.executeUpdate(sql);
			
			
		} catch(Exception e) {	
			out.print("회원 정보 수정 실패");
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
		String sql2 = "SELECT * FROM members WHERE member_id= '" + mid + "'";

		Connection conn2 = null; // connection 인터페이스로 선언 후 null값으로 초기화 (인스턴스화XX)
		Statement stmt2 = null; // sql문을 관리(실행)해주는 객체를 선언해주는 인터페이스로 stmt 선언 후 null값으로 초기화(인스턴스화 XX)
		ResultSet rs2 = null; // selest문 실행시 db에서 반환해주는 레코드의 값을 받아줄 rs
		memberDto memberDto2 = new memberDto(); // DTO 객체 채우기
		
		try {
			Class.forName(driverName); // mysql 드라이버 클래스 불러오기
			conn2 = DriverManager.getConnection(url, username, password);	
			// connection 이 메모리에 생성(DB와 연결 커넥션 conn 생성)
			stmt2 = conn2.createStatement(); // stmt 객체 생성 
			//int sqlResult = stmt.executeUpdate(sql);
			// sql문을 DB로 보내서 실행해줌 -> 성공하면 1을 반환, 실패면 1이 아닌 값을 반환 (영향을 받은 행의 갯수)
			rs2 =  stmt2.executeQuery(sql2); 
			// SELECT문 실행 -> 결과가 DB로 반환 -> 결과(레코드)를 받아주는 ResultSet 타입 객체로 받아야함
			
			if (rs2.next()){ // 아이디가 존재 
				do {
					String mid2 = rs2.getString("member_id");
					String mpw2 = rs2.getString("member_pw");
					String mname2 = rs2.getString("member_name");
					String memail2 = rs2.getString("member_email");
					
					
					memberDto2.setMember_id(mid2);
					memberDto2.setMember_pw(mpw2);
					memberDto2.setMember_name(mname2);
					memberDto2.setMember_email(memail2);
				} while (rs2.next());
			}else{ // 아이디가 존재 하지않으면
				response.sendRedirect("memberModify.jsp");
			}
			 
			} catch(Exception e) {	
			e.printStackTrace();
		} finally { // 에러 발생여부와 상관없이 connection 닫기 실행
			try {
				if(rs2 != null){ // stmt 가 null이 아니면 닫기 (conn 보다 먼저 닫아야함)
					rs2.close();
				}
				if(stmt2 != null){ // stmt 가 null이 아니면 닫기 (conn 보다 먼저 닫아야함)
				stmt2.close();
				}
				if(conn2 != null){ // connection이 null이 아닐 때만 닫기
				conn2.close();
				} 
			} catch(Exception e) {
				e.printStackTrace();
			}	
			
			}
			request.setAttribute("memberDto", memberDto2);
		
	%>
		<h2>수정된 회원 정보</h2>
		아이디 : ${memberDto.member_id }<br><br>
		비밀번호 : ${memberDto.member_pw }<br><br>
		이름 : ${memberDto.member_name }<br><br>
		이메일 : ${memberDto.member_email }<br><br>
</body>
</html>