<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
	<body>
	<div class="container-fluid">
	
		<!--  mainMenu include  -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!--  mainMenu include -->
		
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
			<h4><span class="text-primary font-weight-bold"><%=loginMember.getMemberName() %> </span>님 반갑습니다.</h4>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectMemberOne.jsp">회원정보</a>	<br><br>		
			
			<!--  관리자 메뉴  -->
		<%
			if(loginMember.getMemberLevel() > 0) {		//	Level이 1 이상일 때만 출력
		%>
			<div><a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/adminIndex.jsp">관리자 메뉴</a></div>
		<%	
			}
		}
		%>	
		</div>
	</div>
	</body>
</html>