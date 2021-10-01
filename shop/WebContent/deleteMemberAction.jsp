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
	String memberId = null;
	String memberPw = null;
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null) {	//	넘어온 memberId, memberPw 값이 없으면
		response.sendRedirect(request.getContextPath() + "/deleteMemberForm.jsp");
	} else {
		memberId = request.getParameter("memberId");
		memberPw = request.getParameter("memberPw");
	}
	//	넘겨받은 값 디버깅
	//	System.out.println("[탈퇴할 회원 ID : ]" + memberId);
	//	System.out.println("[비밀번호 : ]" + memberPw);	
	
	MemberDao memberDao = new MemberDao();
	boolean value = memberDao.deleteMemberByMember(memberId, memberPw);
	
	if(value) {		//	쿼리가 실행되었으면 ( Pw가 일치해서 정상적으로 삭제 )	
		System.out.println("회원 탈퇴 성공");
		session.invalidate();	//	사용자의 세션을 새로운 세션으로 갱신
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	} else {		//	쿼리가 실행되지 않았으면 ( Pw 가 일치하지 않아서 삭제되지 않음 )
		System.out.println("비밀번호가 일치하지 않습니다.");
		response.sendRedirect(request.getContextPath() + "/deleteMemberForm.jsp?memberId=" + memberId);
	}
	
%>