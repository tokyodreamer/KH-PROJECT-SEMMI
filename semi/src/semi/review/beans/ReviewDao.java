package semi.review.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import semi.beans.JDBCUtils;

public class ReviewDao {
//	public List<ReviewDto> list() throws Exception{

//	}
	
	//리뷰 작성 기능??(insert-void)
	public void write(ReviewDto reviewDto) throws Exception{
		
		Connection con = JDBCUtils.getConnection();
		
		String sql="insert into review values(review_seq.nextval,?,sysdate,?,?)";
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setInt(1, reviewDto.getReviewNick());
		ps.setString(2, reviewDto.getReviewStar());
		ps.setString(3, reviewDto.getReviewContent());
		ps.execute();
		
		con.close();
		
		
		
		
		
	}
	
	
	
}
