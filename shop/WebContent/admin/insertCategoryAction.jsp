<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}	
	
	//	카테고리명 입력값 유효성 검사	//	입력값이 null 값일 경우
	if(request.getParameter("categoryName") == null || request.getParameter("categoryState") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/insertCategoryForm.jsp");
		return;
	}							//	입력값이 공백일 경우
	if(request.getParameter("categoryName").equals("") || request.getParameter("categoryState").equals("")) {
		response.sendRedirect(request.getContextPath() + "/admin/insertCategoryForm.jsp");
		return;
	}
	
	Category category = new Category();
	category.setCategoryName(request.getParameter("categoryName")); 
	category.setCategoryState(request.getParameter("categoryState"));
	
	//	System.out.println("[디버그] " + category.getCategoryName());
	//	System.out.println("[디버그] " + category.getCategoryState());
	
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.insertCategory(category);
	
	response.sendRedirect(request.getContextPath() + "/admin/selectCategoryList.jsp");
	
%>
	