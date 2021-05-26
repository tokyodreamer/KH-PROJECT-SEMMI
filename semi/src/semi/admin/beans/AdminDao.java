package semi.admin.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import semi.beans.JDBCUtils;

public class AdminDao {

	public AdminDto login(AdminDto adminDto) throws Exception {
		Connection con = JDBCUtils.getConnection();

		String sql = "select * from admin where admin_id = ? and admin_pw = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, adminDto.getAdminId());
		ps.setString(2, adminDto.getAdminPw());
		ResultSet rs = ps.executeQuery();

		AdminDto find;
		if (rs.next()) {
			find = new AdminDto();

			find.setAdminNo(rs.getInt("admin_no"));
			find.setAdminId(rs.getString("admin_id"));
			find.setAdminPw(rs.getString("admin_pw"));
			find.setAdminNick(rs.getString("admin_nick"));

		} else {
			find = null;
		}
		return find;

	}

}
