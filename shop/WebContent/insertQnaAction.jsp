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
	
	//	객체 생성
	QnaDao qnaDao = new QnaDao();
	Qna qna = new Qna();	
		
	//	값 전달
	qna.setQnaCategory(request.getParameter("qnaCategory"));
	qna.setQnaTitle(request.getParameter("qnaTitle"));
	qna.setQnaContent(request.getParameter("qnaContent"));
	qna.setQnaSecret(request.getParameter("qnaSecret"));
	qna.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));	
	
	//	QnA 등록 메서드 호출
	qnaDao.insertQna(qna);
	
	response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
%>