package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;
import vo.Member;
import vo.Order;
import vo.OrderComment;
import vo.OrderEbookMember;

public class OrderDao {
	
	//	OrderList 출력 메서드
	//	리턴 타입 OrderEbookMember
	public ArrayList<OrderEbookMember> selectOrderList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		String sql = "SELECT "
				+ "o.order_no orderNo, "
				+ "o.order_price orderPrice, "
				+ "o.create_date createDate, "
				+ "e.ebook_no ebookNo, "
				+ "e.ebook_title ebookTitle, "
				+ "m.member_no memberNo, "
				+ "m.member_id memberId "
				+ "FROM orders o INNER JOIN ebook e INNER JOIN member m "
				+ "ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no "
				+ "ORDER BY o.create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		//	System.out.println("[selectOrderList -> ]" + stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);			
		}
		rs.close();
		stmt.close();
		conn.close();		
		return list;
	}
	
	
	
	//	전자책 이름별로 검색한 리스트 출력
	public ArrayList<OrderEbookMember> selectOrderListBySearchEbookTitle(int beginRow, int rowPerPage, String searchEbookTitle) throws ClassNotFoundException, SQLException {
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		String sql = "SELECT "
				+ "o.order_no orderNo, "
				+ "o.order_price orderPrice, "
				+ "o.create_date createDate, "
				+ "e.ebook_no ebookNo, "
				+ "e.ebook_title ebookTitle, "
				+ "m.member_no memberNo, "
				+ "m.member_id memberId "
				+ "FROM orders o INNER JOIN ebook e INNER JOIN member m "
				+ "ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no "
				+ "WHERE ebook_title LIKE ? "
				+ "ORDER BY o.create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchEbookTitle+"%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		//	System.out.println("[selectOrderListBySearchEbookTitle -> ]" + stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);			
		}
		rs.close();
		stmt.close();
		conn.close();		
		return list;
	}
	
	
	//	멤버 별 OrderList 출력 메서드
	public ArrayList<OrderEbookMember> selectOrderListByMember(int memberNo) throws ClassNotFoundException, SQLException {
		ArrayList<OrderEbookMember> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		String sql = "SELECT "
				+ "o.order_no orderNo, "
				+ "o.order_price orderPrice, "
				+ "o.create_date createDate, "
				+ "e.ebook_no ebookNo, "
				+ "e.ebook_title ebookTitle, "
				+ "m.member_no memberNo, "
				+ "m.member_id memberId "
				+ "FROM orders o INNER JOIN ebook e INNER JOIN member m "
				+ "ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no "
				+ "WHERE m.member_no=? "
				+ "ORDER BY o.create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		//	System.out.println("[selectOrderListByMember -> ]" + stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderEbookMember oem = new OrderEbookMember();
			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setCreateDate(rs.getString("createDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			oem.setEbook(e);
			
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
			
			list.add(oem);			
		}
		rs.close();
		stmt.close();
		conn.close();		
		return list;
	}	
	
	
	

	
	//	Order 추가 메서드
	public void insertOrder(Order order) throws ClassNotFoundException, SQLException {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		String sql = "INSERT INTO orders(ebook_no, member_no, order_price, create_date, update_date) "
				+ "VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, order.getEbook().getEbookNo());
		stmt.setInt(2, order.getMemberNo());
		stmt.setInt(3, order.getOrderPrice());
		//	System.out.println("[insertOrder -> ]" + stmt);
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();			
	}
	
	
	//	Order 상세 내역 출력 메서드
	//	리턴 타입 OrderEbookMember
	public OrderEbookMember selectOrderOne(int orderNo) throws ClassNotFoundException, SQLException {
		OrderEbookMember oem = new OrderEbookMember();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		String sql = "SELECT "
				+ "o.order_no orderNo, "
				+ "o.order_price orderPrice, "
				+ "o.update_date updateDate, "
				+ "e.ebook_no ebookNo, "
				+ "e.ebook_title ebookTitle, "
				+ "e.ebook_img ebookImg, "
				+ "m.member_id memberId "
				+ "FROM orders o INNER JOIN ebook e INNER JOIN member m "
				+ "ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no "
				+ "WHERE o.order_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);
		//	System.out.println("[selectOrderOne -> ]" + stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {			
			Order o = new Order();
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setUpdateDate(rs.getString("updateDate"));
			oem.setOrder(o);
			
			Ebook e = new Ebook();
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookImg(rs.getString("ebookImg"));
			oem.setEbook(e);							
			
			Member m = new Member();
			m.setMemberId(rs.getString("memberId"));
			oem.setMember(m);
		}
		rs.close();
		stmt.close();
		conn.close();		
		return oem;
	}
	
	
	//	[관리자] Order관리 LastPage 반환 메서드
	public int selectOrderLastPage(int rowPerPage, String searchEbookTitle) throws ClassNotFoundException, SQLException {
	
		int lastPage = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		PreparedStatement stmt;		
		if(searchEbookTitle.equals("")) {	//	전체 행 수
			String sql = "SELECT COUNT(*) "
					+ "FROM orders o INNER JOIN ebook e INNER JOIN member m "
					+ "ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no";
			stmt = conn.prepareStatement(sql);
		} else {						//	검색된 memberId 의 전체 행 수
			String sql = "SELECT COUNT(*) "
					+ "FROM orders o INNER JOIN ebook e INNER JOIN member m "
					+ "ON o.ebook_no = e.ebook_no AND o.member_no = m.member_no "
					+ "WHERE e.ebook_title LIKE ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchEbookTitle+"%");
		}
		//	System.out.println("[selectLastPage -->] " + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		
		int totalRowCount = 0;
		if(rs.next()) {
			totalRowCount = rs.getInt("COUNT(*)");
			//	System.out.println("[검색된 행 개수] " + totalRowCount);
		}
		lastPage = totalRowCount / rowPerPage;
		if(totalRowCount % rowPerPage != 0) {
			lastPage++;
			//	System.out.println("[lastPage] " + lastPage);
		}
		//	System.out.println("[lastPage] " + lastPage);
		rs.close();
		stmt.close();
		conn.close();
		return lastPage;
	}

}
