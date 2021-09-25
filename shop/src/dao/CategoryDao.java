package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import commons.DBUtil;
import vo.*;

public class CategoryDao {
	
	//	[관리자] 전자책 목록 출력 메서드
	public ArrayList<Category> selectCategoryList() throws ClassNotFoundException, SQLException {
		
		//	DB에서 Category 목록을 가져올 배열 생성
		ArrayList<Category> list = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT "
				+ "category_name categoryName, "
				+ "update_date updateDate, "
				+ "create_date createDate, "
				+ "category_state categoryState "
				+ "FROM category ORDER BY category_name";
		PreparedStatement stmt = conn.prepareStatement(sql);		
		//	System.out.println("[selectCategoryList ->] " + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryName(rs.getString("categoryName"));
			category.setUpdateDate(rs.getString("updateDate"));
			category.setCreateDate(rs.getString("createDate"));
			category.setCategoryState(rs.getString("categoryState"));
			list.add(category);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;			
	}
	
	
	//	[관리자] 전자책 추가 시 카테고리명 중복 검사 메서드
	//	null 값이 반환되면 사용 가능한 categoryName
	public String selectCategoryName(String categoryNameCheck) throws ClassNotFoundException, SQLException {		
		String categoryName = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT category_name categoryName FROM category WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryNameCheck);
		//	System.out.println("[selectCategoryName ->]" + stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			categoryName = rs.getString("categoryName");
		}
		rs.close();
		stmt.close();
		conn.close();		
		return categoryName;	//	null -> Id 사용가능
	}
	
	
	//	[관리자] 전자책 카테고리 추가 메서드
	public void insertCategory(Category category) throws ClassNotFoundException, SQLException {
		//	매개변수 값 디버깅
		//	System.out.println("[CategoryDao.insertCategory categoryName -->]" + category.getCategoryName());
		//	System.out.println("[CategoryDao.insertCategory categoryState -->]" + category.getCategoryState());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO category(category_name, category_state, update_date, create_date) VALUES(?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setString(2, category.getCategoryState());
		stmt.executeQuery();
		//	System.out.println("[insertCategory stmt -->]" + stmt);	//	디버깅
		
		stmt.close();
		conn.close();
	}
	
	
	//	[관리자] 전자책 카테고리 사용유무 변경 메서드
	public void updateCategoryState(Category category) throws ClassNotFoundException, SQLException {
		//	매개변수 값 디버깅
		//	System.out.println("[CategoryDao.updateCategoryState categoryName -->]" + category.getCategoryName());
		//	System.out.println("[CategoryDao.insertCategoryState categoryState -->]" + category.getCategoryState());		
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql = "UPDATE category SET category_state=?, update_date=NOW() WHERE category_name=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		if(category.getCategoryState().equals("Y")) {
			stmt.setString(1, "N");
		} else if(category.getCategoryState().equals("N")) {
			stmt.setString(1, "Y");
		}
		stmt.setString(2, category.getCategoryName());
		//	System.out.println("[CategoryDao.updateCategoryState ->]" + stmt);
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();			
	}

}
