package semi.member.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

import semi.beans.JDBCUtils;

public class MemberDao {
	
	
	//회원 가입 메소드
	public void regist(MemberDto memberDto) throws Exception{
		Connection con = JDBCUtils.getConnection();
		
		String sql="insert into member values(member_seq.nextval,?,?,?,200000,?)";
		
		PreparedStatement ps= con.prepareStatement(sql);
		ps.setString(1, memberDto.getMemberId());
		ps.setString(2, memberDto.getMemberPw());
		ps.setString(3, memberDto.getMemberNick());
		ps.setString(4, memberDto.getMemberEmail());
		
		ps.execute();
		
		con.close();
	}
	
	// ?
	public MemberDto sth(int memberNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select * from member where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ResultSet rs = ps.executeQuery();
		
		MemberDto memberDto;
		if(rs.next()) {
			memberDto = new MemberDto();
			
			memberDto.setMemberNo(rs.getInt("member_no"));
			memberDto.setMemberId(rs.getString("member_id"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberPoint(rs.getInt("member_point"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			// memberDto.setMemberGrade(rs.getString("member_grade"));
		}
		else {
			memberDto = null;
		}
		
		con.close();
		
		return memberDto;
	}
	
	// 로그인 메소드
	public MemberDto login(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return null;
	}
}

