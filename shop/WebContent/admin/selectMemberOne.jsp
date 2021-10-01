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
	
	//	방어코드
	if(request.getParameter("memberId") == null) {
		response.sendRedirect(request.getContextPath() + "/admin/selectMemberList.jsp");
	}
	//	넘겨받은 memberId 값
	String memberId = request.getParameter("memberId");
	
	MemberDao memberDao = new MemberDao();
	OrderDao orderDao = new OrderDao();
	
	//	회원 정보 출력 메서드 호출
	Member m = memberDao.selectMemberOne(memberId);	
	//	해당 회원 구매 내역 출력 메서드 호출
	ArrayList<OrderEbookMember> list = orderDao.selectOrderListByMember(m.getMemberNo());
	
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
			<h1>
				<div>[회원 관리]</div>
				<div>회원 정보</div>			
			</h1>
		</div>
		
		<h3><div class="text-center">회원 정보</div></h3>
		
		<table class="table table-hover text-center table-layout:fixed">
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
					<th>등급 수정</th>
					<th>비밀번호 수정</th>
					<th>회원 탈퇴</th>
				</tr>
			</thead>
			<tbody>
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
						<td>
							<!-- 회원 등급 수정 -->
							<a href="<%=request.getContextPath() %>/admin/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo() %>">등급 수정</a>
						</td>
						<td>
							<!-- 회원 비밀번호 수정 -->
							<a href="<%=request.getContextPath() %>/admin/updateMemberPwForm.jsp?memberNo=<%=m.getMemberNo() %>">비밀번호 수정</a>
						</td>					
						<td>
							<!-- 회원 강제탈퇴 -->
							<a href="<%=request.getContextPath() %>/admin/deleteMemberForm.jsp?memberNo=<%=m.getMemberNo() %>">회원 탈퇴</a>
						</td>
					</tr>
			</tbody>	
		</table>
		
		<br><br>
		<!-- 회원 구매내역 -->
		<h3><div class="text-center">구매내역</div></h3>
		
		<table class="table text-center table-layout:fixed">
			<thead>
				<tr>
					<th width="10%">주문 번호</th>
					<th width="50%">제목</th>
					<th width="20%">구매 가격</th>
					<th width="20%">구매 날짜</th>
				</tr>
			</thead>
			<tbody>		
			<%
				for(OrderEbookMember oem : list) {
			%>
					<tr>
						<td><%=oem.getOrder().getOrderNo() %></td>
						<td><%=oem.getEbook().getEbookTitle() %></td>
						<td><%=oem.getOrder().getOrderPrice() %></td>
						<td><%=oem.getOrder().getCreateDate() %></td>	
					</tr>
			<%
				}		
			%>		
			</tbody>	
		</table>
	
		<div class="text-center"><a class="btn btn-dark" href="<%=request.getContextPath() %>/admin/selectMemberList.jsp">돌아가기</a></div>	
	
	</div>
	</body>
</html>