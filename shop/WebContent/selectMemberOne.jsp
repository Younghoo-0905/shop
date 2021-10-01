<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	//	비회원 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){	//	
		//	System.out.println("접근 불가능" + loginMember.getMemberLevel());
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	//	방어코드
	if(request.getParameter("memberId") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
	//	넘겨받은 memberId 값
	String memberId = request.getParameter("memberId");
	
	MemberDao memberDao = new MemberDao();
	
	//	회원 정보 출력 메서드 호출
	Member m = memberDao.selectMemberOne(memberId);	
	
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
			<h1>
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
						<!-- 비밀번호 수정 -->
						<a href="<%=request.getContextPath() %>/updateMemberPwForm.jsp?memberId=<%=m.getMemberId() %>">비밀번호 수정</a>
					</td>					
					<td>
						<!-- 탈퇴 -->
						<a href="<%=request.getContextPath() %>/deleteMemberForm.jsp?memberId=<%=m.getMemberId() %>">회원 탈퇴</a>
					</td>
				</tr>
			</tbody>	
		</table>		

		<div class="text-center"><a class="btn btn-dark" href="<%=request.getContextPath() %>/index.jsp">돌아가기</a></div>	
	
	</div>
	</body>
</html>