package semi.challenge.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import semi.beans.JDBCUtils;

//challenge_list라는 view를 조회하기 위한 DAO
public class ChallengeListDao {

	// 게시글 목록 기능
	public List<ChallengeListDto> list(int startRow, int endRow) throws Exception {
		Connection con = JDBCUtils.getConnection();

		String sql = "select * from (" + "select rownum rn, TMP.* from ("
				+ "select * from challenge_list order by challenge_no desc" + ")TMP" + ") where rn between ? and ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();

		List<ChallengeListDto> challengeList = new ArrayList<>();
		while (rs.next()) {
			ChallengeListDto challengeListDto = new ChallengeListDto();
			challengeListDto.setChallengeNo(rs.getInt("challenge_no"));
			challengeListDto.setChallengeTitle(rs.getString("challenge_title"));
			challengeListDto.setChallengePushPoint(rs.getInt("challenge_pushPoint"));
			challengeListDto.setChallengeStartDate(rs.getString("challenge_startDate"));
			challengeListDto.setChallengeEndDate(rs.getString("challenge_endDate"));
			challengeListDto.setChallengePercent(rs.getInt("challenge_percent"));
			challengeListDto.setChallengeReward(rs.getInt("challenge_reward"));
			challengeListDto.setChallengeDonate(rs.getInt("challenge_donate"));
			// challengeListDto.setChallengeResult(rs.getString("challenge_result"));
			// challengeListDto.setChallengeRead(rs.getInt("challenge_read"));

			challengeListDto.setMemberNo(rs.getInt("member_no"));
			challengeListDto.setMemberNick(rs.getString("member_nick"));
			challengeListDto.setMemberPoint(rs.getInt("member_point"));

			challengeListDto.setCategoryNo(rs.getInt("category_no"));
			challengeListDto.setCategorytype(rs.getString("category_type"));

			challengeList.add(challengeListDto);
		}

		con.close();
		return challengeList;

	}

	// 검색 기능
	public List<ChallengeListDto> search(String type, String keyword, int startRow, int endRow) throws Exception {
		Connection con = JDBCUtils.getConnection();

		String sql = "select * from (" + "select rownum rn, TMP.* from (" + "select * from challenge_list "
				+ "where instr(#1, ?) > 0 order by challenge_no desc" + ")TMP" + ") where rn between ? and ?";

		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();

		List<ChallengeListDto> challengeList = new ArrayList<>();
		while (rs.next()) {
			ChallengeListDto challengeListDto = new ChallengeListDto();
			challengeListDto.setChallengeNo(rs.getInt("challenge_no"));
			challengeListDto.setChallengeTitle(rs.getString("challenge_title"));
			challengeListDto.setChallengePushPoint(rs.getInt("challenge_pushPoint"));
			challengeListDto.setChallengeStartDate(rs.getString("challenge_startDate"));
			challengeListDto.setChallengeEndDate(rs.getString("challenge_endDate"));
			challengeListDto.setChallengePercent(rs.getInt("challenge_percent"));
			challengeListDto.setChallengeReward(rs.getInt("challenge_reward"));
			challengeListDto.setChallengeDonate(rs.getInt("challenge_donate"));
			challengeListDto.setChallengeResult(rs.getString("challenge_result"));
			challengeListDto.setChallengeRead(rs.getInt("challenge_read"));

			challengeListDto.setMemberNo(rs.getInt("member_no"));
			challengeListDto.setMemberNick(rs.getString("member_nick"));

			challengeListDto.setCategoryNo(rs.getInt("category_no"));
			challengeListDto.setCategorytype(rs.getString("category_type"));

			challengeList.add(challengeListDto);
		}

		con.close();
		return challengeList;

	}

	// 페이지블럭 계산을 위한 카운트 기능(목록/검색)
	public int getCount() throws Exception {
		Connection con = JDBCUtils.getConnection();

		String sql = "select count(*) from challenge_list";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();

		int count = rs.getInt(1);

		con.close();

		return count;
	}

	public int getCount(String type, String keyword) throws Exception {

		Connection con = JDBCUtils.getConnection();

		String sql = "select count(*) from challenge_list where instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;

	}

	// 작성자 번호를 통해 회원DB 작성자 명 불러오기 기능 (05/26, 구현자 : 정 계진)
	public ChallengeListDto getChallenge(int challengeNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select * from challenge_list where challenge_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, challengeNo);
		ResultSet rs = ps.executeQuery();
		
		ChallengeListDto challengeListDto;
		if(rs.next()) {
			challengeListDto = new ChallengeListDto();
			challengeListDto.setChallengeNo(rs.getInt("challenge_no"));
			challengeListDto.setChallengeTitle(rs.getString("challenge_title"));
			challengeListDto.setChallengePushPoint(rs.getInt("challenge_pushPoint"));
			challengeListDto.setChallengeStartDate(rs.getString("challenge_startDate"));
			challengeListDto.setChallengeEndDate(rs.getString("challenge_endDate"));
			challengeListDto.setChallengePercent(rs.getInt("challenge_percent"));
			challengeListDto.setChallengeReward(rs.getInt("challenge_reward"));
			challengeListDto.setChallengeDonate(rs.getInt("challenge_donate"));
			challengeListDto.setChallengeContent(rs.getString("challenge_content"));
			// challengeListDto.setChallengeResult(rs.getString("challenge_result"));
			// challengeListDto.setChallengeRead(rs.getInt("challenge_read"));

			challengeListDto.setMemberNo(rs.getInt("member_no"));
			challengeListDto.setMemberNick(rs.getString("member_nick"));

			challengeListDto.setCategoryNo(rs.getInt("category_no"));
			challengeListDto.setCategorytype(rs.getString("category_type"));
		} else {
			challengeListDto = null;
		}
		con.close();
		
		return challengeListDto;
	}
	
}
