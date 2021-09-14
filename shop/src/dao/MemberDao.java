package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.DBUtil;
import vo.Member;

public class MemberDao {
	
	//	1. 회원가입
	public void insertMember(Member member) throws ClassNotFoundException, SQLException {
		//	매개변수 값 디버깅
		System.out.println("[MemberDao.insertMember memberId -->]" + member.getMemberId());
		//	System.out.println("[MemberDao.insertMember memberPw -->]" + member.getMemberPw());
		//	System.out.println("[MemberDao.insertMember memberLevel -->]" + member.getMemberLevel());
		//	System.out.println("[MemberDao.insertMember memberName -->]" + member.getMemberName());
		//	System.out.println("[MemberDao.insertMember memberAge -->]" + member.getMemberAge());
		//	System.out.println("[MemberDao.insertMember memberGender -->]" + member.getMemberGender());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member("
				+ "member_id, "
				+ "member_pw, "
				+ "member_level, "
				+ "member_name, "
				+ "member_age, "
				+ "member_gender, "
				+ "update_date, "
				+ "create_date) "
				+ "VALUES(?, PASSWORD(?), 0, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		stmt.setInt(4, member.getMemberAge());
		stmt.setString(5, member.getMemberGender());
		stmt.executeQuery();
		//	System.out.println("[insertMember stmt -->]" + stmt);	//	디버깅
		
		stmt.close();
		conn.close();
	}
	
	//	2. 로그인
	//	로그인 성공 시 Member : memberId + memberName
	//	로그인 실패 시 Member : null
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		//	System.out.println("[MemberDao.login memberId ->]" + member.getMemberId());
		//	System.out.println("[MemberDao.login memberPw ->]" + member.getMemberPw());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id AS memberId, member_pw AS memberPw, member_name AS memberName FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		//	System.out.println("[stmt -->]" + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			Member returnMember = new Member();
			returnMember.setMemberId(rs.getString("memberId"));
			returnMember.setMemberPw(rs.getString("memberPw"));			
			returnMember.setMemberName(rs.getString("memberName"));
			stmt.close();
			conn.close();
			rs.close();
			return returnMember;
		}
		
		stmt.close();
		conn.close();
		rs.close();
		return null;
	}
}
