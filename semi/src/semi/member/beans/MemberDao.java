package semi.member.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import semi.beans.JDBCUtils;

public class MemberDao {
	
	public boolean changePassword(int memberNo,String nowPw, String newPw) throws Exception { //비밀번호 변경
				

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
	
	public boolean changeInformation(MemberDto memberDto) throws Exception { //회원정보 수정
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
	

	
	public MemberDto find(int memberNo) throws Exception { //memberno를 기준으로 회원찾기
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select * from member where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ResultSet rs = ps.executeQuery();
		
		MemberDto memberDto;
		if(rs.next()) {
			
			memberDto = new MemberDto();
			
			memberDto.setMemberNo(rs.getInt("member_no"));
			memberDto.setMemberNick(rs.getString("member_nick"));
			memberDto.setMemberPw(rs.getString("member_pw"));
			memberDto.setMemberId(rs.getString("member_id"));
			memberDto.setMemberEmail(rs.getString("member_email"));
			memberDto.setMemberPoint(rs.getInt("member_point"));
		}
		else {
			memberDto = null;
		}
		
		con.close();
		return memberDto;
		
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

