package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Member;

public class MemberDao {
	
	//	[비회원] 회원가입 메서드
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
	
	//	[회원] 로그인 메서드
	//	로그인 성공 시 Member : memberId + memberName
	//	로그인 실패 시 Member : null
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		//	System.out.println("[MemberDao.login memberId ->]" + member.getMemberId());
		//	System.out.println("[MemberDao.login memberPw ->]" + member.getMemberPw());
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, "
				+ "member_pw memberPw, "
				+ "member_name memberName, "
				+ "member_level memberLevel "
				+ "FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
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
			returnMember.setMemberLevel(rs.getInt("memberLevel"));
			stmt.close();
			conn.close();
			rs.close();
			return returnMember;
		}		
		rs.close();
		stmt.close();
		conn.close();
		return null;
	}
	
	
	//	[관리자] 회원목록 출력 메서드
	public ArrayList<Member> selectMemberListAllByPage(int beginRow, int rowPerPage) throws ClassNotFoundException, SQLException {
		
		ArrayList<Member> list = new ArrayList<Member>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT "
				+ "member_no memberNo, "
				+ "member_id memberId, "
				+ "member_level memberLevel, "
				+ "member_name memberName, "
				+ "member_age memberAge, "
				+ "member_gender memberGender, "
				+ "update_date updateDate, "
				+ "create_date createDate "
				+ "FROM member ORDER BY update_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		//	System.out.println("[selectMemberListAllByPage ->] " + stmt);	//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			list.add(member);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;			
	}
	
	
	//	[관리자] 회원목록 검색해서 출력 메서드
	public ArrayList<Member> selectMemberListAllBySearchMemberId(int beginRow, int rowPerPage, String searchMemberId) throws ClassNotFoundException, SQLException {
		
		ArrayList<Member> list = new ArrayList<Member>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT "
				+ "member_no memberNo, "
				+ "member_id memberId, "
				+ "member_level memberLevel, "
				+ "member_name memberName, "
				+ "member_age memberAge, "
				+ "member_gender memberGender, "
				+ "update_date updateDate, "
				+ "create_date createDate "
				+ "FROM member WHERE member_id LIKE ? ORDER BY update_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchMemberId+"%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		//	System.out.println("[selectMemberListAllBySearchMemberId ->] " + stmt);		//	stmt 디버깅
		ResultSet rs = stmt.executeQuery();
		//	데이터 타입 변환
		while(rs.next()) {
			Member member = new Member();
			member.setMemberNo(rs.getInt("memberNo"));
			member.setMemberId(rs.getString("memberId"));
			member.setMemberLevel(rs.getInt("memberLevel"));
			member.setMemberName(rs.getString("memberName"));
			member.setMemberAge(rs.getInt("memberAge"));
			member.setMemberGender(rs.getString("memberGender"));
			member.setUpdateDate(rs.getString("updateDate"));
			member.setCreateDate(rs.getString("createDate"));
			list.add(member);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;			
	}
	
	//	[관리자] LastPage 반환 메서드
	public int selectLastPage(int rowPerPage, String searchMemberId) throws ClassNotFoundException, SQLException {
		int lastPage = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		PreparedStatement stmt;		
		if(searchMemberId.equals("")) {	//	전체 행 수
			String sql = "SELECT COUNT(*) FROM member";
			stmt = conn.prepareStatement(sql);
		} else {						//	검색된 memberId 의 전체 행 수
			String sql = "SELECT COUNT(*) FROM member WHERE member_id LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchMemberId+"%");
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
}
