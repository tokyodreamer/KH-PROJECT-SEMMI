package semi.auth.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import semi.beans.JDBCUtils;

public class AuthDao {

	public List<AuthDto> list() throws Exception {

		Connection con = JDBCUtils.getConnection();

		String sql = "select * from auth order by auth_no desc";

		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<AuthDto> authList = new ArrayList<>();

		while (rs.next()) {
			AuthDto authDto = new AuthDto();

			authDto.setAuthNo(rs.getInt("auth_no"));
			authDto.setAuthChallengeNo(rs.getInt("auth_challengeNo"));
			authDto.setAuthWriter(rs.getInt("auth_writer"));
			authDto.setAuthCategoryType(rs.getInt("auth_categoryType"));
			authDto.setAuthTitle(rs.getString("auth_title"));
			authDto.setAuthContent(rs.getString("auth_content"));
			authDto.setAuthTimeLine(rs.getDate("auth_timeLine"));
			authDto.setAuthResult(rs.getString("auth_result"));
			authDto.setAuthReason(rs.getString("auth_reason"));

			authList.add(authDto);
		}

		return authList;

	}

	public AuthDto get(int authNo) throws Exception {

		Connection con = JDBCUtils.getConnection();

		String sql = "select * from auth where auth_no = ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, authNo);
		ResultSet rs = ps.executeQuery();

		AuthDto authDto = new AuthDto();
		if (rs.next()) {

			authDto.setAuthNo(rs.getInt("auth_no"));
			authDto.setAuthChallengeNo(rs.getInt("auth_challengeNo"));
			authDto.setAuthWriter(rs.getInt("auth_writer"));
			authDto.setAuthCategoryType(rs.getInt("auth_categoryType"));
			authDto.setAuthTitle(rs.getString("auth_title"));
			authDto.setAuthContent(rs.getString("auth_content"));
			authDto.setAuthTimeLine(rs.getDate("auth_timeLine"));
			authDto.setAuthResult(rs.getString("auth_result"));
			authDto.setAuthReason(rs.getString("auth_reason"));
		}
		else {
			authDto = null;
		}

		return authDto;

	}

}
