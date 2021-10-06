<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
	OrderDao orderDao = new OrderDao();
	OrderEbookMember oem = orderDao.selectOrderOne(orderNo);
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
			<h1>상세 구매내역</h1>
		</div>		
		
		<table class="table text-center table-layout:fixed">
			<thead>
				<tr>
					<td>구매자 ID : <%=oem.getMember().getMemberId() %></td>
				</tr>
				<tr>
					<td>전자책 제목 : <%=oem.getEbook().getEbookTitle() %></td>
				</tr>				
			</thead>
			<tbody>
				<tr>
					<td>
						<img src="<%=request.getContextPath() %>/image/<%=oem.getEbook().getEbookImg() %>">						
					</td>
				</tr>
				<tr>
					<td>
						<div>구매 가격 : ₩ <%=oem.getOrder().getOrderPrice() %></div>						
					</td>	
				</tr>
				<tr>
					<td>
						<div>구매 날짜 : <%=oem.getOrder().getUpdateDate() %></div>						
					</td>	
				</tr>
				<tr>	
					<td>
						<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/selectOrderList.jsp">돌아가기</a>
					</td>	
				</tr>
			</tbody>
		</table>	
	</div>
	</body>
</html>