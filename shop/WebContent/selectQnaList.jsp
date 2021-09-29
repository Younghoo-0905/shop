<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> list = qnaDao.selectQnaList();
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
			<h1>QnA 게시판</h1>
		</div>		
		
		<table class="table table-hover text-center table-layout:fixed">
		
			<!-- QnA 등록 버튼 -->
						
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/insertQnaForm.jsp">QnA 등록</a>		
					
			<thead>
				<tr>
					<th width="10%">번호</th>		
					<th width="10%">카테고리</th>		
					<th width="40%">제목</th>		
					<th width="20%">작성자 번호</th>
					<th width="20%">작성일</th>
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
						<td><img src="<%=request.getContextPath() %>/image/secret.png" width="13" height="13"> 비밀글입니다.</td>						
			<%
					} else if(q.getQnaSecret().equals("N")) {
			%>
						<td><a href="<%=request.getContextPath() %>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo() %>"><%=q.getQnaTitle() %></a></td>
			<%
					}
			%>
						<td><%=q.getMemberNo() %></td>
						<td><%=q.getCreateDate() %></td>
					</tr>
			<%
				}		
			%>					
			</tbody>	
		</table>		
	</div>
	</body>
</html>