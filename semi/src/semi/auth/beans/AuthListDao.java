package semi.auth.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import semi.beans.JDBCUtils;

public class AuthListDao {
	
	//member 테이블과 조인 후 목록 출력 구문
	public List<AuthListDto> list()	throws Exception{
			Connection con = JDBCUtils.getConnection();
			
			String sql = "select * from auth_list order by auth_no desc";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			List<AuthListDto> authList = new ArrayList<>();
			
			while(rs.next()) {
				AuthListDto authlistDto = new AuthListDto();
				authlistDto.setAuthNo(rs.getInt("auth_no"));
				authlistDto.setAuthChallengeNo(rs.getInt("auth_challengeNo"));
				authlistDto.setAuthWriter(rs.getInt("auth_writer"));
				authlistDto.setAuthCategoryType(rs.getInt("auth_categoryType"));
				authlistDto.setAuthTitle(rs.getString("auth_title"));
				authlistDto.setAuthContent(rs.getString("auth_content"));
				authlistDto.setAuthTimeLine(rs.getDate("auth_timeLine"));
				authlistDto.setAuthResult(rs.getString("auth_result"));
				authlistDto.setAuthReason(rs.getString("auth_reason"));
				
				
				authlistDto.setMemberNick(rs.getString("member_nick"));
				
				authList.add(authlistDto);
			}
			
			con.close();
			return authList;
	}

	//단일 조회(준비물 인증글번호 authNo)
	public AuthListDto get(int authNo) throws Exception {

		Connection con = JDBCUtils.getConnection();

		String sql = "select * from auth_list where auth_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, authNo);
		ResultSet rs = ps.executeQuery();

		AuthListDto authListDto;
		if (rs.next()) {
			authListDto = new AuthListDto();
			authListDto.setAuthNo(rs.getInt("auth_no"));
			authListDto.setAuthChallengeNo(rs.getInt("auth_challengeNo"));
			authListDto.setAuthWriter(rs.getInt("auth_writer"));
			authListDto.setAuthCategoryType(rs.getInt("auth_categoryType"));
			authListDto.setAuthTitle(rs.getString("auth_title"));
			authListDto.setAuthContent(rs.getString("auth_content"));
			authListDto.setAuthTimeLine(rs.getDate("auth_timeLine"));
			authListDto.setAuthResult(rs.getString("auth_result"));
			authListDto.setAuthReason(rs.getString("auth_reason"));
			
			authListDto.setMemberNick(rs.getString("member_nick"));
		}
		else {
			authListDto = null;
		}
		
		con.close();
		return authListDto;

	}
}
