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
	
	//	검색어
	String searchEbookTitle = "";
	if(request.getParameter("searchEbookTitle") != null) {
		searchEbookTitle = request.getParameter("searchEbookTitle");
	}
	
	int pagingNum = ((currentPage-1) / 10);		//	페이지의 페이지 넘버 : 0부터 시작	
	final int ROW_PER_PAGE = 10;	//	상수 : 10으로 초기화 되면 계속 10 값이 할당
	int beginRow = (currentPage-1) * ROW_PER_PAGE;	//	출력을 시작할 행 넘버
	
	//	주문 목록을 가져오는 메서드
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = null;
	
	if(searchEbookTitle.equals("") == true) {
		list = orderDao.selectOrderList(beginRow, ROW_PER_PAGE);
	} else {		//	검색한 아이디가 있을 경우 출력할 리스트
		list = orderDao.selectOrderListBySearchEbookTitle(beginRow, ROW_PER_PAGE, searchEbookTitle);
	}
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
		
			<!-- ebookTitle로 검색 -->
			<form action="<%=request.getContextPath() %>/admin/selectOrderList.jsp" method="get">
				<span>전자책 제목 : </span>
				<input type="text" name="searchEbookTitle">
				<button class="btn btn-dark" type="submit">검색</button>		
			</form>			
			
			<thead>
				<tr>
					<th>번호</th>
					<th>전자책 제목</th>
					<th>가격</th>
					<th>구매 날짜</th>
					<th>구매자 ID</th>
					<th>상세정보</th>
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
						<td><a href="<%=request.getContextPath() %>/admin/selectAdminOrderEbookOne.jsp?orderNo=<%=oem.getOrder().getOrderNo() %>">상세보기</a></td>									
					</tr>
			<%
				}		
			%>		
			</tbody>	
		</table>
		
		<!-- 페이징 구현 -->
		
		<div class="d-flex justify-content-center">
			<ul class =	"pagination active">
		<%		
			//	lastPage를 구하는 메서드 사용
			int lastPage = orderDao.selectOrderLastPage(ROW_PER_PAGE, searchEbookTitle);
			if(pagingNum > 0) {		//	'이전' 버튼
		%>			
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectOrderList.jsp?currentPage=<%=(pagingNum * 10) %>&searchEbookTitle=<%=searchEbookTitle %>">이전</a></li>
		<%
			}				
		
			for(int i = 1; i<=10; i++) {	//	페이지 번호
				if(i + (pagingNum * 10) == currentPage) {	//	currentPage인 링크버튼 파란색으로 표시
		%>
					<li class="page-item active"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectOrderList.jsp?currentPage=<%=i + (pagingNum * 10) %>&searchEbookTitle=<%=searchEbookTitle %>"><%=i + (pagingNum * 10) %></a></li>
		<%
				} else {									//	currentPage 아닌 링크버튼
		%>					
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectOrderList.jsp?currentPage=<%=i + (pagingNum * 10) %>&searchEbookTitle=<%=searchEbookTitle %>"><%=i + (pagingNum * 10) %></a></li>
		<%
				}
				if(((i + (pagingNum * 10)) == lastPage) || lastPage == 0) {	//	currentPage가 lastPage이면 다음페이지를 더이상 출력하지 않는다
					break;
				}
			}
			if(pagingNum < ((lastPage-1) / ROW_PER_PAGE)) {	//	'다음' 버튼
		%>
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectOrderList.jsp?currentPage=<%=(pagingNum * 10) + 11 %>&searchEbookTitle=<%=searchEbookTitle %>">다음</a></li>					
		<%
			}
		%>							
			</ul>	
		</div>		
		
	
	</body>
</html>