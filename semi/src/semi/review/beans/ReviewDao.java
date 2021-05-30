package semi.review.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import semi.beans.JDBCUtils;

public class ReviewDao {
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
	
	//상세보기 기능
	public ReviewDto get(int reviewNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		//review 테이블에서 모든 값을 조회합니다. 근데 그 중에 특정 reviewNo값을 조회할겁니다
		String sql="select * from review where reviw_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewNo);
		ResultSet rs = ps.executeQuery();
		
		//rs값에 데이터가 있는지 없는지 알 수 없으므로
		ReviewDto reviewDto;
		if(rs.next()) {
			reviewDto = new ReviewDto();
			
			reviewDto.setReviewNo(rs.getInt("review_no"));
			reviewDto.setReviewNick(rs.getInt("review_nick"));
			reviewDto.setReviewTime(rs.getDate("review_time"));
			reviewDto.setReviewStar(rs.getString("review_star"));
			reviewDto.setReviewContent(rs.getString("review_content"));
			
		}
		else {
			reviewDto=null;
		}
		con.close();
		
		return reviewDto;
	}
	
}
