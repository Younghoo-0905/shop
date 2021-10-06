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
					<td><%=oem.getEbook().getEbookTitle() %></td>
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
						<a class="btn btn-dark" href="<%=request.getContextPath() %>/insertOrderCommentForm.jsp?ebookNo=<%=oem.getEbook().getEbookNo() %>&orderNo=<%=oem.getOrder().getOrderNo() %>">상품평 등록</a>
						<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectOrderListByMember.jsp">돌아가기</a>
					</td>	
				</tr>
			</tbody>
		</table>	
	</div>
	</body>
</html>