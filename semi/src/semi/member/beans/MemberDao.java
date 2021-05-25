package semi.member.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import semi.beans.JDBCUtils;
import semi.member.beans.*;

public class MemberDao {
	
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

	public MemberDto login(MemberDto memberDto) {
		// TODO Auto-generated method stub
		return null;
	}
}
