<%@page import="com.ddu.member.boardDto"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ddu.member.memberDto"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
	
		// DB 커넥션 준비
		String driverName = "com.mysql.jdbc.Driver"; // mysql JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // mysql이 설치된 서버의 주소(ip)와 연결할 DB(스키마)의 이름
		String username = "root";
		String password = "12345";
		
		// sql문 만들기
		String sql = "SELECT b.bnum, b.btitle, b.bcontent, m.member_id, b.bdate FROM board AS b INNER JOIN members AS m ON m.member_id = b.member_id ORDER BY bnum DESC";
	
		
		Connection conn = null; // connection 인터페이스로 선언 후 null값으로 초기화 (인스턴스화XX)
		Statement stmt = null; // sql문을 관리(실행)해주는 객체를 선언해주는 인터페이스로 stmt 선언 후 null값으로 초기화(인스턴스화 XX)
		ResultSet rs = null; // selest문 실행시 db에서 반환해주는 레코드의 값을 받아줄 rs
		List<boardDto> boardList = new ArrayList<>(); // 1명의 게시글정보 Dto 객체들이 여러개 저장될 리스트 선언
		
		try {
			Class.forName(driverName); // mysql 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);	
			// connection 이 메모리에 생성(DB와 연결 커넥션 conn 생성)
			stmt = conn.createStatement(); // stmt 객체 생성 
			rs =  stmt.executeQuery(sql); 
			
			
			while (rs.next()){
				boardDto boardDto = new boardDto();
				// boardDto boardDto = new boardDto(rs.getInt("bnum"),rs.getString("btitle"));
				boardDto.setBnum(rs.getInt("bnum"));
				boardDto.setBtitle(rs.getString("btitle"));
				boardDto.setBcontent(rs.getString("bcontent"));
				boardDto.setMember_id(rs.getString("member_id"));
				boardDto.setBdate(rs.getString("bdate"));

				boardList.add(boardDto);	
			} 
			} catch(Exception e) {	
			out.print("DB 에러 발생 ! 회원가입 실패!");
			e.printStackTrace();
		} finally { // 에러 발생여부와 상관없이 connection 닫기 실행
			try {
				if(rs != null){ // stmt 가 null이 아니면 닫기 (제일 먼저 닫아야함)
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
		request.setAttribute("boardList", boardList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("boardListOk.jsp");
		dispatcher.forward(request, response);
	%>
	
</body>
</html>
