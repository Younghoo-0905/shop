package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.OrderComment;

public class OrderCommentDao {
	
	//	상품평 별점평균 구하는 메서드
	public double selectOrderScoreAvg(int ebookNo) throws ClassNotFoundException, SQLException {
		double avgScore = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT avg(order_score) avgScore FROM order_comment WHERE ebook_no=? ORDER BY ebook_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		ResultSet rs = stmt.executeQuery();
		//	System.out.println("[selectOrderScoreAvg stmt -->]" + stmt);	//	디버깅
		if(rs.next()) {
			avgScore = rs.getDouble("avgScore");
		}
		
		
		rs.close();
		stmt.close();
		conn.close();
		return avgScore;
	}
	
	
	//	상품평 등록 메서드
	public void insertOrderComment(OrderComment orderComment) throws ClassNotFoundException, SQLException {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		String sql = "INSERT INTO order_comment "
				+ "VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderComment.getOrderNo());
		stmt.setInt(2, orderComment.getEbookNo());
		stmt.setInt(3, orderComment.getOrderScore());
		stmt.setString(4, orderComment.getOrderCommentContent());		
		//	System.out.println("[insertOrderComment -> ]" + stmt);
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();	
		
	}
	
	
	//	상품평 목록 호출 메서드
	public ArrayList<OrderComment> OrderCommentList(int ebookNo) throws ClassNotFoundException, SQLException {
		ArrayList list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		String sql = "SELECT "
				+ "order_score orderScore, "
				+ "order_comment_content orderCommentContent, "
				+ "update_date updateDate "
				+ "FROM order_comment "
				+ "WHERE ebook_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		//	System.out.println("[OrderCommentList -> ]" + stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			OrderComment oc = new OrderComment();
			oc.setOrderScore(rs.getInt("orderScore"));
			oc.setOrderCommentContent(rs.getString("orderCommentContent"));
			oc.setUpdateDate(rs.getString("updateDate"));
			list.add(oc);
		}		
		rs.close();
		stmt.close();
		conn.close();	
		return list;
	}
	
	
	//	상품평 페이징 LastPage 반환 메서드
	public int selectCommentLastPage(int rowPerPage, int ebookNo) throws ClassNotFoundException, SQLException {
		
		int lastPage = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		PreparedStatement stmt;		
		String sql = "SELECT COUNT(*) FROM order_comment WHERE ebook_no=?";
		stmt = conn.prepareStatement(sql);	
		stmt.setInt(1, ebookNo);
		//	System.out.println("[selectCommentLastPage ->] " + stmt);	//	stmt 디버깅
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
		System.out.println("[lastPage] " + lastPage);
		rs.close();
		stmt.close();
		conn.close();
		return lastPage;
	}
}
