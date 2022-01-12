<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>		
		
<nav class="navbar navbar-expand-sm bg-light navbar-light d-flex justify-content-between">
	<div>
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/index.jsp">메인 페이지</a>
			<!-- 회원 관리 : 목록, 비밀번호 수정, 등급 수정, 회원 강제 탈퇴 -->
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/admin/selectMemberList.jsp">회원 관리</a>
			<!-- 전자책 카테고리 관리 : 목록, 추가, 사용유무 전환	 -->
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/admin/selectCategoryList.jsp">전자책 카테고리 관리</a>
			<!-- 전자책 관리 : 목록, 추가(이미지), 수정, 삭제 -->
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/admin/selectEbookList.jsp">전자책 관리</a>
			<!-- 주문 관리 : 목록,  -->
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/admin/selectOrderList.jsp">주문 관리</a>
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/admin/selectAdminNoticeList.jsp">공지 게시판 관리</a>
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/admin/selectAdminQnaList.jsp">QnA게시판 관리</a>
	</div>	
	
	<div>
		<span class="text-primary font-weight-bold"><%=loginMember.getMemberName() %> </span>관리자님 반갑습니다 
		<a class="btn btn-dark" href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a>			
	</div>	
</nav>