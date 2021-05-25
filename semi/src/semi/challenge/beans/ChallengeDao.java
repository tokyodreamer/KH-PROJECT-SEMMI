package semi.challenge.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import semi.beans.JDBCUtils;

public class ChallengeDao {
	
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
	
}
