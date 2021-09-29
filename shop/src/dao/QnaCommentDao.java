package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.DBUtil;
import vo.QnaComment;

public class QnaCommentDao {
	
	//	QnA 답글 등록
	public void insertQnaComment(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO qna_comment(qna_no, qna_comment_content, member_no, create_date, update_date) "
				+ "VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaComment.getQnaNo());
		stmt.setString(2, qnaComment.getQnaCommentContent());
		stmt.setInt(3, qnaComment.getMemberNo());
		//	System.out.println("[QnaCommentDao.insertQnaComment -> ]" + stmt);	//	stmt 디버깅
		stmt.executeUpdate();
		stmt.close();
		conn.close();					
	}
	
	
	//	해당 qnaNo에 대한 qnaComment 답변 내용 출력 메서드
	//	답변 내용 없을 시 null 리턴
	public String selectQnaCommentByQnaNo(int qnaNo) throws ClassNotFoundException, SQLException {
		String qcc = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT qna_comment_content qnaCommentContent "
				+ "FROM qna_comment "
				+ "WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaNo);
		//	System.out.println("[QnaCommentDao.selectQnaCommentByQnaNo -> ]" + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			qcc = rs.getString("qnaCommentContent");
		}
		rs.close();
		stmt.close();
		conn.close();	
		return qcc;
	}	
	

}
