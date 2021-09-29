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
	//	qna 값 전달	//	방어코드
	int qnaNo = 0;
	if(request.getParameter("qnaNo") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	} else {
		qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	}
	
	//	객체 생성
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	QnaComment qnaComment = new QnaComment();
	
	QnaDao qnaDao = new QnaDao();
	Qna qna = qnaDao.selectQnaOne(qnaNo);	
	
	//	값 전달
	qnaComment.setQnaNo(qna.getQnaNo());
	qnaComment.setQnaCommentContent(request.getParameter("qnaCommentContent"));
	qnaComment.setMemberNo(qna.getMemberNo());
	
	//	QnA 답글 등록 메서드 호출
	qnaCommentDao.insertQnaComment(qnaComment);
	
	response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
%>