<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	//	방어코드 : 로그인 전에만 접근 가능한 페이지
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	//	회원가입 입력값 유효성 검사	//	입력값이 null 값일 경우
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null || request.getParameter("memberAge") == null || request.getParameter("memberGender") == null) {
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
		return;
	}							//	입력값이 공백일 경우
	if(request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberName").equals("") || request.getParameter("memberAge").equals("") || request.getParameter("memberGender").equals("")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	Member member = new Member();
	member.setMemberId(request.getParameter("memberId")); 
	member.setMemberPw(request.getParameter("memberPw"));
	member.setMemberName(request.getParameter("memberName"));
	member.setMemberAge(Integer.parseInt(request.getParameter("memberAge")));
	member.setMemberGender(request.getParameter("memberGender"));
	
	//	System.out.println("[MemberDao.insertMember memberId -->]" + member.getMemberId());
	//	System.out.println("[MemberDao.insertMember memberPw -->]" + member.getMemberPw());
	//	System.out.println("[MemberDao.insertMember memberName -->]" + member.getMemberName());
	//	System.out.println("[MemberDao.insertMember memberAge -->]" + member.getMemberAge());
	//	System.out.println("[MemberDao.insertMember memberGender -->]" + member.getMemberGender());
		
	//	회원 가입 시 입력 패스워드 재확인을 위한 변수
	String memberPwRe = request.getParameter("memberPwRe");
	
	MemberDao memberDao = new MemberDao();		
	if(member.getMemberPw().equals(memberPwRe)) {		//	두 패스워드가 일치하면
		memberDao.insertMember(member);
		System.out.println("회원 가입 되었습니다.");
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	} else {									//	두 패스워드가 일치하지 않으면
		System.out.println("패스워드가 일치하지 않습니다.");
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
		return;
	}			
%>