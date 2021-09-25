<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
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
			<h1>메인 페이지</h1>	
		</div>
		<div class="text-center">
		<%
		if(session.getAttribute("loginMember") == null) {		
		%>		
			<!--  로그인 전 -->
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/loginForm.jsp">로그인</a>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/insertMemberForm.jsp">회원가입</a>
		<%
		} else {
			Member loginMember = (Member)session.getAttribute("loginMember");
		%>		
			<!--  로그인 후 -->		
			<h4><span class="text-primary font-weight-bold"><%=loginMember.getMemberName() %> </span>님 반갑습니다.</h4>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectMemberOne.jsp">회원정보</a>	<br><br>		
			
			<!--  관리자 메뉴  -->
		<%
			if(loginMember.getMemberLevel() > 0) {		//	Level이 1 이상일 때만 출력
		%>
			<div><a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/adminIndex.jsp">관리자 메뉴</a></div>
		<%	
			}
		}
		%>	
		</div>
		<!-- 상품 목록 -->
		<%
		
			//	페이징 관련 변수
			
			int currentPage = 1;	//	currentPage 초기화
			if(request.getParameter("currentPage") != null) {	//	currentPage 값이 넘어왔으면
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
			//	System.out.println("[현재 페이지] " + currentPage);
			
			int pagingNum = ((currentPage-1) / 10);		//	페이지의 페이지 넘버 : 0부터 시작	
			final int ROW_PER_PAGE = 20;	//	상수 : 10으로 초기화 되면 계속 10 값이 할당
			int beginRow = (currentPage-1) * ROW_PER_PAGE;	//	출력을 시작할 행 넘버
			
			
			EbookDao ebookDao = new EbookDao();
			ArrayList<Ebook> ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);		
		%>
		<br>
		<table class="table table-hover text-center table-layout:fixed">			
			<tr>
		<%
			int i = 0;
			for(Ebook e : ebookList) {
		%>
					<td>
						<div><img src="<%=request.getContextPath() %>/image/<%=e.getEbookImg() %>" width="200" height="200"></div>
						<div><%=e.getEbookTitle() %></div>	
						<div>₩ <%=e.getEbookPrice() %></div>
					</td>		
		<%
				i++;
				if(i%5 == 0) {
		%>
				</tr>
				<tr>
		<%					
				}
			}		
		%>		
			</tr>
		</table>
	</div>
	</body>
</html>