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
	
	//	객체 생성
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = new Notice();
	
	//	값 전달
	notice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	notice.setNoticeTitle(request.getParameter("noticeTitle"));
	notice.setNoticeContent(request.getParameter("noticeContent"));
	
	//	공지 수정 메서드 호출
	noticeDao.updateNotice(notice);
	
	response.sendRedirect(request.getContextPath() + "/admin/selectAdminNoticeOne.jsp?noticeNo=" + notice.getNoticeNo());
%>