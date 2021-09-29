<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
	
	<div class="container-fluid">
	
		<!--  mainMenu include  -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!--  mainMenu include -->
	
		<div class="jumbotron text-center">
			<h1>로그인</h1>
		</div>
		
		<form id="loginForm" class="text-center" method="post" action="<%=request.getContextPath() %>/loginAction.jsp">
		
			<div>회원 ID : </div>
			<div><input id="memberId" type="text" name="memberId" value=""></div>
			<div>회원 PW : </div>
			<div><input id="memberPw" type="password" name="memberPw" value=""></div><br>
			
			<button id="loginBtn" class="btn btn-dark" type="button">로그인</button>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/index.jsp">돌아가기</a>	
		
		</form>
		
		<script>
			$('#loginBtn').click(function() {
				//	로그인 버튼 click -> 유효성 검사
				if($('#memberId').val() == '') {
					alert('memberId를 입력하세요');
					return;
				} else if($('#memberPw').val() == '') {
					alert('memberPw를 입력하세요');
					return;
				} else {
					$('#loginForm').submit();
				}
				
			});		
		</script>
	</div>
	</body>
</html>