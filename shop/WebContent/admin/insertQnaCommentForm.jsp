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
	//	qna 값 전달	//	방어코드
	int qnaNo = 0;
	if(request.getParameter("qnaNo") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	} else {
		qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	}
	
	QnaDao qnaDao = new QnaDao();
	Qna qna = new Qna();	
	
	qna = qnaDao.selectQnaOne(qnaNo);
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
		
		<div class="jumbotron text-center">	  
			<h1>QnA 답변</h1>
		</div>			
		
		<form method="post" action="<%=request.getContextPath() %>/admin/insertQnaCommentAction.jsp">
		
			<table class="table table-bordered text-center table-layout:fixed">	
				<tr>
					<td width="10%">No</td>
					<td><input type="hidden" name="qnaNo" value="<%=qna.getQnaNo() %>"><%=qna.getQnaNo() %></td>
				</tr>
				<tr>
					<td width="10%">카테고리</td>
					<td><%=qna.getQnaCategory() %></td>
				</tr>			
				<tr>
					<td>제목</td>
					<td><%=qna.getQnaTitle() %></td>
				</tr>
				<tr> 
					<td valign="middle">내용</td>
					<td><%=qna.getQnaContent() %></td>
				</tr>
				<tr>
					<td>답변</td>
					<td><textarea rows="5" cols="100" name="qnaCommentContent"></textarea></td>
				</tr>				
				<tr>
					<td>작성자 번호</td>
					<td><%=qna.getMemberNo() %></td>
				</tr>
				<tr>
					<td>게시일</td>
					<td><%=qna.getCreateDate() %></td>
				</tr>	
			</table>
			<div class="text-center">
				<button class="btn btn-dark" type="submit">등록</button>
				<a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/selectAdminQnaOne.jsp?qnaNo=<%=qnaNo %>">돌아가기</a>
			</div>	
		</form>
	</div>
	</body>
</html>