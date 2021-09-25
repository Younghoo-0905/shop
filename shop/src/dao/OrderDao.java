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
import vo.OrderEbookMember;

public class OrderDao {
	
	//	주문 목록 출력 메서드
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
	
}
