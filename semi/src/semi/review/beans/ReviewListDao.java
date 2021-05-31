package semi.review.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import semi.beans.JDBCUtils;

public class ReviewListDao {
	public List<ReviewListDto> list() throws Exception{
		Connection con =  JDBCUtils.getConnection();
		
		String sql = "select*from review_list order by review_time asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<ReviewListDto> reviewList = new ArrayList<>();
		
		while(rs.next()) {
			ReviewListDto reListDto = new ReviewListDto();
			
			reListDto.setReviewNo(rs.getInt("review_no"));
			reListDto.setReviewNick(rs.getInt("review_nick"));
			reListDto.setReviewContent(rs.getString("review_content"));
			reListDto.setReviewTime(rs.getDate("review_time"));
			reListDto.setReviewStar(rs.getInt("review_star"));
			reListDto.setMemberNick(rs.getString("member_nick"));
	
			
			reviewList.add(reListDto);
			
		}
		return reviewList;
	}
}
