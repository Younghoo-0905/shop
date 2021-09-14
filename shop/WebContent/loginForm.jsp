<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<body>
	<%
		//	인증 방어코드 : 로그인 전에만 접근 가능한 페이지
		if(session.getAttribute("loginMember") != null) {
			System.out.println("이미 로그인 되었습니다.");
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}	
	
	%>
		<h1>로그인</h1>
		<form method="post" action="<%=request.getContextPath() %>/loginAction.jsp">
		
			<div>회원 ID : </div>
			<div><input type="text" name="memberId"></div>
			<div>회원 PW : </div>
			<div><input type="password" name="memberPw"></div><br>
			
			<div><button type="submit">로그인</button></div>		
		
		</form>
	</body>
</html>