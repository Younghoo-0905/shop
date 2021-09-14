<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
	<body>
	<div class="container">
		<!--  submenu include  -->
		<div>
			<jsp:include page="/partial/submenu.jsp"></jsp:include>
		</div>
		<!--  submenu include -->
		<div class="jumbotron text-center">	  
			<h1>메인 페이지</h1>	
		</div>
		<div class="text-center">
		<%
		if(session.getAttribute("loginMember") == null) {		
		%>		
			<!--  로그인 전 -->
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/loginForm.jsp">로그인</a>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/insertMemberForm.jsp">회원가입</a>
		<%
		} else {
			Member loginMember = (Member)session.getAttribute("loginMember");
		%>		
			<!--  로그인 후 -->		
			<div><%=loginMember.getMemberName() %>님 반갑습니다.</div>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectMemberOne.jsp">회원정보</a>
		<%
		}
		%>	
		</div>
	</div>
	</body>
</html>