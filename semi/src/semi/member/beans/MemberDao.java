package semi.member.beans;

import java.sql.Connection;
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

}
