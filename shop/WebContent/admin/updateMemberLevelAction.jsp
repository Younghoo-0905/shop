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
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	
	//	넘겨받은 memberNo , memberLevel 값
	member.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
	member.setMemberLevel(Integer.parseInt(request.getParameter("memberLevel")));
	
	memberDao.updateMemberLevelByAdmin(member);
	
	response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");	
%>