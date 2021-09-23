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
	
	//	categoryName 값이 넘어왔으면, categoryName 값 업데이트
	String categoryName = "";
	if(request.getParameter("categoryName") != null) {
		categoryName = request.getParameter("categoryName");
	}
	
	int currentPage = 1;	//	currentPage 초기화
	if(request.getParameter("currentPage") != null) {	//	currentPage 값이 넘어왔으면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//	System.out.println("[현재 페이지] " + currentPage);
	
	int pagingNum = ((currentPage-1) / 10);		//	페이지의 페이지 넘버 : 0부터 시작		
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1) * ROW_PER_PAGE;	//	출력을 시작할 행 넘버
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	EbookDao ebookDao = new EbookDao();
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
			<h1>전자책 관리</h1>
		</div>
		
		<form action="<%=request.getContextPath() %>/admin/selectEbookList.jsp">
		
			<select name="categoryName">
				<%
					for(Category c : categoryList) {
				%>
						<option value="<%=c.getCategoryName() %>"><%=c.getCategoryName() %></option>
				<%		
					}
				%>			
			</select>		
			<button type="submit">검색</button>
		</form>				
		
		<!-- 전자책 목록 출력 -->
		
		<%			
			ArrayList<Ebook> ebookList = new ArrayList<>();		
			if(categoryName.equals("")) {	//	categoryName 값이 공백이면 전체 목록 출력 메서드 실행
				ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);	
			} else {						//	categoryName 값이 존재하면 categoryName별 목록 출력 메서드 실행
				ebookList = ebookDao.selectEbookListByCategory(beginRow, ROW_PER_PAGE, categoryName);		
			}
		%>
		
		<table class="table table-hover text-center table-layout:fixed">	
			
			<thead>
				<tr>
					<th width="10%">전자책 번호</th>		
					<th width="20%">카테고리명</th>		
					<th width="50%">전자책 제목</th>
					<th width="20%">상태</th>
				</tr>
			</thead>
			<tbody>
		
			<%
				for(Ebook e : ebookList) {
			%>
					<tr>
						<td><%=e.getEbookNo() %></td>
						<td><%=e.getCategoryName() %></td>
						<td><a href="<%=request.getContextPath() %>/admin/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo() %>"><%=e.getEbookTitle() %></a></td>
						<td><%=e.getEbookState() %></td>
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
			int lastPage = ebookDao.selectEbookLastPage(ROW_PER_PAGE, categoryName);
			if(pagingNum > 0) {		//	'이전' 버튼
		%>			
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectEbookList.jsp?currentPage=<%=(pagingNum * 10) %>&categoryName=<%=categoryName %>">이전</a></li>
		<%
			}				
		
			for(int i = 1; i<=10; i++) {	//	페이지 번호
				if(i + (pagingNum * 10) == currentPage) {	//	currentPage인 링크버튼 파란색으로 표시
		%>
					<li class="page-item active"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectEbookList.jsp?currentPage=<%=i + (pagingNum * 10) %>&categoryName=<%=categoryName %>"><%=i + (pagingNum * 10) %></a></li>
		<%
				} else {									//	currentPage 아닌 링크버튼
		%>					
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectEbookList.jsp?currentPage=<%=i + (pagingNum * 10) %>&categoryName=<%=categoryName %>"><%=i + (pagingNum * 10) %></a></li>
		<%
				}
				if((i + (pagingNum * 10)) == lastPage) {	//	currentPage가 lastPage이면 다음페이지를 더이상 출력하지 않는다
					break;
				}
			}
			if(pagingNum < ((lastPage-1) / ROW_PER_PAGE)) {	//	'다음' 버튼
		%>
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectEbookList.jsp?currentPage=<%=(pagingNum * 10) + 11 %>&categoryName=<%=categoryName %>">다음</a></li>					
		<%
			}
		%>							
			</ul>	
		</div>
	
	</body>
</html>