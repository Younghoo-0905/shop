<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	Member loginMember = (Member)session.getAttribute("loginMember");

	int ebookNo = 0;
	if(request.getParameter("ebookNo") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	} else if(request.getParameter("ebookNo") != null) {
		ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	}
	
	int currentPage = 1;	//	currentPage 초기화
	if(request.getParameter("currentPage") != null) {	//	currentPage 값이 넘어왔으면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int pagingNum = ((currentPage-1) / 10);		//	페이지의 페이지 넘버 : 0부터 시작	
	final int ROW_PER_PAGE = 10;	//	상수 : 10으로 초기화 되면 계속 10 값이 할당
	int beginRow = (currentPage-1) * ROW_PER_PAGE;	//	출력을 시작할 행 넘버
	
	//	상품의 별점 평균
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	double avgScore = orderCommentDao.selectOrderScoreAvg(ebookNo);		

	ArrayList<OrderComment> list = orderCommentDao.OrderCommentList(ebookNo);
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
			<h1>상품 상세보기</h1>	
		</div>
		
		<div>
			<!-- 상품상세출력 -->
			<%
				EbookDao ebookDao = new EbookDao();
				Ebook ebook = ebookDao.selectEbookOne(ebookNo);				
			%>				
			
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
							<div>가격 : ₩ <%=ebook.getEbookPrice() %></div>						
						</td>	
					</tr>
				</tbody>
			</table>			
		</div>
		<br>
		<div class="text-center">
			<h3>상품 구매</h2>
			<%
				if(loginMember == null) {
			%>
					<div>
						로그인 후에 주문이 가능합니다
						<a class="btn btn-dark" href="<%=request.getContextPath() %>/loginForm.jsp">로그인</a>	
					</div>
			<%
				} else {
			%>
					<!-- 주문 입력 폼 -->
					<form method="post" action="<%=request.getContextPath() %>/insertOrderAction.jsp">
						<input type="hidden" name="ebookNo" value="<%=ebook.ebookNo %>">
						<input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo() %>">
						<input type="hidden" name="orderPrice" value="<%=ebook.getEbookPrice() %>">
						<button class="btn btn-dark" type="submit">주문</button>				
					</form>
			<%
				}
			%>
		
		</div class="text-center">
		<br>
		<div>
			<h3>후기</h3>
			<!-- 이 상품의 평균별점 -->
			<div>
				<h2>평균 별점 : <%=avgScore %> / 10</h2>
			</div>		
		</div>
		<br>
		<div>
			<!-- 이 상품의 후기 ( 페이징 ) -->
			<table class="table text-center table-layout:fixed">
				<thead>
					<tr>
						<th width="10%">별점</th>
						<th width="70%">후기</th>
						<th width="20%">등록일</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(OrderComment oc : list) {
					%>
					<tr>
						<td><%=oc.getOrderScore() %></td>
						<td><%=oc.getOrderCommentContent() %></td>
						<td><%=oc.getUpdateDate() %></td>
					</tr>					
					<%
						}
					%>
				</tbody>
			</table>	
			
			<!-- 페이징 -->
		
			<div class="d-flex justify-content-center">
				<ul class =	"pagination active">
			<%		
				//	lastPage를 구하는 메서드 사용
				int lastPage = orderCommentDao.selectCommentLastPage(ROW_PER_PAGE, ebookNo);
				if(pagingNum > 0) {		//	'이전' 버튼
			%>			
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/selectEbookOne.jsp?currentPage=<%=(pagingNum * 10) %>&ebookNo=<%=ebookNo %>">이전</a></li>
			<%
				}				
			
				for(int i = 1; i<=10; i++) {	//	페이지 번호
					if(lastPage == 0) {			//	상품평이 한개도 없는 경우 페이징 표시하지 않는다
						break;
					}
					if(i + (pagingNum * 10) == currentPage) {	//	currentPage인 링크버튼 파란색으로 표시
			%>
						<li class="page-item active"><a class="page-link" href="<%=request.getContextPath() %>/selectEbookOne.jsp?currentPage=<%=i + (pagingNum * 10) %>&ebookNo=<%=ebookNo %>"><%=i + (pagingNum * 10) %></a></li>
			<%
					} else {									//	currentPage 아닌 링크버튼
			%>					
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/selectEbookOne.jsp?currentPage=<%=i + (pagingNum * 10) %>&ebookNo=<%=ebookNo %>"><%=i + (pagingNum * 10) %></a></li>
			<%
					}
					if((i + (pagingNum * 10)) == lastPage) {	//	currentPage가 lastPage이면 다음페이지를 더이상 출력하지 않는다
						break;
					}
				}
				if(pagingNum < ((lastPage-1) / ROW_PER_PAGE)) {	//	'다음' 버튼
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/selectEbookOne.jsp?currentPage=<%=(pagingNum * 10) + 11 %>&ebookNo=<%=ebookNo %>">다음</a></li>					
			<%
				}
			%>							
				</ul>	
			</div>
		
		</div>
	</div>
	</body>
</html>