package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Notice;
import vo.Qna;

public class QnaDao {
	
	//	QnA 목록 출력
	public ArrayList<Qna> selectQnaListByPage(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		ArrayList<Qna> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT "
				+ "qna_no qnaNo, "
				+ "qna_category qnaCategory, "
				+ "qna_title qnaTitle, "
				+ "qna_content qnaContent, "
				+ "qna_secret qnaSecret, "
				+ "member_no memberNo, "
				+ "create_date createDate "
				+ "FROM qna ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		//	System.out.println("[QnaDao.selectQnaList -> ]" + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Qna q = new Qna();
			q.setQnaNo(rs.getInt("qnaNo"));
			q.setQnaCategory(rs.getString("qnaCategory"));
			q.setQnaTitle(rs.getString("qnaTitle"));
			q.setQnaContent(rs.getString("qnaContent"));
			q.setQnaSecret(rs.getString("qnaSecret"));
			q.setMemberNo(rs.getInt("memberNo"));
			q.setCreateDate(rs.getString("createDate"));
			list.add(q);
		}
		rs.close();
		stmt.close();
		conn.close();				
		return list;
	}
	
	
	//	QnA 등록
	public void insertQna(Qna qna) throws ClassNotFoundException, SQLException {		
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO qna("
				+ "qna_category, "
				+ "qna_title, "
				+ "qna_content, "
				+ "qna_secret, "
				+ "member_no, "
				+ "create_date, "
				+ "update_date) "
				+ "VALUES(?, ?, ?, ?, ?, NOW(), NOW()) ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategory());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, qna.getMemberNo());
		//	System.out.println("[QnaDao.insertQna -> ]" + stmt);	//	stmt 디버깅
		stmt.executeQuery();		
		
		stmt.close();
		conn.close();		
	}
	
	
	//	선택QnA 정보 가져오기 (QnA 상세보기)
	public Qna selectQnaOne(int qnaNo) throws ClassNotFoundException, SQLException {
		Qna q = new Qna();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT "
				+ "qna_category qnaCategory, "
				+ "qna_title qnaTitle, "
				+ "qna_content qnaContent, "
				+ "qna_secret qnaSecret, "
				+ "member_no memberNo, "
				+ "create_date createDate "
				+ "FROM qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		//	System.out.println("[QnaDao.selectQnaOne -> ]" + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			q.setQnaNo(qnaNo);
			q.setQnaCategory(rs.getString("qnaCategory"));
			q.setQnaTitle(rs.getString("qnaTitle"));
			q.setQnaContent(rs.getString("qnaContent"));
			q.setQnaSecret(rs.getString("qnaSecret"));
			q.setMemberNo(rs.getInt("memberNo"));
			q.setCreateDate(rs.getString("createDate"));
		}
		rs.close();
		stmt.close();
		conn.close();				
		return q;
	}
	
	
	//	답변 내용 없는 QnA 목록 출력
	public ArrayList<Qna> selectNotCommentQnaList() throws ClassNotFoundException, SQLException {
		ArrayList<Qna> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		//	LEFT JOIN 사용해서 답변이 없는 행만 출력하는 쿼리
		String sql = "SELECT "
				+ "q.qna_no qnaNo, "
				+ "q.qna_category qnaCategory, "
				+ "q.qna_title qnaTitle, "
				+ "q.qna_secret qnaSecret, "
				+ "q.member_no memberNo, "
				+ "q.create_date createDate "
				+ "FROM qna q LEFT JOIN qna_comment qc "
				+ "ON q.qna_no = qc.qna_no "
				+ "WHERE qc.qna_no IS NULL "
				+ "ORDER BY createDate ASC "
				+ "LIMIT 0, 10";
		PreparedStatement stmt = conn.prepareStatement(sql);
		//	System.out.println("[QnaDao.selectNotCommentQnaList -> ]" + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Qna q = new Qna();
			q.setQnaNo(rs.getInt("qnaNo"));
			q.setQnaCategory(rs.getString("qnaCategory"));
			q.setQnaTitle(rs.getString("qnaTitle"));
			q.setQnaSecret(rs.getString("qnaSecret"));
			q.setMemberNo(rs.getInt("memberNo"));
			q.setCreateDate(rs.getString("createDate"));
			list.add(q);
		}
		rs.close();
		stmt.close();
		conn.close();	
		return list;
	}
	
	
	//	답변 내용 없는 QnA 개수
	public int selectNotCommentQnaCount() throws ClassNotFoundException, SQLException {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		//	LEFT JOIN 사용해서 답변이 없는 행만 출력하는 쿼리
		String sql = "SELECT COUNT(*) c "
				+ "FROM qna q LEFT JOIN qna_comment qc "
				+ "ON q.qna_no = qc.qna_no "
				+ "WHERE qc.qna_no IS NULL";
		PreparedStatement stmt = conn.prepareStatement(sql);
		//	System.out.println("[QnaDao.selectNotCommentQnaList -> ]" + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("c");
		}
		rs.close();
		stmt.close();
		conn.close();	
		return count;
	}
	
	
	//	QnA 목록 LastPage 반환 메서드
	public int selectQnaLastPage(int rowPerPage) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		PreparedStatement stmt;		
		String sql = "SELECT COUNT(*) FROM qna";
		stmt = conn.prepareStatement(sql);
	
		//	System.out.println("[QnA 행 개수 구하는 쿼리 -->] " + stmt);	//	stmt 디버깅
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
