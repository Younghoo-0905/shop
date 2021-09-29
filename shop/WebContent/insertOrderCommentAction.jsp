<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	//	비회원 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){	//	
		//	System.out.println("접근 불가능" + loginMember.getMemberLevel());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	OrderComment orderComment = new OrderComment();
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	
	//	값 전달
	orderComment.setEbookNo(Integer.parseInt(request.getParameter("ebookNo")));
	orderComment.setOrderNo(Integer.parseInt(request.getParameter("orderNo")));	
	orderComment.setOrderScore(Integer.parseInt(request.getParameter("orderScore")));
	orderComment.setOrderCommentContent(request.getParameter("orderComment"));
	
	orderCommentDao.insertOrderComment(orderComment);
	
	response.sendRedirect(request.getContextPath() + "/selectOrderListByMember.jsp");
	
%>