<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>    
<%@ page import="dao.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	//	관리자 페이지 접근 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){	//	로그인 전이거나 memberLevel이 0이면
		//	System.out.println("접근 불가능" + loginMember.getMemberLevel());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	} 
	
	MultipartRequest mr =  new MultipartRequest(request, "C:/git-shop/shop/WebContent/image", 1024*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
    int ebookNo = Integer.parseInt(mr.getParameter("ebookNo"));
    String ebookImg = mr.getFilesystemName("ebookImg");
    
    Ebook ebook = new Ebook();
    ebook.setEbookNo(ebookNo);
    ebook.setEbookImg(ebookImg);
    
    EbookDao ebookDao = new EbookDao();
    ebookDao.updateEbookImg(ebook);
    response.sendRedirect(request.getContextPath() + "/admin/selectEbookOne.jsp?ebookNo=" + ebookNo);

%>