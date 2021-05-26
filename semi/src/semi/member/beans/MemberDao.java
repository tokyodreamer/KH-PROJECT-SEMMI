package semi.member.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import semi.beans.JDBCUtils;

public class MemberDao {
	
	
	//회원 가입 메소드(insert-ps.execute)
	
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

		//회원 탈퇴 메소드(Delete-int count=executeUpdate.)단일조회와 비슷
	public boolean exit(int memberNo) throws Exception{
			
			Connection con = JDBCUtils.getConnection();
			
			String sql="delete member where member_no=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, memberNo);
			int count =ps.executeUpdate();
			
			con.close();
			
			return count>0;
		}
		
	}
