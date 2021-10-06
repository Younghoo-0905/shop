package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;

public class EbookDao {
	
		//	[관리자 & 고객] ebook 목록 출력. ebookTitle 검색어 존재시 검색어별로 필터링
		public ArrayList<Ebook> selectEbookList(int beginRow, int rowPerPage, String searchEbookTitle) throws ClassNotFoundException, SQLException {
			ArrayList<Ebook> list = new ArrayList<>();
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			String sql = null;
			PreparedStatement stmt;
			if(searchEbookTitle.equals("")) {
				sql = "SELECT "
						+ "ebook_no ebookNo, "
						+ "category_name categoryName, "
						+ "ebook_title ebookTitle, "
						+ "ebook_img ebookImg, "
						+ "ebook_price ebookPrice, "
						+ "ebook_state ebookState "
						+ "FROM ebook "
						+ "ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
			} else {
				sql = "SELECT "
						+ "ebook_no ebookNo, "
						+ "category_name categoryName, "
						+ "ebook_title ebookTitle, "
						+ "ebook_img ebookImg, "
						+ "ebook_price ebookPrice, "
						+ "ebook_state ebookState "
						+ "FROM ebook "
						+ "WHERE ebook_title LIKE ? "
						+ "ORDER BY create_date DESC LIMIT ?, ?";		
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%"+searchEbookTitle+"%");
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);
			}
			//	System.out.println("[EbookDao.selectEbookList -> ]" + stmt);	//	stmt 디버깅
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				Ebook e = new Ebook();
				e.setEbookNo(rs.getInt("ebookNo"));
				e.setCategoryName(rs.getString("categoryName"));
				e.setEbookTitle(rs.getString("ebookTitle"));
				e.setEbookImg(rs.getString("ebookImg"));
				e.setEbookPrice(rs.getInt("ebookPrice"));
				e.setEbookState(rs.getString("ebookState"));
				list.add(e);
			}
			rs.close();
			stmt.close();
			conn.close();				
			return list;
		}
		
		
		//	메인페이지 상품목록 출력 메서드
		public ArrayList<Ebook> selectEbookList(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
			ArrayList<Ebook> list = new ArrayList<>();
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
		
			String sql = "SELECT "
					+ "ebook_no ebookNo, "
					+ "category_name categoryName, "
					+ "ebook_title ebookTitle, "
					+ "ebook_img ebookImg, "
					+ "ebook_price ebookPrice, "
					+ "ebook_state ebookState "
					+ "FROM ebook "
					+ "ORDER BY create_date DESC LIMIT ?, ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);

			//	System.out.println("[EbookDao.selectEbookList -> ]" + stmt);	//	stmt 디버깅
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				Ebook e = new Ebook();
				e.setEbookNo(rs.getInt("ebookNo"));
				e.setCategoryName(rs.getString("categoryName"));
				e.setEbookTitle(rs.getString("ebookTitle"));
				e.setEbookImg(rs.getString("ebookImg"));
				e.setEbookPrice(rs.getInt("ebookPrice"));
				e.setEbookState(rs.getString("ebookState"));
				list.add(e);
			}
			rs.close();
			stmt.close();
			conn.close();				
			return list;
		}
		
		
		//	최신 ebookList 출력 메서드
		public ArrayList<Ebook> selectRecentEbookList() throws ClassNotFoundException, SQLException {
			ArrayList<Ebook> list = new ArrayList<>();
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice "
					+ "FROM ebook "
					+ "ORDER BY create_date DESC "
					+ "LIMIT 0, 5";
			PreparedStatement stmt = conn.prepareStatement(sql);
			//	System.out.println("[EbookDao.selectRecentEbookList -> ]" + stmt);	//	stmt 디버깅
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				Ebook e = new Ebook();
				e.setEbookNo(rs.getInt("ebookNo"));
				e.setEbookTitle(rs.getString("ebookTitle"));
				e.setEbookImg(rs.getString("ebookImg"));
				e.setEbookPrice(rs.getInt("ebookPrice"));
				list.add(e);
			}
			rs.close();
			stmt.close();
			conn.close();				
			return list;
		}
		
		
		//	인기 ebookList 출력 메서드
		public ArrayList<Ebook> selectPopularEbookList() throws ClassNotFoundException, SQLException {
			ArrayList<Ebook> list = new ArrayList<>();
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT e.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_img ebookImg, e.ebook_price ebookPrice "
					+ "FROM ebook e INNER JOIN "
					+ "(SELECT ebook_no, COUNT(ebook_no) count "
					+ "FROM orders "
					+ "GROUP BY ebook_no "
					+ "ORDER BY COUNT(ebook_no) DESC "
					+ "LIMIT 0, 5) t "
					+ "ON e.ebook_no = t.ebook_no";
			PreparedStatement stmt = conn.prepareStatement(sql);
			//	System.out.println("[EbookDao.selectPopularEbookList -> ]" + stmt);	//	stmt 디버깅
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				Ebook e = new Ebook();
				e.setEbookNo(rs.getInt("ebookNo"));
				e.setEbookTitle(rs.getString("ebookTitle"));
				e.setEbookImg(rs.getString("ebookImg"));
				e.setEbookPrice(rs.getInt("ebookPrice"));
				list.add(e);
			}
			rs.close();
			stmt.close();
			conn.close();				
			return list;
		}
		
		
		//	[관리자] ebook 카테고리별 목록
		public ArrayList<Ebook> selectEbookListByCategory(int beginRow, int rowPerPage, String categoryName, String searchEbookTitle) throws ClassNotFoundException, SQLException {
			ArrayList<Ebook> list = new ArrayList<>();
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			String sql = null;
			PreparedStatement stmt;
			if(searchEbookTitle.equals("")) {
				sql = "SELECT "
						+ "ebook_no ebookNo, "
						+ "category_name categoryName, "
						+ "ebook_title ebookTitle, "
						+ "ebook_price ebookPrice, "
						+ "ebook_state ebookState "
						+ "FROM ebook "
						+ "WHERE category_name=? "
						+ "ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, categoryName);
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);
			} else {
				sql = "SELECT "
						+ "ebook_no ebookNo, "
						+ "category_name categoryName, "
						+ "ebook_title ebookTitle, "
						+ "ebook_price ebookPrice, "						
						+ "ebook_state ebookState "
						+ "FROM ebook "
						+ "WHERE category_name=? AND ebook_title LIKE ? "
						+ "ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, categoryName);
				stmt.setString(2, "%"+searchEbookTitle+"%");
				stmt.setInt(3, beginRow);
				stmt.setInt(4, rowPerPage);
			}
			//	System.out.println("[EbookDao.selectEbookList -> ]" + stmt);	//	stmt 디버깅
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				Ebook ebook = new Ebook();
				ebook.setEbookNo(rs.getInt("ebookNo"));
				ebook.setCategoryName(rs.getString("categoryName"));
				ebook.setEbookTitle(rs.getString("ebookTitle"));
				ebook.setEbookPrice(rs.getInt("ebookPrice"));
				ebook.setEbookState(rs.getString("ebookState"));
				list.add(ebook);
			}
			rs.close();
			stmt.close();
			conn.close();				
			return list;
		}	
		
		
		//	[관리자] ebook 목록 LastPage 반환 메서드
		public int selectEbookLastPage(int rowPerPage, String categoryName, String searchEbookTitle) throws ClassNotFoundException, SQLException {
			int lastPage = 0;
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			PreparedStatement stmt;	
			if(categoryName.equals("all")) {		//	카테고리 검색값이 x
				if(searchEbookTitle.equals("")) {	//	제목 검색값이 x
					String sql = "SELECT COUNT(*) FROM ebook";
					stmt = conn.prepareStatement(sql);				
					System.out.println(stmt);	
				} else {							//	제목 검색값이 o
					String sql = "SELECT COUNT(*) FROM ebook WHERE ebook_title LIKE ?";
					stmt = conn.prepareStatement(sql);			
					stmt.setString(1, "%"+searchEbookTitle+"%");
					System.out.println(stmt);
				}			
			} else {							//	카테고리 검색값이 o
				if(searchEbookTitle.equals("")) {	//	제목 검색값이 x
					String sql = "SELECT COUNT(*) FROM ebook WHERE category_name=?";
					stmt = conn.prepareStatement(sql);					
					stmt.setString(1, categoryName);
				} else {							//	제목 검색값이 o
					String sql = "SELECT COUNT(*) FROM ebook WHERE category_name=? AND ebook_title LIKE ?";
					stmt = conn.prepareStatement(sql);					
					stmt.setString(1, categoryName);
					stmt.setString(2, "%"+searchEbookTitle+"%");
				}							
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
				System.out.println("[lastPage] " + lastPage);
			}
			rs.close();
			stmt.close();
			conn.close();
			return lastPage;
		}
		
	
		//	[관리자] ebookOne 출력 메서드
		public Ebook selectEbookOne(int ebookNo) throws ClassNotFoundException, SQLException {
			Ebook ebook = null;
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			PreparedStatement stmt;		
			String sql = "SELECT ebook_no ebookNo, ebook_title ebookTitle, ebook_img ebookImg, ebook_price ebookPrice FROM ebook WHERE ebook_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ebookNo);
			//	System.out.println("[selectEbookOne -> ]" + stmt);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				ebook = new Ebook();
				ebook.setEbookNo(rs.getInt("ebookNo"));
				ebook.setEbookTitle(rs.getString("ebookTitle"));
				ebook.setEbookImg(rs.getString("ebookImg"));
				ebook.setEbookPrice(rs.getInt("ebookPrice"));
			}
			rs.close();
			stmt.close();
			conn.close();
			return ebook;		
		}
		
		
		//	[관리자] ebook 이미지 수정 메서드
	   public void updateEbookImg(Ebook ebook) throws ClassNotFoundException, SQLException {
		   
	      DBUtil dbUtil = new DBUtil();
	      Connection conn = dbUtil.getConnection();
	      
	      String sql = "UPDATE ebook SET ebook_img=? WHERE ebook_no=?";
	      PreparedStatement stmt = conn.prepareStatement(sql);
	      stmt.setString(1, ebook.getEbookImg());
	      stmt.setInt(2, ebook.getEbookNo());
	      //	System.out.println("[updateEbookImg -> ]" + stmt);
	      stmt.executeUpdate();
	      stmt.close();
	      conn.close();
	   }
	
		   
		//	[관리자] ebook 가격 수정
		//	입력 : ebookNo, 수정할 가격
		public void updateEbookPrice(Ebook ebook) throws ClassNotFoundException, SQLException {
			
		      DBUtil dbUtil = new DBUtil();
		      Connection conn = dbUtil.getConnection();
		      
		      String sql = "UPDATE ebook SET ebook_price=? WHERE ebook_no=?";
		      PreparedStatement stmt = conn.prepareStatement(sql);
		      stmt.setInt(1, ebook.getEbookPrice());
		      stmt.setInt(2, ebook.getEbookNo());
		      //	System.out.println("[updateEbookPrice -> ]" + stmt);
		      stmt.executeUpdate();   	      
		      stmt.close();
		      conn.close();
		}
		
		
		//	[관리자] ebook 삭제
		public void deleteEbook(int ebookNo) throws ClassNotFoundException, SQLException {
			
		      DBUtil dbUtil = new DBUtil();
		      Connection conn = dbUtil.getConnection();
		      
		      String sql = "DELETE FROM ebook WHERE ebook_no=?";
		      PreparedStatement stmt = conn.prepareStatement(sql);
		      stmt.setInt(1, ebookNo);
		      //	System.out.println("[deleteEbook -> ]" + stmt);
		      stmt.executeUpdate();   	      
		      stmt.close();
		      conn.close();
		}
		 
	   
}
