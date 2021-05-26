package semi.challenge.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;


import semi.beans.JDBCUtils;

public class ChallengeDao {
	
	// 도전글 번호 불러오기
	public int getSequence() throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select challenge_seq nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();

		
		int challengeNo = rs.getInt(1);
		
		con.close();
		return challengeNo;
	}
	
	// 도전글 가입
	public void challengeJoin(ChallengeDto challengeDto) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "insert into challenge values(challenge_seq.nextval, ?, ?, ?, ?, ?, ?, 0, ?, 0, ?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, challengeDto.getChallengeWriter()); // 멤버 번호 : -> 작성자 등록
		ps.setInt(2, challengeDto.getCategoryNo()); // 카테고리 번호 : -> 카테고리 타입 불러올 용도
		ps.setString(3, challengeDto.getChallengeTitle()); // 글 제목
		ps.setInt(4, challengeDto.getChallengePushPoint()); // 참가비
		ps.setString(5, challengeDto.getChallengeStartDate()); // 시작일
		ps.setString(6, challengeDto.getChallengeEndDate()); // 종료일
		ps.setInt(7, (int) (challengeDto.getChallengePushPoint()*0.01)); // 상금 로직 : 참가비 * 0.01
		ps.setString(8, challengeDto.getChallengeContent()); // 도전글 내용 
		ps.execute();
		
		con.close();
	}
	
	// 도전글 상세보기
	public ChallengeDto getChallenge(int challengeNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select * from challenge where challenge_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, challengeNo);
		ResultSet rs = ps.executeQuery();
		
		ChallengeDto challengeDto;
		if(rs.next()) {
			challengeDto = new ChallengeDto();
			
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
		} else {
			challengeDto = null;
		}
		
		con.close();
		
		return challengeDto;
	}
	
	//게시글 목록 기능
	public List<ChallengeDto> list(int startRow, int endRow) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select * from ("
					 	+ "select rownum rn, TMP.* from ("
					 		+ "select * from challenge order by challenge_no desc"
					 	+ ")TMP"
			          +") where rn between ? and ?"; 
							
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
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
	public List<ChallengeDto> search(String type, String keyword, int startRow, int endRow) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		
		String sql = "select * from ("
			 			+ "select rownum rn, TMP.* from ("
			 				+ "select * from challenge "
			 				+ "where instr(#1, ?) > 0 order by challenge_no desc"
			 			+ ")TMP"
			 		+") where rn between ? and ?"; 
				
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
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
	
	//페이지블럭 계산을 위한 카운트 기능(목록/검색)
	public int getCount() throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select count(*) from challenge";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
	
	public int getCount(String type, String keyword) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select count(*) from challenge where instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
		
	}
	
}
