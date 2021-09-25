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
	
	//	전달받은 값을 ebook 타입으로 저장
	Ebook ebook = new Ebook();
	ebook.setEbookNo(Integer.parseInt(request.getParameter("ebookNo")));
	ebook.setEbookPrice(Integer.parseInt(request.getParameter("ebookPrice")));
	
	//	가격 수정 메서드 호출
	EbookDao ebookDao = new EbookDao();
	ebookDao.updateEbookPrice(ebook);
	
	//	ebook 정보 페이지로 이동
	response.sendRedirect(request.getContextPath() + "/admin/selectEbookOne.jsp?ebookNo=" + ebook.getEbookNo());
%>