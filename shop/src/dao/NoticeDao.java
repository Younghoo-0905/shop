package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Ebook;
import vo.Notice;

public class NoticeDao {
	
	//	notice 전체 리스트 출력
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT "
				+ "notice_no noticeNo, "
				+ "notice_title noticeTitle, "
				+ "notice_content noticeContent, "
				+ "member_name memberName, "
				+ "update_date updateDate "
				+ "FROM notice ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		//	System.out.println("[NoticeDao.selectNoticeList -> ]" + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setMemberName(rs.getString("memberName"));
			n.setUpdateDate(rs.getString("updateDate"));
			list.add(n);
		}
		rs.close();
		stmt.close();
		conn.close();				
		return list;
	}
	
	
	//	notice 등록
	public void insertNotice(Notice notice) throws ClassNotFoundException, SQLException {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO notice(notice_title, notice_content, member_no, member_name, create_date, update_date) "
				+ "VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getMemberNo());
		stmt.setString(4, notice.getMemberName());
		//	System.out.println("[NoticeDao.insertNotice -> ]" + stmt);	//	stmt 디버깅
		stmt.executeUpdate();
		stmt.close();
		conn.close();			
	}
	
	
	//	notice 정보 가져오기 (notice 상세보기)
	public Notice selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		Notice n = new Notice();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT "
				+ "notice_no noticeNo, "
				+ "notice_title noticeTitle, "
				+ "notice_content noticeContent, "
				+ "member_name memberName, "
				+ "update_date updateDate "
				+ "FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		//	System.out.println("[NoticeDao.selectNoticeOne -> ]" + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setMemberName(rs.getString("memberName"));
			n.setUpdateDate(rs.getString("updateDate"));
		}
		rs.close();
		stmt.close();
		conn.close();				
		return n;
	}
	
	
	//	notice 수정
	public void updateNotice(Notice notice) throws ClassNotFoundException, SQLException {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE notice SET "
				+ "notice_title=?, "
				+ "notice_content=?, "
				+ "update_date=NOW() "
				+ "WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		//	System.out.println("[NoticeDao.updateNotice -> ]" + stmt);	//	stmt 디버깅
		stmt.executeUpdate();
		stmt.close();
		conn.close();			
	}
	
	
	//	notice 삭제
	public void deleteNotice(int noticeNo) throws ClassNotFoundException, SQLException {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM notice WHERE notice_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		//	System.out.println("[NoticeDao.deleteNotice -> ]" + stmt);	//	stmt 디버깅
		stmt.executeUpdate();
		stmt.close();
		conn.close();			
	}
	
	
	//	notice 목록 LastPage 반환 메서드
	public int selectNoticeLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		PreparedStatement stmt;		
		String sql = "SELECT COUNT(*) FROM notice";
		stmt = conn.prepareStatement(sql);
	
		//	System.out.println("[notice 행 개수 구하는 쿼리 -->] " + stmt);	//	stmt 디버깅
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


}
