<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	//	방어코드
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
	OrderDao orderDao = new OrderDao();
	Order order = new Order();
	Ebook ebook = new Ebook();
	
	ebook.setEbookNo(Integer.parseInt(request.getParameter("ebookNo")));
	
	order.setEbook(ebook);
	order.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
	order.setOrderPrice(Integer.parseInt(request.getParameter("orderPrice")));
	
	orderDao.insertOrder(order);
	
	response.sendRedirect(request.getContextPath() + "/selectOrderListByMember.jsp");
%>