package semi.donate.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import semi.beans.JDBCUtils;

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
	
	
}
