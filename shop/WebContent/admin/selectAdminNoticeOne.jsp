<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		//	System.out.println("접근 불가능" + loginMember.getMemberLevel());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
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
	
		<!--  adminMenu include  -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!--  adminMenu include -->
		
		<div class="jumbotron text-center">	  
			<h1>공지 게시판 관리</h1>
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
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/updateNoticeForm.jsp?noticeNo=<%=notice.getNoticeNo() %>">수정</a>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/selectAdminNoticeList.jsp">돌아가기</a>
		</div>	
	</div>
	</body>
</html>