<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
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
				<div>[전자책 카테고리 관리]</div>
				<div>카테고리 추가</div>
			</h1>		
		</div>
	
		<%
			//	중복 체크가 완료된 카테고리명 변수
			String categoryNameCheck = "";
			if(request.getParameter("categoryNameCheck") != null) {
				categoryNameCheck = request.getParameter("categoryNameCheck");
			}			

			//	중복 된 이름 유무여부를 알려주는 변수값
			String NameCheckResult = "";
			if(request.getParameter("NameCheckResult") != null) {
				NameCheckResult = request.getParameter("NameCheckResult");
			}			
		%>
		
		<!-- 처음 페이지 접근 시 ""(공백) -->
		<div class="d-flex justify-content-center"><%=NameCheckResult %></div> 
	
		<div class="d-flex justify-content-center">		
		
			<!-- 카테고리명 중복 검사를 위한 폼 -->		
			<form class="text-center" method="post" action="<%=request.getContextPath() %>/admin/selectCategoryNameCheckAction.jsp">
				<div>
					카테고리명 :
					<input type="text" name="categoryNameCheck">	
					<button type="submit">중복 검사</button>
				</div>		
			</form>
						
		</div>		
		<div class="d-flex justify-content-center">
			
			<form class="text-center" method="post" action="<%=request.getContextPath() %>/admin/insertCategoryAction.jsp">			
				<table>
					<tr>
						<td>카테고리명 : </td>
						<td><input type="text" id="categoryName" name="categoryName" readonly="readonly" value="<%=categoryNameCheck %>"></td>
						<td>			
					</tr>	
					<tr>
						<td>카테고리 상태 : </td>
						<td>
							<input type="radio" name="categoryState" value="Y">사용
							<input type="radio" name="categoryState" value="N">미사용
						</td>
					</tr>
				</table>
				<br>
				<button class="btn btn-dark" type="submit">카테고리 추가</button>	
				<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/selectCategoryList.jsp">돌아가기</a>		
			</form>
		</div>	
	</div>
	</body>
</html>