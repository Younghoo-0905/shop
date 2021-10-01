<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	//	비회원 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){	//	
		//	System.out.println("접근 불가능" + loginMember.getMemberLevel());
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
		
	//	넘어온 memberId값 리턴
	String memberId = null;
	if(request.getParameter("memberId") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
	memberId = request.getParameter("memberId");
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
				<h1>
					<div>[회원 정보]</div>
					<div>비밀번호 변경</div>
				</h1>
			</div>
			
			<form class="text-center" method="post" action="<%=request.getContextPath() %>/updateMemberPwAction.jsp">
			
				<table class="table table-bordered text-center table-layout:fixed" style="width:500px" align="center">
					<tr>
						<td>회원 ID : </td>
						<td><input type="hidden" name="memberId" value="<%=memberId %>" readonly="readonly"><%=memberId %></td>
					</tr>	
					<tr>
						<td>비밀번호 : </td>
						<td><input type="password" name="memberPw"></td>					
					</tr>				
					<tr>
						<td>새 비밀번호 : </td>
						<td><input type="password" name="memberPwNew"></td>					
					</tr>			
				</table>
				
				<button class="btn btn-dark" type="submit">변경</button>
				<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectMemberOne.jsp?memberId=<%=memberId %>">돌아가기</a>	
			
			</form>		

		</div>

	</body>
</html>