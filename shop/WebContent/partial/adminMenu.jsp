<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
	<ul>
		<li><a href="<%=request.getContextPath() %>/index.jsp">[메인 페이지로]</a>
			<!-- 회원 관리 : 목록, 비밀번호 수정, 등급 수정, 회원 강제 탈퇴 -->
		<li><a href="<%=request.getContextPath() %>/admin/selectMemberList.jsp">[회원 관리]</a></li>
			<!-- 
				전자책 카테고리 관리 : 목록, 추가, 사용유무 전환
				
				8. updateCategoryStateAction.jsp					
			 -->
		<li><a href="<%=request.getContextPath() %>/admin/selectCategoryList.jsp">[전자책 카테고리 관리]</a></li>
			<!-- 전자책 관리 : 목록, 추가(이미지), 수정, 삭제 -->
		<li><a href="<%=request.getContextPath() %>/admin/selectEbookList.jsp">[전자책 관리]</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/">[주문 관리]</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/">[상품평 관리]</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/">[공지게시판 관리]</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/">[QnA게시판 관리]</a></li>
	</ul>
</div>