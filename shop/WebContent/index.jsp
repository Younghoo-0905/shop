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
			ArrayList<Ebook> popularEbookList = ebookDao.selectPopularEbookList();
			ArrayList<Ebook> recentEbookList = ebookDao.selectRecentEbookList();
		%>
		<br><br>
			<!-- 인기 상품목록 -->
		<div class="text-center">
			<h1><img src="<%=request.getContextPath() %>/image/hot.jpg" width="50" height="50">인기 상품목록</h1>
		</div>
		<br>
		<table class="table table-hover text-center table-layout:fixed">
			<tr>
		<%			
			for(Ebook e : popularEbookList) {
		%>			
				<td>
					<div>
						<a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo() %>">
						<img src="<%=request.getContextPath() %>/image/<%=e.getEbookImg() %>.jpg" width="200" height="200">
						</a>
					</div>
					<div>
						<a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo() %>">
						<%=e.getEbookTitle() %>					
						</a>
					</div>	
					<div>₩ <%=e.getEbookPrice() %></div>
				</td>			
		<%									
			}		
		%>		
			</tr>
		</table>
		<br><br>
			<!-- 최신 상품목록 -->
		<div class="text-center">
			<h1><img src="<%=request.getContextPath() %>/image/new.png" width="70" height="50">최신 상품목록</h1>
		</div>
		<br>
		<table class="table table-hover text-center table-layout:fixed">
			<tr>
		<%			
			for(Ebook e : recentEbookList) {
		%>			
				<td>
					<div>
						<a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo() %>">
						<img src="<%=request.getContextPath() %>/image/<%=e.getEbookImg() %>.jpg" width="200" height="200">
						</a>
					</div>
					<div>
						<a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo() %>">
						<%=e.getEbookTitle() %>
						</a>
					</div>	
					<div>₩ <%=e.getEbookPrice() %></div>
				</td>			
		<%									
			}		
		%>		
			</tr>
		</table>
		<br><br>		
			<!-- 전체 상품목록 -->
		<div class="text-center">
			<h1>전체 상품목록</h1>
		</div>
		<br>
		<table class="table table-hover text-center table-layout:fixed">			
			<tr>
		<%
			int i = 0;
			for(Ebook e : ebookList) {
		%>
					<td>
						<div>
							<a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo() %>">
							<img src="<%=request.getContextPath() %>/image/<%=e.getEbookImg() %>.jpg" width="200" height="200">
							</a>
						</div>
						<div>
							<a href="<%=request.getContextPath() %>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo() %>">
							<%=e.getEbookTitle() %>
							</a>
						</div>	
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