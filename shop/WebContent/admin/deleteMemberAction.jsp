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
	int memberNo = 0;
	String adminPw = null;
	if(request.getParameter("memberNo") == null || request.getParameter("adminPw") == null) {	//	넘어온 memberNo 값이 없으면
		response.sendRedirect(request.getContextPath() + "/admin/deleteMemberForm.jsp");
	} else {
		memberNo = Integer.parseInt(request.getParameter("memberNo"));
		adminPw = request.getParameter("adminPw");
	}
	//	넘겨받은 값 디버깅
	//	System.out.println("[탈퇴할 회원 No : ]" + memberNo);
	//	System.out.println("[관리자 비밀번호 : ]" + adminPw);
	
	MemberDao memberDao = new MemberDao();
	boolean value = memberDao.compareAdminPw(loginMember, adminPw);	//	관리자의 비밀번호가 일치하는지 확인하는 메서드
	
	if(value) {		//	메서드의 반환값이 true이면 회원강제탈퇴 실행
		memberDao.deleteMemberByAdmin(memberNo);		
		response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
	} else {
		System.out.println("관리자 비밀번호가 일치하지 않습니다.");
		response.sendRedirect(request.getContextPath() + "/admin/deleteMemberForm.jsp?memberNo=" + memberNo);
	}
	
%>