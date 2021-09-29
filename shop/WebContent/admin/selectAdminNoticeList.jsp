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
	
		<!--  adminMenu include  -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!--  adminMenu include -->
		
		<div class="jumbotron text-center">	  
			<h1>공지 게시판 관리</h1>
		</div>		
		
		<table class="table table-hover text-center table-layout:fixed">
			
			<!-- 공지 등록 버튼 -->
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/insertNoticeForm.jsp">공지 등록</a>		
		
			<thead>
				<tr>
					<th width="10%">번호</th>		
					<th width="40%">제목</th>		
					<th width="20%">작성자</th>
					<th width="20%">공지일</th>
					<th width="5%">수정</th>
					<th width="5%">삭제</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeNo() %></td>
							<!-- 클릭 시 공지 게시글 내용 상세보기 -->
						<td><a href="<%=request.getContextPath() %>/admin/selectAdminNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a></td>
						<td><%=n.getMemberName() %></td>
						<td><%=n.getUpdateDate() %></td>
							<!-- 클릭 시 공지 게시글 수정 창 -->
						<td><a href="<%=request.getContextPath() %>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo() %>">수정</a></td>
							<!-- 클릭 시 공지 게시글 삭제 -->
						<td><a href="<%=request.getContextPath() %>/admin/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo() %>">삭제</a></td>
					</tr>
			<%
				}		
			%>					
			</tbody>	
		</table>		
	</div>
	</body>
</html>