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
			<h1>상품평 작성</h1>
		</div>		
		
		<form method="post" action="<%=request.getContextPath() %>/insertOrderCommentAction.jsp?ebookNo=<%=ebookNo %>&orderNo=<%=orderNo %>">
		
			<table class="table text-center table-layout:fixed">
				<thead>
					<tr>
						<td><%=ebook.getEbookTitle() %></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<img src="<%=request.getContextPath() %>/image/<%=ebook.getEbookImg() %>.jpg">						
						</td>
					</tr>
					<tr>
						<td>평점<br>
							<input type="text" style="width:30px" name="orderScore">/10
						</td>
						
					</tr>
					<tr>
						<td>
							<input type="textarea" style="width:400px;height:80px" name="orderComment">
						</td>						
					</tr>
					<tr>	
						<td>
							<button class="btn btn-dark" type="submit">등록</button>
							<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectOrderEbookOne.jsp?orderNo=<%=orderNo %>">돌아가기</a>
						</td>	
					</tr>
				</tbody>
			</table>		
		</form>	
	</div>
	
	</body>
</html>