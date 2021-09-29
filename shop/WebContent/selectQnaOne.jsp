<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");	
		
	//	방어코드
	//	qnaNo 값 전달
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
	
		<!--  mainMenu include  -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!--  mainMenu include -->
		
		<div class="jumbotron text-center">	  
			<h1>QnA 게시판</h1>
		</div>			
		
		<table class="table table-bordered text-center table-layout:fixed">	
			<tr>
				<td width="10%">No</td>
				<td><%=qna.getQnaNo() %></td>
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
				<td>작성자 번호</td>
				<td><%=qna.getMemberNo() %></td>
			</tr>
			<tr>
				<td>게시일</td>
				<td><%=qna.getCreateDate() %></td>
			</tr>	
		</table>
		<div class="text-center">
			<a class="btn btn-dark" href="<%=request.getContextPath() %>/selectQnaList.jsp">돌아가기</a>
		</div>	
	</div>
	</body>
</html>