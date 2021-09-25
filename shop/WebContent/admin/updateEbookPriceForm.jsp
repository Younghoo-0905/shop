<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
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
	
	EbookDao ebookDao = new EbookDao();
	Ebook ebook = ebookDao.selectEbookOne(ebookNo);
%>


<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	<body>
	
	<div class="container-fluid">
	
		<!--  adminMenu include  -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!--  adminMenu include -->
		
		<div class="jumbotron text-center">	  
			<h1>
				<div>[전자책 관리]</div>
				<div>전자책 가격 수정</div>
			</h1>
		</div>		
		
		<form class="text-center" method="post" action="<%=request.getContextPath() %>/admin/updateEbookPriceAction.jsp">
		
			<div>전자책 No : </div>
			<div><input type="text" name="ebookNo" value="<%=ebookNo %>" readonly="readonly"></div>
			<div>가격 : </div>
			<div><input type="text" name="ebookPrice"></div>
			
			<br>		
		
			<button type="submit" class="btn btn-dark">수정</button>	
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>">돌아가기</a>			
		</form>
	</div>
	</body>
</html>