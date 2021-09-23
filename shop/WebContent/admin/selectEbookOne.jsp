<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		//	System.out.println("접근 불가능" + loginMember.getMemberLevel());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
%>


<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	<body>
	
	<!--  adminMenu include  -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!--  adminMenu include -->
	
	<div class="jumbotron text-center">	  
		<h1>전자책 정보</h1>
	</div>
	
	<%
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	%>	
	
	<div>
		<%=ebook.getEbookNo() %>
	</div>
	<div>
		<img src="<%=request.getContextPath() %>/image/<%=ebook.getEbookImg() %>">
	</div>
	<div>
		<a href="">삭제</a>
		<a href="">가격수정</a>
		<a href="<%=request.getContextPath() %>/admin/updateEbookImg.jsp?ebookNo=<%=ebookNo %>">이미지수정</a>
	
	</div>
	
	</body>
</html>