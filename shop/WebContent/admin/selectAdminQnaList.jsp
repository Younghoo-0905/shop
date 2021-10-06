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
	
	//	페이징 관련 변수
	int currentPage = 1;	//	currentPage 초기화
	if(request.getParameter("currentPage") != null) {	//	currentPage 값이 넘어왔으면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//	System.out.println("[현재 페이지] " + currentPage);	//	디버깅
	int pagingNum = ((currentPage-1) / 10);		//	페이지의 페이지 넘버 : 0부터 시작		
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1) * ROW_PER_PAGE;	//	출력을 시작할 행 넘버
	
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> list = qnaDao.selectQnaListByPage(beginRow, ROW_PER_PAGE);
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
			<h1>QnA 게시판 관리</h1>
		</div>		
		
		<table class="table table-hover text-center table-layout:fixed">		
		
			<thead>
				<tr>
					<th width="10%">번호</th>		
					<th width="10%">카테고리</th>		
					<th width="30%">제목</th>		
					<th width="20%">작성자 번호</th>
					<th width="20%">작성일</th>
					<th width="10%">삭제</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Qna q : list) {
			%>
					<tr>
						<td><%=q.getQnaNo() %></td>
						<td><%=q.getQnaCategory() %></td>						
							<!-- QnA 제목. 클릭 시 QnA 내용 상세보기 -->
			<%
					if(q.getQnaSecret().equals("Y")) {
			%>
						<!-- 비밀 글은 자물쇠 이미지 출력 -->
						<td><img src="<%=request.getContextPath() %>/image/secret.png" width="13" height="13"><a href="<%=request.getContextPath() %>/admin/selectAdminQnaOne.jsp?qnaNo=<%=q.getQnaNo() %>"><%=q.getQnaTitle() %></td>						
			<%
					} else if(q.getQnaSecret().equals("N")) {
			%>
						<td><a href="<%=request.getContextPath() %>/admin/selectAdminQnaOne.jsp?qnaNo=<%=q.getQnaNo() %>"><%=q.getQnaTitle() %></a></td>
			<%
					}
			%>
						<td><%=q.getMemberNo() %></td>
						<td><%=q.getCreateDate() %></td>
						<td><a href="<%=request.getContextPath() %>/admin/deleteQnaAction.jsp?qnaNo=<%=q.getQnaNo() %>">삭제</a></td>
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
			int lastPage = qnaDao.selectQnaLastPage(ROW_PER_PAGE);
			if(pagingNum > 0) {		//	'이전' 버튼
		%>			
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectAdminQnaList.jsp?currentPage=<%=(pagingNum * 10) %>">이전</a></li>
		<%
			}				
		
			for(int i = 1; i<=10; i++) {	//	페이지 번호
				if(i + (pagingNum * 10) == currentPage) {	//	currentPage인 링크버튼 파란색으로 표시
		%>
					<li class="page-item active"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectAdminQnaList.jsp?currentPage=<%=i + (pagingNum * 10) %>"><%=i + (pagingNum * 10) %></a></li>
		<%
				} else {									//	currentPage 아닌 링크버튼
		%>					
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectAdminQnaList.jsp?currentPage=<%=i + (pagingNum * 10) %>"><%=i + (pagingNum * 10) %></a></li>
		<%
				}
				if((i + (pagingNum * 10)) == lastPage) {	//	currentPage가 lastPage이면 다음페이지를 더이상 출력하지 않는다
					break;
				}
			}
			if(pagingNum < ((lastPage-1) / ROW_PER_PAGE)) {	//	'다음' 버튼
		%>
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectAdminQnaList.jsp?currentPage=<%=(pagingNum * 10) + 11 %>">다음</a></li>					
		<%
			}
		%>							
			</ul>	
		</div>	
	</div>
	</body>
</html>