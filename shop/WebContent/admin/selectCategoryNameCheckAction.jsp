<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}	

	CategoryDao categoryDao = new CategoryDao();	
	
	//	넘겨받은 categoryNameCheck 값이 공백인지 확인
	if(request.getParameter("categoryNameCheck") == null) {			//	null값이면 돌려보냄
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp");
		return;
	}
	
	//	중복여부 확인 메서드 실행
	String categoryNameCheck = request.getParameter("categoryNameCheck");
	
	//	리턴 값을 result에 저장. result가 null인지 아닌지에 따라 분기
	String result = categoryDao.selectCategoryName(categoryNameCheck);	
	if(result == null) {	//	null 값이면 사용 가능한 이름이므로 전달
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp?categoryNameCheck="+categoryNameCheck);
	} else {				//	사용 불가능한 이름임을 알림
		response.sendRedirect(request.getContextPath()+"/admin/insertCategoryForm.jsp?NameCheckResult=same NAME is exist");
	};
%>