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
		<h1>
			<div>[전자책 관리]</div>
			<div>전자책 이미지 수정</div>
		</h1>
	</div>
	
	<form action="<%=request.getContextPath() %>/admin/updateEbookImgAction.jsp" class="text-center" method="post" enctype="multipart/form-data">
				<!-- multipart/form-data : 액션으로 기계어코드를 넘길 때 사용 -->
				<!-- application/x-www-form-urlencoded : 액션으로 문자열 넘길 때 사용 -->
				
		<div>
			<input type="hidden" name="ebookNo" value="<%=ebookNo %>" readonly="readonly">상품 번호 : <%=ebookNo %>
			<input type="file" name="ebookImg">
		  	<button type="submit">이미지파일 수정</button>
		</div>
		<br>
	  	<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>">돌아가기</a>	
	
	</form>	
	</body>
</html>