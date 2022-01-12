<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<nav class="navbar navbar-expand-sm bg-light navbar-light d-flex justify-content-between">
	<div> 
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/index.jsp">메인 페이지</a>
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/selectEbookList.jsp">전자책 검색</a>
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/selectNoticeList.jsp">공지 게시판</a>
		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/selectQnaList.jsp">QnA 게시판</a>
	</div>
	
	<div>
		<%
		if(session.getAttribute("loginMember") == null) {	//	로그인 전 화면	
		%>		
			<!--  로그인 전 -->
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/loginForm.jsp">로그인</a>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/insertMemberForm.jsp">회원가입</a>
		<%
		} else {		//	로그인 후 화면
			Member loginMember = (Member)session.getAttribute("loginMember");
		%>		
			<!--  로그인 후 -->		
			<span class="text-primary font-weight-bold"><%=loginMember.getMemberName() %> </span>님 반갑습니다 
			
			<!--  관리자 메뉴  -->
		<%
			if(loginMember.getMemberLevel() > 0) {		//	Level이 1 이상일 때만 출력
		%>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/adminIndex.jsp">관리자 메뉴</a>
		<%	
			}
		%>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectMemberOne.jsp?memberId=<%=loginMember.getMemberId() %>">회원정보</a>
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectOrderListByMember.jsp">나의 주문</a>		
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a>			
		<%	
		}
		%>	
	</div>		
</nav>