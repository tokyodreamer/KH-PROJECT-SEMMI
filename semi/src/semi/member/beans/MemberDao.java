package semi.member.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import semi.beans.JDBCUtils;

public class MemberDao {
	
	public boolean changePassword(int memberNo,
			String nowPw, String newPw) throws Exception {
				
			Connection con = JDBCUtils.getConnection();


			String sql="update meber set member_pw=? where member_no=? and member_pw=?";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,newPw);
			ps.setInt(2,memberNo);
			ps.setString(3,nowPw);

			int count = ps.executeUpdate();

			con.close();

			return count > 0;
	}
	
	public boolean changeInformation(MemberDto memberDto) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "update member "
						+ "set member_nick=?, member_email=? "
						+ "where member_no=? and member_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberDto.getMemberNick());
		ps.setString(2, memberDto.getMemberEmail());
		ps.setInt(3, memberDto.getMemberNo());
		ps.setString(4, memberDto.getMemberPw());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public boolean checkMember(int no,String nowPw) throws Exception { //멤버 확인
		Connection con = JDBCUtils.getConnection();
		
		String sql = "";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		int count = ps.executeUpdate();
		return count > 0;
	}
	
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
		
		// 로그인 메소드
		public MemberDto login(MemberDto memberDto) throws Exception {
			
			Connection con = JDBCUtils.getConnection();
			String sql = "select * from member where member_id = ? and member_pw = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, memberDto.getMemberId());
			ps.setString(2, memberDto.getMemberPw());
			ResultSet rs = ps.executeQuery(); 
			
			MemberDto sth;
			if(rs.next()) {
				sth = new MemberDto();
				
				sth.setMemberId(rs.getString("member_id"));
				sth.setMemberPw(rs.getString("member_pw"));
			}
			else {
				sth = null;
			}
			con.close();
			
			return sth;
		}
	

	
}
