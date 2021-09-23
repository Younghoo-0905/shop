<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}	

	//	CategoryDao 객체생성
	CategoryDao categoryDao = new CategoryDao();	
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전자책 목록</title>
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
		<h1>전자책 카테고리 관리</h1>
	</div>
	<table class="table table-hover text-center table-layout:fixed">
	
		<!-- Category 추가 버튼 -->
					
		<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/insertCategoryForm.jsp">카테고리 추가</button>		
				
		<thead>
			<tr>
				<th>전자책 이름</th>		
				<th>사용 여부</th>		
				<th>업데이트 날짜</th>
				<th>생성 날짜</th>
			</tr>
		</thead>
		<tbody>
	
		<%
			for(Category c : categoryList) {
		%>
				<tr>
					<td><%=c.getCategoryName() %></td>
						<!-- 클릭 시 사용유무 변경 -->
					<td><a href="<%=request.getContextPath() %>/admin/updateCategoryStateAction.jsp?categoryState=<%=c.getCategoryState() %>&categoryName=<%=c.getCategoryName() %>"><%=c.getCategoryState() %></a></td>
					<td><%=c.getUpdateDate() %></td>
					<td><%=c.getCreateDate() %></td>
				</tr>
		<%
			}		
		%>		
		</tbody>	
	</table>	
	</body>
</html>