package semi.review.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
<<<<<<< HEAD
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
=======
>>>>>>> refs/remotes/origin/main

import semi.beans.JDBCUtils;

public class ReviewDao {
<<<<<<< HEAD
	public List<ReviewDto> list() throws Exception{
		Connection con =  JDBCUtils.getConnection();
		
		String sql = "select*from order by review_time asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<ReviewDto> reviewList = new ArrayList();
		
		while(rs.next()) {
			ReviewDto reDto = new ReviewDto();
			
			reDto.setReviewNo(rs.getInt("review_no"));
			reDto.setReviewNick(rs.getInt("member_no"));
			reDto.setReviewTime(rs.getDate("review_time"));
			reDto.setReviewStar(rs.getString("review_star"));
			reDto.setReviewContent(rs.getString("review_content"));
			
			reviewList.add(reDto);
			
		}
		return reviewList;
	}
	public int getSequence()throws Exception{
Connection con = JDBCUtils.getConnection();
		
		String sql ="select review_seq.nextval";
		PreparedStatement ps= con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int reviewNo = rs.getInt(1);
		
		con.close();
		return reviewNo;
	}
	
	//후기글 등록
	public void insert(ReviewDto reDto) throws Exception{
		Connection con = JDBCUtils.getConnection();
		
		String sql = "insert into ";
	}
=======
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
	
>>>>>>> refs/remotes/origin/main
	
	
}
