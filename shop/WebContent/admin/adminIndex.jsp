<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%
	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		//	System.out.println("접근 불가능" + loginMember.getMemberLevel());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
	<body>
	<div class="container">
	
		<!--  adminMenu include  -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!--  adminMenu include -->
		
		<div class="jumbotron text-center">	  
			<h1>관리자 페이지</h1>
		</div>
		
		<div class="d-flex justify-content-center"><%=loginMember.getMemberName() %> 님 반갑습니다.</div>
	</body>
</html>