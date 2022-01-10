<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		//	System.out.println("접근 불가능" + loginMember.getMemberLevel());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	Qna qna = new Qna();
	QnaDao qnaDao = new QnaDao();
	
	//	답변 내용이 아직 없는 QnA 게시글 목록 불러오기
	ArrayList<Qna> qnaList = qnaDao.selectNotCommentQnaList();
	int count = qnaDao.selectNotCommentQnaCount();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
	<body>
	<div class="container-fluid">	
		
		<!--  adminMenu include  -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!--  adminMenu include -->
		
		<h4 class="d-flex justify-content-center"><span class="text-primary font-weight-bold"><%=loginMember.getMemberName() %> </span> 님 반갑습니다.</h4>
				
		<div class="jumbotron text-center">	  
			<h1>관리자 페이지</h1>
		</div>		
		
		<!-- 아직 답변하지 않은 QnA 게시글 목록 메인화면에 출력 -->
		
		<h2 class="text-center">아직 답변하지 않은 QnA 게시글이 <%=count %>개 있습니다.</h2>
		
		<table class="table table-hover text-center table-layout:fixed">		
		
			<thead>
				<tr>
					<th width="10%">번호</th>		
					<th width="10%">카테고리</th>		
					<th width="40%">제목</th>		
					<th width="20%">작성자 번호</th>
					<th width="20%">작성일</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Qna q : qnaList) {
			%>
					<tr>
						<td><%=q.getQnaNo() %></td>
						<td><%=q.getQnaCategory() %></td>						
							<!-- QnA 제목. 클릭 시 QnA 내용 상세보기 -->
			<%
					if(q.getQnaSecret().equals("Y")) {
			%>
						<!-- 비밀 글은 자물쇠 이미지 출력 -->
						<td><img src="<%=request.getContextPath() %>/image/secret.png" width="13" height="13"><a href="<%=request.getContextPath() %>/admin/selectAdminQnaOne.jsp?qnaNo=<%=q.getQnaNo() %>"><%=q.getQnaTitle() %></a></td>						
			<%
					} else if(q.getQnaSecret().equals("N")) {
			%>
						<td><a href="<%=request.getContextPath() %>/admin/selectAdminQnaOne.jsp?qnaNo=<%=q.getQnaNo() %>"><%=q.getQnaTitle() %></a></td>
			<%
					}
			%>
						<td><%=q.getMemberNo() %></td>
						<td><%=q.getCreateDate() %></td>
					</tr>
			<%
				}		
			%>					
			</tbody>	
		</table>	
	</div>			
	</body>
</html>