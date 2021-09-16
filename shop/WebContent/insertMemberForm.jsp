<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
	<body>	
	<%
	request.setCharacterEncoding("UTF-8");
	
	//	방어코드 : 로그인 전에만 접근 가능한 페이지
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	} else {				
	%>
	<div class="container-fluid">
	
		<!--  mainMenu include  -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!--  mainMenu include -->
		
		<div class="jumbotron text-center"><h1>회원 가입</h1></div>
		<div class="d-flex justify-content-center">
		<form class="text-center" method="post" action="<%=request.getContextPath() %>/insertMemberAction.jsp">			
			<table>
				<tr>
					<td>회원 ID : </td>
					<td><input type="text" name="memberId"></td>
					<td>			
				</tr>
				<tr>
					<td>회원 PW : </td>
					<td><input type="password" name="memberPw"></td>
				</tr>
				<tr>
					<td>회원 PW 확인 : </td>
					<td><input type="password" name="memberPwRe"></td>
				</tr>
				<tr>
					<td>회원 이름 : </td>
					<td><input type="text" name="memberName"></td>
				</tr>
				<tr>
					<td>나이 : </td>
					<td><input type="text" name="memberAge"></td>
				</tr>
				<tr>
					<td>성별 : </td>
					<td>
						<input type="radio" name="memberGender" value="남">남
						<input type="radio" name="memberGender" value="여">여
					</td>
				</tr>
			</table>
			<br><br>
			<button class="btn btn-dark" type="submit">회원 가입</button>	
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/index.jsp">돌아가기</a>
		<%		
		}
		%>		
		</form>
		</div>
	</body>
</html>