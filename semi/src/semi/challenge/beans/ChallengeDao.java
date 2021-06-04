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
		
		String sql = "select challenge_seq.nextval from dual";
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
		
		String sql = "insert into challenge values(?, ?, ?, ?, ?, ?, ?, 0, ?, 0, ?, 'N', 0, 0)";
		
		PreparedStatement ps = con.prepareStatement(sql); 
		ps.setInt(1, challengeDto.getChallengeNo()); // 도전글 번호 
		ps.setInt(2, challengeDto.getChallengeWriter()); // 멤버 번호 : -> 작성자 등록
		ps.setInt(3, challengeDto.getCategoryNo()); // 카테고리 번호 : -> 카테고리 타입 불러올 용도
		ps.setString(4, challengeDto.getChallengeTitle()); // 글 제목
		ps.setInt(5, challengeDto.getChallengePushPoint()); // 참가비
		ps.setString(6, challengeDto.getChallengeStartDate()); // 시작일
		ps.setString(7, challengeDto.getChallengeEndDate()); // 종료일
		ps.setInt(8, (int) (challengeDto.getChallengePushPoint()*0.01)); // 상금 로직 : 참가비 * 0.01
		ps.setString(9, challengeDto.getChallengeContent()); // 도전글 내용 
		// 'N' - 컬럼 추가 제어문 : 도전 테이블에 최종 정산 여부를 확인할 용도 (05/28, 작성자 : 정 계진)
		// 0 - 컬럼 추가 : 도전 테이블에 조회수 기능 추가(05/31, 작성자 : 박 민웅)
		// 0 - 컬럼 추가 : 도전 테이블에 댓글 기능 추가(06/03, 작성자 : 박 민웅)
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
			challengeDto.setChallengeResult(rs.getString("challenge_result"));
			challengeDto.setChallengeRead(rs.getInt("challenge_read"));
			challengeDto.setChallengeReply(rs.getInt("challenge_reply"));
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
					 		+ "select * from challenge where sysdate <= challenge_endDate and challenge_result = 'N' order by challenge_no desc"
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
			challengeDto.setChallengeResult(rs.getString("challenge_result"));
			challengeDto.setChallengeRead(rs.getInt("challenge_read"));
			challengeDto.setChallengeReply(rs.getInt("challenge_reply"));
			
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
			 				+ "where instr(#1, ?) > 0 and sysdate <= challenge_endDate and challenge_result = 'N' order by challenge_no desc"
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
			challengeDto.setChallengeResult(rs.getString("challenge_result"));
			challengeDto.setChallengeRead(rs.getInt("challenge_read"));
			challengeDto.setChallengeReply(rs.getInt("challenge_reply"));
			
			challengeList.add(challengeDto);
		}
		
		con.close();
		return challengeList;
	}
	
	//페이지블럭 계산을 위한 카운트 기능(목록/검색)
	public int getCount() throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select count(*) from challenge where sysdate <= challenge_endDate and challenge_result = 'N'";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
	
	public int getCount(String type, String keyword) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select count(*) from challenge where instr(#1, ?) > 0 and sysdate <= challenge_endDate and challenge_result = 'N'";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
		
	}
	

	public ChallengeDto find(int challengeWriter) throws Exception { // write_no를 기준으로 회원찾기

		Connection con = JDBCUtils.getConnection();

		String sql = "select * from challenge where challenge_writer = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, challengeWriter);
		ResultSet rs = ps.executeQuery();
		
		

		ChallengeDto challengeDto;
		if (rs.next()) {

			challengeDto = new ChallengeDto();

			challengeDto.setChallengeNo(rs.getInt("challenge_no"));
			challengeDto.setChallengeWriter(rs.getInt("challenge_writer"));
			challengeDto.setChallengeTitle(rs.getString("challenge_title"));

		} else {
			challengeDto = null;
		}

		con.close();
		
		return challengeDto;

	}
	
	
	//조회수 증가 기능 : 특정 번호의 게시글을 작성자가 아닌 사람이 읽을 경우에만 증가되도록 구현(05/31, 작성자 : 박 민웅)
	public boolean read(int challengeNo, int memberNo) throws Exception{
		Connection con = JDBCUtils.getConnection();
		
		String sql = "update challenge "
				+ "set challenge_read = challenge_read + 1 "
				+ "where challenge_no = ? and challenge_writer != ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, challengeNo);
		ps.setInt(2, memberNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
	//댓글 개수 갱신 기능 구현(06/03 작성자 : 박민웅)
	public boolean refreshChallengeReply(int challengeNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "update challenge "
						+ "set challenge_reply = (select count(*) from reply where reply_origin = ? ) "
					+ "where challenge_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, challengeNo);
		ps.setInt(2, challengeNo);
		int count = ps.executeUpdate();
		con.close();
		return count > 0;
	}
	
//	내 게시글목록
	public List<ChallengeDto> myList(int memberNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "select * from challenge where challenge_writer = ?"; 
							
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, memberNo);
		ResultSet rs = ps.executeQuery();
		
		List<ChallengeDto> challengeList = new ArrayList<>();
		while(rs.next()) {
			ChallengeDto challengeDto = new ChallengeDto();
			challengeDto.setChallengeNo(rs.getInt("challenge_no"));
			challengeDto.setChallengeWriter(rs.getInt("challenge_writer"));
//			challengeDto.setCategoryNo(rs.getInt("category_no")); 
			challengeDto.setChallengeTitle(rs.getString("challenge_title"));
			challengeDto.setChallengePushPoint(rs.getInt("challenge_pushPoint"));
			challengeDto.setChallengeStartDate(rs.getString("challenge_startDate"));
			challengeDto.setChallengeEndDate(rs.getString("challenge_endDate"));
			challengeDto.setChallengePercent(rs.getInt("challenge_percent"));
			challengeDto.setChallengeReward(rs.getInt("challenge_reward"));
			challengeDto.setChallengeDonate(rs.getInt("challenge_donate"));
			challengeDto.setChallengeResult(rs.getString("challenge_result"));
			challengeDto.setChallengeRead(rs.getInt("challenge_read"));
			//challengeDto.setChallengeReply(rs.getInt("challenge_reply"));
			
			challengeList.add(challengeDto);
		}
		
		con.close();
		return challengeList;
		
	}
	
	
//	진행중임돠
//	public boolean rfind(int memberNo) throws Exception {
//		
//		Connection con = JDBCUtils.getConnection();
//		String sql = "select * from challenge where challenge_writer = ?";
//		PreparedStatement ps = con.prepareStatement(sql);
//		ps.setInt(1, memberNo);
//		ResultSet rs = ps.executeQuery();
//		
//		if(rs.next()) {
//			return true;
//		}
//		else {
//			return false;
//		}
//		
//	}

	// 후원금 등록 시, 도전글 DB의 후원금 컬럼에 후원금을 더해주는 메소드 (작성자 : 정 계진)
	// 설명 : 후원금 등록 메소드의 후원금 값과 도전글 번호 값을 활용하여 후원금을 업데이트(누적 형태로) 하는 메소드
	public boolean donateJoin(int challengeDonate, int challengeNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "update challenge set challenge_donate = challenge_donate + ? where challenge_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, challengeDonate);
		ps.setInt(2, challengeNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	// 백분율 메소드 (05/28, 작성자 : 정 계진)
	public boolean challengePercent(int challengeNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		String sql = "update challenge set challenge_percent = ("
				+ "select trunc((select count(auth_result) from auth where auth_result = 'S' and auth_challengeNo = ?) / "
				+ "(select trunc(challenge_endDate) - trunc(challenge_startDate) from challenge where challenge_no = ?) * 100) from dual) "
				+ "where challenge_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, challengeNo);
		ps.setInt(2, challengeNo);
		ps.setInt(3, challengeNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	/*정산 작업 */
	
	// 0. 정산 작업물이 있는 지 확인
		public boolean checkResult() throws Exception {
			Connection con = JDBCUtils.getConnection();
			
			String sql = "select count(*) from challenge where sysdate >= challenge_endDate and challenge_result = 'N'";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			boolean check = false;
			
			if(rs.next()) {
				check = true;
			}
			
			con.close();
			
			return check;
		}
	
	// 1. 도전 정산 작업 
		public boolean changeChallenge() throws Exception {
			try(Connection con = JDBCUtils.getConnection();) {
				
				String sql = "merge into member M using complete_challenge C on (C.challenge_writer = M.member_no) "
						+ "when matched then update set M.member_point = M.member_point + C.challenge_calc_total";
				PreparedStatement ps = con.prepareStatement(sql);
				int count = ps.executeUpdate();
				
				return count > 0;
			} 
			
		}
		
	// 2. 후원 정산 작업
		public boolean changeDonate() throws Exception {
			try(Connection con = JDBCUtils.getConnection();) {
				String sql = "merge into member M using complete_donate d on (d.member_no = M.member_no) "
						+ "when matched then update set M.member_point = M.member_point + d.donate_calc_total";
				PreparedStatement ps = con.prepareStatement(sql);
				int count = ps.executeUpdate();
				
				return count > 0;
			} 
			
		}
		
	// 3. 해당 기한 만료 도전글에 대하여 정산 결과 변경 (완료)
		public boolean changeResult() throws Exception {
			try(Connection con = JDBCUtils.getConnection();) {
				String sql = "update challenge set challenge_result = 'Y' where sysdate >= challenge_endDate and challenge_result = 'N'";
				PreparedStatement ps = con.prepareStatement(sql);
				int count = ps.executeUpdate();
				
				return count > 0;
			} 
		}
		
}
