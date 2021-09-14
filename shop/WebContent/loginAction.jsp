<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	//	request 값 디버깅
	System.out.println("[memberId, memberPw -->] " + memberId + ", " + memberPw);
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	
	//	성공 : memberId + memberName
	//	실패 : null
	Member returnMember = memberDao.login(member);
	//	디버깅
	if(returnMember == null) {
		System.out.println("로그인 실패");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	} else {
		System.out.println("로그인 성공");
		//	리턴값 디버깅
		System.out.println("[LoginId -->] " + returnMember.getMemberId());
		System.out.println("[LoginName -->] " + returnMember.getMemberName());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
	
	//	request, session : JSP 내장객체
	//	특정 사용자의 공간(session) 변수 생성
	session.setAttribute("loginMember", returnMember);
%>
    