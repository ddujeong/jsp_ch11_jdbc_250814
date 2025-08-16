<%@page import="java.util.ArrayList"%>
<%@page import="com.ddu.member.memberDto"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모든 회원 리스트</title>
</head>
<body>
	<h2>모든 회원 리스트</h2>
	<hr>
	<%
		request.setCharacterEncoding("utf-8");
	
		// DB 커넥션 준비
		String driverName = "com.mysql.jdbc.Driver"; // mysql JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // mysql이 설치된 서버의 주소(ip)와 연결할 DB(스키마)의 이름
		// jdbc:mysql://172.30.1.55:3306 <- 선생님 ip주소 
		String username = "root";
		String password = "12345";
		
		// sql문 만들기
		String sql = "SELECT * FROM members";
	
		Connection conn = null; // connection 인터페이스로 선언 후 null값으로 초기화 (인스턴스화XX)
		Statement stmt = null; // sql문을 관리(실행)해주는 객체를 선언해주는 인터페이스로 stmt 선언 후 null값으로 초기화(인스턴스화 XX)
		ResultSet rs = null; // selest문 실행시 db에서 반환해주는 레코드의 값을 받아줄 rs
		List<memberDto> memberList = new ArrayList<>(); // 1명의 회원정보 Dto 객체들이 여러개 저장될 리스트 선언
		
		try {
			Class.forName(driverName); // mysql 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);	
			// connection 이 메모리에 생성(DB와 연결 커넥션 conn 생성)
			stmt = conn.createStatement(); // stmt 객체 생성 
			//int sqlResult = stmt.executeUpdate(sql);
			rs =  stmt.executeQuery(sql); 
			// SELECT문 실행 -> 결과가 DB로 반환 -> 결과(레코드)를 받아주는 ResultSet 타입 객체로 받아야함
			
			while (rs.next()){
				memberDto memberDto = new memberDto();
				memberDto.setMember_id(rs.getString("member_id"));
				memberDto.setMember_pw(rs.getString("member_pw"));
				memberDto.setMember_name(rs.getString("member_name"));
				memberDto.setMember_email(rs.getString("member_email"));
				memberDto.setMember_date(rs.getString("member_date"));
				
				memberList.add(memberDto);
			}
			for(memberDto mdto : memberList){
				out.println(mdto.getMember_id() + " / ");
				out.println(mdto.getMember_pw() + " / ");
				out.println(mdto.getMember_name() + " / ");
				out.println(mdto.getMember_email() + " / ");
				out.println(mdto.getMember_date() + "<br>");
			}
			
			} catch(Exception e) {	
			out.print("DB 에러 발생 ! 회원가입 실패!");
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
	
	%>
</body>
</html>