<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
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
	request.setCharacterEncoding("UTF-8");
	
	//	방어코드 : 로그인 전에만 접근 가능한 페이지
	if(session.getAttribute("loginMember") != null) {
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
			<h1>회원 가입</h1>
		</div>
		
		<%
			String memberIdCheck = "";
			if(request.getParameter("memberIdCheck") != null) {
				memberIdCheck = request.getParameter("memberIdCheck");
			}			

			String idCheckResult = "";
			if(request.getParameter("idCheckResult") != null) {
				idCheckResult = request.getParameter("idCheckResult");
			}			
		%>
		
		<!-- 처음 페이지 접근 시 ""(공백) -->
		<div class="d-flex justify-content-center"><%=idCheckResult %></div> 
	
		<div class="d-flex justify-content-center">		
		
			<!-- 아이디 중복 검사를 위한 폼 -->		
			<form class="text-center" method="post" action="<%=request.getContextPath() %>/selectMemberIdCheckAction.jsp">
				<div>
					회원 ID :
					<input type="text" name="memberIdCheck">	
					<button type="submit">중복 검사</button>
				</div>		
			</form>
			
		</div>
		<div class="d-flex justify-content-center">
			
			<form id="joinForm" class="text-center" method="post" action="<%=request.getContextPath() %>/insertMemberAction.jsp">			
				<table>
					<tr>
						<td>회원 ID : </td>
						<td><input id="memberId" type="text" name="memberId" readonly="readonly" value="<%=memberIdCheck %>"></td>
						<td>			
					</tr>
					<tr>
						<td>회원 PW : </td>
						<td><input id="memberPw" type="password" name="memberPw"></td>
					</tr>
					<tr>
						<td>회원 PW 확인 : </td>
						<td><input id="memberPwRe" type="password" name="memberPwRe"></td>
					</tr>
					<tr>
						<td>회원 이름 : </td>
						<td><input id="memberName" type="text" name="memberName"></td>
					</tr>
					<tr>
						<td>나이 : </td>
						<td><input id="memberAge" type="text" name="memberAge"></td>
					</tr>
					<tr>
						<td>성별 : </td>
						<td>
							<input id="memberGender" type="radio" name="memberGender" value="남">남
							<input id="memberGender" type="radio" name="memberGender" value="여">여
						</td>
					</tr>
				</table><br>				
				<button id="btn" class="btn btn-dark" type="button">회원 가입</button>	
				<a class="btn btn-dark" href="<%=request.getContextPath() %>/index.jsp">돌아가기</a>			
			</form>
		</div>
		
		<script>
			$('#btn').click(function() {
				
				if($('#memberId').val() == '') {
					alert('memberId를 입력하세요');
					return;
				} else if($('#memberPw').val() == '') {
					alert('memberPw를 입력하세요');
					return;
				} else if($('#memberPwRe').val() == '') {
					alert('memberPw를 입력하세요');
					return;
				} else if($('#memberName').val() == '') {
					alert('memberName을 입력하세요');
					return;
				} else if($('#memberAge').val() == '') {
					alert('memberAge를 입력하세요');
					return;
				} else if($('#memberGender:checked').length == 0) {
					alert('memberGender를 선택하세요');
					return;
				} else {
					$('#joinForm').submit();	
				}				
			})		
		
		
		</script>
	</body>
</html>