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
				<div>전자책 정보</div>
			</h1>
		</div>		
		
		<table class="table text-center table-layout:fixed">
			<thead>
				<tr>
					<td><%=ebook.getEbookNo() %></td>
				</tr>
				<tr>
					<td><%=ebook.getEbookTitle() %></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<img src="<%=request.getContextPath() %>/image/<%=ebook.getEbookImg() %>">
						<br>
						<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/updateEbookImg.jsp?ebookNo=<%=ebookNo %>">이미지수정</a>
					</td>
				</tr>
				<tr>
					<td>
						<div>가격 : ₩ <%=ebook.getEbookPrice() %></div>
						<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/updateEbookPriceForm.jsp?ebookNo=<%=ebookNo %>">가격 수정</a>
					</td>	
				</tr>
				<tr>	
					<td>
						<a class="btn btn-dark" href="">상품평</a>	
					</td>	
				</tr>
				<tr>	
					<td>
						<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/deleteEbookAction.jsp?ebookNo=<%=ebookNo %>">삭제</a>	
					</td>	
				</tr>
			</tbody>
		</table>
	</div>
	</body>
</html>