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
			<h1>QnA 등록</h1>
		</div>		
		
			<form class="text-center" method="post" action="<%=request.getContextPath() %>/insertQnaAction.jsp">			
				<table class="table table-hover table-bordered text-center table-layout:fixed">
					<tr>
						<td>카테고리 선택</td>
						<td>
							<select name="qnaCategory">
								<option value="상품">상품</option>
								<option value="회원">회원</option>
								<option value="기타">기타</option>							
							</select>
						</td>
					</tr>
					<tr>
						<td>공개여부</td>
						<td>
							<input type="radio" name="qnaSecret" value="N">공개
							<input type="radio" name="qnaSecret" value="Y">비공개
						</td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="qnaTitle" style="width:400px"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="5" cols="100" name="qnaContent"></textarea></td>
					</tr>
					<tr>
						<td>작성자 회원번호</td>
						<td><input type="text" name="memberNo" value="<%=loginMember.getMemberNo() %>" readonly="readonly"></td>
					</tr>
				</table><br>				
				<button class="btn btn-dark" type="submit">등록</button>	
				<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectQnaList.jsp">돌아가기</a>			
			</form>
		
	</div>
	</body>
</html>