<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	int currentPage = 1;	//	currentPage 초기화
	if(request.getParameter("currentPage") != null) {	//	currentPage 값이 넘어왔으면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//	System.out.println("[현재 페이지] " + currentPage);
	
	//	검색어
	String searchMemberId = "";
	if(request.getParameter("searchMemberId") != null) {
		searchMemberId = request.getParameter("searchMemberId");
	}
	System.out.println("[검색 아이디] " + searchMemberId);
	
	int pagingNum = ((currentPage-1) / 10);		//	페이지의 페이지 넘버 : 0부터 시작	
	final int ROW_PER_PAGE = 10;	//	상수 : 10으로 초기화 되면 계속 10 값이 할당
	int beginRow = (currentPage-1) * ROW_PER_PAGE;	//	출력을 시작할 행 넘버

	//	페이지별로 member정보를 가져오는 메서드 실행
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = null;
	
	if(searchMemberId.equals("") == true) {
		memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
	} else {		//	검색한 아이디가 있을 경우 출력할 리스트
		memberList = memberDao.selectMemberListAllBySearchMemberId(beginRow, ROW_PER_PAGE, searchMemberId);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
	<body>	
	<div class="container">
			
		<!--  adminMenu include  -->
		<div>
			<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
		</div>
		<!--  adminMenu include -->
		
	<div class="jumbotron text-center">	  
		<h1>회원 관리</h1>
	</div>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>회원 번호</th>
				<th>회원 ID</th>
				<th>등급</th>
				<th>이름</th>
				<th>나이</th>
				<th>성별</th>
				<th>업데이트 날짜</th>
				<th>가입 날짜</th>
			</tr>
		</thead>
		<tbody>
	
		<%
			for(Member m : memberList) {
		%>
				<tr>
					<td><%=m.getMemberNo() %></td>
					<td><%=m.getMemberId() %></td>
					<!-- 회원의 등급 표시 -->
					<td>
						<%
							if(m.getMemberLevel() == 0) {	//	Level이 0 이면 일반회원
						%>
								<span>일반 회원</span>
						<%
							} else if(m.getMemberLevel() == 1) {	//	Level이 1이면 관리자
						%>
								<span>관리자</span>
						<%
							}
						%>
					</td>
					<td><%=m.getMemberName() %></td>
					<td><%=m.getMemberAge() %></td>
					<td><%=m.getMemberGender() %></td>
					<td><%=m.getUpdateDate() %></td>
					<td><%=m.getCreateDate() %></td>
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
		int lastPage = memberDao.selectLastPage(ROW_PER_PAGE, searchMemberId);
		if(pagingNum > 0) {		//	'이전' 버튼
	%>			
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectMemberList.jsp?currentPage=<%=(pagingNum * 10) %>&searchMemberId=<%=searchMemberId %>">이전</a></li>
	<%
		}				
	
		for(int i = 1; i<=10; i++) {	//	페이지 번호
			if(i + (pagingNum * 10) == currentPage) {	//	currentPage인 링크버튼 파란색으로 표시
	%>
				<li class="page-item active"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectMemberList.jsp.jsp?currentPage=<%=i + (pagingNum * 10) %>&searchMemberId=<%=searchMemberId %>"><%=i + (pagingNum * 10) %></a></li>
	<%
			} else {									//	currentPage 아닌 링크버튼
	%>					
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectMemberList.jsp?currentPage=<%=i + (pagingNum * 10) %>&searchMemberId=<%=searchMemberId %>"><%=i + (pagingNum * 10) %></a></li>
	<%
			}
			if((i + (pagingNum * 10)) == lastPage) {	//	currentPage가 lastPage이면 다음페이지를 더이상 출력하지 않는다
				break;
			}
		}
		if(pagingNum < ((lastPage-1) / ROW_PER_PAGE)) {	//	'다음' 버튼
	%>
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/admin/selectMemberList.jsp?currentPage=<%=(pagingNum * 10) + 11 %>&searchMemberId=<%=searchMemberId %>">다음</a></li>					
	<%
		}
	%>							
		</ul>	
	</div>
	
	<!-- memberId로 검색 -->
		<form action="<%=request.getContextPath() %>/admin/selectMemberList.jsp" method="get">
			<span>회원 ID : </span>
			<input type="text" name="searchMemberId">
			<button class="btn btn-dark" type="submit">검색</button>		
		</form>	
	</div>
	</body>
</html>