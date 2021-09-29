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
			<h1>
				<div>[공지 게시판 관리]</div>
				<div>공지 등록</div>	
			</h1>
		</div>		
		
			<form class="text-center" method="post" action="<%=request.getContextPath() %>/admin/insertNoticeAction.jsp">			
				<table class="table table-hover table-bordered text-center table-layout:fixed">
					<tr>
						<td>제목</td>
						<td><input type="text" name="noticeTitle" style="width:400px"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="100" name="noticeContent"></textarea></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><input type="text" name="memberName" value="<%=loginMember.getMemberName() %>" readonly="readonly"></td>
					</tr>
				</table><br>				
				<button class="btn btn-dark" type="submit">등록</button>	
				<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/selectAdminNoticeList.jsp">돌아가기</a>			
			</form>
		
	</div>
	</body>
</html>