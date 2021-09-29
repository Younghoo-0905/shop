<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<% 
	request.setCharacterEncoding("UTF-8");
	
	//	비회원 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){	
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderListByMember(loginMember.getMemberNo());
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
			<h1>나의 주문 내역</h1>
		</div>		
		
		<table class="table text-center table-layout:fixed">
			<thead>
				<tr>
					<th>주문 번호</th>
					<th>제목</th>
					<th>가격</th>
					<th>구매 날짜</th>
					<th>구매내역 상세보기</th>
				</tr>
			</thead>
			<tbody>		
			<%
				for(OrderEbookMember oem : list) {
			%>
					<tr>
						<td><%=oem.getOrder().getOrderNo() %></td>
						<td><%=oem.getEbook().getEbookTitle() %></td>
						<td><%=oem.getOrder().getOrderPrice() %></td>
						<td><%=oem.getOrder().getCreateDate() %></td>	
						<td><a href="<%=request.getContextPath() %>/selectOrderEbookOne.jsp?ebookNo=<%=oem.getEbook().getEbookNo() %>&orderNo=<%=oem.getOrder().getOrderNo() %>&orderPrice=<%=oem.getOrder().getOrderPrice() %>">상세보기</a>
					</tr>
			<%
				}		
			%>		
			</tbody>	
		</table>
	</div>
	</body>
</html>