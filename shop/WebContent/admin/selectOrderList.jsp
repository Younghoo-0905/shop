<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	int currentPage = 1;	//	currentPage 초기화
	if(request.getParameter("currentPage") != null) {	//	currentPage 값이 넘어왔으면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//	System.out.println("[현재 페이지] " + currentPage);
	
	int pagingNum = ((currentPage-1) / 10);		//	페이지의 페이지 넘버 : 0부터 시작	
	final int ROW_PER_PAGE = 10;	//	상수 : 10으로 초기화 되면 계속 10 값이 할당
	int beginRow = (currentPage-1) * ROW_PER_PAGE;	//	출력을 시작할 행 넘버
	
	//	주문 목록을 가져오는 메서드
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderList(beginRow, ROW_PER_PAGE);
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
		<h1>주문 관리</h1>
	</div>
	
		<table class="table table-hover text-center table-layout:fixed">			
			<thead>
				<tr>
					<th>번호</th>
					<th>전자책 제목</th>
					<th>가격</th>
					<th>구매 날짜</th>
					<th>구매자 ID</th>
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
						<td><%=oem.getMember().getMemberId() %></td>			
					</tr>
			<%
				}		
			%>		
			</tbody>	
		</table>
		
		<!-- 페이징 구현 -->
		
	
	</body>
</html>