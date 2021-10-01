<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		//	System.out.println("접근 불가능" + loginMember.getMemberLevel());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	//	받아온 값이 없으면 돌려보내는 방어코드
	if(request.getParameter("ebookNo") == null) {	//	넘어온 ebook 값이 없으면
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
		return;
	}
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));

	//	넘겨받은 값 디버깅
	//	System.out.println("[삭제할 ebook No : ]" + ebookNo);
	
	//	ebook 삭제 메서드 호출
	EbookDao ebookDao = new EbookDao();
	ebookDao.deleteEbook(ebookNo);
	
	response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
	
%>