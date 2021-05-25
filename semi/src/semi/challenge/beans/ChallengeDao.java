package semi.challenge.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import semi.beans.JDBCUtils;

public class ChallengeDao {
	
	
	//게시글 목록 기능
	public List<ChallengeDto> list() throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select * from challenge order by challenge_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<ChallengeDto> challengeList = new ArrayList<>();
		while(rs.next()) {
			ChallengeDto challengeDto = new ChallengeDto();
			challengeDto.setChallengeNo(rs.getInt("challenge_no"));
			challengeDto.setChallengeWriter(rs.getInt("challenge_writer"));
			challengeDto.setCategoryNo(rs.getInt("category_no"));
			challengeDto.setChallengeTitle(rs.getString("challenge_title"));
			challengeDto.setChallengePushPoint(rs.getInt("challenge_pushPoint"));
			challengeDto.setChallengeStartDate(rs.getString("challenge_startDate"));
			challengeDto.setChallengeEndDate(rs.getString("challenge_endDate"));
			challengeDto.setChallengePercent(rs.getInt("challenge_percent"));
			challengeDto.setChallengeReward(rs.getInt("challenge_reward"));
			challengeDto.setChallengeDonate(rs.getInt("challenge_donate"));
			challengeDto.setChallengeContent(rs.getString("challenge_content"));
			
			challengeList.add(challengeDto);
		}
		
		con.close();
		return challengeList;
		
	}
	
	//검색 기능
	public List<ChallengeDto> search(String type, String keyword) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select * from challenge where instr(#1, ?) > 0 order by challenge_no desc";
		
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		
		List<ChallengeDto> challengeList = new ArrayList<>();
		while(rs.next()) {
			ChallengeDto challengeDto = new ChallengeDto();
			challengeDto.setChallengeNo(rs.getInt("challenge_no"));
			challengeDto.setChallengeWriter(rs.getInt("challenge_writer"));
			challengeDto.setCategoryNo(rs.getInt("category_no"));
			challengeDto.setChallengeTitle(rs.getString("challenge_title"));
			challengeDto.setChallengePushPoint(rs.getInt("challenge_pushPoint"));
			challengeDto.setChallengeStartDate(rs.getString("challenge_startDate"));
			challengeDto.setChallengeEndDate(rs.getString("challenge_endDate"));
			challengeDto.setChallengePercent(rs.getInt("challenge_percent"));
			challengeDto.setChallengeReward(rs.getInt("challenge_reward"));
			challengeDto.setChallengeDonate(rs.getInt("challenge_donate"));
			challengeDto.setChallengeContent(rs.getString("challenge_content"));
			
			challengeList.add(challengeDto);
		}
		
		con.close();
		return challengeList;
	}
}