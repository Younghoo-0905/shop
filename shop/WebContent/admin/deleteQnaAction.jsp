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
	
	//	객체 생성
	QnaDao qnaDao = new QnaDao();
	
	//	값 전달
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	//	QnA 삭제 메서드 호출
	qnaDao.deleteQna(qnaNo);
	
	response.sendRedirect(request.getContextPath() + "/admin/selectAdminQnaList.jsp");
%>