package semi.member.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import semi.beans.JDBCUtils;

public class MemberDao {

	public boolean changePassword(int memberNo,String nowPw, String newPw) throws Exception { //비밀번호 변경

				
			Connection con = JDBCUtils.getConnection();
			String sql="update member set member_pw=? where member_no=? and member_pw=?";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, newPw);
			ps.setInt(2, memberNo);
			ps.setString(3, nowPw);

	
			int count = ps.executeUpdate();

			con.close();

			return count > 0;
	}
	


	public boolean changeInformation(MemberDto memberDto) throws Exception { // 회원정보 수정
		Connection con = JDBCUtils.getConnection();

		String sql = "update member set member_nick=?, member_email=? where member_no=? and member_pw=?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberDto.getMemberNick());
		ps.setString(2, memberDto.getMemberEmail());
		ps.setInt(3, memberDto.getMemberNo());
		ps.setString(4, memberDto.getMemberPw());
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

	public MemberDto find(int memberNo) throws Exception { // memberno를 기준으로 회원찾기

		Connection con = JDBCUtils.getConnection();

		String sql = "select * from member where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ResultSet rs = ps.executeQuery();

		MemberDto memberDto;
		if (rs.next()) {

			memberDto = new MemberDto();

			memberDto.setMemberNo(rs.getInt("member_no"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberId(rs.getString("member_id"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			memberDto.setMemberPoint(rs.getInt("member_point"));
		} else {
			memberDto = null;
		}

		con.close();
		return memberDto;

	}

	// 회원 가입 메소드
	public void regist(MemberDto memberDto) throws Exception {
		Connection con = JDBCUtils.getConnection();

		String sql = "insert into member values(member_seq.nextval,?,?,?,200000,?)";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberDto.getMemberId());
		ps.setString(2, memberDto.getMemberPw());
		ps.setString(3, memberDto.getMemberNick());
		ps.setString(4, memberDto.getMemberEmail());

		ps.execute();
		con.close();

	}

	// 로그인 메소드
	public MemberDto login(MemberDto memberDto) throws Exception {

		Connection con = JDBCUtils.getConnection();
		String sql = "select * from member where member_id = ? and member_pw = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberDto.getMemberId());
		ps.setString(2, memberDto.getMemberPw());
		ResultSet rs = ps.executeQuery();

		MemberDto sth;
		if (rs.next()) {
			sth = new MemberDto();
			sth.setMemberNo(rs.getInt("member_no"));
			sth.setMemberId(rs.getString("member_id"));
			sth.setMemberPw(rs.getString("member_pw"));
		} else {
			sth = null;
		}
		con.close();

		return sth;
	}

	// 회원 탈퇴 메소드(Delete-int count=executeUpdate.)단일조회와 비슷
	public boolean exit(int memberNo) throws Exception {

		Connection con = JDBCUtils.getConnection();

		String sql = "delete member where member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}
	
	// 도전글 등록 시, 포인트 차감 메소드 (작성자 : 정 계진)
	// 설명 : 세션의 회원번호를 기준으로 도전글 등록이 되면 ChallengeJoinServlet 에서 도전글 등록 메소드와 같이 실행
	public boolean challengeJoin(int memberNo, int pushPoint) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "update member set member_point = member_point - ? where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, pushPoint);
		ps.setInt(2, memberNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	//아이디 찾기
	
	public String searchId(String email,String nick)throws Exception {
		
		Connection con = JDBCUtils.getConnection();

		String sql = "select member_id from member where member_email= ? and member_nick =?" ;
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,email);
		ps.setString(2,nick);
		ResultSet rs = ps.executeQuery();
		
		if(rs.next()) {
			String id = rs.getString("member_id");
			con.close();
			return id;
		}
		else {
			con.close();
			return null;
		}
		
		
	}
	
	//비밀번호 찾기
	public String searchPw(String id,String nick) throws Exception {

		Connection con = JDBCUtils.getConnection();
		
		String sql ="select member_pw from member where member_id= ? and member_nick =?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1,id);
		ps.setString(2,nick);

		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			String pw = rs.getString("member_pw");
			con.close();
			return pw;
		}
		else {
			con.close();
			return null;
		}
	}
}
