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
	
	//	넘어온 memberNo값 리턴
	int memberNo = 0;
	if(request.getParameter("memberNo") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
	} else if(request.getParameter("memberNo") != null) {
		memberNo = Integer.parseInt(request.getParameter("memberNo"));
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
					<div>[회원 관리]</div>
					<div>회원 등급 수정</div>
				</h1>
			</div>
			
			<form class="text-center" method="post" action="<%=request.getContextPath() %>/admin/updateMemberLevelAction.jsp">
						
				<table class="table table-bordered text-center table-layout:fixed" style="width:500px" align="center">
					<tr>
						<td>회원 No : </td>
						<td><input type="hidden" name="memberNo" value="<%=memberNo %>" readonly="readonly"><%=memberNo %></td>								
					</tr>
					<tr>
						<td>회원 등급 : </td>
						<td>
							<select name="memberLevel">
								<option value="0">0</option>
								<option value="1">1</option>						
							</select>	
						</td>
					</tr>
				</table>
				
				<button class="btn btn-dark" type="submit">적용</button>
				<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/selectMemberList.jsp">돌아가기</a>	
			
			</form>		
		</div>
	</body>
</html>