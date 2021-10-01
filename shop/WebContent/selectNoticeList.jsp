<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	//	페이징 관련 변수
	int currentPage = 1;	//	currentPage 초기화
	if(request.getParameter("currentPage") != null) {	//	currentPage 값이 넘어왔으면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//	System.out.println("[현재 페이지] " + currentPage);	//	디버깅
	int pagingNum = ((currentPage-1) / 10);		//	페이지의 페이지 넘버 : 0부터 시작		
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1) * ROW_PER_PAGE;	//	출력을 시작할 행 넘버
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE);
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
			<h1>공지 게시판</h1>
		</div>		
		
		<table class="table table-hover text-center table-layout:fixed">
			
			<thead>
				<tr>
					<th width="10%">번호</th>		
					<th width="50%">제목</th>		
					<th width="25%">작성자</th>
					<th width="25%">공지일</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeNo() %></td>
							<!-- 클릭 시 공지 게시글 내용 상세보기 -->
						<td><a href="<%=request.getContextPath() %>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a></td>
						<td><%=n.getMemberName() %></td>
						<td><%=n.getUpdateDate() %></td>
					</tr>
			<%
				}		
			%>					
			</tbody>	
		</table>
			
		<!-- 페이징 -->
		<div class="d-flex justify-content-center">
			<ul class =	"pagination active">
		<%		
			//	lastPage를 구하는 메서드 사용
			int lastPage = noticeDao.selectNoticeLastPage(ROW_PER_PAGE);
			if(pagingNum > 0) {		//	'이전' 버튼
		%>			
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/selectNoticeList.jsp?currentPage=<%=(pagingNum * 10) %>">이전</a></li>
		<%
			}				
		
			for(int i = 1; i<=10; i++) {	//	페이지 번호
				if(i + (pagingNum * 10) == currentPage) {	//	currentPage인 링크버튼 파란색으로 표시
		%>
					<li class="page-item active"><a class="page-link" href="<%=request.getContextPath() %>/selectNoticeList.jsp?currentPage=<%=i + (pagingNum * 10) %>"><%=i + (pagingNum * 10) %></a></li>
		<%
				} else {									//	currentPage 아닌 링크버튼
		%>					
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/selectNoticeList.jsp?currentPage=<%=i + (pagingNum * 10) %>"><%=i + (pagingNum * 10) %></a></li>
		<%
				}
				if((i + (pagingNum * 10)) == lastPage) {	//	currentPage가 lastPage이면 다음페이지를 더이상 출력하지 않는다
					break;
				}
			}
			if(pagingNum < ((lastPage-1) / ROW_PER_PAGE)) {	//	'다음' 버튼
		%>
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/selectNoticeList.jsp?currentPage=<%=(pagingNum * 10) + 11 %>">다음</a></li>					
		<%
			}
		%>							
			</ul>	
		</div>	
	</div>
	</body>
</html>