<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	MemberDao memberDao = new MemberDao();
	
	//	넘겨받은 memberIdCheck 값이 공백인지 확인
	if(request.getParameter("memberIdCheck") == null) {			//	null값이면 돌려보냄
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	
	String memberIdCheck = request.getParameter("memberIdCheck");
	
	String result = memberDao.selectMemberId(memberIdCheck);	
	if(result == null) {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?memberIdCheck="+memberIdCheck);
	} else {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?idCheckResult=same ID is exist");
	};
%>