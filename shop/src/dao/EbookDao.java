package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;

public class EbookDao {
	
	//	ebook 목록
	public ArrayList<Ebook> selectEbookList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Ebook> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT "
				+ "ebook_no ebookNo, "
				+ "category_name categoryName, "
				+ "ebook_title ebookTitle, "
				+ "ebook_state ebookState "
				+ "FROM ebook ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		//	System.out.println("[EbookDao.selectEbookList -> ]" + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Ebook ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookState(rs.getString("ebookState"));
			list.add(ebook);
		}
		rs.close();
		stmt.close();
		conn.close();				
		return list;
	}
	
	//	ebook 카테고리별 목록
	public ArrayList<Ebook> selectEbookListByCategory(int beginRow, int rowPerPage, String categoryName) throws ClassNotFoundException, SQLException {
		ArrayList<Ebook> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT "
				+ "ebook_no ebookNo, "
				+ "category_name categoryName, "
				+ "ebook_title ebookTitle, "
				+ "ebook_state ebookState "
				+ "FROM ebook WHERE category_name=? ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		//	System.out.println("[EbookDao.selectEbookList -> ]" + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Ebook ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setCategoryName(rs.getString("categoryName"));
			ebook.setEbookTitle(rs.getString("ebookTitle"));
			ebook.setEbookState(rs.getString("ebookState"));
			list.add(ebook);
		}
		rs.close();
		stmt.close();
		conn.close();				
		return list;
	}	
	
	
	//	ebook 목록 LastPage 반환 메서드
	public int selectEbookLastPage(int rowPerPage, String categoryName) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		PreparedStatement stmt;		
		if(categoryName.equals("")) {	//	전체 행 수 검색
			String sql = "SELECT COUNT(*) FROM ebook";
			stmt = conn.prepareStatement(sql);
		} else {						//	선택된 카테고리의 전체 행 수 검색
			String sql = "SELECT COUNT(*) FROM ebook WHERE category_name=?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
		}
		//	System.out.println("[행 개수 구하는 쿼리 -->] " + stmt);	//	stmt 디버깅
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
		rs.close();
		stmt.close();
		conn.close();
		return lastPage;
	}
	

	//	ebookOne 출력 메서드
	public Ebook selectEbookOne(int ebookNo) throws ClassNotFoundException, SQLException {
		Ebook ebook = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		PreparedStatement stmt;		
		String sql = "SELECT ebook_no ebookNo, ebook_img ebookImg FROM ebook WHERE ebook_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebookNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			ebook = new Ebook();
			ebook.setEbookNo(rs.getInt("ebookNo"));
			ebook.setEbookImg(rs.getString("ebookImg"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return ebook;		
	}
	
	
	//	ebook 이미지 수정 메서드
	   public void updateEbookImg(Ebook ebook) throws ClassNotFoundException, SQLException {
		   
	      DBUtil dbUtil = new DBUtil();
	      Connection conn = dbUtil.getConnection();
	      
	      String sql = "UPDATE ebook SET ebook_img=? WHERE ebook_no=?";
	      PreparedStatement stmt = conn.prepareStatement(sql);
	      stmt.setString(1, ebook.getEbookImg());
	      stmt.setInt(2, ebook.getEbookNo());
	      stmt.executeUpdate();
	      stmt.close();
	      conn.close();
	   }

}
