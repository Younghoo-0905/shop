<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeList();
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
			<h1>공지 게시판</h1>
		</div>		
		
		<table class="table table-hover text-center table-layout:fixed">
			
			<thead>
				<tr>
					<th width="10%">번호</th>		
					<th width="50%">제목</th>		
					<th width="25%">작성자</th>
					<th width="25%">공지일</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeNo() %></td>
							<!-- 클릭 시 공지 게시글 내용 상세보기 -->
						<td><a href="<%=request.getContextPath() %>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a></td>
						<td><%=n.getMemberName() %></td>
						<td><%=n.getUpdateDate() %></td>
					</tr>
			<%
				}		
			%>					
			</tbody>	
		</table>		
	</div>
	</body>
</html>