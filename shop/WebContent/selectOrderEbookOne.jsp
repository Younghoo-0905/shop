<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	//	비회원 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){	//	
		//	System.out.println("접근 불가능" + loginMember.getMemberLevel());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	
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
	
		<!--  mainMenu include  -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!--  mainMenu include -->
		
		<div class="jumbotron text-center">	  
			<h1>상세 구매내역</h1>
		</div>		
		
		<table class="table text-center table-layout:fixed">
			<thead>
				<tr>
					<td><%=ebook.getEbookTitle() %></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<img src="<%=request.getContextPath() %>/image/<%=ebook.getEbookImg() %>">						
					</td>
				</tr>
				<tr>
					<td>
						<div>구매 가격 : ₩ <%=orderPrice %></div>						
					</td>	
				</tr>
				<tr>	
					<td>
						<a class="btn btn-dark" href="<%=request.getContextPath() %>/insertOrderCommentForm.jsp?orderNo=<%=orderNo %>&ebookNo=<%=ebookNo %>">상품평 등록</a>	
					</td>	
				</tr>
			</tbody>
		</table>	
	</div>
	</body>
</html>