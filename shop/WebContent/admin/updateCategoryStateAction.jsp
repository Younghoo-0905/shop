<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}	

	Category category = new Category();
	category.setCategoryName(request.getParameter("categoryName"));
	category.setCategoryState(request.getParameter("categoryState"));

	CategoryDao categoryDao = new CategoryDao();
	categoryDao.updateCategoryState(category);

	response.sendRedirect(request.getContextPath() + "/admin/selectCategoryList.jsp");
%>