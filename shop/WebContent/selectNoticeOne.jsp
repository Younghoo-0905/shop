<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeOne(noticeNo);	
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
		
		<table class="table table-bordered text-center table-layout:fixed">	
			<tr>
				<td width="10%">No</td>
				<td><%=notice.getNoticeNo() %></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><%=notice.getNoticeTitle() %></td>
			</tr>
			<tr> 
				<td valign="middle">내용</td>
				<td><%=notice.getNoticeContent() %></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%=notice.getMemberName() %></td>
			</tr>
			<tr>
				<td>공지일</td>
				<td><%=notice.getUpdateDate() %></td>
			</tr>	
		</table>
		<div class="text-center">
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectNoticeList.jsp">돌아가기</a>
		</div>	
	</div>
	</body>
</html>