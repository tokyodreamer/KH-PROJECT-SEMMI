package semi.review.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import semi.beans.JDBCUtils;

public class ReviewDao {

	public List<ReviewDto> list() throws Exception {
		Connection con = JDBCUtils.getConnection();

		String sql = "select*from order by review_time asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<ReviewDto> reviewList = new ArrayList();

		while (rs.next()) {
			ReviewDto reDto = new ReviewDto();

			reDto.setReviewNo(rs.getInt("review_no"));
			reDto.setReviewNick(rs.getInt("member_no"));
			reDto.setReviewTime(rs.getDate("review_time"));
			reDto.setReviewStar(rs.getInt("review_star"));
			reDto.setReviewContent(rs.getString("review_content"));

			reviewList.add(reDto);

		}
		return reviewList;
	}
	

	public int getSequence() throws Exception {
		Connection con = JDBCUtils.getConnection();

		String sql ="select review_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int reviewNo = rs.getInt(1);

		con.close();
		return reviewNo;
	}
	
	

	// 리뷰 작성 기능??(insert-void)
	public void write(ReviewDto reviewDto) throws Exception {

		Connection con = JDBCUtils.getConnection();

		String sql = "insert into review values(review_seq.nextval,?,sysdate,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewDto.getReviewNick());
		ps.setInt(2, reviewDto.getReviewStar());
		ps.setString(3, reviewDto.getReviewContent());
		ps.execute();

		con.close();
		
	}
	
	//상세보기 기능(작성자 :박준영)
	public ReviewDto get(int reviewNo) throws Exception {
		Connection con = JDBCUtils.getConnection();
		
		//review 테이블에서 모든 값을 조회합니다. 근데 그 중에 특정 reviewNo값을 조회할겁니다
		String sql="select * from review where review_no=?";
		
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
			reviewDto.setReviewStar(rs.getInt("review_star"));
			reviewDto.setReviewContent(rs.getString("review_content"));
			
		}
		else {
			reviewDto=null;
		}
		con.close();
		
		return reviewDto;
	}
	
	//게시글 수정 기능(작성자: 박준영)  
	//update, delete 같은 경우는 반환형을 boolean으로 작성해주는게 좋다. 
	//결과가 어찌되었든 성공 실패 여부는 알려줘야하기때문
	public boolean edit(ReviewDto reviewDto) throws Exception{
		Connection con = JDBCUtils.getConnection();
		
		//update 하겠습니다 review 테이블을. 그리고 set(바꾸겠습니다)
		String sql="update review set review_star=?, review_content=? where review_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewDto.getReviewStar());
		ps.setString(2, reviewDto.getReviewContent());
		ps.setInt(3, reviewDto.getReviewNo());
		System.out.println(reviewDto.getReviewNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count>0;
	}
	
	//게시글 삭제기능(작성자: 박준영)
	//삭제나 업뎃은 주로 boolean 반환형 사용
	public boolean delete(int reviewNo) throws Exception{
		
		Connection con = JDBCUtils.getConnection();
		//삭제하겠습니다 (~테이블을) 조건(where) 번호는 몇 번 
		String sql="delete review where review_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewNo); //단순 삭제이므로 입력값인 reviewDto.get~ 이 아니다
		
		//성공이냐 실패를 확인해야하기때문에 boolean으로 받고 그 결과의 개수를 int count 로 파악하기때문에,
		//결과가 0보다 크면 반환한다
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
		
		
	}
	
}
