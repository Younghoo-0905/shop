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
	
	//	받아온 값이 없으면 돌려보내는 방어코드
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null) {	//	넘어온 memberId, memberPw 값이 없으면
		response.sendRedirect(request.getContextPath() + "/updateMemberPwForm.jsp");
	}
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberPwNew = request.getParameter("memberPwNew");
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	
	//	넘겨받은 memberNo , memberPw 값	
	member.setMemberId(request.getParameter("memberId"));
	member.setMemberPw(request.getParameter("memberPw"));
	//	디버깅
	//	System.out.println("[updateMemberPw : ID, Pw] " + member.getMemberNo() + ", " + member.getMemberPw());
	//	System.out.println("[updateMemberPw : 새로운 비밀번호] " + memberPwNew);
	
	boolean value = memberDao.updateMemberPwByMember(member, memberPwNew);
	if(value) {		//	쿼리가 성공적으로 실행되었으면 
		System.out.println("비밀번호 수정 성공! 다시 로그인 하세요.");
		session.invalidate();	//	사용자의 세션을 새로운 세션으로 갱신
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");		
	} else {		//	Pw가 일치하지 않아서 수정에 실패했으면
		System.out.println("비밀번호가 일치하지 않습니다.");
		response.sendRedirect(request.getContextPath() + "/updateMemberPwForm.jsp?memberId=" + memberId);
	}	
%>