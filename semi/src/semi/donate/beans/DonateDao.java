package semi.donate.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import semi.beans.JDBCUtils;
import semi.member.beans.MemberDto;

public class DonateDao {

	// 후원DB 시퀀스 번호 뽑아오기
	public int getSequence() throws Exception {
		Connection con = JDBCUtils.getConnection();

		String sql = "select donate_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();

		int donateNo = rs.getInt(1);

		con.close();
		return donateNo;
	}
	
	public void donateJoin(DonateDto donateDto) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "insert into donate values(?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, donateDto.getDonateNo());
		ps.setInt(2, donateDto.getDonateChallengeNo());
		ps.setInt(3, donateDto.getDonateMemberNo());
		ps.setInt(4, donateDto.getDonateCategoryNo());
		ps.setInt(5, donateDto.getDonatePushPoint());
		ps.execute();
		
		con.close();
	}
	
	public int checkDonate(int challengeNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select member_no from donate where challenge_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, challengeNo);
		ResultSet rs = ps.executeQuery();
		
		int checkDonateMember;
		
		if(rs.next()) {
			checkDonateMember = rs.getInt("member_no");
		} else {
			checkDonateMember = 0;
		}
		con.close();
		
		return checkDonateMember;
	}
	
	public DonateDto find(int challengeNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select * from donate where challenge_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, challengeNo);
		ResultSet rs = ps.executeQuery();
		
		DonateDto donateDto;
		if (rs.next()) {

			donateDto = new DonateDto();

			donateDto.setDonateNo(rs.getInt("donate_no"));
			donateDto.setDonateChallengeNo(rs.getInt("challenge_no"));
			donateDto.setDonateMemberNo(rs.getInt("member_no"));
			donateDto.setDonateCategoryNo(rs.getInt("category_no"));
			donateDto.setDonatePushPoint(rs.getInt("donate_pushPoint"));
			
		} else {
			donateDto = null;
		}
		
		
		con.close();
		return donateDto;
	}
	
//	public int count(int memberNo) throws Exception{
//		Connection con = JDBCUtils.getConnection();
//		
//		String sql = "select count(*) from donate where member_no = ?";
//		PreparedStatement ps = con.prepareStatement(sql);
//		ps.setInt(1, memberNo);
//		ResultSet rs = ps.executeQuery();
//		
//		int count;
//		
//		if(rs.next()) {
//			count = rs.get;
//		} else {
//			count = 0;
//		}
//		
//		return count;
//	}
	
}
