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
	
	//	공지 리스트 출력
	public ArrayList<Notice> selectNoticeList() throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT "
				+ "notice_no noticeNo, "
				+ "notice_title noticeTitle, "
				+ "notice_content noticeContent, "
				+ "member_name memberName, "
				+ "update_date updateDate "
				+ "FROM notice ORDER BY create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
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
	
	
	//	공지 등록
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
	
	
	//	선택공지 정보 가져오기 (공지 상세보기)
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
	
	
	//	공지 수정
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
	
	
	//	공지 삭제
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


}
